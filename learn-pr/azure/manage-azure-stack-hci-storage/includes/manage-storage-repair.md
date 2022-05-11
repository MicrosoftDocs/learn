With all the relevant configuration settings in place, you now want to focus on the operational aspects of managing Azure Stack HCI drives. Although you are confident that you've successfully optimized storage performance, capacity, and resiliency, you realize that downtime from hardware failures and maintenance events is unavoidable. To properly prepare for failure and maintenance downtime, you need to determine how Azure Stack HCI handles the storage repair process. 

## Describe storage repair in Azure Stack HCI

In addition to the resiliency provisions presented earlier in this module, Storage Spaces Direct includes self-healing capabilities that simplify its maintenance considerably. However, before you focus on maintenance considerations, it's helpful to first explore the purpose and significance of the Health Service.

The Health Service continuously monitors the cluster and its components for issues. When it detects issues, it analyzes their characteristics, assesses their impact, and identifies steps to resolve them. It then records the outcome in the form of faults. Each fault includes the following information:

- The severity of the impact

- A description of the issue

- Recommended steps to resolve the issue

- Identifying information for the faulting entity

- The physical location of the faulting entity

Whenever possible, Health Service uses information it collects to remediate the underlying issue and restore the cluster and its components to their original operational status state. This remediation takes the form of actions. 

Health Service relies on actions to automate and streamline a number of disk lifecycle events, including:

- Retiring the disk. The Health Service automatically retires disks in response to faults affecting their availability or performance, including:

   - Media failure. This is applicable to any disk that experiences physical failure.
   - Lost communication. This is applicable to any disk that that isn’t accessible for more than 15 minutes.
   - Unresponsiveness. This is applicable to any disk for which latency of individual reads or writes increases to more than five seconds at least three times within an hour.

   > [!NOTE]
   > Disk retirement doesn't apply in cases where a failure simultaneously affects multiple disks, an entire node, or a storage enclosure.

- Restoring resiliency. After a disk is designated as retired, Health Service automatically rebalances data distribution to the remaining disks to reinstate full resiliency.

- Activating a disk indicator light. Health Service automatically triggers the indicator light on a disk following its retirement.

- Disk pooling. When a replacement disk is available, Health Service automatically adds it to the storage pool and rebalances data distribution accordingly.

- Fault reporting. After the data distribution completes, Health Service automatically resolves the fault and updates the Storage Spaces Direct health status.

In this sequence of events, your only responsibility is replacing a failed disk or disks. Because disks are hot-swappable, this is an online operation.

You should leave some unallocated capacity in the storage pool to benefit from the automatic storage repair process that occurs following drive failures. Storage Spaces Direct triggers this process if there's sufficient disk space in the pool. To optimize disk space usage, consider setting aside the equivalent of one capacity drive per server, up to four drives per server.

> [!NOTE]
> In clusters with drives of all three types (NVMe, SSD, and HDD), you should reserve the equivalent of one SSD drive plus one HDD drive per server, up to four drives of each.

> [!NOTE]
> Storage repair occurs in response to drive failures in addition to following standard maintenance tasks such as reboots of individual cluster nodes or temporary downtime resulting from a patch deployment. 

## Describe storage repair speed settings in Azure Stack HCI

Automatic storage repair utilizes storage resources, so it could interfere with active workloads. As an Azure Stack HCI administrator, you can control the degree of this interference. If active workload performance is your key priority, you can allocate more resources to them, effectively extending the period during which the cluster operates in a reduced resiliency state. Conversely, if your primary objective is to accelerate restoring full cluster resiliency, you can increase the repair process priority provided you're willing to accept a higher risk of negatively affecting the active workloads.

The storage repair speed is configurable by using the following settings:

| Setting | Queue depth | Resource allocation                                      |
| ----------- | --------------- | ------------------------------------------------------------ |
| Very low    | 1               | Prioritizes active workloads, resulting in  a longer repair period. |
| Low         | 2               | Favors active workloads.                                     |
| Medium      | 4               | Balances active workloads and recovery  speed (default).     |
| High        | 8               | Favors recovery speed.                                       |
| Very high   | 16              | Prioritizes recovery speed.                                  |

## Manage storage repair speed settings in Azure Stack HCI

To change the repair speed settings, you can use Windows Admin Center or the 'Set-StorageSubSystem' PowerShell cmdlet.

The storage repair speed is setting on the Storage Spaces and pools page in the Windows Admin Center. You can select one of the storage repair speeds listed in the previous table.

:::image type="content" source="../media/7-storage-repair-speed.png" alt-text="Screenshot of the Storage Spaces and pools page with the medium option being selected for storage repair speed." border="true":::

When using PowerShell, you reference the queue depth value by using the *-**VirtualDiskRepairQueueDepth* parameter of the 'Set-StorageSubSystem' cmdlet.

> [!IMPORTANT]
> The total storage capacity per server shouldn't exceed 400 TB. The more storage capacity per server, the longer the time required to complete the repair process after downtime or rebooting, such as when applying software updates.
