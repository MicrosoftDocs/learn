Atlas can be offline for up to 20 minutes, but restarting the VM within that window doesn't prove the resize worked. In this unit, you decide what the operator needs to know before interrupting Atlas, how to tell whether it still processes receipts correctly at peak demand, and how to recover if the original size is unavailable.

## Capture the starting state

A resize of a running VM causes a restart even when prior deallocation is unnecessary. If the desired size isn't available on the current hardware cluster, deallocation might be required. Deallocation releases the compute allocation and can affect dynamic address assignments; verify the exact public and private address configuration and dependencies.

Operating system and data disks persist through an ordinary resize, but local temporary storage must never hold irreplaceable data. Record the current size, power state, VM generation, and security type.

Inventory the network interfaces, private addresses, any public addresses, and whether each address is static or dynamic. Record the Domain Name System (DNS) entries that point to them. If a dynamic address changes after deallocation, those entries and any application using the old address need to be checked.

Map each Azure disk to its volume or drive letter in the guest and record its cache settings. Identify the latest successful backup and any restore check showing that you can recover the required data from it. Record how long each disk and backup must be retained: deleting the VM won't necessarily remove them or their charges.

Record the processor count and memory visible inside the guest so you can compare them after the attempt. If allocation fails, Azure's stored configuration can show the requested size while the guest still runs on the previous resources. Confirm the operation result and the running guest resources before declaring success.

## Define a bounded change plan

For Atlas, the operator proposes a single disposable VM with no production traffic or business records. The plan identifies a private management path, such as an existing Azure Bastion host, and an owner for networking, monitoring, and recovery. Permission to resize a VM doesn't grant a Windows sign-in, permission to join a subnet outside the role's scope, or access to billing records. Private guest access also doesn't guarantee connectivity to monitoring or recovery services.

The funding owner approves the cost of the baseline, observation, recovery, and cleanup, including retained disks and backups. A Cost Management budget alert isn't a hard cap or an automatic shutdown. The operator needs a runtime limit and a cleanup deadline independent of any alert.

Use these conditions to decide whether the canary is ready to start and whether the resize succeeds:

| Gate | Required condition |
|---|---|
| Target | D4s v5 to D2s v5, same approved region, and compatible placement |
| Management and dependencies | Proven private guest access, required endpoint connectivity, and working approved monitoring and recovery arrangements before resize |
| Disruption | At most 20 minutes in the synthetic maintenance window |
| Correctness | A basic check produces the expected report. Under representative demand, all service operations complete without failure and all receipts have the expected results. |
| Performance | Representative service P95 at most 250 ms and at least 100 completed service operations per second, using the approved latency population/window and throughput interval under matched demand |
| Resource headroom | Pass the preapproved CPU, guest memory/commit/paging, disk/VM I/O, and relevant network criteria; record each metric, statistic, interval, threshold, and sustained-duration rule with supporting observations |
| Recovery | Approved alternate capacity or recovery path; the previous size isn't guaranteed to be available |
| Budget | Named funding owner, approved spend ceiling, maximum runtime and disposable-resource lifetime, and owned stop/cleanup deadline covering observation and recovery |
| Stop | A required check fails, funding expires, or necessary evidence is unavailable. Don't accept the canary or continue rollout. |

Plan how to restore acceptable service within the approved interruption. Rolling back to the previous size is one possible recovery action, not a guarantee: deallocation releases the original host, and the previous size might no longer be available. If no approved recovery option meets the time limit, abort before changing anything.

In the Atlas scenario, the business service runs elsewhere. Leaving the isolated canary stopped for investigation can contain a failed change and prevent further rollout. Containment limits the impact; it doesn't demonstrate that service was restored.

## Prepare observation

In Azure Monitor, record the interval each platform metric represents (its time grain), how the samples are combined (aggregation), and the period actually covered. The reporting interval can differ from a guest counter's collection interval. Percentage CPU and the VM/disk I/O metrics used here support a one-minute time grain, while some burst-credit metrics update less often. Record gaps rather than treating missing samples as zero.

Inspect **VM Uncached IOPS Consumed Percentage**, **VM Uncached Bandwidth Consumed Percentage**, and the relevant operating-system/data-disk metrics. Separate VM limits from disk limits, distinguish cached and uncached paths, account for bursting, and correlate pressure with application results. An isolated 100 percent sample doesn't establish sustained throttling. Approve the actual headroom thresholds, statistics, intervals, and sustained-duration rules before the change.

Set CPU and memory headroom thresholds for the expected peak. If processors stay fully busy, work can queue and latency can rise. If Windows repeatedly moves memory pages between RAM and disk, that can be a sign the workload doesn't fit in physical memory. Check committed memory and sustained paging alongside application response times rather than treating one high sample as a failure.

Verify that guest memory, commit, and paging measurements are arriving before resizing. For example, Azure Monitor Agent uses a data collection rule to select operating-system performance counters and how often to collect them. Missing memory evidence blocks a real downsizing decision.

Standard Metrics Explorer aggregation doesn't directly calculate P95/P99. Calculate percentiles from an appropriate population of collected resource samples or application latency observations; don't average interval percentiles. For interval network-byte totals, convert to Mb/s as `bytes * 8 / seconds / 1000000` before comparing with the workload's network rates.

The Atlas plan calls for at least 24 hours of post-change observation, including its weekday peak under demand comparable to the baseline. A smoke test after restart answers a narrower question: does a basic operation still work? It can't establish peak throughput, latency, or headroom. The 24-hour window is an Atlas acceptance condition, not a universal rule, or a reason to wait after a check fails.

The timeline shows when the decision changes. Before the resize, a missing prerequisite means abort. After an attempt, a failed requirement or loss of essential evidence means stop rollout and follow the approved recovery or containment plan. Only a completed observation window with all required checks passing supports acceptance.

:::image type="content" source="../media/canary-validation-timeline.svg" alt-text="Diagram that shows when to abort or recover and when to accept a canary: all checks pass for at least 24 hours, including peak demand.":::
