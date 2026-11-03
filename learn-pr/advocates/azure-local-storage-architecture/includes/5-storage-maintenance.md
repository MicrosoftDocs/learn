*Degradation* is a reduction in storage protection, performance, or available resources compared with the system's healthy operating state. For example, a failed drive can leave a volume with fewer data copies, a failed network path can reduce access redundancy, and low physical capacity can restrict writes or repair. A degraded system may still serve applications, but it has less tolerance for additional faults or may deliver reduced performance. Degradation doesn't, by itself, mean that data has been lost or the service is offline.

During degradation, collect evidence that can distinguish the failed layer. "The cluster is online," "the disk is online," and "the application can commit a transaction" are observations at different layers.

Record the observation time, affected node, object identity, and recent changes. Compare samples over time rather than relying on one percentage or one green status. Use approved monitoring and event collection to correlate storage, network, cluster, and application events.

## Monitor resilience continuously

Read-only queries explain a point in time. Continuous monitoring helps detect a failing component, shrinking reserve, or worsening repair window before another fault causes an outage. Establish a healthy baseline and retain enough history to distinguish normal workload peaks from sustained degradation.

The Storage Spaces Direct Health Service reports storage faults and supports automatic recovery actions. Windows Admin Center exposes local health and performance information. In connected deployments, configured Azure Local Insights and Azure Monitor metrics can complement those local observations. Insights uses Azure Monitor Agent, data collection rules, and Log Analytics. Platform metrics use a separate telemetry path, so enabling one doesn't imply that every other monitoring capability is configured.

Keep the measurement layer visible when designing alerts. Input/output operations per second (IOPS) measures the number of storage operations completed per second. Throughput measures the amount of data transferred per second, and latency measures how long an operation takes.

| Signal and scope | What to watch | Response to define |
| --- | --- | --- |
| Physical pool or array capacity | Remaining allocatable capacity, growth rate, and the reserve needed for the promised repair scenario | Escalate before reserve is consumed. Choose thresholds from the approved design and expansion lead time, not one universal free-space percentage. |
| CSV and guest filesystem capacity | Free space at each filesystem layer | Identify which layer is approaching exhaustion. Guest free space doesn't override an exhausted backing pool. |
| Physical devices and storage health faults | Failed or detached drives, unsupported components, repeated errors, and correlated node or enclosure faults | Identify the affected hardware and likely shared cause before approving replacement. |
| Repair and resynchronization | Outstanding work, progress across observations, duration, and available repair destinations | Investigate persistent lack of progress and pause further elective maintenance while protection is incomplete. |
| Volume and application performance | Latency, throughput, IOPS, and application response time compared with the baseline | Correlate changes with repair, optimization, network conditions, and workload demand. A throughput drop alone doesn't identify the failed component. |
| Paths, replication, and quorum resources | Expected path health, array replication state, node membership, and witness reachability | Restore lost redundancy and investigate correlated faults even if the application still works. |

Each actionable alert needs an affected object, a severity, an operational owner, and evidence for resolution. Avoid treating the same failure's downstream symptoms as unrelated incidents. For example, several disks disappearing from one node can indicate a node or connectivity problem rather than simultaneous failure of every drive.

Monitor the monitoring path too. Record the last collection time and treat stale or absent telemetry as missing evidence, not proof of health. During an Azure connectivity interruption, use available local observations and the approved local response process. Cloud dashboards can't be assumed to reflect the latest state.

Host, virtual-disk, and volume metrics don't establish complete guest-application or external-array health. Include in-guest and application monitoring where required, and use the array's supported management tools for controller, replication, and array-capacity evidence.

## Inspect local storage and volume state

Use this example for Storage Spaces Direct, not to infer the internal state of an external array. It requires the Storage and FailoverClusters modules and contains no values to replace.

> [!NOTE]
> The examples in this unit are read-only. Run them only on authorized systems, using elevated Windows PowerShell on an Azure Local node with the solution-provided modules. Don't run these node-local commands in Azure Cloud Shell. If a command or provider is unavailable, report the missing evidence and resolve the environment issue. An empty or failed query isn't a healthy result.

