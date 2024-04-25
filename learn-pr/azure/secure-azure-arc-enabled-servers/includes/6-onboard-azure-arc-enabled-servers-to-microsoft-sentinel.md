Tailwind Traders has onboarded its machines to Azure Arc-enabled servers, and now wants to onboard those servers to Microsoft Sentinel. In this unit, you learn how to onboard your Azure Arc-enabled servers to Microsoft Sentinel. First, you connect the Azure Arc-enabled server to a Log Analytics workspace. Second, you enable Microsoft Sentinel on this workspace.

## Connect the Azure Arc-enabled server to a Log Analytics workspace

For physical and virtual machines, you can install the Log Analytics agent, which collects the logs and forwards them to Microsoft Sentinel. Azure Arc-enabled servers support deploying the Log Analytics agent using the following methods:

- Using the **VM extensions framework**, you can deploy the Log Analytics agent VM extension to a non-Azure Windows and/or Linux server. You can manage VM extensions using the Azure portal, Azure CLI, Azure PowerShell, and Azure Resource Manager templates.
- Using **Azure Policy**, you can deploy Log Analytics agent to Windows or Linux Azure Arc machines to audit if the Azure Arc-enabled server has the Log Analytics agent installed. If the agent isn't installed, it automatically deploys it using a remediation task. You can also use the built-in Azure Policy to enable Azure Monitor for VMs initiative to install and configure the Log Analytics agent.

## Enable Microsoft Sentinel on the Log Analytics workspace

1. From your browser, go to the [Azure portal](https://portal.azure.com/).
1. Search for and select **Microsoft Sentinel**.

    :::image type="content" source="../media/azure-portal-search.png" alt-text="Screenshot of Microsoft Sentinel selection in the Azure portal.":::

1. Select **Add**.
1. Select the workspace to which the Azure Arc-enabled server is connected. You can run Microsoft Sentinel on more than one workspace, but the data is isolated to a single workspace.  

    :::image type="content" source="../media/sentinel-add-workspace.png" alt-text="Screenshot that shows how to add Microsoft Sentinel to the Log Analytics workspace.":::

1. Select **Add Microsoft Sentinel**.

After your Arc-enabled servers are connected, your data starts streaming into Microsoft Sentinel and is ready for you to start working with. You can view the logs in the built-in workbooks and start building queries in Log Analytics to investigate the data.
