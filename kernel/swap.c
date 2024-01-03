//
// Created by os on 12/12/23.
//

#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "swap.h"
#include "defs.h"
#include "spinlock.h"

#define SWAP_FRAMES 16384       // number of swap disk frames of 1kB
#define SWAP_SLOTS 16384/4      // 4kB
#define FRAMES_NUMBER ((uint64)PHYSTOP>>12) - ((uint64)KERNBASE>>12)
#define B_IN_1KB 2<<10

uint64 swap_dsk_bit_vector [SWAP_SLOTS/64];  // SWAP_SLOTS/64 = 64
struct frame_entry frame_entries[FRAMES_NUMBER];

struct spinlock swap_lock;

// pronalazi slobodan slot na disku, vraca vrednost od 0-4095
int
free_slot_on_swap(void) {
    for (int i = 0; i < SWAP_SLOTS/64; i++) {
        if (swap_dsk_bit_vector[i] != ~((uint64)0x0)) {  // ako nisu svi u ovoj reci zauzeti onda se krece u pretragu
            uint64 tmp = swap_dsk_bit_vector[i];
            int index = 0;
            while ((tmp & 1) != 0) {
                tmp >>= 1;
                index++;
            }
            return i * (SWAP_SLOTS/64) + index;
        }
    }
    printf("nema dovoljno slotova\n");
    return -1; // ako nema dovoljno slotova
}

void
mark_slot_as_taken(int slot) {
    int row = slot / 64;
    int col = slot % 64;
    swap_dsk_bit_vector[row] |= (1 << col);
}

void
mark_slot_as_free(int slot) {
    int row = slot / 64;
    int col = slot % 64;
    swap_dsk_bit_vector[row] &= ~(uint64)(1 << col);
}

void
remove_from_swap(pte_t* pte) {
    int slot = (int)((*pte >> 10) & 0xfffffffffff);
    if (slot >= 0 && slot < SWAP_SLOTS) mark_slot_as_free(slot);
}

void
new_frame_entry(pte_t *pte) {
    acquire(&swap_lock);
    uint64 pa = PTE2PA(*pte);

    if (frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte != 0) printf("overwrite, %d\n", (pa >> 12) - ((uint64)KERNBASE>>12));

    //printf("created new frame entry for pa: %x, with pte at address: %x, index is: %d\n", pa, (uint64)pte, (pa >> 12) - ((uint64)KERNBASE>>12));

    if (((pa >> 12) - ((uint64)KERNBASE>>12)) < FRAMES_NUMBER && ((pa >> 12) - ((uint64)KERNBASE>>12)) > 0) {
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte = pte;
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].ref_bits = (uint8)0x80;
    }
    else {
        panic("frame entry creation error\n");
    }
    release(&swap_lock);
}

void
delete_frame_entry(uint64 pa) {
    acquire(&swap_lock);
    if (((pa >> 12) - ((uint64)KERNBASE>>12)) < FRAMES_NUMBER && ((pa >> 12) - ((uint64)KERNBASE>>12)) > 0) {
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte = 0;
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].ref_bits = (uint8)0;
    }
    else {
        panic("frame entry deletion error\n");
    }
    release(&swap_lock);
}

void
update_ref_bits() {
    acquire(&swap_lock);
    for (uint32 i = 0; i < FRAMES_NUMBER; i++) {
        if (frame_entries[i].pte != 0) {
            frame_entries[i].ref_bits >>= 1;
            frame_entries[i].ref_bits = frame_entries[i].ref_bits | ((*frame_entries[i].pte & PTE_A) << 1);
            // reset accessed bit
            *frame_entries[i].pte &= ~PTE_A;
        }
    }
    release(&swap_lock);
}

// uporedjuje sve ref_bite i pronalazi onog sa najmanjim ref bitima
uint32
find_victim() {
    uint8 min_ref_bits = 0xff;
    uint32 min_frame_index = -1;
    for (uint32 i = 0; i < FRAMES_NUMBER; i++) {
        if (frame_entries[i].pte != 0 && frame_entries[i].ref_bits <= min_ref_bits) {
            min_ref_bits = frame_entries[i].ref_bits;
            min_frame_index = i;
        }
    }
    return min_frame_index;
}

void*
swap_out_victim() {
    acquire(&swap_lock);
    uint32 victim = find_victim();

    void* pa = (void*)PTE2PA(*frame_entries[victim].pte);

    int slot = free_slot_on_swap();
    if (slot == -1) {
        release(&swap_lock);
        return 0;  // no space on swap disk
    }
    // sending a block from OM in 4 parts, because a block in OM is 4kB
    // and a block on the disk is 1kB
    void* ret = pa;
    mark_slot_as_taken(slot);
    *frame_entries[victim].pte &= ~(uint64)(0xfffffffffff << 10);
    *frame_entries[victim].pte |= slot << 10;
    *frame_entries[victim].pte &= (~PTE_V);
    frame_entries[victim].pte = 0;
    release(&swap_lock);

    for (int i = 0; i < 4; i++) {
        write_block(slot * 4 + i, (uchar*)pa, 0);
        pa = (uchar*)pa + (2<<10);
    }

    //sfence_vma();
    return ret;
}

int
load_from_swap(pte_t *pte) {
    printf("load from swap\n");
    uint64 slot = (uint64)((*pte >> 10) & 0xfffffffffff);

    void* mem = kalloc();
    if (!mem) {
      printf("no space in OM, and no space on swap disk");
      return -1;
    }   // no space in OM, and no space on swap disk
    printf("1loaded on addr: %x\n", mem);
    uchar* data = mem;
    for (int i = 0; i < 4; i++) {
        read_block(slot * 4 + i, data, 0);
        data = data + (2<<10);
    }

    printf("2loaded on addr: %x\n", mem);
    mark_slot_as_free(slot);
    *pte &= ~(uint64)(0xfffffffffff << 10);
    *pte |= PA2PTE(mem);
    *pte |= PTE_V;
    new_frame_entry(pte);

    return 0;
}

void
swaping_init(void) {
    printf("began swaping init\n");
    // pravljenje neke strukture u kojoj cemo da cuvamo koji blokovi na disku su zauzeti
        // struktura neka bude koji ima 64 elemenata i u svakoj reci se u svakom bit cuva podatak za jedan
        // slot na disku

    for (int i = 0; i < SWAP_SLOTS/64; i++) {
        swap_dsk_bit_vector[i] = 0;
    }

    // pravimo niz struktura frame_entry, niz ima onoliko elemenata koliko ima blokova u OM
    for (uint32 i = 0; i < FRAMES_NUMBER; i++) {
        frame_entries[i].pte = 0;
        frame_entries[i].ref_bits = (uint8)0;
    }

    // videti da li negde treba raditi medjusobno iskuljucivanje pri pristupu blokovima na swap disku
}