```powershell
$ErrorActionPreference = 'Stop'

Get-StoragePool -IsPrimordial $false |
    Select-Object FriendlyName, HealthStatus, OperationalStatus,
        IsReadOnly, Size, AllocatedSize

Get-VirtualDisk |
    Select-Object FriendlyName, ResiliencySettingName, HealthStatus,
        OperationalStatus, Size, FootprintOnPool

Get-PhysicalDisk |
    Select-Object FriendlyName, SerialNumber, MediaType, Usage,
        HealthStatus, OperationalStatus, Size

Get-StorageJob |
    Select-Object Name, JobState, PercentComplete, BytesProcessed,
        BytesTotal

Get-ClusterSharedVolume |
    Select-Object Name, State, OwnerNode

Get-ClusterSharedVolume |
    Select-Object -ExpandProperty SharedVolumeInfo |
    Select-Object FriendlyVolumeName, RedirectedAccess, FaultState
```

`-IsPrimordial $false` excludes the primordial pool that represents unpooled devices. The remaining pools are the concrete storage pools to investigate. Correlate returned objects with the affected workload rather than assuming that every reported disk belongs to the same volume.

| Observation | What to infer | What not to infer |
| --- | --- | --- |
| Pool `Size` and `AllocatedSize` | Approximate backing capacity and current allocation at the pool layer | That the difference is all available for application growth. Repair reserve and placement constraints still matter. |
| Virtual-disk `Size` | Logical capacity exposed by the virtual disk | That all of it's currently backed by allocated physical blocks. |
| Virtual-disk `FootprintOnPool` | Physical pool allocation attributable to that virtual disk | The size or free space of an individual guest VHDX file. |
| Physical-disk health and identity | Which devices need correlation with hardware and storage events | That a friendly name alone uniquely identifies the failed hardware. |
| Storage-job progress | Reported long-running work, including applicable repair activity | That an empty result proves all storage and optimization work is complete. |
| CSV state, path, and redirection | Clustered-volume access and ownership evidence | That an application has completed recovery or that redirected access always means data loss. |

Size properties are in bytes. In PowerShell, the `1TB` numeric suffix represents a binary tebibyte, despite its spelling. Use consistent units when translating the output.

CSV redirected access can occur when I/O must use another node or during certain operations. Correlate it with the fault and performance evidence. Don't change ownership or force a disk online simply to make the output look normal.

## Inspect external storage paths

For a qualified external array, run this read-only inventory on every relevant node. It requires the Storage and CimCmdlets modules, configured MPIO, approved drivers, and the MPIO WMI provider. No vendor configuration is changed.

```powershell
$ErrorActionPreference = 'Stop'

Get-InitiatorPort |
    Select-Object NodeAddress, PortAddress, ConnectionType

Get-Disk |
    Select-Object Number, FriendlyName, SerialNumber, BusType,
        OperationalStatus, IsOffline

$pathInventory = Get-CimInstance -Namespace root\wmi `
    -ClassName MPIO_DISK_INFO

$pathInventory.DriveInfo |
    Select-Object Name, SerialNumber, DsmName, NumberPaths
```

The Common Information Model (CIM) query reads the Windows Management Instrumentation (WMI) provider. `DriveInfo` contains per-device records. `NumberPaths` belongs to each record. It isn't a count of protected data copies. Disk numbers can differ between hosts, so compare stable identities and the vendor's LUN mapping rather than assuming that "Disk 3" means the same device everywhere.

In the vendor's approved read-only management interface, compare host registration, masking, zoning, controller and port health, replication state, and multipath policy with the Windows inventory. There's no universal array command for these observations.

**Interpret a supplied case:** A workload LUN has four expected paths on all nodes except A2, which reports two. The CSV remains online and the application still works. This is a degraded-path investigation, not proof of data loss. Determine which paths are missing and whether the remaining paths share a fabric or controller. The next fault might now cause an outage even though the current application check passes.

Four visible paths aren't automatically four healthy, independent paths. Conversely, an inactive path can be expected under a qualified array's path-selection policy. Use the actual design and vendor state rather than treating every non-active path as failed.

Don't disable a path or remove a cable to manufacture teaching evidence. Planned failover validation belongs in an approved test plan with the storage vendor and workload owner.

## Inspect quorum with event timing

Run this read-only query on an authorized node with FailoverClusters. It changes neither votes nor witness configuration.

```powershell
$ErrorActionPreference = 'Stop'

