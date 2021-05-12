As part of your evaluation of Azure Stack HCI, you identified the quorum configuration that provides sufficient high availability provisions. Now, you want to address the lack of disaster recovery provisions, which surfaced during recent outages in Contoso's on-premises datacenters. To accomplish this goal, you decide to explore the possibility of implementing Azure Stack HCI stretched clusters, spanning two datacenters, with nodes in each site.

## Overview of Azure Stack HCI stretched clusters

To provide site-level resiliency for Azure Stack HCI, you can implement a stretched Azure Stack HCI cluster that consists of two groups of nodes with one group per site. Each group must contain at least two nodes. The total number of nodes in a stretched cluster cannot exceed the maximum number of nodes supported by Azure Stack HCI for a single cluster. 

A stretched Azure Stack HCI cluster relies on Storage Replica to perform synchronous replication between storage volumes hosted by the two groups of nodes in their respective physical sites. If a failure is affecting the availability of the primary site, to minimize potential downtime, the cluster automatically brings online its workloads on nodes in the surviving site. For a planned downtime at the primary site, you can use Hyper-V Live Migration to transition VM-based workloads to the other site, which maintains their online status.

> [NOTE]
> The synchronous replication requirement imposes a limit of five milliseconds (ms) round-trip network latency between two groups of cluster nodes in the replicated sites. Depending on the physical network connectivity characteristics, this limit typically translates into a distance of 20–30 miles.

Stretched Azure Stack HCI clusters support the active-passive and active-active modes. In the active-passive mode, you have a designated primary site, which unidirectionally replicates to another site providing the disaster recovery functionality. In the active-active mode, two sites replicate their respective volumes unidirectionally to each other, providing failover capability if there is a failure in either site. The active-active mode helps minimize business continuity costs by eliminating the need for a dedicated disaster recovery site. 

Azure Stack HCI stretched clusters are site aware. Site awareness allows you to control placement of virtualized workloads by assigning to them their preferred sites. This way, you can ensure that each site hosts clustered VMs serving core infrastructure roles, such as Active Directory Domain Services (AD DS) domain controllers and Domain Name System (DNS) servers.

## Implement Azure Stack HCI stretched clusters by using Windows Admin Center

The Create Cluster wizard in Windows Admin Center provides a wizard-driven interface that guides you through the process of creating an Azure Stack HCI stretched cluster. The wizard detects whether cluster nodes reside in two distinct AD DS sites or whether their IP addresses belong to two different subnets. If either of these two conditions are satisfied, the wizard automatically creates and configures the corresponding cluster sites. Windows Admin Center also simplifies the process of provisioning replicated volumes.

> [!NOTE]
> Creating volumes and virtual disks for stretched clusters is more complex than that for single-site clusters. Stretched clusters require a minimum of four volumes, comprised of two data volumes and two log volumes, with a data/log volume pair at each site. When you create a replicated data volume by using Windows Admin Center, the process automatically provisions the log volume in the primary site and both data and log replicated volumes in the secondary site. This ensures that each volume has the required size and configuration settings.

---
## Check your knowledge

## Multiple Choice
You are designing a disaster recovery site for Contoso that will provide disaster recovery capabilities for Azure Stack HCI clusters in the primary site. You need to ensure that you will be able to implement a stretched cluster to automate failover of the virtualized workloads. What should be the maximum round-trip network latency between the two sites?
( ) < 5 ms{{Correct. The synchronous replication requirement imposes a limit of 5 ms round-trip network latency between two groups of cluster nodes in the replicated sites. }}
( ) < 50 ms{{Incorrect. This latency would be acceptable only with asynchronous replication, which is not supported by Azure Stack HCI stretched clusters.}}
( ) < 200 ms{{Incorrect. This latency would be acceptable only with asynchronous replication, which is not supported by Azure Stack HCI stretched clusters.}}