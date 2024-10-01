As part of Azure File Sync, Microsoft provides a set of evaluation PowerShell cmdlets. The cmdlets show you whether the server has any incompatibilities with Azure File Sync.

After you learn about Azure File Sync, you want to assess your servers to check whether they can take part in the sync process. You can use the tools offered by Microsoft to help you do this task.

In this unit, learn the system requirements for servers that you want to use with Azure File Sync. You see how to run system checks by using PowerShell.

## Possible problems

Before you consider using Azure File Sync with your on-premises servers, be aware of the following possible problems:

- **Antivirus**: Antivirus programs work by scanning files known for malicious code. This feature might cause an undesired recall of tiered files. Most recent antivirus products, including Microsoft products like Windows Defender and System Center Endpoint Protection, recognize and support dealing with these files. If you're using a third-party program, check compatibility with the software vendor.
- **Backup**: Like antivirus solutions, backup solutions can cause tiered files to be recalled. We highly recommend that you use Azure Backup because it backs up the data in the Azure file share itself. If you're restoring files from Azure Backup, it's important to use volume-level or file-level restore operations when you're using Azure File Sync. Files restored by these methods automatically sync to all endpoints in the sync group. Existing files are replaced with the newly restored versions.
- **Encryption**: Azure File Sync works with common encryption methods from Microsoft, including BitLocker, Azure Information Protection, Azure Rights Management, and Active Directory RMS. Azure File Sync doesn't work with the NTFS file system encryption method, Encrypted File System (EFS).

## Evaluate the OS and files for compatibility

You can use the Azure File Sync evaluation tool to evaluate the system's OS and files to ensure compatibility with the service. This tool is an Azure PowerShell cmdlet that checks for potential problems with the file system and data sets, like unsupported characters or OS version.

## System requirements

Azure File Sync has these system requirements for your local file server:

- **Operating system**: Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, or Windows Server 2022, in either Datacenter or Standard edition in full or core deployments.
- **Memory**: 2 GB of RAM or more.
- **Patches**: Latest Windows patches applied.
- **Storage**: Locally attached volume formatted in the NTFS file format. Remote storage connected by USB isn't supported.

The NTFS file system supports many features, and Azure File Sync supports a subset of them.

The supported features are:

- **Access control lists (ACLs)**: ACLs are preserved and enforced on Windows Server endpoints.
- **NTFS compression**: Compressing files to save space is fully supported.
- **Sparse files**: Sparse files are stored in a more efficient way than normal files. Sparse files are supported, but are stored as normal full files during the sync to the cloud.

There are many different file types on a Windows Server computer. Some files are important to the operating system but have no place in a sync operation. If they were synced, these files would take up unnecessary space. So the following files are ignored:

- *Desktop.ini*: OS-specific file
- *ethumbs.db$*: Temporary file for thumbnails
- *-$.*: Temporary Office file
- *.tmp*: Temporary file
- *.laccdb*: Access DB locking file
- *6878HDHJKDHHJ7878*: Internal sync file
- *\System Volume Information*:  Volume-specific folder
- *$RECYCLE.BIN*: Folder for deleted items
- *\SyncShareState*: Folder for sync

## Complete an evaluation

You can use PowerShell to download the latest versions of `PackageManagement` and `PowerShellGet`. These packages allow the installation of preview modules. You can then install the `Az.StorageSync` PowerShell module that allows the data set and system requirements to be tested and saved in a comma-separated file.

To do an evaluation, run `Invoke-AzStorageSyncCompatibilityCheck` with the correct parameters. For example, on your on-premises file server, you can run the following types of checks:

- Check the system and data files:

  ```powershell
  Invoke-AzStorageSyncCompatibilityCheck -Path <path to folder>
  ```  
  
- Check only the files and folders for compatibility:

  ```powershell
  Invoke-AzStorageSyncCompatibilityCheck -Path <path to folder> -SkipSystemChecks
  ```
  
- Check only the system:

  ```powershell
  Invoke-AzStorageSyncCompatibilityCheck -ComputerName <name of computer to check> -SkipNamespaceChecks
  ```

The results tell you if the OS, file system, file names, or folder names have compatibility problems.
