Tailwind Traders has onboarded its machines to Azure Arc-enabled servers, and now wants to onboard those servers to Microsoft Defender for Cloud. In this unit, you’ll learn how to onboard your Azure Arc-enabled servers to Microsoft Defender for Cloud by enabling Log Analytics.

## Add non-Azure machines with Azure Arc

Because your Azure VM is already registered and managed as an Azure resource, it's necessary to reconfigure the VM. Reconfiguring the VM involves removing extensions, disabling the Azure VM guest agent, and blocking Azure IMDS access. After you've made these three changes, your Azure VM behaves like any machine or server outside of Azure. This reconfigured Azure VM will offer a starting point to install and evaluate Azure Arc-enabled servers.

The preferred way of adding your non-Azure machines to Microsoft Defender for Cloud is with Azure Arc-enabled servers. Connecting a machine to Azure through Azure Arc-enabled servers creates an Azure resource for the hybrid machine. When you install the Log Analytics agent on the Arc-enabled server, the hybrid machine will also appear in Defender for Cloud. Just like your other Azure resources, the Arc-enabled server can also have security recommendations, surface alerts, and be captured in your secure score.

Defender for Cloud's Log Analytics auto-deploy tools don't support machines running Azure Arc. Log Analytics agent-deployment options include:  

- You can deploy VM extensions for Azure Arc-enabled servers from the Azure portal. You can also deploy them using PowerShell, the Azure CLI, or with an Azure Resource Manager (ARM) template.
- Azure Policy through the Configure Log Analytics extension on Azure Arc enabled Linux servers/Configure Log Analytics extension on Azure Arc enabled Windows servers policy definitions.
- Azure Automation and its support for PowerShell and Python to automate the deployment of the Log Analytics agent VM extension.

## Enable the Log Analytics VM extension from Azure portal

You can apply VM extensions to your Azure Arc-enabled server-managed machine via the Azure portal:

1. From your browser, go to the [Azure portal](https://portal.azure.com/).
1. In the portal, search for and select **Servers - Azure Arc**, then select your hybrid machine from the list.
1. Choose **Extensions**, then select **Add**. Choose the Log Analytics VM Extension from the list of available extensions and follow the instructions in the wizard.

   ![Screenshot of the Log Analytics VM Extension selection from the Azure portal.](../media/log-analytics-extension.png)

1. To complete the installation, provide the workspace ID and primary key.

   ![Screenshot of Log Analytics VM Extension configuration with the correct workspace details](../media/log-analytics-extension-details.png)

1. After confirming the required information provided, select **Review + Create**. A summary of the deployment is displayed, and you can review the status of the deployment.

## Verify your deployment

Now you can view your Azure and non-Azure machines together in one place. Within Microsoft Defender for Cloud, open the asset inventory page and filter to the relevant resource types.

The asset inventory page of Microsoft Defender for Cloud provides a single area to view your connected resources and their security postures. Defender for Cloud periodically analyzes the security state of resources connected to your subscriptions to identify potential security vulnerabilities. It then provides you with recommendations on how to remediate those vulnerabilities.
