The financial company you're working with has moved an application to Azure that generates reports and data exports for users and other systems to consume. They wanted to consolidate the files it produces into a native cloud service. By using Azure file shares, the company can continue to use the SMB protocol to access these files securely.

Azure storage accounts, and the fully managed cloud shares it provides enabled you to recreate the on-premises file shares the finance company was using. You then added extra levels of security to these shares to restrict access and create snapshots. With the secure file shares in place, you quickly transferred 1,000 files using AzCopy.

If you couldn't use Azure file shares, you might have to manually create a Virtual Machine in the cloud to act as a file server. You would then be responsible for managing the operating system updates and disk space. This solution wouldn't benefit from the global redundancy that a GRS storage account has built-in, and the server would become a single point of failure. All of this would result in higher costs than using the unified Azure file shares.

Azure file shares are simpler to use because organizations can continue to use their existing tools. The speed of adoption is fast because Azure provides PowerShell commands that can be deployed to add the Azure files shares to Windows machines. Azure file shares are a simple, secure, and resilient way to manage shared files in the cloud.

## Further reading

- [Planning for an Azure Files deployment](https://docs.microsoft.com/en-gb/azure/storage/files/storage-files-planning)
- [Quickstart: Create and manage Azure Files share with Windows virtual machines](https://docs.microsoft.com/en-gb/azure/storage/files/storage-files-quick-create-use-windows#create-a-share-snapshot)
- [Transfer data with AzCopy and file storage](https://docs.microsoft.com/azure/storage/common/storage-use-azcopy-files)
- [Use an Azure file share with Windows](https://docs.microsoft.com/en-gb/azure/storage/files/storage-how-to-use-files-windows)
- [Use Azure Files with Linux](https://docs.microsoft.com/en-gb/azure/storage/files/storage-how-to-use-files-linux)
- [Mount Azure file share over SMB with macOS](https://docs.microsoft.com/en-gb/azure/storage/files/storage-how-to-use-files-mac)