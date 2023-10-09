Azure Import/Export provides a way for organizations to export data from Azure Storage to an on-premises location. The service offers a secure, reliable, and cost-effective method to export large amounts of data.

You can also use Azure Import/Export to import data to Azure Storage from an on-premises location. However, we recommend that you use an Azure Data Box device when you're in a region where the Azure Data Box family is supported. Importing data by using one of the products in the Azure Data Box family is easier than using Azure Import/Export.

When you're moving large amounts of data between locations, speed and reliability are fundamental requirements. Even the fastest networks have bandwidth limitations. If you need to transfer tens of terabytes (TB) of data between remote sites, the operation could take several days. Additionally, if the transfer fails at some point, you don't want to have to start the whole process again from the beginning. The Azure Import/Export service is designed to address these issues.

In the film-production company scenario, you need a reliable and secure way to transfer 200 TB of film footage from Azure Storage to your local facility as quickly as possible. You decide to investigate using the Azure Import/Export service as a means of accomplishing this task.

In this unit, you learn more about the Azure Import/Export service and the scenarios that it's best suited for.

## The Azure Import/Export service

Azure Import/Export is an Azure service that's used to migrate large quantities of data between an on-premises location and an Azure Storage account. By using the service, you send and receive physical disks that contain your data between your on-premises location and an Azure datacenter. You ship data that's stored on your own disk drives. These disk drives can be Serial ATA (SATA) hard-disk drives (HDDs) or solid-state drives (SSDs).

The Azure Import/Export service is ideally suited to situations where you must upload or download large amounts of data. But, your network backbone doesn't have sufficient capacity or reliability to support large-scale transfers. You'd typically use this service to:

- Migrate large amounts of data from on-premises to Azure as a one-time task.
- Back up your data on-premises in Azure Storage.
- Recover large amounts of data that you previously stored in Azure Storage.
- Distribute data from Azure Storage to customer sites.

## The WAImportExport tool

If you're importing data into Azure Storage, your data must be written to disk in a specific format. You can use the WAImportExport drive preparation tool to do this task. This tool checks a drive and prepares a journal file that's then used by an import job when data is being imported into Azure.

The WAImportExport tool performs the following tasks:

- Prepares disk drives to be shipped to the Azure datacenter. WAImportExport formats the drive and checks it for errors before data is copied to the disks.
- Encrypts the data on the drive.
- Quickly scans the data and determines how many physical drives are required to hold the data being transferred.
- Creates the journal files that are used for import and export operations. A journal file contains information about the drive serial number, encryption key, and storage account. Each drive you prepare with the Azure Import/Export tool has a single journal file.

There are two versions of this tool:

- Version 1 supports import or export of data to or from Azure Blob storage.
- Version 2 supports import of data into Azure Files.

Download the appropriate version of WAImportExport from the Microsoft Download Center. The WAImportExport tool is compatible only with 64-bit Windows operating systems.

## Security considerations

For export jobs, the Import/Export Service uses BitLocker to encrypt the drive before it's shipped back to you. Microsoft provides you with the encryption key. You then use the encryption key to access the data and transfer it to your on-premises location.

For import jobs, all data must be encrypted through BitLocker before you send the disks to Microsoft. This encryption helps protect your data. No one can read the data on the disk drives without providing the encryption key. You can encrypt disks by using the WAImportExport tool, or you can manually enable BitLocker on the drive and provide the encryption key to the WAImportExport tool.

By default, BitLocker uses 128-bit encryption to protect data on disk drives. If you're transferring critical data such as credit card details, customer account information, or online account details, you can enable 256-bit encryption. To use 256-bit encryption, you can change the encryption mode in BitLocker before the data is copied.
