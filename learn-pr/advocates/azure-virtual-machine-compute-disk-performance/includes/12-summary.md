In each displayed baseline minute, the stock reporting service missed both targets in both environments. A faster disk increased the read rate in D but not in V. D still missed both targets after the upgrade. Its processor readings justify investigating CPU contention, not prescribing more CPU.

In V, the disk-only trial still completed 3,990 reads/s. It didn't report application p95, so the effect on latency is unknown. Only the separate trial that raised the VM's uncached limit met both targets: 6,000 reads/s and an application p95 of 8 ms.

A controlled experiment can reveal improvement, no improvement, or a newly exposed constraint. Carry that result, including uncertainty and residual limits, into rightsizing. The goal is a justified operational decision, not the largest benchmark number.

When local CPU, memory, and disk measurements don't explain a slow request, compare time spent in the caller, on the path, and at the remote service before recommending a VM change.

## More info

These references explain the guest counters, storage limits, dependency traces, and network metrics used in the examples.

- [Monitor Windows Server performance](/training/modules/monitor-windows-server-performance/)
- [Attribute high CPU usage to Windows processes and threads](/troubleshoot/windows-server/performance/troubleshoot-high-cpu-usage-guidance)
- [B-series CPU credits and base CPU performance](/azure/virtual-machines/sizes/b-series-cpu-credit-model)
- [Interpret Windows hard page faults and pagefile performance counters](/troubleshoot/windows-client/performance/how-to-determine-the-appropriate-page-file-size-for-64-bit-versions-of-windows)
- [Add and size disks in Azure virtual machines](/training/modules/add-and-size-disks-in-azure-virtual-machines/)
- [Map Azure disks to Windows guest disks](/azure/virtual-machines/windows/azure-to-guest-disk-mapping)
- [Identify Linux SCSI and NVMe disks with Azure VM utilities](/azure/virtual-machines/linux/azure-virtual-machine-utilities)
- [Virtual machine and disk performance](/azure/virtual-machines/disks-performance)
- [Azure managed disk types and Premium SSD transaction accounting](/azure/virtual-machines/disks-types)
- [Credit-based and on-demand disk bursting, and VM storage bursting](/azure/virtual-machines/disk-bursting)
- [Disk metrics and controller limitations](/azure/virtual-machines/disks-metrics)
- [Supported Azure VM metrics, units, and dimensions](/azure/azure-monitor/reference/supported-metrics/microsoft-compute-virtualmachines-metrics)
- [How Azure Monitor aggregates metrics](/azure/azure-monitor/metrics/metrics-aggregation-explained)
- [Benchmark applications on Azure Disk Storage](/azure/virtual-machines/disks-benchmarks)
- [Azure disk performance design: throughput, latency, and queue depth](/azure/virtual-machines/premium-storage-performance)
- [John D. C. Little, “A Proof for the Queuing Formula: L = λW” (1961)](https://doi.org/10.1287/opre.9.3.383)
- [Read Windows performance counters with Get-Counter (PowerShell 7.6 LTS)](/powershell/module/microsoft.powershell.diagnostics/get-counter?view=powershell-7.6&preserve-view=true)
- [Track dependency calls in Application Insights](/azure/azure-monitor/app/dependencies)
- [Measure network reachability and latency with Connection Monitor](/azure/network-watcher/connection-monitor-overview)
- [Understand Azure VM network throughput and outbound bandwidth](/azure/virtual-network/virtual-machine-network-throughput)
- [Compare base, expanded, and burst limits for a Premium SSD](/azure/virtual-machines/disks-scalability-targets#premium-ssd-managed-disks-per-disk-limits)
- [Find read and write rates on the managed disk resource](/azure/azure-monitor/reference/supported-metrics/microsoft-compute-disks-metrics)
- [Interpret Linux disk busy time, queue depth, and latency with iostat](https://man7.org/linux/man-pages/man1/iostat.1.html)
- [Understand Azure Advisor's VM resize criteria](/azure/advisor/advisor-cost-recommendations#resize-sku-recommendations)
- [Check host-caching and bursting restrictions on shared Premium SSDs](/azure/virtual-machines/disks-shared#premium-ssd)
- [Distinguish Connection Monitor RTT, failed checks, and test-result metrics](/azure/azure-monitor/reference/supported-metrics/microsoft-network-networkwatchers-connectionmonitors-metrics)
- [Check background-copy status after restoring a disk from a snapshot](/azure/virtual-machines/scripts/virtual-machines-powershell-sample-create-managed-disk-from-snapshot#performance-impact---background-copy-process)
- [Understand VM resize outcomes and allocation failures](/azure/virtual-machines/sizes/resize-vm)
- [Read operation outcomes in the Azure activity log](/azure/azure-monitor/fundamentals/activity-log)
