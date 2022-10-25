WAImportExport is the Azure Import/Export service tool. The tool is used to prepare drives before importing data, and to repair any corrupted or missing files after data transfer.

> [!Note]
> The WAImportExport tool is available in two versions:
> 
> - Version 1 is best for importing and exporting data in Azure Blob Storage.
> - Version 2 is best for importing data into Azure Files.
>
> The WAImportExport tool is only compatible with 64-bit Windows operating system.
> For the list of supported operating systems and versions, see [Azure Import/Export requirements](/azure/import-export/storage-import-export-requirements#supported-operating-systems).

### Things to know about the WAImportExport tool

You can use the WAImportExport tool with the Azure Import/Export service to complete the following tasks:

- Before you create an Azure Import job, use the WAImportExport tool to copy data to the hard disk drives you intend to ship to Microsoft.

- After your Azure Import job completes, use the WAImportExport tool to repair any blobs that were corrupted, missing, or that have conflicts with other blobs in your Azure Storage.

- After you receive your disk drives from a completed Azure Export job, use the WAImportExport tool to repair any corrupted or missing files on the drives.

- The WAImportExport tool handles data copy, volume encryption, and creation of journal files. Journal files are necessary to create an Azure Import/Export job and help ensure the integrity of the data transfer.

### Things to consider when using the WAImportExport tool

There are several points to consider as you plan for using the WAImportExport tool with the Azure Import/Export service.

- **Consider supported disk drives**. For hard disk drives, the Azure Import/Export service requires internal SATA II/III HDDs or SSDs. Keep this requirement in mind when selecting your hard disk drives.

- **Consider BitLocker encryption**. When you prepare a disk for an Azure Import job, you must encrypt the NTFS volume of each disk drive with BitLocker.

- **Consider OS version**. To prepare a disk drive, you must connect the drive to a computer that's running a 64-bit version of the Windows client or server operating system. You run the WAImportExport tool from that computer.