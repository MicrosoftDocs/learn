The financial company you're working with has moved an application to Azure that generates reports and data exports for users and other systems to consume. They wanted to consolidate the files they produce into a native cloud service. With Azure file shares, the company can continue to use the SMB protocol to access these files securely.

You used Azure storage accounts, and the fully managed cloud shares it provides, to re-create the on-premises file shares used by the finance company. You then added extra levels of security to these shares to restrict access and create snapshots.

If you couldn't use Azure file shares, you might have to manually create a virtual machine in the cloud to act as a file server. You would then be responsible for managing the operating system updates and disk space. This solution wouldn't benefit from the global redundancy that a GRS storage account has built in. The server would become a single point of failure. In this scenario, costs would be higher than using the unified Azure file shares.

Azure file shares are simpler to use because organizations can continue to use their existing tools. The speed of adoption is fast because Azure provides PowerShell commands that can be deployed to add Azure file shares to Windows machines. Azure file shares are a simple, secure, and resilient way to manage shared files in the cloud.

## Learn more

To learn more about Azure Files, see the following articles:

- [Planning for an Azure Files deployment](https://docs.microsoft.com/azure/storage/files/storage-files-planning)
- [Quickstart: Create and manage an Azure Files share with Windows virtual machines](https://docs.microsoft.com/azure/storage/files/storage-files-quick-create-use-windows#create-a-share-snapshot)
- [Transfer data with AzCopy and file storage](https://docs.microsoft.com/azure/storage/common/storage-use-azcopy-files)
- [Use an Azure file share with Windows](https://docs.microsoft.com/azure/storage/files/storage-how-to-use-files-windows)
- [Use Azure Files with Linux](https://docs.microsoft.com/azure/storage/files/storage-how-to-use-files-linux)
- [Mount an Azure Files share over SMB with macOS](https://docs.microsoft.com/azure/storage/files/storage-how-to-use-files-mac)
- [Deploy Azure File Sync](https://docs.microsoft.com/azure/storage/files/storage-sync-files-deployment-guide)
