The Ledger database averages just 7% CPU utilization, but its month-end workload needs 24 GiB of memory. The proposed 16 GiB VM has a lower hourly price, yet it can't meet that peak requirement. In this unit, you compare Azure Advisor's estimates with your workload baseline and check whether each proposed size supports the VM's operating system, disks, and network configuration. You use that evidence to decide which resize to test on a canary, which to reject, and which to defer until you have better measurements.

## Interpret Advisor as evidence rather than authority

Azure Advisor is Azure's configuration and usage recommendation service. Its resize recommendations consider CPU, memory, and outbound network utilization and estimate savings using retail rates. They don't account for your existing reservations or savings plans. They can also miss application-specific storage behavior, operational headroom, or seasonal requirements.

Advisor's configurable lookback periods include 7, 14, 21, 30, 60, and 90 days. Updating the lookback doesn't instantly regenerate all recommendations. Record the recommendation generation time and configuration rather than assuming it used the same window as your own analysis. Advisor has its own aggregation and workload-classification rules; its figures aren't interchangeable with the resource percentiles or application SLO measurements in these cases.

Shutdown recommendations use different criteria and don't establish that a low-CPU standby is unnecessary. For a burstable size, check how long peak demand lasts. The VM earns credits below its CPU baseline and spends them to run above it. If credits run out before the job finishes, CPU performance can fall back to that baseline and the job can miss its deadline. A low daily average won't expose that risk.

For a real VM, the operator can find resize and shutdown recommendations under **Advisor** > **Cost** in the Azure portal. The useful evidence is the resource identifier, current and proposed sizes, estimated savings, recommendation age, and observation assumptions. Dismissing or postponing a recommendation doesn't change the underlying workload requirement.

## Check the exact transition

Atlas runs on a standalone Windows Server 2025 x64 VM. The proposed change from `Standard_D4s_v5` to `Standard_D2s_v5` must preserve the VM's generation (its boot firmware and related virtual hardware) and security type. The `v5` in the size name is the series version, not the boot generation. Both the image and target size must support the selected security features.

Atlas has a managed operating system (OS) disk, one managed Premium solid-state drive (SSD) for application data, and one network interface. The managed disks persist independently of the compute host. Compare the workload's I/O demand with both the data disk's configured allowance and the VM limits below.

The following published size characteristics establish important limits for this transition. Recheck the size documentation and actual resource configuration before execution.

| Characteristic | D4s v5 | D2s v5 | Interpretation |
|---|---|---|---|
| Virtual CPUs | 4 | 2 | CPU headroom decreases |
| Memory | 16 GiB | 8 GiB | Check the peak working set (memory in physical RAM) and committed memory (what Windows must back with RAM or paging space). |
| Maximum data disks | 8 | 4 | Attached disk count must fit |
| Uncached Premium SSD baseline IOPS | 6,400 | 3,750 | Compare sustained operations that bypass the host cache against the baseline. A temporary burst can't support a sustained peak. |
| Uncached Premium SSD baseline throughput | 145 MB/s | 85 MB/s | Check both VM and disk bandwidth. Either limit can cause throttling, which delays I/O requests. |
| Maximum network interfaces | 2 | 2 | Preserve supported networking configuration |
| Accelerated Networking | Required | Required | Confirm that the guest image supports Accelerated Networking and the network interface is configured for it. |
| Local temporary storage | None | None | Neither size uses host-local temporary storage, so there's no local temporary disk to migrate. Don't rely on this storage to persist when changing hosts. |

Inspect processor architecture, VM generation, disk count and controller, security type, encryption requirements, specialized devices, and placement. The OS image and application must support the target architecture. Resizing alone can't turn an x64 image into an Arm64 image.

Check which controller the guest uses to reach its disks. Small Computer System Interface (SCSI) and remote Non-Volatile Memory Express (NVMe) use different interfaces and drivers. You can't directly resize a SCSI VM to a size that uses remote NVMe storage. Follow the supported migration procedure instead. Remote NVMe storage isn't a local temporary disk.

On Windows, the ordinary resize workflow doesn't support switching directly between a size with local temporary storage and one without it. Linux has different support. Don't generalize a Windows limitation or workaround across operating systems.

## Make the three decisions

All three proposed sizes have a lower hourly price, but each workload needs a different decision. The targets are hypothetical recommendations, not Advisor output calculated from the supplied observations. Compare each workload's peak demand with the target's limits: consider a canary if the evidence supports it, reject a size that can't meet a known requirement, or defer if measurements missed the demand that matters.

- **Accept Atlas for a controlled canary**, not for an unconditional production rollout. A rough proportional CPU estimate is `18% × 4 / 2 = 36%` on the smaller size. Memory is `4.7 / 8 × 100 = 58.75%`. Those values suggest sufficient headroom, while observed I/O remains below target limits. Test these estimates; halving the processor count doesn't guarantee that CPU utilization will simply double.
- **Reject the proposed Ledger database resize.** Its 24-GiB working-memory requirement exceeds the proposed 16 GiB, and 8,000 IOPS exceed the target VM's 6,400 baseline. A $144 retail savings estimate can't justify a change that won't meet workload requirements. The data owner can investigate database tuning or a different compatible size through a separate change.
- **Defer the Recovery worker resize pending updated evidence.** Current low demand is expected for a standby, and its documented 14-GiB recovery requirement exceeds the 8-GiB target. The owner must validate the current emergency workload and update its requirement before reconsidering. Deferral doesn't authorize an automatic resize later.

The table summarizes the resize decisions for Atlas (A), the Ledger database (B), and the Recovery worker (C). Each row shows the technical decision, how to interpret the estimated savings, and who's responsible for the next step.

| Recommendation | Technical decision | Financial qualification | Owner and next action |
|---|---|---|---|
| A | Accept canary, subject to allocation and SLO gates | The $72 estimate doesn't guarantee cash savings | Platform operator runs gate; finance checks benefit reuse |
| B | Reject proposed target | Savings irrelevant while requirements fail | Data owner proposes another optimization |
| C | Defer | Demand and commitment coverage incomplete | Recovery owner supplies drill and memory evidence within 30 days |
