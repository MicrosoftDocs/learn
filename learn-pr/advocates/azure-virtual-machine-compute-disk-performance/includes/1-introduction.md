At 6 a.m., a warehouse dispatcher is waiting for the stock report before releasing the first truck. The report hasn't come through as usual. The stock reporting service generates the report on an Azure VM, and a quick check shows that disk reads on that VM have spiked. Before allocating faster storage, the on-call engineer needs to know: Is storage holding up the report, or is the VM short on memory and reading data it normally keeps in RAM?

You start the investigation with two questions: how much work does the stock reporting service need to complete, and how quickly must it respond? You compare its symptoms with measurements from the guest operating system and Azure for the same disk and time window to decide whether a faster disk would help.

The stock reporting service has two targets: complete 6,000 random reads per second, each eight kibibytes in size, and keep its 95th-percentile (p95) response time below 10 milliseconds. During the incident it completes fewer operations, response time rises, and disk activity is high. The team proposes a faster managed disk.

> [!NOTE]
> **What p95 tells you:** If p95 is 14 milliseconds, about 95% of requests finished in 14 milliseconds or less. The slowest requests form the *tail*. A mean response time of 8 milliseconds doesn't tell you whether the stock reporting service met its p95 target.

Before replacing the disk, consider three other explanations:

- The VM might already be at its shared storage limit.
- Low memory might be generating extra disk reads.
- The stock reporting service might be issuing reads too slowly.

The worked examples follow the stock reporting service in two VM configurations. In each, you check whether the service completes 6,000 random reads per second and keeps its p95 response time below 10 milliseconds. Comparing the measured read rate with the disk and VM limits explains why a faster disk increases the read rate in one configuration but not the other.

For compute and storage, the examples compare what Azure reports for the VM and its disks with what the guest (the operating system inside the VM) sees. For a remote call, they also use the application's trace and measurements between the two endpoints.

Disk capacity tells you how much data a disk can hold, not how quickly it can serve the report. An eight-kibibyte read counts as one operation and transfers eight kibibytes. Compare both the operation rate and the byte rate with the disk's limits and the limits shared by its VM's attached disks.

Before comparing the two sources, establish which disk holds the application's data. Its logical unit number (LUN) identifies the Azure attachment. A spike on the operating system (OS) disk isn't evidence that the data disk reached its limit.

Match the LUN to the disk the guest sees, then follow that disk to the partition, filesystem, and mount point or drive letter that contains the file. The examples below show why that last step matters.

**Windows**: Trace the stock report from the `F:` volume on guest Disk 4 to the Azure data disk attached at LUN 2.

:::image type="content" source="../media/disk-attachment-to-file.svg" alt-text="Diagram that shows Azure LUN 2 mapped to Windows Disk 4 and its F: volume, where the stock report is stored.":::

**Linux**: If the data disk isn't mounted at `/srv/reports`, writing to the same report path can put the file on the OS disk instead.

:::image type="content" source="../media/linux-mount-write-destination.svg" alt-text="Diagram that shows writes to /srv/reports reaching the data disk when mounted and the OS disk when the mount is missing.":::

These diagrams locate the file the service writes. To investigate slow reads, map the input file involved in those reads. Its volume isn't necessarily the volume holding the output report.

The same disk can look busy in one chart and quiet in another if the charts cover different periods. Compare per-LUN rates over the same full minute when both sources report at that resolution. For less frequent measurements, choose a longer window that both sources cover.

> [!NOTE]
> **Read an Azure chart in three steps.** The *dimension* identifies a series, such as the disk at LUN 0. The *time bin* groups readings into an interval. The *aggregation* summarizes those readings. Where a metric offers Maximum, it shows the largest value captured, not every peak the workload experienced. Selecting a finer interval can't recover a missed spike.
