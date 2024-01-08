#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

int
main(int argc, char *argv[]) {
    uint64 pages[200];
    int s, k;

    for (int i = 0; i < 6000; i++) {
        uint64 a = (uint64) sbrk(4096);

        if (a == 0xffffffffffffffff) {
            printf("no space\n");
            exit(0);
        }

        if (i < 200) pages[i] = a;

        // modify the memory to make sure it's really allocated.
        *(char *) (a + 4096 - 1) = 1;
    }

    for (s = 0; s < 200; s += 5) {
        for (k = 0; k < 50; k++) {
            // modify the memory to make sure it's really allocated.
            *(char *) (pages[s] + 4096 - 1) = 67;
            //printf("modified\n");
            *(char *) (pages[s + 1] + 4096 - 1) = 67;
            *(char *) (pages[s + 2] + 4096 - 1) = 67;
            *(char *) (pages[s + 3] + 4096 - 1) = 67;
            *(char *) (pages[s + 4] + 4096 - 1) = 67;
        }
    }

    for (s = 0; s < 200; s += 5) {
        // modify the memory to make sure it's really allocated.
        if (*(char *) (pages[s] + 4096 - 1) != 67) printf("not the same\n\n\n");
        if (*(char *) (pages[s + 1] + 4096 - 1) != 67) printf("not the same\n\n\n");
        if (*(char *) (pages[s + 2] + 4096 - 1) != 67) printf("not the same\n\n\n");
        if (*(char *) (pages[s + 3] + 4096 - 1) != 67) printf("not the same\n\n\n");
        if (*(char *) (pages[s + 4] + 4096 - 1) != 67) printf("not the same\n\n\n");
    }

    printf("new_maxout_vm test finished\n");
    exit(0);
}
