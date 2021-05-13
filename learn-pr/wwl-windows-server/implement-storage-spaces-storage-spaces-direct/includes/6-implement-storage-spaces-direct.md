Implementing Storage Spaces Direct is relatively easy considering the complexity of its architecture. You can use for this purpose Windows Admin Center, Windows PowerShell, or Microsoft System Center Virtual Machine Manager.

## Implement Storage Spaces Direct by using Windows Admin Center

Windows Admin Center simplifies implementation of Storage Spaces Direct clusters by guiding through the provisioning process and automating most configuration tasks. You can use it to implement the following Storage Spaces Direct configurations:

- Hyperconverged (Failover Clustering, Hyper-V, and Storage Spaces Direct).
- Hyperconverged with Software Defined Networking (SDN) (Failover Clustering, Hyper-V, and Storage Spaces Direct, Software Defined Networking).
- Storage cluster (Failover Clustering and Storage Spaces Direct).

## Implement Storage Spaces Direct by using Windows PowerShell

Windows PowerShell facilitates implementation of Storage Spaces Direct clusters by offering several Storage Spaces Direct-related storage and Failover Clustering cmdlets, including:

- ```Test-Cluster```. This cmdlet tests the suitability of a hardware configuration before you create a cluster.
- ```Enable-ClusterS2D```. This cmdlet configures a cluster for Storage Spaces Direct.
- ```Optimize-StoragePool```. This cmdlet rebalances storage optimization if a disk or storage node changes.
- ```Get-HealthFault```. This cmdlet displays any faults that are affecting Storage Spaces Direct.

> [!NOTE]
> ```Enable-ClusterStorageSpacesDirect``` is an alias of ```Enable-ClusterS2D```.

## Implement Storage Spaces Direct by using Microsoft System Center Virtual Machine Manager

If you use Microsoft System Center Virtual Machine Manager, you can use to deploy a Storage Spaces Direct cluster. To do so, when you run the **Create Hyper-V Cluster Wizard**, select the **Enable Storage Spaces Direct** check box. The wizard then performs the following high-level tasks:

1. Installs the relevant Windows Server roles.
1. Runs cluster validation.
1. Installs and configures failover clustering.
1. Enables storage features.

## Demonstration

The following video demonstrates how to provision Storage Spaces Direct by using Windows PowerShell.

The main steps in the process are:

1. Create AD DS environment. Create a single-domain AD DS forest with two domain member servers with four data disks each.
1. Install the Windows Server roles and features. Use Windows PowerShell to install required roles and services on the domain member servers.
1. Validate cluster configuration and create a cluster. Use Windows PowerShell to validate cluster configuration and create a cluster.
1. Enable the Storage Spaces Direct feature, create a storage pool, virtual disk, file server, and file share. Use Windows PowerShell to enable the Storage Spaces Direct feature, create a storage pool, virtual disk, file server, and file share.
1. Test storage high availability. Use Windows PowerShell to trigger a failure of one of the cluster nodes and verify the availability of clustered volumes.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MB0j]