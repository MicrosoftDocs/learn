A lower read rate can mean the stock reporting service received less work, not that it slowed down. In this unit, you compare how much work arrived, how many reads finished, and how long requests took during a healthy period and an incident period. Comparing windows of equal length under similar workloads helps you tell a drop in performance from a change in demand.

Describe the input/output (I/O) workload before looking at disk speed. Record the operation size, mix of reads and writes, access pattern, amount of data accessed repeatedly (the workload's working set), concurrency, and required completion rate.

> [!NOTE]
> **Access pattern and concurrency answer different questions.** Sequential reads move through neighboring file locations. Random reads jump between locations. Concurrency is the number of operations in progress at once: one worker can have four reads outstanding if it submits all four before waiting, or just one if it waits after each read.

Input/output operations per second (IOPS) is an operation rate. State where it's measured: application requests, guest block I/O completions, and I/Os counted by the managed disk aren't necessarily one-to-one. A closed-loop benchmark waits for completions before issuing replacements, so its achieved IOPS alone doesn't establish unmet demand.

A target tells you what the service must complete when enough work is available. To show a shortfall, compare the work offered with the work completed in the same interval. Look for rejected requests, a growing backlog, or a controlled test with enough reads ready to issue. If the service needed only 2,000 reads/s and completed them all on time, that result doesn't tell you whether it could sustain 6,000.

Define success in application terms before examining infrastructure. For the stock reporting service, success requires both 6,000 completed reads per second and 95th-percentile response time below 10 milliseconds at representative demand. Passing one while failing the other isn't success.

A baseline is a comparable healthy observation, not the fastest historical result. Keep the environment, file, operation mix, concurrency, cache policy, and sampling interval stable. Exclude warm-up from the measured interval and record background work. Use Coordinated Universal Time (UTC) for all timestamps.

Consider a separate simulated service where one successful request needs one uncached eight-kibibyte read. Both its VM and its data disk can sustain more than 6,000 reads/s. These two 15-minute windows cover the same VM and disk, offered load, read mix, concurrency limit, cache policy, and burst state:

| Window | Requests offered/s | Requests completed successfully/s | Requests rejected before disk I/O/s | Application p95 for successful requests |
|---|---:|---:|---:|---:|
| Healthy | 6,000 | 6,000 | 0 | 8 ms |
| Incident | 6,000 | 4,000 | 2,000 | 18 ms |

Each p95 is calculated from successful requests across its whole window, not by averaging minute-by-minute percentiles. Reporting rejected requests separately keeps fast failures from hiding the shortfall. Both throughput and successful-request latency worsened; neither observation identifies the cause.

> [!NOTE]
> **Where's the data cached?** A read can be served from memory inside the guest or from a separate cache on the Azure host. Direct I/O bypasses the guest's data cache, not the host cache. With read/write host caching on a supported disk, an ordinary write can be acknowledged at the host cache and written to the managed disk later. Completion alone doesn't establish durability.

The examples use binary units: kibibytes (KiB), mebibytes (MiB), and gibibytes (GiB). Keep those separate from decimal units when comparing rates or published limits.

A file benchmark measures file I/O, not the stock reporting service's full request path. Disk measurements show how many reads finished; timings from the service show whether it met its response-time target.

Average latency hides tails and pauses. A five-minute average can combine a healthy burst period with a throttled sustained period. Preserve per-interval throughput and latency distributions where available. Don't average percentile values from several runs and label the result a combined percentile; retain each run's distribution or aggregate the underlying observations correctly.
