
Before you can start synchronizing files with Azure File Sync, there are several high-level steps that need to be completed.

:::image type="content" source="../media/file-sync-steps-b6fa9fd9.png" alt-text="Flowchart that shows the steps to complete before you start synchronizing files with Azure File Sync." border="false":::

### Step 1: Deploy the Storage Sync Service

You can deploy the Storage Sync Service from the Azure portal. You configure the following settings:
- The deployment name for the Storage Sync Service
- The Azure subscription ID to use for the deployment
- A Resource Group for the deployment
- The deployment location

### Step 2: Prepare each Windows Server to use Azure File Sync

After you deploy the Storage Sync Service, you configure each Windows Server or cloud virtual machine that you intend to use with Azure File Sync, including server nodes in a Failover Cluster. 

### Step 3: Install the Azure File Sync agent

When the Windows Server configuration is complete, you're ready to install the Azure File Sync agent. The agent is a downloadable package that enables Windows Server to be synced with an Azure Files share. The Azure File Sync agent installation package should install relatively quickly.

> [!Note]
> For the agent installation, Microsoft recommends using the default installation path. Also enable Microsoft Update to ensure your servers are running the latest version of Azure File Sync.

### Step 4: Register each Windows Server with the Storage Sync Service

After the Azure File Sync agent installation completes, the **Server Registration** window opens. 

By registering the Windows Server with a Storage Sync Service, you establish a trust relationship between your server (or cluster) and the Storage Sync Service. For the registration, you need your Azure subscription ID and some of the deployment settings you configured in the first step:
- The Storage Sync Service deployment name
- The Resource Group for the deployment

> [!Note]
> A server (or cluster) can be registered with only one Storage Sync Service resource at a time.