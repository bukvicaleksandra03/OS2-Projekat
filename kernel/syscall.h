// System call numbers
#define SYS_fork    1
#define SYS_exit    2
#define SYS_wait    3
#define SYS_pipe    4
#define SYS_read    5
#define SYS_kill    6
#define SYS_exec    7
#define SYS_fstat   8
#define SYS_chdir   9
#define SYS_dup    10
#define SYS_getpid 11
#define SYS_sbrk   12
#define SYS_sleep  13
#define SYS_uptime 14
#define SYS_open   15
#define SYS_write  16
#define SYS_mknod  17
#define SYS_unlink 18
#define SYS_link   19
#define SYS_mkdir  20
#define SYS_close  21


//int fork()                            Create a process, return child’s PID.
//int exit(int status)                  Terminate the current process; status reported to wait(). No return.
//int wait(int *status)                 Wait for a child to exit; exit status in *status; returns child PID.
//int kill(int pid)                     Terminate process PID. Returns 0, or -1 for error.
//int getpid()                          Return the current process’s PID.
//int sleep(int n)                      Pause for n clock ticks.
//int exec(char *file, char *argv[])    Load a file and execute it with arguments; only returns if error.
//char *sbrk(int n) G                   row process’s memory by n bytes. Returns start of new memory.
//int open(char *file, int flags)       Open a file; flags indicate read/write; returns an fd (file descriptor).
//int write(int fd, char *buf, int n)   Write n bytes from buf to file descriptor fd; returns n.
//int read(int fd, char *buf, int n)    Read n bytes into buf; returns number read; or 0 if end of file.
//int close(int fd)                     Release open file fd.
//int dup(int fd)                       Return a new file descriptor referring to the same file as fd.
//int pipe(int p[])                     Create a pipe, put read/write file descriptors in p[0] and p[1].
//int chdir(char *dir)                  Change the current directory.
//int mkdir(char *dir)                  Create a new directory.
//int mknod(char *file, int, int)       Create a device file.
//int fstat(int fd, struct stat *st)    Place info about an open file into *st.
//int stat(char *file, struct stat *st) Place info about a named file into *st.
//int link(char *file1, char *file2)    Create another name (file2) for the file file1.
//int unlink(char *file)                Remove a file.