$quorum = Get-ClusterQuorum
$quorum | Select-Object Cluster, QuorumResource

if ($quorum.QuorumResource) {
    $quorum.QuorumResource | Select-Object Name, State
}

Get-ClusterNode |
    Select-Object Name, State, NodeWeight, DynamicWeight
```

`NodeWeight` describes configured voting participation. `DynamicWeight` describes the currently assigned dynamic vote. A zero dynamic vote doesn't, by itself, mean a failed node. `Get-ClusterQuorum` identifies the quorum resource but isn't a historical record of every arbitration decision.

For the earlier 2+2 partition, the supplied initial state had four node votes and one witness vote. Zone A's two nodes plus the retained witness vote provided three of five. Compare that supplied state with the actual event sequence. A later snapshot can reflect membership and vote changes.

If cluster quorum is present but a CSV is unavailable, continue the investigation at pool metadata, data placement, paths, and capacity. If the CSV is available but the VM can't start, inspect host resources and placement. If the VM runs but the application fails, examine application recovery and dependencies. These transitions prevent an ownership symptom from becoming a reason to perform an unrelated storage change.

## Recover from drive or node failure

Recovery has several related operations. They can overlap, and a reported job name doesn't always map to just one concept.

| Operation | Purpose | What completion doesn't prove |
| --- | --- | --- |
| Storage repair | Reconstruct missing copies or parity protection from surviving data on eligible storage | That an application has completed its own recovery or that damaged application data has been restored to an earlier version. |
| Resynchronization | Bring stale returning copies up to date after they missed writes while offline | That a node's hardware, placement configuration, or every unrelated volume is healthy. |
| Rebalancing | Redistribute stored data across eligible capacity, such as a replacement drive or repaired node | That quorum, independent access paths, or application correctness have been established. |

Storage repair is different from the Azure Local machine-repair lifecycle operation. Machine repair can involve hardware replacement, reimaging, and configuration recovery. Storage repair and rebalancing can continue after that lifecycle operation reports completion.

For an ordinary Storage Spaces Direct deployment, use this conceptual recovery sequence with the current Azure Local and solution-provider procedures:

1. Establish the failed component and the remaining protection. Correlate the health fault, serial number, physical location, and affected workloads. Don't replace a drive solely because its path disappeared. A node, enclosure, or fabric fault can make multiple healthy drives unreachable.
1. Determine whether the event is transient or needs hardware replacement. A returning node with intact data drives normally needs its missed writes synchronized. Hardware or operating-system damage can instead require the OEM-qualified component or machine-repair workflow.
1. Replace only the confirmed failed component with a qualified replacement. Confirm model, capacity, role, firmware, and physical location. Preserve retained data drives during machine repair. Don't initialize, format, or reset them as an improvised recovery step.
1. Observe the supported recovery process. Health Service can retire an unusable drive and start restoring resiliency when sufficient eligible capacity remains. Replacement admission depends on configuration and eligibility, including automatic-pooling settings. Simply inserting a drive doesn't establish successful admission or OEM qualification.
1. Confirm required repair, resynchronization, and any workflow-required rebalancing have completed. Check storage health and application access as well as the jobs. Only then approve the next maintenance action that would reduce protection again.

A failed cache drive needs special attention because it can serve several capacity drives. Reassignment to another cache device depends on one being available, and cache handling must follow the supported design. Don't apply a capacity-drive replacement assumption to every cache failure.

When a node returns after downtime, its local copies can be stale even while the node reports `Up`. Storage Spaces Direct tracks changed regions so it can synchronize missed changes rather than automatically recopying every block. The amount of outstanding work and its progress matter more than the node's reachability alone.

On an authorized local-storage node with the solution-provided Health Service and cluster-performance commands, the following read-only example shows health faults and the documented per-node series for data requiring storage recovery:

```powershell
$ErrorActionPreference = 'Stop'

