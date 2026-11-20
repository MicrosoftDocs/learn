A low read rate tells you the stock reporting service is falling behind only if it has more work to do. In this unit, the workload needs 6,000 reads per second. You compare its measured read rate with the data disk's IOPS limit and the VM's shared uncached IOPS limit. Bandwidth, processor, and memory readings help you check whether another constraint explains the shortfall.

In both simulated environments, the service issues random 8-KiB reads with up to 32 operations outstanding. Host caching is off for the workload data disk, and all measured workload reads reach it. Neither guest is under memory pressure. During the measured period, neither the disk nor the VM is bursting: credit-based resources stay within their nonburst limits, and on-demand disk bursting isn't active. Each row in the measurement table summarizes one minute of a 15-minute steady period.

Compare the limit on each data disk with the uncached storage limit shared by its VM:

| Environment | Data disk limit | VM uncached aggregate limit | Other-disk activity |
|---|---|---|---|
| D | 3,000 IOPS; 150 MiB/s | 12,000 IOPS; 200 MiB/s | Negligible in this fixture |
| V | 12,000 IOPS; 200 MiB/s | 4,000 IOPS; 100 MiB/s | Negligible in this fixture |

The following measurements show the completed read rate, use of each IOPS limit, and application response time in the same three minutes:

| UTC minute | Environment | Completed IOPS | Disk IOPS % | VM uncached IOPS % | MiB/s | Mean I/O ms | Application p95 ms |
|---|---|---|---|---|---|---|---|
| 12:10 | D | 2,985 | 99.5 | 24.9 | 23.32 | 10.7 | 26 |
| 12:11 | D | 2,995 | 99.8 | 25.0 | 23.40 | 10.7 | 25 |
| 12:12 | D | 2,990 | 99.7 | 24.9 | 23.36 | 10.7 | 26 |
| 12:10 | V | 3,985 | 33.2 | 99.6 | 31.13 | 8.0 | 19 |
| 12:11 | V | 3,995 | 33.3 | 99.9 | 31.21 | 8.0 | 18 |
| 12:12 | V | 3,990 | 33.3 | 99.8 | 31.17 | 8.0 | 19 |

Processor utilization is 35% to 42% in D and 40% to 48% in V, with no sustained runnable backlog. Available memory exceeds 3 GiB; paging and swap activity are negligible. These supporting observations reduce the likelihood of guest pressure.

For D, 2,990 divided by 3,000 is 99.67%, while 2,990 divided by 12,000 is 24.92%. The throughput is 2,990 multiplied by 8 divided by 1,024, or 23.36 MiB/s. Neither bandwidth ceiling is approached. D is disk-IOPS capped.

For V, the same arithmetic shows approximately 100% of VM uncached IOPS but only one-third of the disk's IOPS allocation. A faster disk can't raise the aggregate VM ceiling. V is VM-IOPS capped, not disk capped.

At 12:12 UTC, D completes 2,990 reads/s at a mean of 10.7 ms. Little's Law gives `2,990 × 0.0107 ≈ 32` outstanding reads, consistent with the Linux interval average. For V, `3,990 × 0.008 ≈ 31.9` is consistent with the configured maximum of 32. V has no measured mean queue depth, so the setting isn't an independent check.

Neither calculation estimates application p95. The application measures whole requests, not individual disk operations. In each of the three displayed minutes, both environments completed fewer than 6,000 reads/s and had application p95 above 10 ms. To evaluate p95 for the full 15-minute period, use the application request durations from that period. Averaging the three minute-level percentiles won't give you that result.
