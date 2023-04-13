
The Azure Log Analytics agent was developed for comprehensive management across virtual machines in any cloud, on-premises machines, and those monitored by System Center Operations Manager. The Windows and Linux agents send collected data from different sources to your Log Analytics workspace in Azure Monitor, as well as any unique logs or metrics as defined in a monitoring solution. The Log Analytics agent also supports insights and other services in Azure Monitor such as Azure Monitor for VMs, Microsoft Defender for Cloud, and Azure Automation.

### Comparison to Azure diagnostics extension

The Azure diagnostics extension in Azure Monitor can also be used to collect monitoring data from the guest operating system of Azure virtual machines. You may choose to use either or both depending on your requirements.

The key differences to consider are:

 -  Azure Diagnostics Extension can be used only with Azure virtual machines. The Log Analytics agent can be used with virtual machines in Azure, other clouds, and on-premises.
 -  Azure Diagnostics extension sends data to Azure Storage, Azure Monitor Metrics (Windows only) and Event Hubs. The Log Analytics agent collects data to Azure Monitor Logs.
 -  The Log Analytics agent is required for solutions, Azure Monitor for VMs, and other services such as Microsoft Defender for Cloud.

:::image type="content" source="../media/az500-connected-sources-311620e5.png" alt-text="Connected sourses illustration moving data to Azure Monitor":::


### Data destinations

The Log Analytics agent sends data to a Log Analytics workspace in Azure Monitor. The Windows agent can be multihomed to send data to multiple workspaces and System Center Operations Manager management groups. The Linux agent can send to only a single destination.

### Other services

The agent for Linux and Windows isn't only for connecting to Azure Monitor, it also supports Azure Automation to host the Hybrid Runbook worker role and other services such as Change Tracking, Update Management, and Microsoft Defender for Cloud.
