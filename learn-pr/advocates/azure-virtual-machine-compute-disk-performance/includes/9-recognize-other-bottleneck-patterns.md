A workload can miss its performance target for reasons that call for different fixes. In this unit, you'll distinguish four patterns: large reads reaching the VM's bandwidth limit, a single thread unable to issue reads fast enough, memory pressure causing extra disk reads, and a disk returning to baseline when its burst credits run out. For each pattern, look for a measurement that supports the diagnosis and one that makes a competing explanation less likely.

These four cases show why the busiest-looking resource isn't always the one to resize. U1 through U3 describe sustained behavior without bursting. U4 shows what happens when burst credits run out.

In U1, each 256-KiB workload read reaches the managed disk as one 256-KiB read. Host caching is off, other storage traffic is negligible, and the VM's 150 MiB/s ceiling is its sustained uncached bandwidth limit. The observed 149.5 MiB/s is traffic on this path.

| Case | Workload and observations | Limits and context |
|---|---|---|
| U1 | 256 KiB sequential reads; demand 1,200 IOPS; observed 598 IOPS, 149.5 MiB/s; processor 30%, memory healthy | Disk 5,000 IOPS and 250 MiB/s; VM 20,000 IOPS and 150 MiB/s |
| U2 | 8 KiB random reads; four cores, total processor 25%; per-thread samples attribute 98% to 100% of one core to the application's sole I/O-issuing thread; that thread remains running or runnable while its application work queue grows; low disk and VM consumed percentages | Memory healthy, no burst or cache transition, application misses throughput |
| U3 | Data LUN reads 300 IOPS; OS disk reads rise sharply; available memory 100 MiB; sustained swap or pagefile-related reads; response tail worsens | Data-disk and VM limits below 30%; application working set grows |
| U4 | First two minutes 3,400 IOPS; later 240 IOPS; unchanged workload; initially available credits are consumed to exhaustion | Burst-to-baseline transition: disk baseline 240 IOPS, burst envelope 3,500; VM headroom remains |

Each diagnosis below identifies the observation that makes a competing explanation less likely.

| Case | Diagnosis and rationale |
|---|---|
| U1 | The VM's 150 MiB/s limit allows 600 reads/s at 0.25 MiB per read, close to the observed 598. If the VM bandwidth limit rises above 250 MiB/s, the disk's 250 MiB/s is the lower bandwidth limit. It allows **at most 1,000 reads/s** at this read size. Measure again to see whether the workload reaches that rate or another constraint appears first. The target of 1,200 reads/s needs **300 MiB/s** from both the disk and the VM, plus headroom in practice. Raising only the disk's IOPS limit addresses neither bandwidth constraint. |
| U2 | The thread that issues reads is processor-limited. Its processor use, runnable state, and growing work queue connect the saturated core to unmet demand. The VM-wide average of 25% doesn't show that on its own. Check whether the thread is doing useful work or spinning, then test parallelism only if the application supports it. The evidence doesn't justify a storage upgrade. |
| U3 | Guest memory pressure is the leading explanation. Locate the pagefile or swap and compare that device's activity with the incident. Working-set growth alone doesn't identify the process responsible for the reads. Windows hard faults can also read mapped files. Compare process memory use with the healthy window before changing memory limits. If you test lower concurrency, keep offered demand comparable and check completions and application latency. Don't disable paging. |
| U4 | The fixture states that the disk's credits ran out. The fall to its 240 IOPS baseline is consistent with that explanation; the two fast minutes don't establish sustained capacity. A similar rate drop alone wouldn't identify which layer ran out of credits. |

For an uncached workload like U4, compare the affected LUN's `Data Disk Target IOPS` and `Data Disk Used Burst IO Credits Percentage` with `VM Uncached Used Burst IO Credits Percentage` on the VM. For a bandwidth bottleneck, compare the corresponding bytes-per-second (BPS) credit percentages. Five-minute credit reports can show the change across a longer window, not the exact minute credits ran out. For disks using on-demand bursting, the hourly `Disk On-demand Burst Operations` metric on the disk resource counts burst transactions. It isn't a remaining-credit gauge or an IOPS rate.

> [!NOTE]
> An Azure Advisor cost recommendation to resize a VM uses CPU, memory, and outbound network utilization over a lookback period. It doesn't measure the application's p95 or the uncached disk IOPS it needed during this incident. Even if the suggested size supports the same disk type, compare its sustained IOPS and bandwidth with the workload's requirements. The recommendation is one input, not approval to resize.

## Justify resize recommendation

A useful handoff names the capability the workload needs before naming a VM size. For environment V, a recommendation to M11 could read:

> **Don't upgrade the disk.** At 12:12 UTC the stock reporting service completed 3,990 reads per second on VM V, using 99.8% of the VM's uncached IOPS but only 33.3% of the disk's IOPS. A disk upgrade left throughput unchanged. Raising only the VM limit in the simulation allowed 6,000 reads per second at 8 ms application p95. Evaluate compatible VM sizes that can sustain 6,000 uncached reads/s at 8 KiB per read (46.875 MiB/s), with headroom for other disk traffic on the VM. Under representative demand, confirm both the read rate and an application p95 below 10 ms.

The simulation supports evaluating a VM change, not promising a production result. M11 still needs representative production measurements, regional capacity, cost, expected disruption, and a rollback plan before recommending a specific size.
