
Azure File Sync is composed of four main components that work together to provide caching for Azure Files shares on an on-premises Windows Server or cloud virtual machine.

The following illustration shows how the components of Azure File Sync provide a cache for a storage account that has Accounting and Sales data stored in Azure Files shares.

:::image type="content" source="../media/file-sync-components-c6561274.png" alt-text="Diagram that shows the components of the Azure File Sync architecture with servers and server endpoints." border="false":::

Let's examine the details of the Azure File Sync components.

### Storage Sync Service

The Storage Sync Service is the top-level Azure resource for Azure File Sync. This resource is a peer of the storage account resource and can be deployed in a similar manner.

- The Storage Sync Service forms sync relationships with multiple storage accounts by using multiple sync groups.

- The service requires a distinct top-level resource from the storage account resource to support the sync relationships.

- A subscription can have multiple Storage Sync Service resources deployed.

### Sync group

A sync group defines the sync topology for a set of files. Endpoints within a sync group are kept in sync with each other. Consider the scenario where you have two distinct sets of files that you want to manage with Azure File Sync. In this case, you create two sync groups and add different endpoints to each sync group. An instance of the Storage Sync Service can host as many sync groups as you need.

### Registered server

The registered server object represents a trust relationship between your server (or cluster) and the Storage Sync Service resource. You can register as many servers to a Storage Sync Service resource as you want.

### Azure File Sync agent

The Azure File Sync agent is a downloadable package that enables Windows Server to be synced with an Azure Files share. The Azure File Sync agent has three main components:

- **FileSyncSvc.exe**: This file is the background Windows service that's responsible for monitoring changes on server endpoints, and for initiating sync sessions to Azure.

- **StorageSync.sys**: This file is the Azure File Sync file system filter that supports cloud tiering. The filter is responsible for tiering files to Azure Files when cloud tiering is enabled.
 
- **PowerShell cmdlets**: These PowerShell management cmdlets allow you to interact with the `Microsoft.StorageSync` Azure resource provider. You can find the cmdlets at the following (default) locations:    
   - `C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.PowerShell.Cmdlets.dll`
   - `C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.ServerCmdlets.dll`

### Server endpoint

A server endpoint represents a specific location on a registered server, such as a folder on a server volume. Multiple server endpoints can exist on the same volume if their namespaces are unique (for example, `F:\\sync1` and `F:\\sync2`). 

### Cloud endpoint

A cloud endpoint is an Azure Files share that's part of a sync group. As part of a sync group, the entire cloud endpoint (Azure Files share) syncs.

- An Azure Files share can be a member of one cloud endpoint only.

- An Azure Files share can be a member of one sync group only.

- Consider the scenario where you have a share with existing files. If you add the share as a cloud endpoint to a sync group, the files in the share are merged with files on other endpoints in the sync group.