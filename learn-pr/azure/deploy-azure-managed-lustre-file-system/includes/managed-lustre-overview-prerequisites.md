Before you can deploy an Azure Managed Lustre file system, you need to meet prerequisites for network configuration and, optionally, blob integration. This unit gives a high level overview of the service topology, and explains prerequisites that you must configure before creating an Azure Managed Lustre file system.

## Overview

The following diagram describes the basic service topology of an Azure Managed Lustre file system, showing how it's arranged, and how it connects to and interacts with other Azure services:

:::image type="content" source="../media/diagram-training-module.png" alt-text="Diagram describing the basic topology of an Azure Managed Lustre file system, and showing how it connects to and interacts with other Azure services." lightbox="../media/diagram-training-module.png":::

## Network prerequisites

Azure Managed Lustre file systems exist in a virtual network subnet. The subnet contains the Lustre Management Service (MGS) and handles all client interactions with the virtual Lustre cluster.

### Network size requirements

The size of subnet that you need depends on the size of the file system you create. The following table gives a rough estimate of the minimum subnet size for Azure Managed Lustre file systems of different sizes.

| Storage capacity     | Recommended CIDR prefix value |
|----------------------|-------------------------------|
| 4 TiB to 16 TiB      | /27 or larger                 |
| 20 TiB to 40 TiB     | /26 or larger                 |
| 44 TiB to 92 TiB     | /25 or larger                 |
| 96 TiB to 196 TiB    | /24 or larger                 |
| 200 TiB to 400 TiB   | /23 or larger                 |

### Subnet access and permissions

By default, no specific changes need to be made to enable Azure Managed Lustre. If your environment includes restricted network or security policies, the following guidance should be considered:

| Access type | Required network settings |
|-------------|---------------------------|
| DNS access  | Use the default Azure-based DNS server. |
| Azure cloud service access | Configure your network security group to permit the Azure Managed Lustre file system to access Azure cloud services from within the file system subnet.<br><br>Add an outbound security rule with the following properties:<br>- **Port**: Any<br>- **Protocol**: Any<br>- **Source**: Virtual Network<br>- **Destination**: "AzureCloud" service tag<br>- **Action**: Allow<br><br>Note: Configuring the Azure cloud service also enables the necessary configuration of the Azure Queue service.<br><br>For more information, see [Virtual network service tags](/azure/virtual-network/service-tags-overview). |
|Lustre network port access| Your network security group must allow inbound and outbound access on port 988 and ports 1019-1023. No other services can reserve or use these ports on your Lustre clients.<br>The default rules `65000 AllowVnetInBound` and `65000 AllowVnetOutBound` meet this requirement.|

### Other networking considerations

When planning your virtual network and subnet configuration, take into account the following considerations and limitations:

- **Azure Kubernetes Service (AKS)**: If you're using an AKS cluster with your Azure Managed Lustre file system, you can locate the AKS cluster in the same subnet as the file system. In this case, you must provide enough IP addresses for the AKS nodes and pods in addition to the address space for the Lustre file system. If you use more than one AKS cluster within the virtual network, make sure the virtual network has enough capacity for all resources in all of the clusters. To learn more about network strategies for Azure Managed Lustre and AKS, see [AKS subnet access](/azure/azure-managed-lustre/use-csi-driver-kubernetes.md#determine-the-network-type-to-use-with-aks).
- **Compute VMs / multiple clusters**: If you plan to use another resource to host your compute VMs in the same virtual network as the file system, check the requirements for that process before creating the virtual network and subnet for your Azure Managed Lustre file system. When planning multiple clusters within the same subnet, make sure to use an address space large enough to accommodate the total requirements for all clusters.
- **Azure NetApp Files**: Azure Managed Lustre and Azure NetApp Files resources can't share a subnet. If you use the Azure NetApp Files service, you must create your Azure Managed Lustre file system in a separate subnet. The deployment fails if you try to create an Azure Managed Lustre file system in a subnet that currently contains, or once contained, Azure NetApp Files resources.
- **ypbind**: If you use the `ypbind` daemon on your clients to maintain Network Information Services (NIS) binding information, you must ensure that `ypbind` doesn't reserve port 988. You can either manually adjust the ports that `ypbind` reserves, or ensure that your system startup infrastructure starts your Lustre client mount before starting `ypbind`.
- Once the file system is created, you can't move the file system another virtual network or subnet.
- Azure Managed Lustre accepts only IPv4 addresses. IPv6 isn't supported.

