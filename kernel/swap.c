//
// Created by os on 12/12/23.
//

#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "swap.h"
#include "spinlock.h"
#include "proc.h"
#include "defs.h"


#define SWAP_FRAMES 16384       // number of swap disk frames of 1kB
#define SWAP_SLOTS 16384/4      // 4kB
#define FRAMES_NUMBER ((uint64)PHYSTOP>>12) - ((uint64)KERNBASE>>12)
#define BUSY_WAIT 0
#define SWAP_FRAME_SIZE 1<<10

uint64 swap_dsk_bit_vector [SWAP_SLOTS/64];  // SWAP_SLOTS/64 = 64
struct frame_entry frame_entries[FRAMES_NUMBER];

struct spinlock swap_lock;

uint cnt_page_faults;
uint64 taken;
int om_full = 0;

extern struct proc proc[NPROC];

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
            return i * 64 + index;
        }
    }
    printf("no free slots on swap disk\n");
    return -1; // ako nema dovoljno slotova
}

void
mark_slot_as_taken(int slot) {
    int row = slot / 64;
    int col = slot % 64;
    swap_dsk_bit_vector[row] |= (uint64)(1 << col);
}

void
mark_slot_as_free(int slot) {
    int row = slot / 64;
    int col = slot % 64;
    swap_dsk_bit_vector[row] &= ~(uint64)(1 << col);
}

void
remove_from_swap(pte_t pte) {
    long int slot = (long int)((pte >> 10) & 0xfffffffffff);
    if (slot >= 0 && slot < SWAP_SLOTS) mark_slot_as_free(slot);
    else { panic("remove from swap"); }
}

void
new_frame_entry(pte_t *pte) {
    uint64 pa = PTE2PA(*pte);

    if (frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte != 0) printf("overwrite, %d\n", (pa >> 12) - ((uint64)KERNBASE>>12));

    if (((pa >> 12) - ((uint64)KERNBASE>>12)) < FRAMES_NUMBER && ((pa >> 12) - ((uint64)KERNBASE>>12)) > 0) {
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte = pte;
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].ref_bits = (uint8)0x80;
    }
    else {
        panic("frame entry creation error\n");
    }
}

void
delete_frame_entry(uint64 pa) {
    if (((pa >> 12) - ((uint64)KERNBASE>>12)) < FRAMES_NUMBER && ((pa >> 12) - ((uint64)KERNBASE>>12)) > 0) {
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte = 0;
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].ref_bits = (uint8)0;
    }
    else {
        panic("frame entry deletion error\n");
    }
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

struct proc* thrash_sleep[NPROC];
int head = -1, tail = -1;

int
count_working_set(pagetable_t pagetable) {
    int result = 0;
    for(int i = 0; i < 512; i++){
        pte_t pte = pagetable[i];
        if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
            // this PTE points to a lower-level page table.
            uint64 child = PTE2PA(pte);
            result += count_working_set((pagetable_t)child);
        } else if(pte & PTE_V){
            if (pte & PTE_A) result++;
        } else if(!(pte & PTE_V) && (pte & PTE_S)) {
            if (pte & PTE_T) result++;
            pagetable[i] &= ~PTE_T;
        }
    }
    return result;
}

void
check_thrashing() {
    int working_set = 0, max_working_set = 0;
    struct proc* p;
    //struct proc* to_swap_out;
    //to_swap_out = 0;
    for(p = proc; p < &proc[NPROC]; p++) {
        acquire(&p->lock);
        if (p->state == RUNNABLE || p->state == SLEEPING || p->state == RUNNING) {
            int ws = count_working_set(p->pagetable);
            working_set += ws;
            if (p->state == RUNNABLE && ws > max_working_set) {
                max_working_set = ws;
                //to_swap_out = p;
            }
        }
        release(&p->lock);
    }

    if (working_set > 20) printf("-------------->working set=%d<--------------\n", working_set);

//    if (working_set < FRAMES_NUMBER / 4) {
//        if (head != -1) {
//            struct proc* p = thrash_sleep[head];
//            p->state = RUNNABLE;
//            printf("process with pid=%d returned to execution\n", p->pid);
//            if (head == tail) head = tail = -1;
//            else head = (head + 1) % NPROC;
//        }
//        return;
//    }
//
//    if (!(working_set > FRAMES_NUMBER * 3 / 4)) return;
//
//    printf("\nTHRASHING!!!\n\n");
//
//    if (!to_swap_out) return;
//    to_swap_out->state = SLEEPING;
//    if(tail == -1) {
//        head = tail = 0;
//    } else {
//        tail = (tail + 1) % NPROC;
//    }
//    thrash_sleep[tail] = to_swap_out;
//    printf("process with pid=%d waiting for thrashing to stop\n", to_swap_out->pid);
}

// uporedjuje sve ref_bite i pronalazi onog sa najmanjim ref bitima
uint32
find_victim() {
    om_full = 1;
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

int cnt = 0;

void*
swap_out_victim() {
    acquire(&swap_lock);
    om_full = 1;

    uint32 victim = find_victim();

    void* pa = (void*)PTE2PA(*frame_entries[victim].pte);

    int slot = free_slot_on_swap();
    if (slot == -1) {
        release(&swap_lock);
        return 0;  // no space on swap disk
    }

    // sending a block from OM in 4 parts, because a block in OM is 4kB
    // and a block on the disk is 1kB
    mark_slot_as_taken(slot);
    *frame_entries[victim].pte &= ~(uint64)(0xfffffffffff << 10);
    *frame_entries[victim].pte |= (slot << 10);
    *frame_entries[victim].pte &= (~PTE_V);
    if (*frame_entries[victim].pte & PTE_A) *frame_entries[victim].pte |= PTE_T;
    frame_entries[victim].pte = 0;

    cnt++;
    printf("writing to disk - %d\n", cnt);

    release(&swap_lock);
    uchar* data = pa;

    for (int i = 0; i < 4; i++) {
        write_block(slot * 4 + i, data, BUSY_WAIT);
        data = data + (SWAP_FRAME_SIZE);
    }

    return pa;
}

int
load_from_swap(pte_t *pte) {
    //printf("load from swap\n");
    cnt_page_faults++;

    uint64 slot = (uint64)((*pte >> 10) & 0xfffffffffff);

    void* mem = kalloc();
    if (!mem) {
        printf("no space in OM, and no space on swap disk\n");
        return -1;
    }   // no space in OM, and no space on swap disk

    uchar* data = mem;

    for (int i = 0; i < 4; i++) {
        read_block(slot * 4 + i, data, BUSY_WAIT);
        data = data + (SWAP_FRAME_SIZE);
    }

    mark_slot_as_free(slot);
    *pte &= ~(uint64)(0xfffffffffff << 10);
    *pte |= PA2PTE(mem);
    *pte |= PTE_V;
    *pte &= ~PTE_T;
    new_frame_entry(pte);

    return 0;
}

void
swaping_init(void) {
    for (int i = 0; i < SWAP_SLOTS/64; i++) {
        swap_dsk_bit_vector[i] = 0;
    }

    // pravimo niz struktura frame_entry, niz ima onoliko elemenata koliko ima blokova u OM
    for (uint32 i = 0; i < FRAMES_NUMBER; i++) {
        frame_entries[i].pte = 0;
        frame_entries[i].ref_bits = (uint8)0;
    }

    for (int i = 0; i < NPROC; i++) {
        thrash_sleep[i] = 0;
    }
}