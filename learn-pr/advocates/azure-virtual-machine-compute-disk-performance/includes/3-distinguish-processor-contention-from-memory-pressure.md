A late stock report can look like a storage problem even when the data disk has capacity to spare. The stock reporting service might not get enough processor time to issue reads, or a shortage of memory might force the operating system to read data back from disk. In this unit, you compare processor activity, available memory, and paging with request latency over the same interval to see which explanation fits.

Low total processor utilization can hide a bottleneck in the one thread that issues reads. Compare per-process and per-core activity with the number of requests waiting and the rate at which they finish.

> [!NOTE]
> **Running, runnable, or waiting?** A process contains one or more threads. A running thread is using a logical processor. A runnable thread is ready for one. A thread blocked on a disk read is waiting, not runnable. One busy thread can use a whole logical processor while the other three on a four-processor VM are idle, even if it's only spinning in a loop.

On Linux, `pidstat` attributes processor and I/O activity to processes. `vmstat` shows runnable work, memory, and swap rates. `iostat` shows block-device activity. Linux I/O wait isn't a direct percentage of disk saturation: it's a processor accounting state observed while work waits.

Check the timestamps before comparing Linux rates with an Azure chart. By default, the first `iostat` report summarizes activity since boot. The first `vmstat` report also shows rates averaged since boot, but its process and memory fields are current snapshots. For incident rates, use subsequent interval reports that cover the Azure time bin. When collecting `iostat` at an interval, add `-y` to skip the initial report.

On Windows, Performance Monitor and `Get-Counter` provide process, processor, memory, and physical-disk evidence. Process `% Processor Time` can exceed 100 across multiple logical processors. To express a process's `% Processor Time` as a share of the whole VM, divide it by the number of logical processors. For example, 100% on a four-processor VM is 25% of the VM's total processor capacity. The `CPU` value from `Get-Process` is cumulative processor time, not an instantaneous utilization percentage.

On a B-series VM, compare `CPU Credits Remaining` with `Percentage CPU`, the size's base CPU performance, and guest runnable work over the same interval. If demand stays high but credits run out and CPU performance settles near the base level, CPU-credit throttling is plausible even when total CPU is well below 100%. A zero balance during an idle period isn't evidence of a bottleneck. CPU credits are separate from storage burst credits.

When available memory falls and disk reads rise, first find out what the guest is reading. Reads from the OS disk might be bringing memory pages back into use rather than serving requests for the application data file.

> [!NOTE]
> **Virtual memory and paging:** A page is a block of memory. A process's resident set (called its working set on Windows) consists of pages currently in physical memory. If a needed page isn't resident, the OS may have to read it from a file, the Windows pagefile, or Linux swap. A Windows hard page fault means a read was necessary, not necessarily a pagefile read. *Thrashing* means repeated paging leaves little time for useful work.

These simulated Windows and Linux observations show the same pattern of memory pressure. Each guest is compared with its own healthy window. Read each counter in its own units. On Linux, the `available` column of `free -m` estimates how much memory can be used without swapping, in MiB. The `free` field in `vmstat` counts only unused memory.

| Evidence | Windows example | Linux example | Interpretation |
|---|---|---|---|
| Memory available | 120 MiB of 8 GiB | `free -m`: 130 MiB `available` of 8 GiB | Very little immediately usable headroom |
| Paging or swap | Sustained Pages Input/sec near 3,000 | `si` around 12 MiB/s after unit normalization | Significant memory-related reads |
| Processor | 38% total, increasing privileged time | 20% user, 18% system, elevated wait | Processor alone doesn't explain response time |
| Disk mapping and activity | The pagefile is on the OS disk; OS-disk reads/s rose | Swap is on the OS disk; OS-disk reads/s rose | On each VM, the application data disk's IOPS and bandwidth consumed percentages both stayed below 20% |
| Application | Working set grows; response tail rises | Resident set grows; response tail rises | Test memory demand and allocation |

> [!NOTE]
> **What the memory counters count:** Windows `Pages Input/sec` counts pages read from disk to resolve hard page faults, including reads from mapped files. Linux `vmstat` reports `si` as a rate of data read from swap. Check the reporting unit before converting it to MiB/s. Similar rates support a similar diagnosis, not a claim that the counters measure identical traffic.

At 4 KiB per page, 3,000 pages brought in per second represent approximately 11.72 MiB/s of page data. That isn't necessarily 3,000 disk read requests/s, nor does it mean all those bytes came from the pagefile.

Low available memory, a growing process working set, rising OS-disk reads, and worsening application latency together support investigating memory pressure. They don't identify the backing file for every read. Identify the process whose memory use grew before proposing a faster data disk. Disabling paging or swap on a production VM isn't a safe way to test the hypothesis.
