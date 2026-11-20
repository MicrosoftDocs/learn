When the stock reporting service misses it's read target, the first question is where the slowdown occurs: inside the guest, at the data disk, or at a storage limit shared by the VM. In this unit, you match guest and Azure measurements for the same disk and time window. You account for reads served from cache and short bursts above baseline before deciding whether a faster disk would help.

A managed disk has its own IOPS and throughput limits. A VM has aggregate storage limits across the relevant attached disks and paths. More attached capacity doesn't automatically increase the VM's aggregate ceiling.

Start with the affected disk's settings. For a Premium SSD, check its assigned performance tier and whether performance plus is enabled. Use the base IOPS and throughput for that tier, or the expanded provisioned limits if performance plus is enabled. A 1,024-GiB disk at the P30 tier has 5,000 provisioned IOPS without performance plus and 8,000 with it. The same 5,000 disk IOPS use 100% of the first limit but only 62.5% of the second.

For a Premium SSD v2, use its provisioned IOPS and throughput. For the VM, use the sustained limits for its size and storage path. In both comparisons, record burst maxima separately: they aren't the limits to use for baseline utilization.

Suppose 10,000 single-operation reads per second reach a cache-enabled attachment and 8,000 hit the host cache. The VM's read metric can show all 10,000, but only the 2,000 misses require managed-disk reads. A hit counts against the VM's cached limit; a miss counts against both its cached and uncached limits. Don't add the two consumed percentages or use all 10,000 reads as the numerator for disk consumption.

The diagram traces workload demand through guest resources to per-disk and VM constraints.

:::image type="content" source="../media/module-overview.svg" alt-text="Diagram that shows how to compare workload demand with guest, disk, and VM limits before testing one change.":::

Use this workflow to identify where work stops progressing at the required rate. Check guest contention before buying storage, then compare the affected disk's utilization with aggregate VM utilization during the same interval. A faster disk can't remove a saturated VM-level path.

Bursting can temporarily raise storage performance above baseline. VM storage bursting, where supported, uses credits. Disk bursting is independent, so a VM and a disk can burst at the same time. Check eligibility for the actual disk type and VM size.

Eligible Premium SSDs of 512 GiB or less and eligible Standard SSDs of 1,024 GiB or less can burst using accumulated credits. Credit-based bursting is best effort. Eligible Premium SSDs larger than 512 GiB can instead use explicitly enabled, billable on-demand bursting. A Premium SSD configured for sharing (`maxShares > 1`) doesn't support disk bursting. Premium SSD v2 supports not disk bursting or host caching.

Metric support depends on the VM series, disk, and controller. Storage consumed-percentage metrics apply to VM series supporting premium storage. The OS and data disk latency metrics are documented for Small Computer System Interface (SCSI) attachments, not remote Non-Volatile Memory Express (NVMe) attachments. If latency is unavailable, use time-aligned guest evidence; a missing value isn't zero.

Most disk metrics are emitted every minute. Storage burst-credit percentages are emitted every five minutes and on-demand burst operation counts every hour. A one-minute chart doesn't create one-minute observations for either of those slower series.

Use the following mapping when reading the VM's **Metrics** blade.

| Measurement | Resource and dimension | Interpretation |
|---|---|---|
| Data Disk Read Operations/Sec and Data Disk Write Operations/Sec | VM, split or filter by LUN | Separate completion rates for the attachment. The read rate includes host-cache hits. |
| Data Disk Read Bytes/Sec and Data Disk Write Bytes/Sec | VM, same LUN and interval | Separate byte rates. Read bytes include those served by the host cache. |
| Data Disk IOPS/Bandwidth Consumed Percentage | VM, same LUN | Per-disk limit pressure |
| VM Uncached IOPS/Bandwidth Consumed Percentage | VM aggregate | Shared uncached-path pressure |
| VM Cached IOPS/Bandwidth Consumed Percentage | VM aggregate, when supported | Pressure on the VM's cached limit, which includes local temporary-drive I/O on applicable sizes with host caching enabled. |
| Data Disk Latency | VM, by LUN on supported SCSI attachments | Mean I/O time in milliseconds |
| Data Disk Queue Depth | VM, by LUN where available | Count of outstanding requests, reported with Average. Check availability for this metric separately from latency. |

