As part of your evaluation of Azure Stack HCI volume-related features, you intend to explore the functionality that would provide disaster recovery based on stretched clusters. To accomplish this, you intend to set up a cluster that spans two locations and configure their volumes with synchronous replication. This will provide automatic failover in case of a failure in the primary location. You realize that it’s possible to script this configuration with PowerShell, but to simplify the setup you decided to use Windows Admin Center instead.

## Describe considerations for stretched volumes

With stretched Azure Stack HCI clusters, a subset of nodes in one location uses Storage Replica to replicate stretched volumes to the remaining cluster nodes in another location. Such a setup requires at least a 4-node cluster, with a pair of nodes in each location. To support automatic failover, the replication must be synchronous, which in turn limits the distance between the two locations to about 20 to 30 miles (32 to 48 kilometers).

> [!NOTE]
> The distance corresponds to the limit of 5 millisecond (ms) round-trip network latency between two groups of cluster nodes in the replicated sites, which is imposed by the synchronous replication requirement. This is important because synchronous replication ensures crash consistency with zero data loss during a failover.

> [!NOTE]
> The Storage Replica's signing and encryption functionality automatically helps protect the replication traffic.

Stretched clusters require a minimum of four volumes comprised of two data volumes and two log volumes with a data/log volume pair at each site. If you create a replicated data volume by using Windows Admin Center, the process automatically provisions the log volume in the primary site and both data and log replicated volumes in the secondary site. This ensures that each of them has the required size and configuration settings.

## Create stretched volumes and configure their replication

To create a stretched volume and set up its replication by using Windows Admin Center:

1. In Windows Admin Center, connect to a Storage Spaces Direct cluster.
1. In the **Tools** pane, select **Volumes**.
1. On the **Volumes** page, select the **Inventory** tab, and then select **Create volume**.
1. In the **Create volume** pane, select the **Replicate volume between sites** option.
1. From the **Replication direction** drop-down list, select the intended replication direction.
1. In the **Replication mode** section, select **Synchronous**.
1. Expand the **Advanced** section, and within the **Advanced** section:
    1. Specify a **Source replication group name**.
    1. Specify a **Destination replication group name**.
    1. If intended, select the **Use blocks already seeded on the target** checkbox.
    1. If intended, select the **Encrypt replication traffic** checkbox.
    1. If intended, select the **Enable consistency groups** checkbox.
1. Enter a name for the volume, and then from the **Resiliency** drop-down list, select the intended resiliency level.
1. In the **Size on HDD** box, specify the size of the volume (for example, **5 TB**), and then select **Create**.

In the details pane of the Windows Admin Center **Volumes** page you should be able to verify that a data disk and a log disk were created in the primary location, and that corresponding data and log replica disks were created in the secondary location. 

Another way to verify the resulting functionality is to open the **Storage Replica** pane from the **Tools** menu, and then in the **Partnerships** section, locate the replication partnership corresponding to the stretched volume replication.

> [!NOTE]
> If you intend to use bidirectional replication, configure two sets of data and volume disks, one per location.
