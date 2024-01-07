//
// Created by os on 1/6/24.
//

#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

#define NUM_PAGES 400

int
main(int argc, char *argv[]) {
    int pid;
    enum { N=50 };

    for(int i = 0; i < N; i++){
        pid = fork();
        if(pid < 0){
            printf("fork failed\n");
            exit(1);
        }
        if(pid == 0) {
            for(int m = 0; m < 1000000; m++);


            uint64 pages[NUM_PAGES];

            for (int k = 0; k < NUM_PAGES; k++) {
                uint64 a = (uint64) sbrk(4096);
                pages[k] = a;
                if (a == 0xffffffffffffffff) {
                    printf("doesn't work\n");
                    break;
                }
            }


            for (int k = 0; k < 100000; k++) {
                for (int s = 0; s < NUM_PAGES; s ++) {
                    // modify the memory to make sure it's really allocated.
                    *(char *) (pages[s] + 4096 - 1) = 1;
                }
            }
            exit(0);
        }
    }

    int xstatus;
    for(int i = 0; i < N; i++){
        wait(&xstatus);
        if(xstatus != 0) {
            printf("fork in child failed\n");
            exit(1);
        }
    }

    printf("thrashing test finished\n");
    exit(0);
}