> [!NOTE]
> After you create your Azure Managed Lustre file system, several new network interfaces appear in the file system's resource group. Their names start with **amlfs-** and end with **-snic**. Don't change any settings on these interfaces. Specifically, leave the default value, **enabled**, for the **Accelerated networking** setting. Disabling accelerated networking on these network interfaces degrades your file system's performance.

## Blob integration prerequisites

If you plan to integrate your Azure Managed Lustre file system with Azure Blob Storage, complete the following prerequisites before you create your file system.

To integrate Azure Blob Storage with your Azure Managed Lustre file system, you must create or configure the following resources before you create the file system:

- [Storage account](#storage-account)
- [Blob containers](#blob-containers)

To learn more about blob integration, see [Use Azure Blob storage with an Azure Managed Lustre file system](/azure/azure-managed-lustre/blob-integration.md).

### Storage account

Create a new storage account or use an existing one. The storage account must have the following settings:

- **Account type** - A compatible storage account type.
- **Access roles** - Role assignments that permit the Azure Managed Lustre system to modify data.
- **Access keys** - The storage account must have the storage account key access setting set to **Enabled**.

#### Supported storage account types

The following storage account types can be used with Azure Managed Lustre file systems:

| Storage account type  | Redundancy                          |
|-----------------------|-------------------------------------|
| Standard              | Locally redundant storage (LRS), geo-redundant storage (GRS)<br><br>Zone-redundant storage (ZRS), read-access-geo-redundant storage (RAGRS), geo-zone-redundant storage (GZRS), read-access-geo-zone-redundant storage (RA-GZRS) |
| Premium - Block blobs | LRS, ZRS |

For more information about storage account types, see [Types of storage accounts](/azure/storage/common/storage-account-overview#types-of-storage-accounts).

#### Access roles for blob integration

Azure Managed Lustre needs authorization to access your storage account. Use [Azure role-based access control (Azure RBAC)](/azure/role-based-access-control/) to give the file system access to your blob storage.

A storage account owner must add these roles before creating the file system:

- [Storage Account Contributor](/azure/role-based-access-control/built-in-roles#storage-account-contributor)
- [Storage Blob Data Contributor](/azure/role-based-access-control/built-in-roles#storage-blob-data-contributor)

To add the roles for the service principal **HPC Cache Resource Provider**, follow these steps:

1. Navigate your storage account, and select **Access control (IAM)** in the left navigation pane.
1. Select **Add** > **Add role assignment** to open the **Add role assignment** page.
1. Assign the role.
1. Add **HPC Cache Resource Provider** to that role.
   > [!TIP]
   > If you can't find the HPC Cache Resource Provider, search for **storagecache** instead. **storagecache Resource Provider** was the service principal name before general availability of the product.
1. Repeat steps 3 and 4 to add each role.

For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

### Blob containers

You must have two separate blob containers in the same storage account, which are used for the following purposes:

- **Data container**: A blob container in the storage account that contains the files you want to use in the Azure Managed Lustre file system.
- **Logging container**: A second container for import/export logs in the storage account. You must store the logs in a different container from the data container.

> [!NOTE]
> You can add files to the file system later from clients. However, files added to the original blob container after you create the file system won't be imported to the Azure Managed Lustre file system unless you [create an import job](/azure/azure-managed-lustre/create-import-job.md).

### Private endpoints (optional)

If you're using a private endpoint with your storage, you must enable the setting **Integrate with private DNS Zone** during the creation of a new private endpoint. This setting ensures that the private endpoint can resolve the DNS name of the storage account.