Get-HealthFault

Get-ClusterNode |
    Get-ClusterPerf -ClusterNodeSeriesName ClusterNode.Storage.Degraded
```

Interpret `ClusterNode.Storage.Degraded` as an amount of data requiring recovery, not a count of failed drives. Correlate it with current health faults and storage jobs. Missing output or unavailable commands don't prove recovery has finished.

For planned node maintenance, follow the current Azure Local suspend/resume workflow, which coordinates cluster state and Azure Local VM-placement eligibility. Moving CSV ownership alone isn't sufficient. After a node resumes, confirm its cluster state, placement eligibility, healthy storage, and completed resynchronization before taking another node down. For a reimaged machine, use the release-matched repair workflow and wait for required background rebalancing as well.

These local-storage behaviors aren't a repair procedure for an external array. Array drive replacement, controller recovery, replication resynchronization, and failback remain governed by the qualified vendor solution. Rack-aware recovery also needs its topology-specific requirements, not an assumption that ordinary-cluster recovery rules are sufficient.

## Repair versus restore

Use *repair* when surviving current data is valid and the task is to restore its protection or access. Use *restore* when the required data must be recovered from a known-good recovery point. Both might be needed in the same incident, but rebuilding replicas doesn't roll back unwanted changes.

| Incident | Appropriate recovery decision |
| --- | --- |
| A drive fails but valid protected data remains accessible | Follow the supported replacement and repair process. A backup restore isn't automatically required merely because hardware failed. |
| A node returns with stale local copies after missing writes | Resynchronize from authoritative current copies. Don't promote stale contents as the current workload state. |
| A file or application record is deleted or overwritten and the change reaches all replicas | Use an appropriate earlier recovery point or application-supported recovery mechanism. Healthy mirrors can faithfully contain the unwanted change. |
| Corruption is detected and no valid redundant data can repair it | Preserve evidence, establish the scope of damage, and recover affected data from a known-good source through the supported storage or application procedure. |
| The whole site or all protected failure domains are unavailable | Invoke the independent disaster-recovery plan. A two-rack design within the lost site doesn't provide another recovery location. |

An application-consistent recovery point coordinates with the application so its captured state is suitable for recovery. A crash-consistent point represents a state similar to an abrupt interruption and can require log replay or other application recovery. Confirm which type the workload needs and which type the selected protection solution actually provides.

A VM checkpoint or array snapshot isn't automatically an independent backup. Assess whether it survives loss or compromise of the source storage, whether the required retention is available, and whether the recovery environment can access the data and any required keys. Keep backup-product installation and configuration in the corresponding backup guidance.

Choose a recovery point that meets the application's RPO and is known to predate the unwanted change or corruption. Measure RTO through application validation and restored client access, not just completion of a disk restore. An hourly recovery point alone can't meet a five-minute RPO.

Before returning restored data to production, confirm the intended application state, dependencies, and ownership. Prevent an old active instance or an inappropriate replication direction from overwriting the recovered state. Record any data-loss interval and obtain the workload owner's acceptance rather than assuming that a technically successful restore met the business objective.

## Incident completion criteria

An incident isn't complete because an alert disappeared. Record which promised level of protection has been restored.

For local storage, establish expected device availability, healthy pool and virtual-disk state, required repair completion, usable reserve, and successful application writes. For external storage, include the expected independent paths, healthy array protection and replication, and consistent LUN access on all required nodes.

If service has recovered but repair remains active, report that distinction explicitly. "Service restored, protection rebuilding" is more useful than "Everything is healthy."
