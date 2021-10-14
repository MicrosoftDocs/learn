Following successful Arc-enablement of Wide World Importers' thousands of servers, continuing to ensure these servers are organized and managed from the Azure plane is essential. We consolidate a set of best practices around tagging, log analytics, health alerts, and update management to ensure that resources are visible, monitored, and manageable. Furthermore, we introduce you to Azure Automanage enabling you point, click, set, and forget across your entire compute infrastructure. With Azure Automanage, you can automatically the best Azure practices across security, governance, and update management for your servers anywhere. 

## Organize Arc-enabled Servers

Ensure machines are tagged and associated with Log Analytics workspaces to ensure organized within Azure. 

As Azure resources, Arc-enabled servers can be tagged for organization. Evaluate and develop an IT-aligned tagging strategy that can help reduce the complexity of managing your Azure Arc-enabled servers and simplify making management decisions.

Arc-enabled servers can be monitored through Azure Monitor or Log Analytics. Evaluate design and deployment considerations to determine if your organization should use an existing or implement another Log Analytics workspace to store collected log data from hybrid servers and machines. Consider setting up workspaces tied to Azure Sentinel for security and threat intelligence applications. 
 
Ensure Arc-enabled Server Connectivity

Create a Resource Health alert to alert when an Arc-enabled Server is no longer connected.  If a server stops sending heartbeats to Azure for longer than 15 minutes, it can mean that it is offline, the network connection has been blocked, or the agent is not running. Develop a plan for how you'll respond and investigate these incidents and use Resource Health alerts to get notified when they start. Specify the following when configuring the alert:

**Resource type = Azure Arc-enabled servers**

**Current resource status = Unavailable**

**Previous resource status = Available**

## Manage the Connected Machine Agent

After initial deployment of the Azure Arc-enabled servers Connected Machine agent for Windows or Linux, you may need to reconfigure the agent, upgrade it, or remove it from the computer. You can easily manage these routine maintenance tasks manually or through automation, which reduces both operational error and expenses.

For the best experience and most recent security and bug fixes, we recommend keeping the Azure Arc-enabled servers' agent up to date. Out-of-date agents will be identified with an Azure Advisor alert. Specify the following when configuring the alert:

**Recommendation type = Upgrade to the latest version of the Azure Connected Machine Agent**

## Leverage Azure Best Practices with Automanage

With Azure Automanage, a range of Azure services are automatically onboarded for you when you use Automanage Machine Best Practices on an Arc-enabled server VM. For all of these services, we will auto-onboard, auto-configure, monitor for drift, and remediate if drift is detected. The following table outlines the Azure Services included with Azure Automanage. 

| Azure Service | Description |
|---|---|
| Machines Insights Monitoring | Azure Monitor for machines monitors the performance and health of your virtual machines, including their running processes and dependencies on other resources. Learn more.
| Azure Security Center | Azure Security Center is a unified infrastructure security management system that strengthens the security posture of your data centers, and provides advanced threat protection across your hybrid workloads in the cloud. Learn more. Automanage will configure the subscription where your VM resides to the free-tier offering of Azure Security Center. If your subscription is already onboarded to Azure Security Center, then Automanage will not reconfigure it.
| Update Management | You can use Update Management in Azure Automation to manage operating system updates for your machines. You can quickly assess the status of available updates on all agent machines and manage the process of installing required updates for servers. Learn more.
| Change Tracking & Inventory | Change Tracking and Inventory combines change tracking and inventory functions to allow you to track virtual machine and server infrastructure changes. The service supports change tracking across services, daemons software, registry, and files in your environment to help you diagnose unwanted changes and raise alerts. Inventory support allows you to query in-guest resources for visibility into installed applications and other configuration items. Learn more.
| Azure Guest Configuration | Guest Configuration policy is used to monitor the configuration and report on the compliance of the machine. The Automanage service will install the Azure Linux baseline using the Guest Configuration extension. For Linux machines, the guest configuration service will install the baseline in audit-only mode. You will be able to see where your VM is out of compliance with the baseline, but noncompliance won't be automatically remediated. Learn more.
| Azure Automation Account | Azure Automation supports management throughout the lifecycle of your infrastructure and applications. Learn more.
| Log Analytics Workspace | Azure Monitor stores log data in a Log Analytics workspace, which is an Azure resource and a container where data is collected, aggregated, and serves as an administrative boundary. Learn more.
