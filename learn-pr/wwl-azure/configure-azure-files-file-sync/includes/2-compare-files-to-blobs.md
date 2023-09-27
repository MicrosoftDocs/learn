
[Azure Files](/azure/storage/files/storage-files-introduction) offers shared storage for applications by using the industry standard [Server Message Block protocol](https://msdn.microsoft.com/library/windows/desktop/aa365233.aspx). Microsoft Azure Virtual Machines and cloud services can share file data across application components by using mounted shares. On-premises applications can also access file data in the share.

### Things to know about Azure Files

Let's examine some characteristics of Azure Files.

- Azure Files stores data as true directory objects in file shares.

- Azure Files provides shared access to files across multiple virtual machines. Any number of Azure virtual machines or roles can mount and access an Azure Files storage share simultaneously.

- Applications that run in Azure Virtual Machines or cloud services can mount an Azure Files storage share to access file data. This process is similar to how a desktop application mounts a typical SMB share. 

- Azure Files offers fully managed file shares in the cloud that are accessible via SMB. Azure Files shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS.

### Things to consider when using Azure Files

There are many common scenarios for using Azure Files storage. As you review the following suggestions, think about how Azure Files storage can provide solutions for your organization.

- **Consider replacement and supplement options**. Replace or supplement traditional on-premises file servers or NAS devices by using Azure Files.

- **Consider global access**. Directly access Azure Files shares by using most operating systems, such as Windows, macOS, and Linux from anywhere in the world.

- **Consider lift and shift support**. _Lift and shift_ applications to the cloud with Azure Files for apps that expect a file share to store file application or user data.

- **Consider the Azure File Sync agent**. Replicate Azure Files shares to Windows Servers by using the Azure File Sync agent. You can replicate on-premises or in the cloud for performance and distributed caching of the data where it's being used. We'll take a closer look at the agent in a later unit.

- **Consider shared applications**. Store shared application settings in Azure Files, such as configuration files.

- **Consider diagnostic data**. Use Azure Files to store diagnostic data such as logs, metrics, and crash dumps in a shared location.

- **Consider tools and utilities**. Azure Files is a good option for storing tools and utilities that are needed for developing or administering Azure Virtual Machines or cloud services.

## Compare Azure Files to Blob Storage and Azure Disks

It can be difficult to determine exactly when to use Azure Files to store data as file shares rather than Azure Blob Storage or Azure Disks to store data as blobs. The following table compares different features of these services and common implementation scenarios.

| Azure Files (file shares) | Azure Blob Storage (blobs) | Azure Disks (page blobs) |
| --- | --- | --- |
| Azure Files provides the SMB and NFS protocols, client libraries, and a REST interface that allows access from anywhere to stored files. | Azure Blob Storage provides client libraries and a REST interface that allows unstructured data to be stored and accessed at a massive scale in block blobs. | Azure Disks is similar to Azure Blob Storage. Azure Disks provides a REST interface to store and access index-based or structured data in page blobs. |
| - Files in an Azure Files share are true directory objects. <br> - Data in Azure Files is accessed through file shares across multiple virtual machines. | - Blobs in Azure Blob Storage are a flat namespace. <br> - Blob data in Azure Blob Storage is accessed through a container. | - Page blobs in Azure Disks are stored as 512-byte pages. <br> - Page blob data is exclusive to a single virtual machine. |
| _**Azure Files** is ideal to lift and shift an application to the cloud that already uses the native file system APIs. Share data between the app and other applications running in Azure._ <br><br> _Azure Files is a good option when you want to store development and debugging tools that need to be accessed from many virtual machines._ | _**Azure Blob Storage** is ideal for applications that need to support streaming and random-access scenarios._ <br><br> _Azure Blob Storage is a good option when you want to be able to access application data from anywhere._ | _**Azure Disks** solutions are ideal when your applications run frequent random read/write operations._ <br><br> _Azure Disks is a good option when you want to store relational data for operating system and data disks in Azure Virtual Machines and databases._ |