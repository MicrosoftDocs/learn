In this unit, you learn how to create an Azure Managed Lustre file system using the Azure portal. It's important to plan the configuration options carefully, as they can't be changed after you create your file system.

## Sign in to the Azure portal

1. Sign in to [the Azure portal](https://portal.azure.com).

1. Type **Azure Managed Lustre** in the search box, and press **Enter**.

1. On the **Azure Managed Lustre** page, select **+ Create**.

## Basics tab

On the **Basics** tab, you provide essential information about your Azure Managed Lustre file system. The following table describes the settings on the **Basics** tab:

| Section | Field | Required or optional | Description |
|---------|-------|----------------------|-------------|
| Project details | Subscription | Required | Select the subscription to use for the Azure Managed Lustre file system. |
| Project details | Resource group | Required | Select an existing resource group, or create a new resource group for this deployment. |
| Project details | Region | Required | Select the Azure region for your file system. For optimal performance, create the file system in the same region and availability zone as your client machines. |
| Project details | Availability zone | Required | Select the availability zone for your file system. |
| File system details | File system name | Required | Enter a name to identify this file system in your list of resources. This name isn't the name of the file system used in `mount` commands. |
| File system details | File system type | Required | Shows **Durable, SSD**. |
| File system details | Storage and throughput | Required | Enter the storage capacity of your file system in TiB, or the maximum throughput in MB/s.</br></br>There are two factors that determine your file system size: The amount of storage allocated for your data (storage capacity), and the maximum data transfer rate (throughput). When you select one of these options, the other values are calculated based on the **Throughput per TiB** setting for your file system type. To set the file system size, choose either **Storage capacity** or **Maximum throughput**. Enter a value in the corresponding field, either the desired storage capacity (in TiB) if you selected **Storage capacity**, or the desired maximum throughput (in MB/second) if you selected **Maximum throughput**.</br></br>Note: These values are rounded up to meet incremental size requirements. The values are never rounded down, so check the final configuration to make sure it's cost-effective for your workload. To learn more about available throughput configurations, see [Throughput configurations](#throughput-configurations). |
| Networking | Virtual network | Required | Select an existing virtual network to use for the file system, or create a new virtual network. |
| Networking | Subnet | Required | Select an existing subnet or create a new one. The Azure Managed Lustre file system uses a dedicated virtual network and one subnet. The subnet contains the Lustre Management Service (MGS), which handles all of the client interaction with the Azure Managed Lustre system. You can open the **Manage subnet configuration** link to make sure the subnet meets your network requirements. The network should have enough available IP addresses to handle the file system's load and any additional IP addresses required by any other services that are colocated with the file system. Make sure you configure all access settings to enable the subnet to access the needed Azure services. |
| Maintenance window | Day of the week | Required | Provide a preferred day of the week and time for the Azure team to perform maintenance and troubleshooting. This maintenance is infrequent and performed only as needed. To learn more, see [Maintenance window](#maintenance-window). |
| Maintenance window | Start time | Required | Provide the time that the maintenance window can begin. Time should be in 24-hour format (HH:MM). |

The following screenshot shows an example of the **Basics** tab for creating an Azure Managed Lustre file system in the Azure portal:

:::image type="content" source="../media/basics-tab.png" alt-text="A screenshot showing the Basics tab for creating an Azure Managed Lustre file system in the Azure portal." lightbox="../media/basics-tab.png":::

When you finish entering details on the **Basics** tab, select **Next: Advanced** to continue.

### Throughput configurations

Currently, the following throughput configurations are available:

| Throughput per TiB storage | Storage minimum | Storage maximum | Increment |
|-----------|-----------|-----------|-----------|
| 40 MB/second | 48 TiB | 768 TiB | 48 TiB |
| 125 MB/second | 16 TiB | 128 TiB | 16 TiB |
| 250 MB/second | 8 TiB | 128 TiB | 8 TiB |
| 500 MB/second | 4 TiB | 128 TiB | 4 TiB |

> [!NOTE]
> Upon request, Azure Managed Lustre can support larger storage capacities up to 2.5PB. To make a request for a larger storage capacity, please [open a support ticket](https://ms.portal.azure.com/#view/Microsoft_Azure_Support/HelpAndSupportBlade/~/overview).
>
> If you need cluster sizes greater than 2.5PB, you can [open a support ticket](https://ms.portal.azure.com/#view/Microsoft_Azure_Support/HelpAndSupportBlade/~/overview) to discuss additional options.

### Maintenance window

Use the **Maintenance window** setting to control the day and time when system updates can occur. Tasks that are active during this maintenance might fail or be delayed.

System updates are typically applied to the service once every two months. The service might be temporarily unavailable during the maintenance window when system updates are being applied. System updates include, but aren't limited to, security updates, Lustre code fixes, and service enhancements.

During the maintenance window, user workloads accessing the file system will temporarily pause if a system update is being applied. User workloads resume when the system updates are complete. If you have multiple cluster deployments, consider spacing out their maintenance windows for availability when updates are necessary.

## Advanced tab

Use the **Advanced** tab to optionally enable and configure Blob Storage integration.

### Blob integration

If you want to integrate data from Azure Blob Storage with your Azure Managed Lustre file system, you can specify the details in the **Blob integration** section when you create the file system. This integration allows you to import and export data between the file system and a blob container.

Configuring blob integration during cluster creation is optional, but it's the only way to use [Lustre Hierarchical Storage Management (HSM)](https://doc.lustre.org/lustre_manual.xhtml#lustrehsm) features. If you don't want the benefits of Lustre HSM, you can import and export data for the Azure Managed Lustre file system by using client commands directly.

To configure blob integration, follow these steps:

1. Create or configure a storage account and blob containers for integration with the file system. The storage account doesn't need to be in the same subscription as the Azure Managed Lustre file system.
1. Select the **Import/export data from blob** check box.
1. Specify the **Subscription**, **Storage account**, and **Container** to use with your Lustre file system.
1. In the **Logging container** field, select the container where you want to store import/export logs. The logs must be stored in a separate container from the data container, but the containers must be in the same storage account.
1. In the **Import prefix** fields, you can optionally supply one or more prefixes to filter the data imported into the Azure Managed Lustre file system. The default import prefix is `/`, and the default behavior imports the contents of the entire blob container. To learn more about import prefixes, see [Import prefix](/azure/azure-managed-lustre/blob-integration#import-prefix).

:::image type="content" source="../media/advanced-blob-integration.png" alt-text="A screenshot showing all blob integration settings on the Advanced tab in the Azure Managed Lustre create flow." lightbox="../media/advanced-blob-integration.png":::

When you finish entering details on the **Advanced settings** tab, you can optionally select **Next: Disk encryption keys** to enter details about managing your own encryption keys. If you don't want to manage your own encryption keys, select **Review + create**.

> [!NOTE]
> You cannot change between Microsoft-managed keys and customer-managed keys after your create the file system.

## Disk encryption keys tab

You can optionally manage the encryption keys used for your Azure Managed Lustre file system storage by supplying your Azure Key Vault information on the **Disk encryption keys** tab. The key vault must be in the same region and in the same subscription as the cache. You can't change between Microsoft-managed keys and customer-managed keys after creating the file system.

In this module, we skip the **Disk encryption keys** tab and use Microsoft-managed keys for encryption. To learn about customer-managed keys, see [Use customer-managed encryption keys with Azure Managed Lustre](/azure/azure-managed-lustre/customer-managed-encryption-keys).

## Review + create tab

When you navigate to the **Review + create** tab, Azure runs validation on the Azure Managed Lustre file system settings. If validation passes, you can proceed to create the file system.

If validation fails, then the portal indicates which settings need to be modified.

The following image shows the **Review + create** tab before the creation of a new file system:

:::image type="content" source="../media/review-create-tab.png" alt-text="A screenshot showing the review and create tab in Azure Managed Lustre create flow." lightbox="../media/review-create-tab.png":::

Select **Create** to begin deployment of the Azure Managed Lustre file system.
