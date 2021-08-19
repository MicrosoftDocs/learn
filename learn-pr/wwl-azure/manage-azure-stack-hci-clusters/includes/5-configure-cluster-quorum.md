Recent hardware failures and power outages in Contoso's on-premises datacenters exposed flaws in the way some of the more critical internally developed applications were implemented, including a lack of sufficient high availability provisions. As part of your evaluation of Azure Stack HCI, you want to ensure that its implementation will take into account the need for such provisions. To accomplish this goal, you decide to explore the concept of cluster quorum and witness in Azure Stack HCI and identify their optimal configuration.

## Overview of cluster quorum and cluster witness in Azure Stack HCI clusters

Azure Stack HCI relies on the Windows Server Failover Clustering operating system feature to implement its high availability capabilities. In a failover cluster, the term quorum represents the number of clustering components that must be available for that cluster to remain online. These components include the cluster nodes and a witness. A *witness* is a resource that helps establish and maintain a quorum. 

> [!NOTE]
> The purpose of a quorum is to prevent the "split brain" scenario. In such a scenario, because of internode connectivity issues, two sets of nodes in a cluster start operating independently of each other, resulting in the corruption of the cluster state and its resources.

You can determine the quorum based on the number of votes associated with each component and the quorum mechanism. Azure Stack HCI includes two quorum mechanisms:

- Cluster quorum, which operates at the cluster level and is based on the votes from nodes and a witness. You can implement such a witness either as a file share or as a blob in an Azure Storage account. 

    > [!NOTE]
    > Azure Stack HCI does not support disk witness.

- Pool quorum, which operates on the storage pool level and is based on the votes from nodes and storage resiliency. The pool quorum designates the node that owns the storage pool resource as the witness.

The following table gives an overview of cluster resiliency based on the number of nodes and the existence of a witness.

|Server nodes|Can survive one server node failure|Can survive one server node failure, then another|Can survive two simultaneous server node failures|
|||||
|2|50/50|No|No|
|2 plus witness|Yes|No|No|
|3|Yes|50/50|No|
|3 plus witness|Yes|Yes|No|
|4|Yes|Yes|50/50|
|4 plus witness|Yes|Yes|Yes|
|5 and above|Yes|Yes|Yes|

The following table provides an overview of the pool quorum resiliency based on the number of nodes and the existence of a witness.

|Server nodes|Can survive one server node failure|Can survive one server node failure, then another|Can survive two simultaneous server node failures|
|||||
|2|No|No|No|
|2 plus witness|Yes|No|No|
|3|Yes|No|No|
|3 plus witness|Yes|No|No|
|4|Yes|No|No|
|4 plus witness|Yes|Yes|Yes|
|5 and above|Yes|Yes|Yes|

 > [!NOTE] 
 > Storage Spaces Direct tolerates (at most) two concurrent node failures for four or more nodes with a witness, regardless of the cluster size.

> [!NOTE]
> The functionality of an Azure Stack HCI cluster depends not only on a quorum but also on the resources available to cluster nodes and their ability to run clustered workloads that fail over to that node. For example, a cluster with five nodes will still have a quorum even if two nodes fail. However, each remaining cluster node continues serving clients only if it has enough resources to run cluster roles that failed over to the remaining three nodes. These resources include storage, processing power, network bandwidth, and memory. 

## Configure an Azure Stack HCI cluster witness by using Windows Admin Center

Although you can configure a cluster witness either as a file share or as a blob in an Azure Storage account, we recommended the blob option as long as the cluster has reliable network connectivity to the Azure region that hosts the storage account. This approach offers more resiliency, facilitating disaster recovery when using stretched clusters, which are described in the next learning unit. 

This type of configuration is referred to as cloud witness and the simplest way to set it up involves the use of Windows Admin Center. The setup consists of the following high-level steps:

1. Connect to the Azure subscription that will host the Azure Storage account that contains the cloud witness blob.
1. In the Azure subscription, create a General Purpose v1 or General Purpose v2 Azure Storage account configured with a locally redundant storage (LRS) replication setting.
1. Retrieve the value of one of the two access keys associated with the storage account. You can identify the key values directly from the storage account blade in the Azure portal.

    :::image type="content" source="../media/cloud-witness-2.png" alt-text="The screenshot depicts the Azure portal Access keys blade that contains the storage account name and the two keys associated with the storage account." border="false":::

1. Connect to the Azure Stack HCI cluster by using Windows Admin Center.
1. Configure the cloud witness quorum from the Cluster Manager interface in Windows Admin Center by providing the storage account name and one of its access keys.

    :::image type="content" source="../media/cloud-witness-4.png" alt-text="The screenshot depicts the Cluster Manager interface in Windows Admin Center with the witness configuration completed." border="false":::

## Demonstration: Configure cloud witness in Azure Stack HCI

In this demonstration, you'll learn how to configure cloud witness in Azure Stack HCI.

>[!VIDEO https://www.microsoft.com/videoplayer/embed/RWDuEE]