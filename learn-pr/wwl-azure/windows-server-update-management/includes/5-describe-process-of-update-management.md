If you have an Azure account, you can also use Microsoft Azure Update Management, a feature of Azure Automation, in conjunction with WSUS (Windows Server Update Services) or instead of WSUS to manage updates on your servers.

## What is Azure Automation?

Azure Automation is a cloud-based service that provide process automation, configuration management, update management, and other management features for both Azure and non-Azure environments, including on-premises environments.

## What is Update Management?

Update Management is a free service within Azure Automation that helps you manage operating system update for both Windows and Linux machines, both in the cloud and on-premises. The only cost associated with using Update Management is the cost of log storage in Azure Log Analytics.

Azure Update Management does not require configuring Group Policies for updates, making it simpler to use than WSUS in many cases. As previously stated, you can use it to manage updates for both Windows and Linux servers, making it a good choice for mixed server environments. Also, because you can use it with cloud-based servers, it's also a good option for managing updates in hybrid environments.

On-premises servers are managed via a locally installed agent on the server that communicates with the cloud service.

## Update Management capabilities

Update Management includes the following capabilities related to on-premises servers:

- Check status of updates on your servers. The Update Management service includes a cloud-based console from where you can review the status of updates across your organization and for a specific machine.

- Ability to configure dynamic groups of machines to target. This service allows you to define a query based on computer group, which is a group of computers that are defined based on another query or imported from another source such as WSUS or Endpoint Configuration Manager.

- Ability to search Azure Monitor logs. Records collected by Update Management are listed in Azure Monitor Logs.

## Onboarding your on-premises server

You must add your on-premises servers to Update Management in Azure Automation manually. After you have an Azure Automation account, you then need to enable either the Inventory or Change tracking features within your Automation account. After either of those solutions is running, then you can enable the Update management solution with your account.

After you enable Update Management, you then download and install the Log Analytics agent for Windows to your on-premises server. After the agent is installed and information about your server is reported to your automation account, you can then onboard the machines in the update workspace within your Automation account.

Additional reading: For more information about Azure Update Management, see [Update Management overview](/azure/automation/update-management/overview).

Additional reading: For more information about installing the Log Analytics agents, see [Connect Windows computers to Azure Monitor](https://aka.ms/agent-windows).

