An override changes part of Network ATC's desired configuration. It isn't a competing manual edit. Use an override when a supported hardware requirement, workload requirement, or fabric policy justifies departing from the default.

Start with the default configuration. Every exception adds a decision that must survive replacement, servicing, recovery, and future review.

## Use typed override objects

The constructors create objects for particular configuration domains. Only the properties you deliberately set should express the exception. Read the existing intent and global state before submitting changes.

The relevant override families serve different purposes.

| Constructor | Purpose | Typical reason to inspect or change it |
|---|---|---|
| `New-NetIntentAdapterPropertyOverrides` | Adapter advanced properties | Supported RDMA transport or hardware-specific setting |
| `New-NetIntentQoSPolicyOverrides` | Priorities and bandwidth reservations | An approved traffic-allocation design |
| `New-NetIntentStorageOverrides` | Storage address-generation behavior | Administrator-managed storage addressing |
| `New-NetIntentGlobalClusterOverrides` | Cluster network and migration policy | Deliberate migration transport, concurrency, or cap |
| `New-NetIntentSwitchConfigurationOverrides` | Supported switch properties | A justified switch capability requirement |
| `New-NetIntentAdapterRssOverrides` | Receive-side scaling configuration | A diagnosed CPU/receive-processing constraint |

There isn't a separate management-override or compute-override constructor to invent. Use the relevant constructor and the documented parameter set.

Several Add and Set parameter names differ.

| Override object | `Add-NetIntent` parameter | `Set-NetIntent` parameter |
|---|---|---|
| Switch configuration | `-SwitchPropertyOverrides` | `-SwitchOverrides` |
| Adapter RSS | `-AdapterRssPropertyOverrides` | `-AdapterRssOverrides` |
| Adapter advanced properties | `-AdapterPropertyOverrides` | `-AdapterPropertyOverrides` |
| QoS policy | `-QoSPolicyOverrides` | `-QoSPolicyOverrides` |
| Storage addressing | `-StorageOverrides` | `-StorageOverrides` |

Don't normalize these names in a wrapper without checking the installed syntax. Global overrides use a separate parameter set and aren't attached to an intent name.

## Change a reservation

Suppose the approved storage design requires a 60% SMB Direct reservation. Confirm matching fabric policy and remaining traffic-class capacity before applying the change.

Capture the current traffic classes and inspect the override object first.

```powershell
$nodes = 'HV01', 'HV02'
$before = @(Get-NetQosTrafficClass -CimSession $nodes -ErrorAction Stop)
Get-NetIntent -ClusterName HVCL01 -Name Storage | Format-List *

$qos = New-NetIntentQoSPolicyOverrides -BandwidthPercentage_SMB 60
$qos | Format-List *

Set-NetIntent -ClusterName HVCL01 -Name Storage `
    -QoSPolicyOverrides $qos -Wait -ErrorAction Stop

Get-NetIntentStatus -ClusterName HVCL01 -Name Storage
$after = @(Get-NetQosTrafficClass -CimSession $nodes -ErrorAction Stop)
$after | Select-Object PSComputerName, Name, Priority, Bandwidth
```

The `$qos` policy override object, created by `New-NetIntentQoSPolicyOverrides`, requests a 60% bandwidth reservation for SMB Direct when applied to the `Storage` intent through the `-QoSPolicyOverrides` parameter of `Set-NetIntent`. The reservation governs bandwidth allocation during contention, not a hard throughput limit. SMB Direct can use more than 60% when additional bandwidth is available. Inspect the resulting `Get-NetQosTrafficClass` output on both `HV01` and `HV02` to confirm that the SMB Direct reservation is 60% and the other traffic classes still match the approved design.

Compare the structured before and after records without converting them into formatted text.

```powershell
Compare-Object -ReferenceObject $before -DifferenceObject $after `
    -Property PSComputerName, Name, Priority, Bandwidth
```

The comparison identifies changed records. It doesn't establish that the physical switch has the same policy or that the workload now meets its latency target.

## Hardware-specific exceptions

An adapter override must match the capabilities exposed by the actual driver and firmware. The following object requests enabled RDMA using RoCEv2.

```powershell
$rdma = New-NetIntentAdapterPropertyOverrides `
    -NetworkDirect 1 -NetworkDirectTechnology 4
$rdma | Format-List *
```

The `$rdma` adapter-property override object created by `New-NetIntentAdapterPropertyOverrides` contains the requested RDMA and RoCEv2 settings. Creating or displaying `$rdma` doesn't change the adapters. To apply these settings to the existing `Storage` intent, pass `$rdma` to the `-AdapterPropertyOverrides` parameter of `Set-NetIntent`, as shown below. Apply this override only if the adapters support RoCEv2, the VLANs are valid, and the physical fabric is prepared. Adapter advanced-property changes can restart interfaces and interrupt traffic.

> [!IMPORTANT]
> Before applying the RoCEv2 override, confirm fabric and policy readiness against the RoCE criteria in the storage-networking unit. Verify the planned RDMA priority, PFC and ETS behavior, DCBx ownership, and matching endpoint and switch configuration. After applying the override, complete the operational acceptance checks and prove RDMA use during an active workload. Changing `NetworkDirectTechnology` doesn't configure the external fabric.

The following cluster-wide mutation illustrates applying that approved exception.

```powershell
Set-NetIntent -ClusterName HVCL01 -Name Storage `
    -AdapterPropertyOverrides $rdma -Wait -ErrorAction Stop

Get-NetIntentStatus -ClusterName HVCL01 -Name Storage
Get-NetAdapterRdma -Name pNIC03,pNIC04 -CimSession HV01,HV02
```

Inspect actual RDMA operation and active SMB paths afterward. Selecting an integer doesn't prove the requested technology is working.

Queuing and offload features solve different processing problems.

| Feature | Concept | Why it matters here |
|---|---|---|
| RSS | Spreads receive processing across processors | Can affect receive-side CPU concentration |
| VMQ | Classifies traffic into queues associated with virtualized networking | Depends on adapter and virtualization capabilities |
| vRSS | Spreads virtualized receive processing | Requires supported queue and processor behavior |
| Software RSC | Coalesces received segments in software | Can reduce processing overhead |
| SR-IOV | Exposes supported hardware virtualization capabilities | Has provisioning and hardware constraints |

Don't disable or force these features as a generic performance recipe. Inspect them only when they explain a measured result or a supported hardware requirement. A virtual switch's SR-IOV configuration can't simply be changed after deployment, so a proposed exception can require resource recreation.

## Revert deliberately

Nullable override properties can hold a value or be left unset (`$null`). They let you provide values for selected settings instead of specifying every property in the override object. An unset property isn't necessarily a request to remove an override already stored in the intent or restore a default. Don't assume that omitting a property or assigning `$null` will undo an earlier change. To revert a setting, use the supported behavior for that specific override or explicitly reapply its approved previous or default value, then inspect the effective configuration.

For the QoS example, returning to the documented 50% SMB reservation is an explicit policy change. Coordinate the matching fabric policy and then verify the result.

```powershell
$qos = New-NetIntentQoSPolicyOverrides -BandwidthPercentage_SMB 50
Set-NetIntent -ClusterName HVCL01 -Name Storage `
    -QoSPolicyOverrides $qos -Wait -ErrorAction Stop
Get-NetIntentStatus -ClusterName HVCL01 -Name Storage
```

This restores that value. It doesn't necessarily remove the record of an explicit exception or make every global setting automatic again. Review the supported behavior for the particular override rather than deleting an intent to simulate a reset.
