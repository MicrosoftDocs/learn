Low CPU use during a batch processor's busiest hour tells you more about its capacity needs than a quiet week on a standby VM that never took over the workload. In this unit, you compare each application's performance targets with measurements from the periods that matter and identify where evidence is missing. You also build a cost baseline that includes existing reservation coverage, so you can judge a proposed resize against what the workload costs today rather than its list price alone.

## Establish the decision boundary

A service-level objective (SLO) gives you a measurable target for application performance or reliability. During the acceptance window, the batch receipt service must complete at least 100 operations per second (throughput). At least 95% of operations must finish within 250 milliseconds (P95 latency), with no incorrect results and no failed operations. An average response time below 250 milliseconds doesn't establish that the P95 target was met.

> [!NOTE]
> **P95** is short for the **95th percentile**: the value at or below which about 95% of measurements fall. It applies to any numeric metric, not just latency. For example, a P95 CPU utilization of 70% means that about 95% of CPU samples in the observation window were at or below 70% utilization.

For live measurements, record what counts as a completed service operation, the interval used to calculate throughput, and which operations and time window contribute to the latency percentile. Keep these definitions consistent before and after the change. Document how service operations relate to receipt counts in the financial comparison. Don't count an in-memory smoke-test report as an operation or a receipt unless it meets that definition.

The application owner approves performance and availability trade-offs. The platform operator owns compatibility and allocation. The finance owner validates benefit scope and cost interpretation. The change approver sets the maintenance window, the period when disruption is authorized, and approves a recovery path.

The following diagram connects workload evidence to a capacity-aware, commitment-aware outcome.

:::image type="content" source="../media/module-overview.svg" alt-text="Diagram that shows how to evaluate a VM resize: measure demand, check quota and capacity, test a canary, compare costs, and record the decision.":::

Collect CPU utilization, network demand, and application latency and errors. Measure the memory the workload uses from inside the VM's operating system (the guest), for example with a monitoring agent. Low CPU utilization doesn't tell you how much memory is available. For disk input/output (I/O), record both operations per second (IOPS) and bytes transferred per second (throughput). Two workloads can perform the same number of operations but transfer very different amounts of data.

Some resources are deliberately kept at low utilization: recovery standbys, extra instances needed to survive a failure, software with minimum licensed VM-size requirements, and seasonal workers waiting for a known event. Missing evidence is a reason to defer, not permission to assume zero demand.

## Store a baseline and compare it with current measurements

In an operational change, keep telemetry outside the VM so deleting the canary doesn't delete the only copy of the evidence. Use the existing monitoring destination approved by the workload owner. The supplied cases don't require a monitoring resource.

> [!NOTE]
> Compare the same month-end peak across years to distinguish seasonal demand from sustained growth. Azure Monitor normally retains standard VM platform metrics for 93 days; guest logs in Log Analytics follow the workspace or table retention settings. Save dated summaries before the measurements expire, according to your approved retention policy. A saved chart link won't preserve expired data.

Use the source that measures the behavior you want to compare:

| What you need | Where to find or store it |
|---|---|
| VM CPU, network traffic, disk operations, and disk throughput | Azure Monitor Metrics stores supported platform metrics automatically. Open the VM's **Metrics** view. Don't assume those metrics are also in a Log Analytics workspace. |
| Guest memory, commit, and paging | Use Azure Monitor Agent with a data collection rule that sends the required guest counters to an approved Log Analytics workspace. Confirm samples are arriving before recording the baseline. |
| Application latency, throughput, and failed requests | Use the instrumented service's telemetry, such as workspace-based Application Insights. Filter to the canary instance and the operations covered by the service objective so other instances don't mask a regression. |

Application Insights traces can be sampled. Finding no failures in a sample doesn't establish that every operation succeeded. For the batch receipt service, reconcile the expected operations with complete counts of successes and failures for that window, then check each receipt against its expected result. A request can report success and still produce the wrong receipt.

Use the resize change record to make the comparison reproducible:

1. **Capture the baseline before resizing.** Select a fixed UTC start and end time that includes the relevant peak. For example, in the VM's **Metrics** view, select **Percentage CPU**, **Average**, and a one-minute time grain. For application P95, use the individual operation durations from the same window rather than averaging interval percentiles.
1. **Preserve the evidence.** In the approved change ticket or its access-controlled evidence folder, save a dated export and the query text or exact metric settings. Record the VM resource ID and size, telemetry source, UTC window, units, filters, workload version, and demand. A link set to *Last 24 hours* isn't a baseline: it'll show different data tomorrow. Keep exports according to the approved retention policy.
1. **Repeat the measurement after resizing.** Run the same query or metric selection for a fixed window of equal duration with comparable workload, concurrency, and peak activity. Save the current export alongside the original. Record the baseline value, current value, difference, and agreed target side by side. If required samples or peak coverage are missing, mark the comparison inconclusive rather than treating missing data as zero.

Consider Atlas, a fictional batch processor. Suppose its P95 latency is 180 ms before resizing and 220 ms afterward under matched peak demand. Latency increased by 40 ms but remained below the 250-ms target. That passes the latency check, not the whole resize.

## Review the supplied observation export

