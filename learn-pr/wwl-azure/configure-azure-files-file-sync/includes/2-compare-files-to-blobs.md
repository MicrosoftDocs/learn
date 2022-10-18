[Azure Files](/azure/storage/files/storage-files-introduction) offers shared storage for applications by using the industry standard [Server Message Block protocol](https://msdn.microsoft.com/library/windows/desktop/aa365233.aspx). Microsoft Azure Virtual Machines and cloud services can share file data across application components by using mounted shares. On-premises applications can also access file data in the share.

### Things to know about Azure Files

Let's examine some charactieristics of Azure Files.

- Azure Files stores data as true directory objects in file shares.

- Azure Files provides shared access to files across multiple virtual machines. Any number of Azure virtual machines or roles can mount and access an Azure Files storage share simultaneously.

- Applications that run in Azure Virtual Machines or cloud services can mount an Azure Files storage share to access file data. This process is similar to how a desktop application mounts a typical SMB share. 

- Azure Files offers fully managed file shares in the cloud that are accessible via SMB. Azure File shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS.

### Things to consider when using Azure Files

There are many common scenarios for using Azure Files storage. As you review the following suggestions, think about how Azure Files storage can provide solutions for your organization.

- **Consider replacement and supplement options**. Replace or supplement traditional on-premises file servers or NAS devices by using Azure Files.

- **Consider global access**. Directly access Azure Files shares by using most operating systems, such as Windows, macOS, and Linux from anywhere in the world.

- **Consider lift and shift support**. _Lift and shift_ applications to the cloud with Azure Files for apps that expect a file share to store file application or user data.

- **Consider the Azure File Sync agent**. Replicate Azure Files shares to Windows Servers by using the Azure File Sync agent. You can replicate on-premises or in the cloud for performance and distributed caching of the data where it's being used.

- **Consider shared applications**. Store shared application settings in Azure Files, such as configuration files.

- **Consider diagnostic data**. Use Azure Files to store diagnostic data such as logs, metrics, and crash dumps in a shared location.

- **Consider tools and utilities**. Azure Files is a good option for storing tools and utilities that are needed for developing or administering Azure virtual machines or cloud services.

## Compare Azure Files and Azure Blob Storage (blobs)

It can be difficult to determine exactly when to use Azure Files shares rather than Azure Blob Storage or Azure Disks (page blobs) shares. The following table compares different features of these services and common implementation scenarios.

| Azure Files | Azure Blob Storage or Azure Disks |
| --- | --- | 
| Azure Files provides the SMB and NFS protocols, client libraries, and a REST interface that allows access from anywhere to stored files. | Azure Blob Storage provides client libraries and a REST interface that allows unstructured data to be stored and accessed at a massive scale in block blobs. 
| - Files in an Azure Files share are true directory objects. <br> - Data in Azure Files is accessed through file shares. <br> - Data stored in Azure Files is shared access across multiple virtual machines. | - Blobs in Azure Blob Storage are a flat namespace. <br> - Blob data in Azure Blob Storage is accessed through a container. <br> - Data stored in Azure Disks is exclusive to a single virtual machine. |
| _Azure Files is ideal to **lift and shift** an application to the cloud that already uses the native file system APIs. You can share data between the application and other applications running in Azure._ <br> _Azure Files is a good option when you want to store development and debugging tools that need to be accessed from many virtual machines._ | _Azure Blob Storage is ideal for applications that need to support streaming and random-access scenarios._ <br> _Azure Blob Storage is a good option when you want to be able to access application data from anywhere._ |