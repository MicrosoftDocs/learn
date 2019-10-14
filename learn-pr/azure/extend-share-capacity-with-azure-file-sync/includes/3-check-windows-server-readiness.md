As part of Azure File Sync, Microsoft provides a set of evaluation powershell cmdlets. The cmdlets will show you if the server has any incompatibilities with Azure File Sync.

After learning about Azure File Sync, you're going to assess servers to check they can take part in the sync process. You'll investigate the tools offered by Microsoft to help you do this task.

In this unit, you'll see what the system requirements are for servers that you wish to install Azure File Sync on. You'll see how to run system checks using powershell.

## Possible problems

Before considering using Azure File Sync with you on-premises machines, you need to be aware of the possible issues:

- *Anti-virus*: Anti-virus programs work by scanning files known for malicious code. This feature might cause an undesired recall of tiered files. Most recent anti-virus products, including Microsoft products like Windows Defender and System Center Endpoint Protection (SCEP), recognize and support dealing with these files. However, if you're using a third-party program, check compatibility with the software vendor.
- *Backup*: Just like anti-virus solutions, backup solutions can cause the recall and processing of tiered files. We highly recommended you use Azure Backup as it backups the data on the Azure file share itself. If you're restoring files from Azure Backup, it's important to use volume or file level restore operations when using Azure File Sync. The files restored using this method will automatically be synced to all endpoints in the sync group. Existing files will be replaced with the newly restored version.
- *Encryption*:  Azure File Sync works with common encryption methods from Microsoft including, BitLocker, Azure Information Protection (AIP), Azure Rights Management Services (ARMS), and Active Directory RMS. Azure File Sync doesn't work with the NTFS file system encryption method, Encrypted File System (EFS).

## Evaluate OS and files for compatibility

Use the Azure File Sync evaluation tool to evaluate the systems OS and files to ensure compatibility with the service. This tool is an Azure PowerShell cmdlet that checks for potential issues with the file system and data sets, like unsupported characters or OS version.

## System requirements

Azure File Sync has these system requirements for your local file server:

- *Operating System*: Windows Server 2012 R2, Windows Server 2016, or Windows Server 2019, in either Datacenter or Standard editions in full or core deployments
- *Memory*: 2 GiB RAM or more
- *Patches*: Latest Windows patches applied
- *Storage*: Locally attached volume formatted in the NTFS file format. It can't be remote storage connected by USB

**Supported file system features**

The NTFS file system supports many features, and Azure File Sync supports a subset of them.

The supported features are:

- *Access Control Lists (ACLs)*: ACLs are preserved and enforced on Windows Server endpoints.
- *NTFS Compression*: Compressing files to save space is fully supported.
- *Sparse files*: Sparse files are stored in a more efficient way than normal files. Sparse files are supported but, during the sync to the cloud, they're stored as a normal full file.

There are many different file types on a Windows Server. Some files are important to the OS but have no place in a sync operation. If they were synced, these files would take up unnecessary space. So the following files are ignored:

- *Desktop.ini*:  OS specific
- *ethumbs.db$*:  temporary file for thumbnails
- *-$.*:  Office temporary file
- *.tmp*:  temporary file
- *.laccdb*:  access DB locking file
- *6878HDHJKDHHJ7878.*:  Internal Sync file
- *\System Volume Information*:  Volume-Specific folder
- *$RECYCLE.BIN*:  folder for deleted items
- *\SyncShareState*:  folder for Sync

## Complete an evaluation

Using PowerShell,  download the latest version of `PackageManagement` and `PowerShellGet`. These packages allow the installation of preview modules. You can then install the `Az.StorageSync` powershell module that allows the data set and system requirements to be tested and saved in a comma-separated file.

Once installed, running `Invoke-AzStorageSyncCompatibilityCheck` with the correct parameters will do the evaluation.

- Check the system and data files:
  
  `Invoke-AzStorageSyncCompatibilityCheck -Path <path to folder to be checked>`
- Check only the files and folders for compatibility: 

  `Invoke-AzStorageSyncCompatibilityCheck -Path <path to folder to be checked> -SkipSystemChecks`
- Check only the system: 

  `Invoke-AzStorageSyncCompatibilityCheck -ComputerName <name of computer to check> -SkipNamespaceChecks`

The results tell you if the OS, filesystem, file names, or folder names have compatibility issues.