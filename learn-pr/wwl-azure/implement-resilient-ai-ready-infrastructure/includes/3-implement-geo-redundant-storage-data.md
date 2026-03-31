Training datasets for AI models often represent months of data collection, curation, and labeling effort that's difficult or impossible to recreate if lost. When a storage account fails or someone accidentally deletes critical training data, recovery depends on your redundancy configuration and data protection policies. Azure Blob Storage provides multiple redundancy tiers that replicate data within a single datacenter, across availability zones in one region, or to secondary region hundreds of miles away. For production AI workloads, geo-redundant storage (GRS) becomes essential because it protects against complete regional failures that could otherwise make all your training data permanently inaccessible.

With geo-redundant storage, Azure automatically maintains six copies of your data—three in the primary region using locally redundant storage (LRS) and three in a paired secondary region also using LRS. This replication happens asynchronously, meaning writes complete in the primary region first, then Azure replicates the changes to the secondary region with typical latency of a few minutes. Unlike synchronous replication that would guarantee zero data loss but increase write latency significantly, asynchronous replication provides the right balance for AI workloads where you can tolerate losing a few minutes of recent changes during a catastrophic regional failure but need fast write performance during normal training operations.

:::image type="content" source="../media/azure-automatically-copies-data-region.png" alt-text="Diagram shows how Azure automatically maintains six copies of data with three in the primary region.":::

## Understanding redundancy options for AI workloads

Four storage redundancy tiers offer different levels of protection and cost trade-offs. Locally redundant storage (LRS) keeps three copies within a single datacenter, providing durability within that region. This durability percentage means that if you store 10,000 objects for a year, you statistically risk losing one object. LRS works well for development datasets where you can regenerate data from source systems if needed and regional outages don't impact business operations.

Geo-redundant storage (GRS) extends this protection to a secondary region with six total copies and high durability, about twice the LRS baseline. The more five nines of durability mean you reduce the risk of data loss by 100,000 times compared to LRS, critical for production training datasets that can't be recreated. However, standard GRS doesn't allow read access to the secondary region's data until you manually initiate a failover through the Azure portal or API, making it suitable for disaster recovery scenarios where you can tolerate hours of downtime during regional transitions.

Read-access geo-redundant storage (RA-GRS) provides the same durability and replication as GRS but enables continuous read access to the secondary region's data without requiring failover. This becomes especially important when you need to serve inference requests from multiple geographic regions or want to validate that replicated data is current before an actual failover occurs. The cost remains the same as GRS, but you gain the ability to configure your application to read from the secondary endpoint proactively, reducing recovery time objectives from hours to minutes.

:::image type="content" source="../media/enable-continuous-read-access-secondary-region.png" alt-text="Diagram showing how read-access geo-redundant storage provides durability and replication.":::

Geo-zone-redundant storage (GZRS) combines zone redundancy within the primary region (three copies across different availability zones) with geo-redundancy to a secondary region, achieving the same 16-nines durability. This pattern protects against both zone-level failures (datacenter-level outages within one region) and region-level failures simultaneously. Organizations choose GZRS for mission-critical AI data where they need maximum availability and can't tolerate even brief outages from single datacenter failures within their primary region.

## Implementing soft delete and resource locks

Redundancy protects against infrastructure failures, but it doesn't prevent accidental deletion or malicious data modification—if someone deletes a blob in the primary region, that deletion replicates to the secondary region within minutes. Soft delete addresses this vulnerability by retaining deleted blobs in a recoverable state for a configurable retention period between 1 and 365 days. When you enable soft delete with a 30-day retention window, deleted training datasets remain recoverable for a month, giving you time to detect accidental deletions during routine backup validation and restore the data without involving Azure support.

Soft delete protects at the blob level, but it doesn't prevent someone from deleting the entire storage account or resource group that contains it. Resource locks provide infrastructure-level protection by requiring explicit lock removal before deletion operations succeed. When you apply a CanNotDelete lock to a storage account, even users with Owner permissions on the subscription can't delete the account until they first remove the lock through a separate action, creating a more verification step that prevents accidental infrastructure removal during cleanup operations or automated scripts.

:::image type="content" source="../media/resource-locks-infrastructure-level-protection.png" alt-text="Diagram showing how resource locks provide infrastructure-level protection by requiring explicit lock removal.":::

Combining these three protection layers—geo-redundant replication, soft delete with 30+ day retention, and CanNotDelete resource locks—creates defense in depth for your AI data. At the same time, this approach increases operational complexity because you must update runbooks to include lock removal steps during legitimate decommissioning and train teams to check soft delete containers before assuming data is permanently lost. Consider what happens when your data science team needs to quickly free up storage quota by deleting old experiment results—they need clear documentation explaining that soft delete doesn't immediately release capacity and that permanently purging soft-deleted blobs requires more permissions and explicit confirmation steps.

## Recovery objectives and failover procedures

Two metrics help you evaluate whether your storage configuration meets business requirements: recovery time objective (RTO) defines the maximum acceptable downtime during recovery, and recovery point objective (RPO) defines the maximum acceptable data loss measured in time. With standard GRS, your RTO depends on how quickly you detect the primary region failure and initiate manual failover through the Azure portal, typically 1-2 hours including detection, approval, and DNS propagation time. Your RPO with asynchronous replication is usually under 15 minutes, meaning you may lose recent writes that didn't replicate before the primary region failed.

:::image type="content" source="../media/maximum-acceptable-data-loss-measured-time.png" alt-text="Diagram showing the maximum acceptable downtime during recovery and recovery point objective.":::

RA-GRS improves RTO significantly because your application can immediately start reading from the secondary endpoint when it detects primary region unavailability, reducing recovery time to minutes rather than hours. However, this requires application-level logic to handle the read-only nature of the secondary endpoint until you perform failover, which permanently switches primary and secondary roles. After failover completes, the former primary region becomes the new secondary, and you must wait for Azure to establish reverse replication before initiating another failover if needed.

For AI training workloads, these recovery characteristics influence your architecture decisions. If your training jobs can checkpoint progress every hour and resume from the last checkpoint, a 15-minute RPO means you lose at most 15 minutes of training progress during regional failure. Building on this concept, you need to coordinate storage failover with compute resource availability—failing over storage to West US doesn't help if your hub's compute clusters remain in the unavailable East US region. With this understanding of storage protection mechanisms, you're ready to examine how container registry geo-replication ensures your model images are available in each region where you deploy compute resources.

:::image type="content" source="../media/blob-storage-geo-redundant-replication-architecture.png" alt-text="Diagram showing synchronous local replication, asynchronous cross-region replication, and data protection layers.":::    


*Azure Blob Storage geo-redundant replication architecture showing synchronous local replication, asynchronous cross-region replication, and data protection layers including soft delete and resource locks*

## More resources

- [Azure Storage redundancy documentation](/azure/storage/common/storage-redundancy) - Detailed comparison of LRS, GRS, RA-GRS, and GZRS with durability calculations
- [Soft delete for blobs](/azure/storage/blobs/soft-delete-blob-overview) - Configuration steps and retention policies for blob-level data protection
- [Resource locks in Azure](/azure/azure-resource-manager/management/lock-resources) - Guide to applying CanNotDelete and ReadOnly locks to prevent accidental deletion