Read each row of the table over its own observation window. For A and B, the resource percentiles summarize 30 days of one-minute samples. C has only seven days. **Memory P99 (GiB)** is the value at or below which 99% of memory samples fall. **App latency P95 (ms)** comes from individual service-operation durations, not an average of interval percentiles. One-minute resource samples can hide shorter spikes. Use **Peak note** to see whether the window captured the demand that matters to each workload.

The table reports memory in gibibytes (GiB). **Disk P95 (IOPS)** counts operations per second, **Disk P95 (MB/s)** measures megabytes per second, and **Network P95 (Mb/s)** measures megabits per second. A byte is eight bits, so the two throughput units aren't interchangeable.

| Recommendation | Resource | Owner | Current size | Target size | Days | CPU average (%) | CPU P95 (%) | Memory P99 (GiB) | Disk P95 (IOPS) | Disk P95 (MB/s) | Network P95 (Mb/s) | App latency P95 (ms) | Peak note |
|---|---|---|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| A | atlas | AppOwner | `Standard_D4s_v5` | `Standard_D2s_v5` | 30 | 9 | 18 | 4.7 | 900 | 20 | 180 | 180 | weekday peak included |
| B | ledger-db | DataOwner | `Standard_D8s_v5` | `Standard_D4s_v5` | 30 | 7 | 22 | 24 | 8000 | 180 | 160 | 230 | month-end memory peak included |
| C | recovery-worker | RecoveryOwner | `Standard_D4s_v5` | `Standard_D2s_v5` | 7 | 0.5 | 2 | missing | 20 | 1 | 2 | `not_tested` | recovery exercise not observed |

For Atlas, `Standard_D4s_v5` to `Standard_D2s_v5` means moving from four virtual CPUs (vCPUs) to two within the Dsv5 series. In these names, `D` identifies the family, `s` denotes Premium Storage support, and `v5` is the series version. The rest of the module uses D4s v5 and D2s v5 for short.

For the Recovery worker (C), the problem isn't just that seven days is a short window. It missed the failover this VM is sized for. The runbook calls for 14 GiB of working memory during recovery, but the owner hasn't rehearsed the current procedure. Idle CPU measurements can't fill that gap.

The owner inventory adds context that metrics alone can't supply.

| Resource | Availability and workload requirement | Known uncertainty |
|---|---|---|
| Atlas | Stateless lab processor: the next request doesn't depend on data stored locally by the last one. A 20-minute interruption is approved. | Measure application behavior on the smaller size. |
| Ledger database | Stateful database: its stored records must survive an interruption and month-end processing must finish on time. | Sampling might miss short I/O bursts. A change also requires a check that data is intact and recoverable. |
| Recovery worker | Must run the emergency workload during regional recovery | Recent memory trace and recovery exercise are missing |

Use the before-change measurements as your baseline. Don't compare a quiet holiday week after a resize with a busy month-end before it. Match the duration, business activity, software version, and number of operations in progress at once (concurrency). If demand differs, compare cost and resource use per successfully processed receipt as well as total usage. Fewer receipts can explain a lower bill without any gain in efficiency. Check peak performance separately.

## Establish a financial baseline

The table uses example on-demand list prices, and isn't representative of an Azure quotation, or a negotiated rate. Each 30-day window assumes 720 hours of use, no taxes or exchange-rate changes, and the same software-license costs, excluded from both totals. The rates are **per VM-hour, not per vCPU-hour**: a four-vCPU VM running for 720 hours consumes 2,880 vCPU-hours but only 720 VM-hours.

| Resource | Current retail rate per VM-hour | Target retail rate per VM-hour | VM-hours | Estimated retail savings |
|---|---:|---:|---:|---:|
| atlas | $0.20 | $0.10 | 720 | $72.00 |
| ledger-db | $0.40 | $0.20 | 720 | $144.00 |
| recovery-worker | $0.20 | $0.10 | 720 | $72.00 |

> [!NOTE]
> The prices in this module are examples only and don't reflect current Azure prices. To estimate the cost of your deployment, use the [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/) with your region, VM size, and expected hours of use.

Record which resources you're comparing and the Cost Management scope you're using to see their charges. Depending on your agreement and permissions, that view might cover a resource group, subscription, billing account, billing profile, or invoice section. Record the **benefit scope** separately: it determines which eligible resources can use a discount. Looking only at Atlas can hide both a discount used by a different VM and an unused commitment recorded at a broader scope.

In the Atlas example, instance size flexibility lets one reservation cover different sizes in the same group. The D4 uses two normalized size units and the D2 uses one. Those units measure reservation coverage, not vCPUs, or reserved hardware. The example uses a verified 2:1 ratio. Published ratios can express the same proportion on a different scale.

The reservation covers two units for the full 720 hours at an amortized cost of $0.12 per hour. Amortization spreads the cost over the term and assigns it to used or unused coverage. Moving Atlas from two units to one changes how much cost is assigned to Atlas, not what you agreed to pay. Use Actual cost when you need to see when the charges were billed.

For a live comparison, check the existing reservation's benefit scope, region, and instance size flexibility setting. A shared VM family name alone doesn't tell you whether the reservation covers both sizes. Look up the current and proposed VM sizes in the Azure reservation catalog, or use a dated extract that an authorized operator confirms is current. Confirm that both sizes belong to the same instance size flexibility group and use the published ratio for each size in that group.
