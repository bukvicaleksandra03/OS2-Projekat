## OS2 Projekat

Modification of the xv6 operating system to support page swapping to the swap space and prevent the occurrence of thrashing. This was implemented as part of the Operating Systems 2 course.

Driver for qemu's virtio disk device is in [virtio_disk.c](./kernel/virtio_disk.c).

The largest part of added code is in [swap.c](./kernel/swap.c) and [swap.h](./kernel/swap.h).

[Project specification](./Projektni%20zadatak%20-%202024%20v1.0.pdf)