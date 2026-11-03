Maintenance must preserve the supported architecture and avoid consuming resources needed for recovery. A space-saving feature isn't a repair tool, and a successful command isn't evidence that the maintenance objective has been achieved.

## Maintenance safeguards

Treat maintenance as a controlled change to a specific volume, not a general instruction to modify every volume in the cluster. A *bounded maintenance operation* has an approved target, a defined time window, acceptable resource and application-impact limits, and conditions for stopping. These boundaries reduce risk, but they don't guarantee that an operation can be reversed.

Use the read-only storage, path, and quorum observations from the preceding unit to establish a baseline. For elective maintenance, resolve degraded protection, unexpected path loss, and active repair before proceeding. Capacity expansion needed to recover an incident should follow the approved incident-recovery plan rather than an ordinary optimization workflow.

| Safeguard | What to establish before the change |
| --- | --- |
| Target and dependencies | Record the CSV name, mount path, owner node, backing virtual disk or array LUN, filesystem, resiliency layout, and dependent workloads. Use stable identities rather than a disk number alone. |
| Health and capacity | Confirm healthy backing storage, expected access paths, sufficient physical headroom, and repair reserve that remains usable after the change. |
| Recovery readiness | Confirm an appropriate backup and a tested recovery procedure for the affected data. A live replica isn't a substitute for a backup. |
| Approved impact | Agree on the maintenance window, workload contact, acceptable application latency, and stop criteria. Avoid overlapping storage-intensive maintenance. |
| Completion criteria | Define the expected final size, owner, protection state, schedule, and workload behavior, as applicable. Record how each will be confirmed. |

If a new fault, unexpected CSV movement, or unacceptable application impact occurs, stop or pause the activity through its supported mechanism where possible and reassess the state. Don't force disks online, change quorum, or remove healthy storage members to complete an unrelated maintenance task.

## Volume lifecycle boundary

Before creating or modifying a volume, identify its storage source, resiliency layout, filesystem, workload, and placement requirements. On supported local configurations, `New-Volume` can create the virtual disk, format it, and add it as a CSV. On external storage, follow the qualified array presentation and cluster-volume workflow instead.

Don't present a generic volume-creation command as valid for every topology. Rack-level mirror layouts, nested resiliency, array LUNs, and platform infrastructure volumes have different requirements. Use the corresponding supported deployment or lifecycle procedure.

After the storage is correctly provisioned, inspect the intended placement location before creating an Azure Local storage path. The path resource advertises that location to management operations, but it doesn't repair the volume or reserve extra physical space.

For expansion, preserve node, drive, network, and failure-domain eligibility. More capacity in a single rack might not provide the reserve needed in the other rack. For layout changes, plan migration if the change isn't supported in place.

## Extend existing volumes

Adding physical capacity and extending a volume are different operations. Adding supported drives or machines can increase a local pool's capacity. Extending an existing volume increases the logical space exposed to its filesystem. Neither operation automatically enlarges a VM's VHDX file or its guest filesystem.

Before extending a local volume, calculate its additional resilient footprint. For example, increasing an ordinary three-way-mirror volume from 1 TiB to 2 TiB increases its ideal fully allocated footprint from 3 TiB to 6 TiB. Plan for the additional 3 TiB without consuming the approved repair reserve. With thin provisioning, allocation can grow later as data is written, so a successful logical extension doesn't prove that the pool can accommodate all future writes.

For an eligible ordinary Storage Spaces Direct volume, follow this sequence:

1. Identify the target volume and its backing objects. Follow the associations from the virtual disk to its disk, partition, and volume rather than selecting a similarly named object.
1. Confirm sufficient pool capacity and eligible placement. If the volume has storage tiers, use `Get-StorageTier` for the selected virtual disk and confirm capacity for each tier's media type and protection overhead.
1. Expand the virtual disk with the supported `Resize-VirtualDisk` workflow, or expand the applicable storage tiers with `Resize-StorageTier`. Specify the intended new total size, not just the amount to add. Preserve the approved tier proportions and resiliency design.
1. Expand the associated data partition with `Resize-Partition` within its supported size limits. Identify the data partition explicitly and don't modify a reserved partition. Growing the backing disk alone doesn't enlarge the filesystem.
1. Confirm the new volume size and free space, remaining physical reserve, CSV accessibility, and application operation.

Windows Admin Center provides a volume expansion workflow through **Volumes** > **Inventory** > the selected volume > **Settings** for supported configurations. Use the interface and procedure approved for the topology. Don't assume that an ordinary volume procedure applies unchanged to nested or rack-aware storage.

For an array-backed CSV, first follow the vendor's qualified LUN-expansion procedure, including any replication requirements. Then follow the supported host discovery and partition-extension workflow. Confirm that every required node sees the same device identity and new capacity. Don't use `Resize-VirtualDisk` as a generic command to enlarge an external array LUN.

Plan expansion as a change that might not have an in-place reversal. Don't assume that shrinking the volume is a supported way to undo it. In a virtualized Storage Spaces Direct environment, resizing the underlying virtual drives is also not a supported substitute for adding capacity through the documented lifecycle procedure.

## Move CSV ownership

Moving a CSV changes its coordinator or owner node. It doesn't copy the volume's data to that node, change the resiliency layout, move the VM itself, or add storage capacity. Other eligible nodes can still access the shared volume.

An ownership move can support planned node maintenance or place coordination on another eligible node. Before moving a CSV, confirm that the volume is healthy, the destination belongs to the same cluster, and the destination has the required storage access and resources. Follow the topology's ownership and placement rules, especially for rack-aware configurations.

