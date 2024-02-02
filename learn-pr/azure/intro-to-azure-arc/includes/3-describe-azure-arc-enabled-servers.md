You can use Azure Arc-enabled servers to manage server-based resources that run outside of Azure. A Windows Server or Linux server that's running in Contoso's on-premises datacenter can be registered with Azure Arc and managed alongside native Azure resources. Contoso can also apply this capability to any server hosted by another cloud provider that's running Windows Server or Linux.

## What is Azure Arc-enabled servers?

Azure Arc-enabled servers allows you to manage all your servers as if they're Azure resources in one of your resource groups. Your managed servers can be:

- Physical computers.
- VMs hosted in an on-premises datacenter.
- VMs hosted with another cloud provider.
- Running either Windows Server or Linux. Many popular distributions of Linux are supported.

## Onboard servers to Azure Arc

The first step for an administrator is to connect servers to Azure Arc. This process is called onboarding.

To onboard a server, you install the Azure Connected Machine agent. This installation connects your machines to Azure Arc-enabled servers.

Each server that you onboard:

- Is assigned an Azure Resource Manager ID.
- Has a managed identity.
- Is located in an Azure resource group and subscription.
- Appears in the Azure portal.
- Can use tags and other Azure management features.

:::image type="content" source="../media/3-onboard.png" alt-text="Screenshot that depicts the Machines - Azure Arc page in the Azure portal. A single computer, ContosoVM1, is listed." border="false" lightbox="../media/3-onboard.png":::

Once installed, the Azure Connected Machine agent sends a heartbeat message to the Azure Arc service every five minutes. If the Azure Arc service stops receiving heartbeat messages from the connected machine, it considers the machine to be offline. The machine is then marked as **Disconnected** until heartbeats resume, at which time the machine is marked as **Connected**.

## Manage and configure servers

After you connect your machines to Azure Arc-enabled servers, you can perform many configuration management tasks. The following table describes some of these capabilities:

| Option                  | Description                                       |
| -------------------------- | ------------------------------------------------------------ |
|Overview | You can review basic information about the server, including status, location, subscription, computer name, operating system, and tags. |
| Activity log| You can review a list of activities that were performed on the server and who performed them. |
|Access control | You can review and manage access to Azure resources for users, groups, service principals, and managed identities at this scope by creating role assignments. |
|Tags | Tags are name/value pairs that enable you to categorize resources. |
|Policies | You can add, configure, and remove policies for the server. |
|Update Management |This option enables you to maintain consistent control and compliance of the server. |
|Change Tracking and Inventory |You can review change tracking and inventory configuration for the server. Change Tracking and Inventory helps enable consistent control and compliance of your resources.|
| Insights | You can use Azure Monitor to review host CPU, disk, and the online/offline state of your Azure Arc-enabled servers. |
| Logs| You can run queries on logs to gather information about the server. |
|Extensions |You can add and remove extensions for the server. Extensions are small apps that provide post-deployment configuration and automation tasks on servers. For example, Contoso could use an extension if a server needs new software, or if IT staff need to run a script on a server. |
