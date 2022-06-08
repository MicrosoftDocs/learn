[File storage](/azure/storage/files/storage-files-introduction) offers shared storage for applications using the industry standard [SMB protocol](https://msdn.microsoft.com/library/windows/desktop/aa365233.aspx). Microsoft Azure virtual machines and cloud services can share file data across application components via mounted shares, and on-premises applications can also access file data in the share.

Applications running in Azure virtual machines or cloud services can mount a file storage share to access file data. This process is similar to how a desktop application would mount a typical SMB share. Any number of Azure virtual machines or roles can mount and access the File storage share simultaneously.

## Common uses of file storage

 -  **Replace and supplement**. Azure Files can be used to completely replace or supplement traditional on-premises file servers or NAS devices.
 -  **Access anywhere**. Popular operating systems such as Windows, macOS, and Linux can directly mount Azure File shares wherever they are in the world.
 -  **Lift and shift**. Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store file application or user data.
 -  **Azure File Sync**. Azure File shares can also be replicated with Azure File Sync to Windows Servers, either on-premises or in the cloud, for performance and distributed caching of the data where it's being used.
 -  **Shared applications**. Storing shared application settings, for example in configuration files.
 -  **Diagnostic data**. Storing diagnostic data such as logs, metrics, and crash dumps in a shared location.
 -  **Tools and utilities**. Storing tools and utilities needed for developing or administering Azure virtual machines or cloud services.

## Files and blobs comparison

Sometimes it is difficult to decide when to use file shares instead of blobs or disk shares. Take a minute to review this table that compares the different features.

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
  :::column:::
    **When to use**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Azure Files**
  :::column-end:::
  :::column:::
    Provides SMB, NFS, client libraries, and a REST interface that allows access from anywhere to stored files.
  :::column-end:::
  :::column:::
    You want to "lift and shift" an application to the cloud that already uses the native file system APIs to share data between it and other applications running in Azure. You want to store development and debugging tools that need to be accessed from many virtual machines.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Azure Blobs**
  :::column-end:::
  :::column:::
    Provides client libraries and a REST interface that allows unstructured data to be stored and accessed at a massive scale in block blobs.
  :::column-end:::
  :::column:::
    You want your application to support streaming and random-access scenarios. You want to be able to access application data from anywhere.
  :::column-end:::
:::row-end:::


Other distinguishing features, when selecting Azure files.

 -  Azure files are true directory objects. Azure blobs are a flat namespace.
 -  Azure files are accessed through file shares. Azure blobs are accessed through a container.
 -  Azure files provide shared access across multiple virtual machines. Azure disks are exclusive to a single virtual machine.

> [!NOTE]
> Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol. Azure File shares can be mounted concurrently by cloud or on-premises deployments of Windows, Linux, and macOS.