Use `Get-ClusterSharedVolume` to identify the current owner and the full cluster resource name. An approved move uses `Move-ClusterSharedVolume` with that resource name and the intended destination node. Windows Admin Center also provides **Volumes** > **Inventory** > the selected volume > **Move**.

After the move, confirm the new owner, online state, mount-path access, expected I/O behavior, and application health. Recheck ownership before running any volume-setting command that must execute on the owner node. Moving CSV ownership alone doesn't drain a host or make it safe to restart. Host maintenance and workload migration require their own supported procedures.

## Retire volumes safely

Volume retirement removes storage that's no longer needed. Treat it as a dependency-removal and data-protection task before treating it as a capacity-reclamation task.

> [!WARNING]
> Deleting a volume destroys its data and doesn't provide an in-place undo operation. Don't delete platform infrastructure volumes or use workload-volume cleanup procedures for witness or performance-history storage.

Use the following sequence for an approved workload-volume retirement:

1. Inventory all consumers, including VM disks, Kubernetes workloads, images, application files, and associated Azure Local storage paths. Confirm that the target isn't platform-managed infrastructure storage.
1. Migrate required workloads and data through their supported lifecycle procedures, or remove workloads whose deletion is approved. Confirm that migrated applications work from the destination and that required recovery copies remain available.
1. Remove the associated Azure Local storage paths after their resource dependencies have been cleared. Removing a storage-path resource doesn't itself delete the underlying volume or its files.
1. Delete the volume through the workflow for its storage source. For local Storage Spaces Direct, `Remove-VirtualDisk` deletes the selected virtual disk and returns its allocation to the pool. For array-backed storage, coordinate cluster removal and array deprovisioning through the qualified SAN procedure instead.
1. Confirm the expected capacity reclamation at the backing layer and the absence of stale workload or placement references.

Don't identify a deletion target by a friendly name alone if names are ambiguous. Verify the associated CSV, virtual disk or LUN identity, and workload inventory before approving removal. Don't delete an array LUN while cluster nodes or other supported dependencies still use it.

## ReFS deduplication

*Deduplication* identifies duplicate data and allows multiple logical references to share physical data blocks. ReFS deduplication uses block cloning and metadata operations, processes data incrementally, and can run manually or on a schedule. Savings depend on the data: similar operating-system images can offer different results from already compressed or encrypted application data.

It's a background optimization, not an inline guarantee that every new write will occupy less space. Compare physical savings after processing with the baseline, and account for concurrent workload growth when interpreting the result.

ReFS deduplication is distinct from Windows Data Deduplication. Don't enable both on the same CSV. The ReFS feature requires an eligible ReFS CSV on a deployed and registered Azure Local instance, and settings-changing commands must run elevated on that CSV's owner node.

## Schedule and control deduplication jobs

Confirm support for the exact filesystem, resiliency layout, and workload before enabling optimization. An NTFS array-backed CSV isn't eligible for ReFS deduplication. The documented mode for this module's baseline is `Dedup`. Don't infer support for older compression modes from the documentation URL.

Record the volume's current status and schedule with `Get-ReFSDedupStatus` and `Get-ReFSDedupSchedule`. If the feature isn't enabled, enabling it with `Enable-ReFSDedup` is a separate approved configuration change. If it's already enabled, preserve the existing configuration unless the change explicitly authorizes modifications.

PowerShell supports both manual and scheduled jobs. Windows Admin Center provides scheduling through the selected volume's settings. Set an explicit start time and maximum duration rather than leaving a maintenance job unlimited. Stagger jobs across CSVs because overlapping optimization can trigger CSV movements and reduce application performance.

For example, approve one manual run on a healthy eligible CSV for a maximum of 30 minutes. With `Start-ReFSDedupJob`, specify the limit as `-Duration (New-TimeSpan -Minutes 30)`. Ensure that recurring jobs won't overlap this window and that any schedule suspension is part of the approved change.

The job can initially report `NotStarted` while it initializes. During the run, observe its status, savings, application latency, backing-storage health, and CSV ownership. Use `Get-ReFSDedupStatus` for ReFS optimization rather than assuming that `Get-StorageJob` reports every deduplication activity.

Reaching the 30-minute limit doesn't mean that the whole volume has been optimized. Later runs can process unfinished work and new or changed data. Compare actual savings with the baseline, allowing for concurrent workload growth, and record whether the run completed its work, reached its time limit, or stopped early.

Choose the control that matches the intended outcome:

| Action | Command | Effect |
| --- | --- | --- |
| Stop the current job | `Stop-ReFSDedupJob` | Stops an in-progress manual or scheduled run. It doesn't disable the feature or cancel all future scheduled runs. |
| Suspend scheduled optimization | `Suspend-ReFSDedupSchedule` | Cancels running jobs and prevents future scheduled runs while retaining schedule settings, optimization metadata, and file-change tracking. |
| Set or change the schedule | `Set-ReFSDedupSchedule` | Defines the approved start time, days, and maximum duration. Review other CSV schedules to avoid overlap. |
| Disable the feature | `Disable-ReFSDedup` | Stops active and future jobs and removes deduplication-management metadata and change tracking. It doesn't undo existing deduplication. |

If application latency exceeds the agreed limit or storage health deteriorates, stop the job and investigate before allowing another run. Disabling the feature isn't an automatic cleanup step and doesn't restore every block to its original physical layout.

Close the maintenance change only after confirming the volume's access and protection state, adequate physical reserve, and expected application operation. Record the observed savings, any incomplete optimization, and whether recurring scheduling is active, suspended, or not configured. Approve recurring optimization based on demonstrated workload impact, not an assumed savings ratio.
