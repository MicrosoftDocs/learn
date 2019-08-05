Azure Import/Export enables organizations to export data from Azure storage to an on-premises location. The service provides a secure, reliable, and cost effective way to export large amounts of data.

You can also use Azure Import/Export to import data to Azure storage from an on-premises location. But, we recommend that you use an Azure Data Box device when you're in a region where the Azure Data Box family is supported. Importing data by using the Azure Data Box family service is easier than using Azure Import/Export.

When you're moving large amounts of data between locations, speed and reliability are fundamental requirements. Even the fastest networks have a bandwidth limitation. If you need to transfer tens of terabytes of data between remote sites, the operation could take several days. Additionally, if the transfer fails at some point, you don't want to have to start the whole process from scratch. The Azure Import/Export service is intended to address these issues.

In the film production company scenario, you need a reliable and secure way to transfer 200 TB of film footage from Azure storage to your local facility as quickly as possible. You decide to investigate using the Azure Import/Export service as a means of performing this task.

In this unit, you'll learn more about the Azure Import/Export service, and understand the scenarios where it's best suited.

## The Azure Import/Export service

Azure Import/Export is an Azure service that's used to migrate large quantities of data between an on-premises location and an Azure storage account. Using the service, you send and receive physical disks holding your data between your on-premises location and an Azure datacenter. You ship data using your own disk drives. These disk drives can be SATA HDDs or SSDs

The Azure Import/Export service is ideally suited to situations when you must upload or download large amounts of data, but your network backbone doesn't have sufficient capacity or reliability to support large-scale transfers. You might typically use this service to:

- Migrate large amounts of data from on-premises to Azure, as a one-off task.
- Back up your data on-premises in Azure storage.
- Recover large amounts of data that you previously stored in Azure storage.
- Distribute data from Azure storage to customer sites.

## The WAImportExport tool

If you're importing data into Azure storage, your data must be written to disk using a specific format. Use the WAImportExport drive preparation tool to do this. This tool checks a drive and prepares a journal file that's then used by an import job when data is being imported into Azure.

The WAImportExport tool performs the following tasks:

- It prepares disk drives to be shipped to the Azure datacenter. WAImportExport formats the drive checks it for errors before data is copied to disks.
- It can encrypt the data held on the drive.
- It quickly scans the data and identifies how many physical drives are required to hold the data being transferred.
- It creates the journal files that are used for import and export operations.
The journal file contains information about the drive serial number, encryption key, and storage account. Each drive you prepare with the Azure Import/Export tool has a single journal file.

There are two versions of this tool:

- Version 1 supports import or export of data to or from Azure Blob storage.
- Version 2 supports import of data into Azure files.

Download the appropriate version of WAImportExport from the Microsoft Download Center. The WAImportExport tool is only compatible with 64-bit Windows operating system.

## Security considerations

For export jobs, the Import/Export Service encrypts the drive using BitLocker before it's shipped back to you. Microsoft provides you with the encryption key. You then use the encryption key to access the data and transfer it to your on-premises location.

For import jobs, all data must be encrypted using BitLocker before you send the disks to Microsoft. This encryption helps to protect your data. No one can read the data on the disk drives without knowing the encryption key. You can encrypt disks using the WAImportExport tool. Or, you can manually enable BitLocker on the drive, and provide the WAImportExport tool with the encryption key.

By default, BitLocker uses 128-bit encryption to protect data on disk drives.  If you're transferring critical data on the disk drives, such as credit card details, customer account information, or online account details, you can enable 256-bit encryption. To use 256-bit mode encryption, you change the encryption mode with BitLocker before the data is copied.
