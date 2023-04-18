Following successful Arc-enablement of Wide World Importers' thousands of servers, continuing to ensure these servers are organized and managed from the Azure plane is essential. We consolidate a set of best practices around tagging, log analytics, health alerts, and update management to ensure that resources are visible, monitored, and manageable. Furthermore, we introduce you to Azure Automanage, enabling you to point, click, set, and forget across your entire compute infrastructure. With Azure Automanage, you can automate the best Azure practices across security, governance, and update management for your servers anywhere. 

## Organize Azure Arc-enabled servers

You need to make sure machines are tagged and associated with Log Analytics workspaces to ensure they're organized within Azure.

As Azure resources, Arc-enabled servers can be tagged for organization. You should evaluate and develop an IT-aligned tagging strategy that can help reduce the complexity of managing your Azure Arc-enabled servers and simplify making management decisions.

Arc-enabled servers can be monitored through Azure Monitor or Log Analytics. Evaluate design and deployment considerations to determine if your organization should use an existing or implement another Log Analytics workspace to store collected log data from hybrid servers and machines. Consider setting up workspaces tied to Microsoft Sentinel for security and threat intelligence applications.

## Ensure Arc-enabled Server Connectivity

Create a Resource Health alert to alert when an Arc-enabled Server is no longer connected. If a server stops sending heartbeats to Azure for longer than 15 minutes, it can mean that it's offline, the network connection has been blocked, or the agent isn't running. Develop a plan for how you'll respond and investigate these incidents and use Resource Health alerts to get notified when they start. Specify the following settings when configuring the alert:

- **Resource type = Azure Arc-enabled servers**

- **Current resource status = Unavailable**

- **Previous resource status = Available**

## Manage the Connected Machine agent

After initial deployment of the Azure Arc-enabled servers Connected Machine agent for Windows or Linux, you might need to reconfigure the agent, upgrade it, or remove it from the computer. You can easily manage these routine maintenance tasks manually or through automation, which reduces both operational error and expense.

For the best experience and most recent security and bug fixes, we recommend keeping the Azure Arc-enabled servers' agent up to date. Out-of-date agents are identified with an Azure Advisor alert. Specify the following setting when configuring the alert:

- **Recommendation type = Upgrade to the latest version of the Azure Connected Machine agent**

## Beginning using Azure services

As a foundation for managing Azure Arc-enabled servers, we recommend organizing machines with tags, connecting to Log Analytics workspaces, and assigning Azure Policies. With the right observability and governance in place, you'll be able to more easily use other Azure services like Microsoft Defender for Cloud, Microsoft Sentinel, and Azure Automanage.

| Recommendation | Description |
|---|---|
| Apply tags to help organize machines | Evaluate and develop an IT-aligned tagging strategy that can help reduce the complexity of managing your Azure Arc-enabled servers and simplify making management decisions. |
| Design and deploy Azure Monitor Logs | Evaluate design and deployment considerations to determine if your organization should use an existing or implement another Log Analytics workspace to store collected log data from hybrid servers and machines. |
| Develop an Azure Policy governance plan | Determine how you'll implement governance of hybrid servers and machines at the subscription or resource group scope with Azure Policy. |
