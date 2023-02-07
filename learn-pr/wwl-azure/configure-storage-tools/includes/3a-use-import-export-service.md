The Azure Import/Export service is used to securely import large amounts of data to Azure Blob Storage and Azure Files by shipping disk drives to an Azure datacenter. This service can also be used to transfer data from Azure Blob Storage to disk drives and ship to your on-premises sites. 

### Things to know about the Azure Import/Export service

Examine the following characteristics of the Azure Import/Export service.

- Data from your disk drives can be imported to Azure Blob Storage or Azure Files in your Azure storage account.

- Data from Azure Storage in your Azure storage account can be exported to drives that you provide.

- Create an Azure Import job to import data from physical disks into Azure Blob Storage or Azure Files.

- Create an Azure Export job to export data from Azure Storage to hard disk drives.

- You can create jobs directly from the Azure portal or programmatically by using the Azure Storage Import/Export REST API.

### Things to consider when using the Azure Import/Export service

The Azure Import/Export service is frequently used in cases where uploading or downloading data over the network is too slow or getting more network bandwidth is cost-prohibitive. Let's review some scenarios where using the Azure Import/Export service can help improve performance.

- **Consider cloud migrations**. Move large amounts of data to Azure quickly and cost effectively with the Azure Import/Export service.

- **Consider content distribution**. Send data quickly to customer sites in diverse geographic locations.

- **Consider backup operations**. Use the Azure Import/Export service to take backups of your on-premises data to store in Azure Blob Storage.

- **Consider data recovery**. Recover large amounts of data stored in Blob Storage, and have the delivered to your on-premises location with the Azure Import/Export service.

## Azure Import jobs

Azure Import jobs securely transfer large amounts of data to Azure Blob Storage (block blobs or page blobs) or Azure Files. You ship disk drives to an Azure datacenter, the staff copy specified data to the Azure storage and then return the drives to you. Consider how Azure Import jobs can be a part of your data transfer strategy.

:::image type="content" source="../media/import-jobs-3dd387ae.png" alt-text="Flowchart of an Azure Import job. You prepare disks, create the job, and ship the disks. The datacenter receives the disks, transfers the data, packages the disks, and ships the disks back." border="false":::

### Create an Azure Import job

Follow these steps to create an Azure Import job.

1. If you don't have an Azure storage account, [create an account](/azure/storage/common/storage-account-create) to use for the Import job.

1. Determine the number of disks needed to accommodate the data to transfer.

1. Identify the computer to use to perform the data copy, and attach the physical disks you intend to ship to Microsoft.

1. Install the WAImportExport tool on the disks. We'll take a closer look at the WAImportExport tool in the next unit.

1. Run the WAImportExport tool to copy the data on the disks.
   - Encrypt the disk drives with BitLocker.
   - Generate journal files to document the data transfer.

1. In the Azure portal, create an Azure Import job and provide the following information:
   - The Azure Storage account to use for the Import job
   - The return address for shipment of your disks
   - Your shipment carrier account number
   - The datacenter address of the Azure region that hosts the Azure storage account

1. Ship the required number of disks to the Azure region datacenter that hosts the storage account. Note the shipment tracking number.

1. Update the Import job to include the shipment tracking number.

1. After the disks arrive at the Azure datacenter, the staff completes the following tasks:
   1. The data on the provided disks is copied to the specified storage account.
   1. The disks are shipped back to you.

## Azure Export jobs

Azure Export jobs transfer data from Azure Storage to hard disk drives and ship the disks to your on-premises sites. Think about how Azure Export jobs can support your data transfer scenarios.

:::image type="content" source="../media/export-jobs-850746e1.png" alt-text="Flowchart of an Azure Export job. You create a job and ship the disks. The datacenter receives the disks, transfers the data, packages the disks, and ships them back." border="false":::

### Create an Azure Export job

Follow these steps to create an Azure Export job.

1. Identify the data in Azure Blob Storage to export.

1. Determine the number of disks needed to accommodate the data to transfer.

1. In the Azure portal, create an Azure Export job and provide the following information:
   - The Azure Storage account to use for the Export job
   - The blob data to export
   - The return address for shipment of your disks
   - Your shipment carrier account number

1. Ship the required number of disks to the Azure region datacenter that hosts the storage account. Note the shipment tracking number.

1. Update the Export job to include the shipment tracking number.

1. After the disks arrive at the Azure datacenter, the staff completes the following tasks:
   1. The specified data in the storage account is copied to the disks you provided.
   1. The disk volumes are encrypted by using BitLocker.
   1. The disks are shipped back to you.
   
   The BitLocker keys used to encrypt your disks are stored with the specified storage account in the Azure portal. You can decrypt the content of the disks and copy the data to your on-premises storage.