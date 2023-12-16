//
// Created by os on 12/12/23.
//

#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "swap.h"
#include "defs.h"

#define SWAP_FRAMES 16384       // number of swap disk frames of 1kB
#define SWAP_SLOTS 16384/4      // 4kB
#define FRAMES_NUMBER ((uint64)PHYSTOP>>12) - ((uint64)KERNBASE>>12)

uint64 swap_dsk_bit_vector [SWAP_SLOTS/64];  // SWAP_SLOTS/64 = 64
//uint64 frames_number = ((uint64)PHYSTOP>>12) - ((uint64)KERNBASE>>12);
struct frame_entry frame_entries[FRAMES_NUMBER];

int
free_slot_on_swap(void) {
    for (uint64 i; i < SWAP_SLOTS/64; i++) {
        if (swap_dsk_bit_vector[i] != ~((uint64)0x0)) {  // ako nisu svi u ovoj reci zauzeti onda se krece u pretragu
            uint64 tmp = swap_dsk_bit_vector[i];
            uint8 index = 0;
            while ((tmp & 1) != 0) {
                tmp >>= 1;
                index++;
            }
            return i * (SWAP_SLOTS/64) + index;
        }
    }
    return -1; // ako nema dovoljno slotova
}

void
new_frame_entry(pte_t *pte, uint64 pa) {
    if (((pa >> 12) - ((uint64)KERNBASE>>12)) < FRAMES_NUMBER && ((pa >> 12) - ((uint64)KERNBASE>>12)) > 0) {
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].pte = pte;
        frame_entries[(pa >> 12) - ((uint64)KERNBASE>>12)].ref_bits = (uint8)0;
    }
    else {
        printf("you dumb\n");
    }
}

void
swaping_init(void) {
    printf("began swaping init\n");
    // pravljenje neke strukture u kojoj cemo da cuvamo koji blokovi na disku su zauzeti
        // struktura neka bude koji ima 64 elemenata i u svakoj reci se u svakom bit cuva podatak za jedan
        // slot na disku

    for (uint32 i = 0; i < SWAP_SLOTS/64; i++) {
        swap_dsk_bit_vector[i] = 0;
    }

    // pravimo niz struktura frame_entry, niz ima onoliko elemenata koliko ima blokova u OM

    for (uint32 i = 0; i < FRAMES_NUMBER; i++) {
        frame_entries[i].pte = 0;
        frame_entries[i].ref_bits = (uint8)0;
    }

//    for (uint32 i = 0; i < SWAP_SLOTS/64; i++) {
//        printf("%d", swap_dsk_bit_vector[i]);
//    }

//    printf("\n");
//
//    for (uint32 i = 0; i < FRAMES_NUMBER; i++) {
//        printf("%d", frame_entries[i].pte);
//        printf("%d", frame_entries[i].ref_bits);
//        printf("\n");
//    }

    // treba da napravimo strukturu koja ce sadrzati pointere na pocetak bloka u fizickoj adresi i na pte (page table entry)
    // pravimo novi element te strukture kad god se pozove void* kalloc(void), a da se ne radi o alokaciji stranica za kernel
    // ili o stranicama korisnickih procesa koje su potrebne za obradu stranicnih gresaka
    // tu se takodje cuvaju i biti referenciranja u uint8 koji se periodicno update-uju

    // kada vise nema mesta medju svim strukturama trazimo onu sa najmanjom vrednostcu refBits i nju proglasavamo za victim
    // trazimo blok na disku gde cemo da je smestimo, saljemo je na disk i upisujemo u pte na neki nacin oznaku da je
    // strancia na disku a ne u OM i upisujemo redni broj bloka u pte

    // ucitavamo novu stranicu (ili sa diska ili iz ...)

    // ako se desi page fault onda ponovo trazimo victim, njega izbacujemo a mi se ucitavamo sa diska na njegovo mesto


    // videti da li negde treba raditi medjusobno iskuljucivanje pri pristupu blokovima na swap disku
}