The Hybrid Runbook Worker feature of Azure Automation allows you to run runbooks that manage local resources in your private data center on machines located in your data center.

Azure Automation stores and manages the runbooks and then delivers them to one or more on-premises machines.

The Hybrid Runbook Worker functionality is presented in the following graphic:

:::image type="content" source="../media/dsc9-4ce36ece.png" alt-text="Diagram of Azure Automation Hybrid Runbook Worker workflow containing Runbooks, DSC Configurations, Local Server and Local Resources icons.":::


## Hybrid Runbook Worker workflow and characteristics

The following list is characteristics of the Hybrid Runbook Worker workflow:

 -  You can select one or more computers in your data center to act as a Hybrid Runbook Worker and then run runbooks from Azure Automation.
 -  Each Hybrid Runbook Worker is a member of a Hybrid Runbook Worker group, which you specify when you install the agent.
 -  A group can include a single agent, but you can install multiple agents in a group for high availability.
 -  There are no inbound firewall requirements to support Hybrid Runbook Workers, only Transmission Control Protocol (TCP) 443 is required for outbound internet access.
 -  The agent on the local computer starts all communication with Azure Automation in the cloud.
 -  When a runbook is started, Azure Automation creates an instruction that the agent retrieves. The agent then pulls down the runbook and any parameters before running it.

To configure your on-premises servers that support the Hybrid Runbook Worker role with DSC, you must add them as DSC nodes.

For more information about onboarding them for management with DSC, see [Onboarding machines for management by Azure Automation State Configuration](/azure/automation/automation-dsc-onboarding).

For more information on installing and removing Hybrid Runbook Workers and groups, see:

 -  [Automate resources in your datacenter or cloud by using Hybrid Runbook Worker.](/azure/automation/automation-hybrid-runbook-worker#installing-hybrid-runbook-worker)
 -  [Hybrid Management in Azure Automation](https://azure.microsoft.com/blog/hybrid-management-in-azure-automation/)
