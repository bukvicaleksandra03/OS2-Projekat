#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"

int
main(int argc, char *argv[]) {
    // originaly was 6000
    for (int i = 0; i < 5000; i++) {
        uint64 a = (uint64) sbrk(4096);
        if (a == 0xffffffffffffffff) {
            printf("doesn't work\n\n\n");
            break;
        }

        // modify the memory to make sure it's really allocated.
        *(char *) (a + 4096 - 1) = 1;
    }

    printf("maxout_vm test finished\n\n\n");
    exit(0);
}
