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
                    exit(0);
                }
            }



                for (int s = 0; s < NUM_PAGES; s += 20) {
                    // modify the memory to make sure it's really allocated.
                    for (int l = 0; l < 1000; l++) {
                        for (int m = 1; m < 4096; m++) {
                            *(char *) (pages[s] + 4096 - m) = 1;
                            *(char *) (pages[s+1] + 4096 - m) = 1;
                            *(char *) (pages[s+2] + 4096 - m) = 1;
                            *(char *) (pages[s+3] + 4096 - m) = 1;
                            *(char *) (pages[s+4] + 4096 - m) = 1;
                            *(char *) (pages[s+5] + 4096 - m) = 1;
                            *(char *) (pages[s+6] + 4096 - m) = 1;
                            *(char *) (pages[s+7] + 4096 - m) = 1;
                            *(char *) (pages[s+8] + 4096 - m) = 1;
                            *(char *) (pages[s+9] + 4096 - m) = 1;
                            *(char *) (pages[s+10] + 4096 - m) = 1;
                            *(char *) (pages[s+11] + 4096 - m) = 1;
                            *(char *) (pages[s+12] + 4096 - m) = 1;
                            *(char *) (pages[s+13] + 4096 - m) = 1;
                            *(char *) (pages[s+14] + 4096 - m) = 1;
                            *(char *) (pages[s+15] + 4096 - m) = 1;
                            *(char *) (pages[s+16] + 4096 - m) = 1;
                            *(char *) (pages[s+17] + 4096 - m) = 1;
                            *(char *) (pages[s+18] + 4096 - m) = 1;
                            *(char *) (pages[s+19] + 4096 - m) = 1;
                        }
                    }
                }
            //}

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