//
// Created by os on 12/12/23.
//

#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "swap.h"
#include "defs.h"

#define SWAP_FRAMES 16384       // number of swap disk frames of 1kB
#define SWAP_SLOTS SWAP_FRAMES/4

struct swap_frame swap_frames[SWAP_SLOTS];


uint16
free_slot_on_swap(void) {
    for (uint16 i = 0; i < SWAP_SLOTS; i++) {
        if(swap_frames[i].is_free == 1) return i;
    }
    return SWAP_SLOTS; // ako nema dovoljno slotova
}

void
swaping_init(void) {
    printf("began swaping init\n");
    // pravljenje neke strukture u kojoj cemo da cuvamo koji blokovi na disku su zauzeti
        // struktura neka bude niz od 16384(to je broj blokova na disku) uint8
        // ako je blok na disku zauzet taj element u nizu je 1, ako nije onda je taj element 0

    for (uint32 i = 0; i < SWAP_SLOTS; i++) {
        swap_frames[i].is_free = 1;
    }

    // pravimo niz struktura frame_entry, niz ima onoliko elemenata koliko ima blokova u OM
    uint32 frames_number = (uint32)(((uint64)PHYSTOP>>12) - ((uint64)KERNBASE>>12));
    struct frame_entry frame_entries[frames_number];
    for (uint32 i = 0; i < frames_number; i++) {
        frame_entries[i].pte = 0;
        frame_entries[i].ref_bits = 0;
    }

    for (uint32 i = 0; i < SWAP_SLOTS; i++) {
        printf("%d", swap_frames[i].is_free);
    }

    for (uint32 i = 0; i < frames_number; i++) {
        printf("%d", frame_entries[i].pte);
        printf("%d", frame_entries[i].ref_bits);
    }

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