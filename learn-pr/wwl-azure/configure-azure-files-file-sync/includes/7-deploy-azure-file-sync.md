There are several high-level steps for configuring File Sync.

:::image type="content" source="../media/file-sync-steps-b6fa9fd9.png" alt-text="Flowchart showing the prerequisites that need to be configured before synchronizing files using Azure File Sync.":::


1.  **Deploy the Storage Sync Service**. The Storage Sync Service can be deployed from the Azure portal. You will need to provide Name, Subscription, Resource Group, and Location.<br>
2.  **Prepare Windows Server to use with Azure File Sync**. For each server that you intend to use with Azure File Sync, including server nodes in a Failover Cluster, you will need to configure the server. Preparation steps include temporarily disabling Internet Explorer Enhanced Security and ensuring you have latest PowerShell version.
3.  **Install the Azure File Sync Agent**. The Azure File Sync agent is a downloadable package that enables Windows Server to be synced with an Azure file share. The Azure File Sync agent installation package should install relatively quickly. We recommend that you keep the default installation path and that you enable Microsoft Update to keep Azure File Sync up to date.
4.  **Register Windows Server with Storage Sync Service**. When the Azure File Sync agent installation is finished, the Server Registration UI automatically opens. Registering Windows Server with a Storage Sync Service establishes a trust relationship between your server (or cluster) and the Storage Sync Service. Registration requires your Subscription ID, Resource Group, and Storage Sync Service (created in step 1). A server (or cluster) can be registered with only one Storage Sync Service at a time.


