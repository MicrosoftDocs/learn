Azure NetApp Files provides metrics on allocated storage, actual storage usage, volume IOPS, and latency. By analyzing these metrics, you can gain a better understanding of the usage pattern and volume performance of your NetApp accounts.

## Access metrics 

Watch this video to understand how you can access access the metrics to monitor Azure NetApp Files system.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=49e989a1-0cd7-47c1-b455-da540f682fe7]

## Metrics for Azure NetApp Files

Azure NetApp Files supports different from usage, performance, and throughput. 

### Usage metrics for capacity pools

| Metric | Description | 
| - | --- |
| Pool Allocated Size | The provisioned size of the pool 
| Pool Allocated to Volume Size | The total of volume quota (GiB) in a given capacity pool (that is, the total of the volumes' provisioned sizes in the capacity pool). This size is the size you selected during volume creation. |
| Pool Consumed Size | The total logical space (GiB) used across volumes in a capacity pool. |
| Total Snapshot Size for the Pool | The sum of snapshot size from all volumes in the pool. |

### Usage metrics for volumes

| Metric | Description | 
| - | --- |
| Percentage Volume Consumed Size | The percentage of the volume consumed, including snapshots. Aggregation metrics (for example, min, max) aren't supported for percentage volume consumed size. |
| Volume Allocated Size | The provisioned size of a volume. |
| Volume Quota Size | The quota size (GiB) the volume is provisioned with. |
| Volume Consumed Size | Logical size of the volume (used bytes). This size includes logical space used by active file systems and snapshots. |
| Volume Snapshot Size	| The size of all snapshots in a volume. |
| Throughput limit reached. | Throughput limit reached is a boolean metric that denotes the volume is hitting its QoS limits. The value 1 means that the volume has reached its maximum throughput, and throughput for this volume will be throttled. The value 0 means this limit hasn't yet been reached. |

>[!NOTE]
>The Throughput limit reached metrics is collected every 5 minutes and is displayed as a hit if it has been collected in the last 5 minutes.

### Performance metrics for volumes

| Metric | Description | 
| - | --- |
| Average Read Latency | The average time for reads from the volume in milliseconds. |
| Average Write Latency | The average time for writes from the volume in milliseconds. |
| Read IOPS | The number of reads to the volume per second. |
| Write IOPS | The number of writes to the volume per second. |

### Volume replication metrics

| Metric | Description | 
| - | --- |
| Is volume replication status healthy | The average time for reads from the volume in milliseconds. |
| Is volume replication transferring | The average time for writes from the volume in milliseconds. |
| Volume replication lag time | The number of reads to the volume per second. |
| Volume replication last transfer duration | The number of writes to the volume per second. |
| Volume replication last transfer size	 | The total number of bytes transferred as part of the last transfer |
| Volume replication progress | The total amount of data transferred for the current transfer operation. |
| Volume replication total transfer | The cumulative bytes transferred for the relationship. |

### Throughput metrics for capacity pools

| Metric | Description | 
| - | --- |
| Pool allocated throughput | Sum of the throughput of all the volumes belonging to the pool. |
| Provisioned throughput for the pool | Provisioned throughput of this pool. |

### Throughput metrics for volumes

| Metric | Description | 
| - | --- |
| Read throughput | Read throughput in bytes per second. |
| Total throughput | Sum of all throughput in bytes per second. |
| Write throughput | Write throughput in bytes per second. |
| Other throughput | Other throughput (that isn't read or write) in bytes per second. |

## Azure Policy definitions for Azure NetApp Files

Azure Policy helps to enforce organizational standards and to assess compliance at-scale. Through its compliance dashboard, it provides an aggregated view to evaluate the overall state of the environment, with the ability to drill down to the per-resource, per-policy granularity. It also helps to bring your resources to compliance through bulk remediation for existing resources and automatic remediation for new resources.

### Custom policy definitions

Azure NetApp Files supports Azure Policy. You can integrate Azure NetApp Files with Azure Policy through creating custom policy definitions.

### Built-in policy definitions

The Azure Policy built-in definitions for Azure NetApp Files enable organization admins to restrict creation of unsecure volumes or audit existing volumes. Each policy definition in Azure Policy has a single effect. That effect determines what happens when the policy rule is evaluated to match.

The following effects of Azure Policy can be used with Azure NetApp Files:

- Deny creation of non-compliant volumes
- Audit existing volumes for compliance.
- Disable a policy definition.

## Storage service add-ons for Azure NetApp Files

The Storage service add-ons portal menu of Azure NetApp Files provides a launching pad for available third-party, ecosystem add-ons to the Azure NetApp Files storage service.

### Access storage service add-ons

Selecting a category (for example, NetApp add-ons) under Storage service add-ons displays tiles for available add-ons in that category. Selecting an add-on tile in the category takes you to a landing page for quick access of that add-on and directs you to the add-on installation page.

:::image type="content" source="../media/6-add-on.png" alt-text="Screenshot of NetApp add-ons.":::
