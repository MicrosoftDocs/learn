Two workloads can complete the same number of reads per second but use different amounts of bandwidth because their reads differ in size. In this unit, you calculate the bandwidth the stock reporting service needs, then use its completion rate and the average number of reads in flight to estimate how long a disk read takes. That estimate describes individual reads, not how long the dispatcher waits for the report.

Throughput equals operation rate multiplied by mean operation size when the observations describe the same I/O stream and interval. A kibibyte (KiB) is 1,024 bytes. A mebibyte (MiB) is 1,048,576 bytes. A megabyte (MB) is 1,000,000 bytes. Keep the original metric unit and convert explicitly.

For the stock reporting service's target read rate, the arithmetic is as follows.

```text
6,000 operations/s × 8 KiB/operation
= 48,000 KiB/s
= 46.875 MiB/s
= 49.152 MB/s
```

Changing the operation size can change the limiting resource even at the same IOPS. A 150 MiB/s bandwidth ceiling permits only 600 operations per second at 256 KiB per operation. An IOPS limit of 5,000 is irrelevant if bandwidth is exhausted first.

For example, the published Premium solid-state drive (SSD) transaction rule counts a 1 MiB I/O as four 256 KiB I/Os. The byte total is still 1 MiB. For throughput, multiply operations per second by mean operation size **at the same layer**. This disk-family rule isn't a maximum application request size or a guarantee that every Azure Monitor counter reports four operations.

Queue depth is outstanding I/O, not simply the number of threads. With one worker and depth four, up to four operations can be in flight, if the I/O engine supports asynchronous submission. With several workers, total possible outstanding operations multiply. A synchronous engine can ignore your intended deep queue in practice.

To find a steady interval, look for a queue where arrivals and completions stay roughly in balance.
The disk queue can be steady even while more application requests arrive than the disk can serve: the backlog can grow *before* requests reach the disk. Don't combine warm-up, a short burst, and the slower period after the burst into one average.

Little's Law relates the average number of operations in flight, their completion rate, and the average time each spends in the system. Apply it to the same set of operations over a steady interval.

> [!NOTE]
> **Where Little's Law comes from**: Little's Law comes from queuing theory, the study of how work arrives, waits, and finishes. John D. C. Little published a general proof in *Operations Research* in 1961.
>
> Think of a warehouse: each minute a truck spends on site adds one truck-minute to the total. You get the same total whether you add up each truck's time on site or count the trucks present over time. At a steady two departures per minute and an average stay of ten minutes, the warehouse has 20 trucks on site on average. For disk reads, **average reads in flight = completed reads per second × average seconds per read**, including time spent waiting and being served.

For example, if the system averages 32 outstanding operations while completing 3,000 per second, estimate the mean I/O time as follows:

```text
Average outstanding I/O ≈ completed IOPS × mean I/O time in seconds
32 outstanding ÷ 3,000 IOPS ≈ 0.01067 seconds = 10.67 milliseconds
```

Use Little's Law to check whether average latency is consistent with queue depth and completion rate. It can't predict the application's 95th-percentile response time. Device latency, filesystem latency, and application response time have different boundaries. Application response can include request queuing, locks, computation, retries, and several dependent I/O operations.

Sequential reads often benefit from larger transfers and read-ahead. Random reads stress per-operation overhead and access latency. A read-heavy cached workload can behave differently from writes requiring durable storage. Don't compare tests that change access pattern, queue depth, cache state, and disk tier simultaneously.

For baseline utilization, express the completed rate as a percentage of the matching sustained limit for the same disk or VM path: compare IOPS with IOPS, or bytes/s with bytes/s. Use the nonburst limit as the denominator, not the burst maximum. Unmet demand is the gap between required and completed work. A low completion rate is evidence of a shortfall only if the workload needed more.
