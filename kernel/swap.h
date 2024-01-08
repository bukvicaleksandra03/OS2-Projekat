//
// Created by os on 12/13/23.
//

#ifndef OS2_PROJEKAT_SWAP_H
#define OS2_PROJEKAT_SWAP_H

struct frame_entry {
    pte_t* pte;              // page table entry
    uint8 ref_bits;          // reference bits
    uint8 swapped;
};

#endif //OS2_PROJEKAT_SWAP_H
