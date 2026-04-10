# Operating Systems

#### Tomas Marmay ~ FAMAF 2022

---

### Overview

Labs for the **Operating Systems** course at FAMAF, all built on top of **xv6** — a small Unix-like teaching OS. The labs progress from shell scripting and process primitives, through synchronization and scheduling, to filesystem implementation. Done in a group with Bruno Volpini, Ignacio Ramirez, and Kevin Prieto.

---

### Lab 0 — Unix Shell Scripting

Introduction to Unix tools: shell scripting with `bash`, text processing with `grep`, `sed`, `awk`, `sort`, `cut`, and `wc`. Exercises include sorting datasets, replacing text in files, extracting system info, and batch file renaming.

---

### Lab 1 — Processes & IPC in C

Hands-on exploration of Unix process primitives:

- `fork` / `exec` / `wait` — process creation and lifecycle
- Pipes — inter-process communication (`3_commands_pipe.c`)
- I/O redirection — `dup2`, stdin/stdout rewiring (`redirIN_redirOUT_.c`, `comunication_redirectos.c`)
- Background processes — running jobs without blocking the parent (`background_proces.c`)

---

### Lab 2 — Named Semaphores in xv6

Implemented **named semaphores** as kernel-level synchronization primitives inside xv6, exposing them via new syscalls:

- `sem_open(name, value)` — creates a semaphore; returns error if already in use
- `sem_close(name)` — destroys a semaphore (user has full control over timing)
- `sem_wait` / `sem_post` — down/up operations, using xv6's `sleep`/`wakeup` and `acquire`/`release` spinlocks

The number of available semaphores equals the number of declared syscalls, allowing all syscalls to run concurrently without contention.

**To run:**
```bash
git clone https://<user>@bitbucket.org/sistop-famaf/so22lab2g30.git
cd so22lab2g30
make qemu
```

---

### Lab 3 — Process Scheduler: MLFQ in xv6

Replaced xv6's default **Round Robin** scheduler with a **Multi-Level Feedback Queue (MLFQ)** scheduler, and benchmarked the results.

**Implementation:**
- Added `NPRIO` priority levels (defined in `param.h`) and new fields to the `proc` struct.
- New syscalls: raise priority, lower priority, and count scheduler selections.
- Processes are demoted after using their full quantum (`yield`) and promoted after voluntarily sleeping (`sleep`), rewarding I/O-bound processes.
- Anti-starvation mechanism: every fixed number of ticks, all runnable processes are promoted to the highest priority queue — at zero cost by reusing the existing scheduler loop.

**Benchmarks** (iobench / cpubench at different quantum sizes): CPU-bound and I/O-bound processes were measured under Round Robin and MLFQ. Results showed MLFQ improved I/O throughput in isolated runs, but mixed workloads showed no dramatic improvement due to implementation trade-offs.

**To run:**
```bash
git clone https://<user>@bitbucket.org/sistop-famaf/so22lab3g30.git
cd so22lab3g30
make qemu CPUS=1
```

---

### Lab 4 — FAT32 Filesystem with FUSE ("Big Brother")

Implemented a **FAT32 filesystem** mounted in userspace using **FUSE** (Filesystem in Userspace). The "Big Brother" extension hides files from the user transparently at the filesystem layer — without the user being able to detect it.

**Key concepts explored:**
- FAT table structure: a linked list of clusters stored in RAM, no need to persist on every write.
- Directory entries: manually updated to mark deleted files and maintain the file tree.
- FAT32 addressing: clusters addressed with `u32`, max table size ≈ 2 TB (2³² clusters × 512 bytes).
- FUSE operations: `OPENDIR`, `GETATTR`, `READDIR`, `LOOKUP` — triggered transparently by standard commands like `ls -l`.

**To run:**
```bash
git clone https://marmiiT@bitbucket.org/sistop-famaf/so22lab4g30.git
cd so22lab4g30
make
mkdir mnt
./fat-fuse resources/fatfs.img ./mnt          # mount
./fat-fuse -d resources/fatfs.img ./mnt       # live FUSE operation log
./fat-fuse -f resources/fatfs.img ./mnt       # debug mode
```
