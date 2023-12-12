//
// Created by os on 11/23/23.
//

#include "defs.h"

struct FrameEntry {
    PMTEntry* pmtEntry;

};

void
swaping_init(void) {
    // pravljenje neke strukture u kojoj cemo da cuvamo koji blokovi na disku su zauzeti
        // struktura neka bude niz od 16384(to je broj blokova na disku) uint8
        // ako je blok na disku zauzet taj element u nizu je 1, ako nije onda je taj element 0

    // struct FrameEntry {
    //      PMTEntry* ptmEntry;
    //      struct run* OMPointer;
    //      uint8 refBits;
    //      ...;
    //      struct FrameEntry* next;
    //  }


    // treba da napravimo strukturu koja ce sadrzati pointere na pocetak bloka u fizickoj adresi i na pte (page table entry)
    // pravimo novi element te strukture kad god se pozove void* kalloc(void), a da se ne radi o alokaciji stranica za kernel
    // ili o stranicama korisnickih procesa koje su potrebne za obradu stranicnih gresaka
    // tu se takodje cuvaju i biti referenciranja u uint8 koji se periodicno update-uju

    // kada vise nema mesta medju svim strukturama trazimo onu sa najmanjom vrednostcu refBits i nju proglasavamo za victim
    // trazimo blok na disku gde cemo da je smestimo, saljemo je na disk i upisujemo u pte na neki nacin oznaku da je
    // strancia na disku a ne u OM i upisujemo redni broj bloka u pte

    // ucitavamo novu stranicu (ili sa diska ili iz ...)

    // ako se desi page fault onda ponovo trazimo victim, njega izbacujemo a mi se ucitavamo sa diska na njegovo mesto
}