Don't average percentages across LUNs to identify a hot disk. A saturated disk and an idle disk can average to 50%. Similarly, an aggregate VM metric includes more than the application's data disk. Account for operating-system and other-disk activity before assigning every operation to your workload.

If host caching is enabled, check the VM size's local-storage specification to see whether host caching and the temporary drive share IOPS and bandwidth limits. If they do, a high VM cached percentage alone can't tell you which one is busy. Compare guest activity on the mapped temporary device with activity on the affected managed-disk LUN over the same interval. Don't count temporary-drive I/O against that LUN.

## Compare guest and Azure measurements

The example later in the module uses one minute from the simulated VM D trace in the next section. In this fixture, the input data being read and the output stock report are both on the `F:` volume. Before interpreting its read rate, the engineer needs to find the Azure metric for that same disk and minute. Windows identifies the guest disk by number, while Azure groups data-disk measurements by LUN.

In the example simulated Windows SCSI view at 12:12 UTC, `F:\reports` is on guest Disk 4. Its disk location shows LUN 2, which VM D's attachment inventory names `orders-data`. A second disk of the same size is attached at LUN 3. Match Disk 4's 2,990 reads/s to `Data Disk Read Operations/Sec` for **VM D, LUN 2, 12:12 to 12:13 UTC**, not LUN 3 or the VM-wide total.

A guest disk number, drive letter, or NVMe namespace number isn't an Azure LUN. For a pooled Windows volume, identify each backing disk.

On Linux, start with the filesystem that serves the file. If `findmnt -T /srv/reports/stock.csv` shows `/` as the mount target, the file is on the root filesystem, not on a separate filesystem mounted at `/srv/reports`. If the source is a logical volume or software RAID device, follow the `lsblk` tree to each backing disk. Match each remote data disk to its LUN on the same VM using its SCSI location or Azure NVMe identification metadata or by-LUN link. If the mapping is missing, leave the LUN unknown. Compare the member disks separately: adding the logical volume's I/O to its members' I/O would count the same work twice.

The table shows alternative Windows and Linux views of the same simulated workload, not two guests on one running VM.

| Measurement | Linux `iostat` | Windows `PhysicalDisk` |
|---|---|---|
| Completed reads per second | `r/s`: 2,990 | `Disk Reads/sec`: 2,990 |
| Read throughput | `rkB/s`: 23,920 KiB/s | `Disk Read Bytes/sec`: 24,494,080 bytes/s |
| Mean read latency | `r_await`: 10.7 milliseconds | `Avg. Disk sec/Read`: 0.0107 seconds |
| Outstanding requests | `aqu-sz`: 32 on average | `Current Disk Queue Length`: 32 at the instant sampled |

> [!NOTE]
> **Average or snapshot?** An interval average of 32 outstanding requests supports a queuing calculation. A single Windows sample of 32 doesn't: the queue might have been nearly empty for the rest of the minute.

In this read-only example, reads account for the device queue. With mixed traffic, Linux `r_await` and Windows `Avg. Disk sec/Read` time reads only. Azure `Data Disk Latency` covers all I/O on the supported attachment, and `aqu-sz` includes other device requests. Don't combine the whole queue with read IOPS alone.

To combine guest read-latency means, weight each by its number of completed reads. If 900 reads average 1 ms and another 100 average 11 ms, the combined read mean is `(900 × 1 + 100 × 11) ÷ 1,000 = 2 ms`, not 6 ms.

Linux `iostat` reports `%util` as the percentage of elapsed time the device had I/O activity. A parallel SSD can be busy for the whole minute without using all its IOPS or bandwidth. For the mapped disk in that minute, compare completed IOPS and bytes/s with disk and VM limits, then check queue depth and latency. Device busy time isn't the CPU's I/O-wait percentage.

In environments D and V, host caching is off for the workload data disk. All measured workload reads reach that disk on the uncached path, and traffic from the OS disk and other disks is negligible. The guest and data-disk rates describe the same completed reads, so you can compare that rate with both the disk's limit and the VM's uncached limit. Where the paths or workloads differ, use the disk consumed percentage for the affected LUN and the applicable cached or uncached percentage for the VM as a whole.
