Azure file shares are deployed into *storage accounts*, which are top-level objects that represent a shared pool of storage. This pool of storage can be used to deploy multiple file shares.

Azure supports multiple types of storage accounts for different storage scenarios customers might have, but there are two main types of storage accounts for Azure Files. Which storage account type you need to create depends on whether you want to create a standard file share or a premium file share:

 -  **General purpose version 2 (GPv2) storage accounts**: Standard GPv2 storage accounts allow you to deploy Azure file shares on standard/hard disk-based (HDD-based) hardware. In addition to storing Azure file shares, GPv2 storage accounts can store other storage resources such as blobs, queues, or tables. File shares can be deployed into the transaction optimized (default), hot, or cool tiers.
 -  **FileStorage storage accounts**: FileStorage storage accounts allow you to deploy Azure file shares on premium/solid-state disk-based (SSD-based) hardware. FileStorage accounts can only be used to store Azure file shares; no other storage resources (blobs, queues, tables, etc.) can be deployed in a FileStorage account.

To create a storage account via the Azure portal, select **+ Create a resource** from the dashboard. In the resulting Azure Marketplace search window, search for **storage account** and select the resulting search result. This will lead to an overview page for storage accounts; select **Create** to proceed with the storage account creation wizard.

:::image type="content" source="../media/create-storage-account-0-d21cefc5.png" alt-text="A screenshot of the storage account quick create option in a browser.":::


### Basics

The first section to complete to create a storage account is labeled **Basics**. This contains all of the required fields to create a storage account. To create a GPv2 storage account, ensure the **Performance** radio button is set to *Standard* and the **Account kind** drop-down list is selected to *StorageV2 (general purpose v2)*.

:::image type="content" source="../media/files-create-smb-share-performance-standard-3b3842f8.png" alt-text="A screenshot of the performance radio button with standard selected and account kind with storagev2 selected.":::


To create a FileStorage storage account, ensure the **Performance** radio button is set to *Premium* and **Fileshares** is selected in the **Premium account type** drop-down list.

:::image type="content" source="../media/files-create-smb-share-performance-premium-fedc04c1.png" alt-text="A screenshot of the performance radio button with premium selected and account kind with FileStorage selected.":::


The other basics fields are independent from the choice of storage account:<br>

 -  **Storage account name**: The name of the storage account resource to be created. This name must be globally unique. The storage account name will be used as the server name when you mount an Azure file share via SMB. Storage account names must be between 3 and 24 characters in length. They may contain numbers and lowercase letters only.
 -  **Location**: The region for the storage account to be deployed into. This can be the region associated with the resource group, or any other available region.
 -  **Replication**: Although this is labeled replication, this field actually means **redundancy**; this is the desired redundancy level: locally redundancy (LRS), zone redundancy (ZRS), geo-redundancy (GRS), and geo-zone-redundancy (GZRS). This drop-down list also contains read-access geo-redundancy (RA-GRS) and read-access geo-zone redundancy (RA-GZRS), which don't apply to Azure file shares; any file share created in a storage account with these selected will be either geo-redundant or geo-zone-redundant, respectively.

### Networking

The networking section allows you to configure networking options. These settings are optional for the creation of the storage account and can be configured later if desired. For more information on these options, see [Azure Files networking considerations](/azure/storage/files/storage-files-networking-overview).

### Data protection

The data protection section allows you to configure the soft-delete policy for Azure file shares in your storage account. Other settings related to soft-delete for blobs, containers, point-in-time restore for containers, versioning, and change feed apply only to Azure Blob storage.
