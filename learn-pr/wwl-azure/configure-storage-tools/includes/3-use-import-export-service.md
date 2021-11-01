Azure Import/Export service is used to securely import large amounts of data to Azure Blob storage and Azure Files by shipping disk drives to an Azure datacenter. This service can also be used to transfer data from Azure Blob storage to disk drives and ship to your on-premises sites. Data from one or more disk drives can be imported either to Azure Blob storage or Azure Files. With the Azure Import/Export service, you supply your own disk drives and transfer data yourself.

## Usage cases

Consider using Azure Import/Export service when uploading or downloading data over the network is too slow or getting more network bandwidth is cost-prohibitive. Scenarios where this would be useful include:

 -  **Migrating data to the cloud**. Move large amounts of data to Azure quickly and cost effectively.
 -  **Content distribution**. Quickly send data to your customer sites.
 -  **Backup**. Take backups of your on-premises data to store in Azure blob storage.
 -  **Data recovery**. Recover large amount of data stored in blob storage and have it delivered to your on-premises location.

## Import jobs

An Import job securely transfers large amounts of data to Azure Blob storage (block and page blobs) and Azure Files by shipping disk drives to an Azure datacenter. In this case, you will be shipping hard drives containing your data.

:::image type="content" source="../media/import-jobs-3dd387ae.png" alt-text="Flowchart of an import data job. From the left prepare disks, create job, ship job to datacenter, datacenter receives disks, transfers data, packages disks, ships disks back to the customer, you receive the disks and view data in Azure.":::


In order to perform an import, follow these steps:

1.  Create an Azure Storage account.
2.  Identify the number of disks that you will need to accommodate all the data that you want to transfer.
3.  Identify a computer that you will use to perform the data copy, attach physical disks that you will ship to the target Azure datacenter, and install the WAImportExport tool.
4.  Run the WAImportExport tool to copy the data, encrypt the drive with BitLocker, and generate journal files.
5.  Use the Azure portal to create an import job referencing the Azure Storage account. As part of the job definition, specify the destination address representing the Azure region where the Azure Storage account resides.
6.  Ship the disks to the destination that you specified when creating the import job and update the job by providing the shipment tracking number.
7.  Once the disks arrive at the destination, the Azure datacenter staff will carry out data copy to the target Azure Storage account and ship the disks back to you.

## Export jobs

Export jobs transfer data from Azure storage to hard disk drives and ship to your on-premise sites.

:::image type="content" source="../media/export-jobs-850746e1.png" alt-text="Flowchart of an export job. From the left create job, ship disks, the datacenter receives the disks, transfers the data, packages the disks, ships the disks back to you, and you receive and unlock the disks.":::


In order to perform an export, follow these steps:

1.  Identify the data in the Azure Storage blobs that you intend to export.
2.  Identify the number of disks that you will need to accommodate all the data you want to transfer.
3.  Use the Azure portal to create an export job referencing the Azure Storage account. As part of the job definition, specify the blobs you want to export, the return address, and your carrier account number. Microsoft will ship your disks back to you after the export process is complete.
4.  Ship the required number of disks to the Azure region hosting the storage account. Update the job by providing the shipment tracking number.
5.  Once the disks arrive at the destination, Azure datacenter staff will carry out data copy from the storage account to the disks that you provided, encrypt the volumes on the disks by using BitLocker, and ship them back to you. The BitLocker keys will be available in the Azure portal, allowing you to decrypt the content of the disks and copy them to your on-premises storage.

## Import/Export Tool (WAImportExport)

The **Azure Import/Export Tool** is the drive preparation and repair tool that you can use with the Microsoft Azure Import/Export service. You can use the tool for the following functions:

 -  Before creating an import job, you can use this tool to copy data to the hard drives you are going to ship to an Azure datacenter.
 -  After an import job has completed, you can use this tool to repair any blobs that were corrupted, were missing, or conflicted with other blobs.
 -  After you receive the drives from a completed export job, you can use this tool to repair any files that were corrupted or missing on the drives.

Import/Export service requires the use of internal SATA II/III HDDs or SSDs. Each disk contains a single NTFS volume that you encrypt with BitLocker when preparing the drive. To prepare a drive, you must connect it to a computer running a 64-bit version of the Windows client or server operating system and run the WAImportExport tool from that computer. The WAImportExport tool handles data copy, volume encryption, and creation of journal files. Journal files are necessary to create an import/export job and help ensure the integrity of the data transfer.

> [!NOTE]
> You can create jobs directly from the Azure portal or you can accomplish this programmatically by using Azure Storage Import/Export REST API.
