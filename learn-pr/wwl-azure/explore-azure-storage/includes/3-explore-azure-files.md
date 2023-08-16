The Azure File storage service allows you to create SMB file shares in Azure just as you would with an on-premises file server. Within each file share, you can create multiple levels of folders to categorize content. Each directory can contain multiple files and folders. Files can be up to 1 TB in size. The maximum size of a file share is 5 TB.

The Azure File storage service is available via both SMB 2.1 and SMB 3.x protocols. Starting with Windows 8 and Windows Server 2012, the operating system includes support for SMB 3.x. Linux distributions also provide support for SMB 3.x by using the cifs-utils package from the Samba project.

The Windows server and client-based version of SMB 3.x offers several advantages over SMB 2.1, including built-in encryption. As the result, you can establish mapping to Azure File storage shares from locations outside the Azure region where the Azure Storage account that is hosting the shares resides. This includes other Azure regions and on-premises environment if you allow outbound traffic on TCP port 445. With SMB 2.1, mappings to file shares are available only from the same Azure region.

Azure Files offers two performance tiers:

- **Standard file shares** are backed by rotational hard disk drives (HDDs) that provide reliable performance for IO workloads that are less sensitive to performance variability such as general-purpose file shares and dev/test environments.
- **Premium file shares** are backed by solid-state disks (SSDs) that provide consistent high performance and low latency, within single-digit milliseconds for most IO operations, for the most IO-intensive workloads. This makes them suitable for a wide variety of workloads like databases, web site hosting, development environments, etc.

There are three options for authorizing access to data objects in Azure Storage:

- **Using Azure AD** to authorize access to file shares and their content. At the time of authoring of this content, this option is available only when accessing Azure Files from Azure VMs joined to Azure Active Directory Domain Services-based domain.
- **Using your storage account keys** to authorize access to the entire content of the corresponding storage account.
- **Using Shared Access Signatures** to grant controlled permissions to specific data objects or containers of objects for a specific amount of time in a target storage account.

## Optional demo

- [Demonstration: Create and manage file shares and snapshots](https://github.com/MicrosoftLearning/AZ-120-Planning-and-Administering-Microsoft-Azure-for-SAP-Workloads/blob/master/Demos/demo-create-manage-file-shares-snapshots.md)
