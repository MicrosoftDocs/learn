There are two primary types of storage accounts for Azure Files. Which storage account type you need to create depends on whether you want to create a standard file share or a premium file share:

 -  **General purpose version 2 (GPv2) storage accounts**: GPv2 storage accounts allow you to deploy Azure file shares on standard/hard disk-based (HDD-based) hardware. GPv2 storage accounts can store other storage resources such as blob containers, queues, or tables. File shares can be deployed into the transaction optimized (default), hot, or cool tiers.
 -  **FileStorage storage accounts**: FileStorage storage accounts allow you to deploy Azure file shares on premium/solid-state disk-based (SSD-based) hardware. FileStorage accounts store Azure file shares. Storage resources, such as blob containers or queues, cannot be deployed in a FileStorage account.

To create a storage account from the Azure portal, select **+ Create a resource** from the dashboard. From the Azure Marketplace search window, search for **storage account** and select the search result. Select **Create** to create the storage account.

:::image type="content" source="../media/configure-storage-accounts-virtual-desktop-1-89239595.png" alt-text="Create a storage account using the Azure portal":::


### The Basics section

The **Basics** section contains the required fields to create a storage account. To create a GPv2 storage account, ensure the **Performance** radio button is set to **Standard** and the **Account kind** selected is ***StorageV2 (general purpose v2)***.

:::image type="content" source="../media/configure-storage-accounts-virtual-desktop-2-15a1b4e6.png" alt-text="Basic section,":::


To create a FileStorage storage account, ensure the **Performance** button is set to **Premium** and the **Account kind** is set to **FileStorage**.

:::image type="content" source="../media/configure-storage-accounts-virtual-desktop-3-5c4ffaf9.png" alt-text="Account type":::


The other basics fields are independent from the choice of storage account:

 -  **Subscription**: The subscription for the storage account to be deployed into.
 -  **Resource group**: The resource group for the storage account to be deployed into. You may either create a new resource group or use an existing resource group. A resource group is a logical container for grouping your Azure services. You can create a new resource group, or use an existing resource group.
 -  **Storage account name**: The name of the storage account resource to be created. This name must be globally unique. The storage account name will be used as the server name when you mount an Azure file share via SMB.
 -  **Location**: The region for the storage account to be deployed into. The is region associated with the resource group, or any other available region.
 -  **Replication**: the options are locally redundancy (LRS), zone redundancy (ZRS), geo-redundancy (GRS), and geo-zone-redundancy. This list contains read-access geo-redundancy (RA-GRS) and read-access geo-zone redundancy (RA-GZRS), which do not apply to Azure file shares. Any file share created in a storage account with these items selected will be either geo-redundant or geo-zone-redundant, respectively. Depending on your region or selected storage account type, some redundancy options may not be allowed.
 -  **Blob access tier**: This field does not apply to Azure Files, so you can choose either one of the radio buttons.
