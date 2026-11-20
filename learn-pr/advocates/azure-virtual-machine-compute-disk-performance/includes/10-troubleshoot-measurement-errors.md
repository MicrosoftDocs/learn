Measurement faults can resemble performance faults. Correct the measurement before tuning the system.

Use the symptom in the first column to decide which measurement to check before you change the workload:

| Symptom | Check | Required response |
|---|---|---|
| Missing consumed-percentage metric | VM-series support, namespace, scope | Record the missing percentage. Estimate disk utilization from managed-disk rates when available. |
| Missing platform latency | Controller support | Use guest latency; don't substitute zero |
| Application and guest read latency rise while disk and VM IOPS and bandwidth consumption stay low | Outstanding requests, guest, and supported platform latency, application timings, recent disk changes | With one synchronous read outstanding and a mean read time of 20 ms, even back-to-back reads finish at only about 50/s. Low throughput doesn't rule out a slow storage path. |
| Implausible throughput | Bytes versus bits, MB versus MiB, rate versus total | Recalculate with explicit units |
| Different guest and Azure disk rates | LUN mapping, cache hits, other workloads, interval edges | Reconcile boundaries before attribution |
| A gain persists after the original setting is restored | Cache, burst credits, background work | Don't attribute the gain to the changed setting alone |

For example, creating a disk from a snapshot can involve a background copy that temporarily increases read latency. Compare the timing of the operation with the latency change. A recent snapshot restore alone doesn't prove the cause, and mean device latency doesn't establish application p95.

For a Premium SSD v2 or Ultra Disk created from a snapshot, check `CompletionPercent` on the new disk, not the source snapshot. A value below 100 indicates that the disk copy is incomplete. Compare read latency under similar demand before and after completion. For other disk types, this property doesn't establish that hydration finished. An incomplete copy alone doesn't prove the cause of high latency.

## Estimate utilization when the disk percentage is missing

Match the VM attachment to its **managed disk resource**. Use that disk's rates for the same interval. Unlike a read rate reported on the VM for a data-disk LUN, these disk reads exclude requests served by the host cache.

- **IOPS**: Add `Disk Read Operations/sec` and `Disk Write Operations/sec`. If the operations are counted on the same basis as the disk's IOPS limit, divide the sum by the effective nonburst IOPS limit and multiply by 100.
- **Bandwidth**: Add `Disk Read Bytes/sec` and `Disk Write Bytes/sec`. Divide by the disk's sustained throughput in bytes/s and multiply by 100.

In the cache example, 8,000 of 10,000 reads/s hit the host cache. Only 2,000 reads/s reach the disk. Using all 10,000 would overstate disk reads fivefold. Check whether the disk was bursting before interpreting either ratio, and label the result as an estimate rather than the missing Azure metric.

One disk's rates don't tell you the VM's aggregate cached or uncached utilization. If the necessary VM-path measurements aren't available, report the disk estimate and leave the VM percentage unknown.
