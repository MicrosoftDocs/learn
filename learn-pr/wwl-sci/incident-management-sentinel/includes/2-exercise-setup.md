
To set up the Azure environment for the optional incident management exercise, complete the following steps.

## Prerequisites

To complete this optional exercise, you need access to an Azure subscription. If you don't have a subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true).

> [!NOTE]
> Be aware that this exercise creates resources that might incur costs in your Azure subscription. To estimate the costs, see [Microsoft Sentinel pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).


## Deploy the Azure Resource Manager template

1. Select the following button to deploy the Azure Resource Manager (ARM) template that creates the Azure resources. Sign in to Azure if prompted.

   [![Deploy To Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-incident-management-sentinel%2Fsentinel-template.json?azure-portal=true)

1. On the **Custom deployment** page, provide the following information:

   - **Subscription**: Select your Azure subscription if not already selected.
   - **Resource group**: Select **Create new**, and name the resource group *azure-sentinel-rg*.
   - **Location**: Select the Azure region where you want to deploy Microsoft Sentinel.
   - **Workspace name**: Provide a unique name for the Microsoft Sentinel workspace, such as *\<yourName>-Sentinel*.

1. Leave the other settings as is, select **Review + create**, and then select **Create**.

Wait for the deployment to finish. The deployment should take less than five minutes.

## Verify deployed resources

1. When the deployment finishes, select **Go to resource group**, or search for **Resource groups** in the portal and then select **azure-sentinel-rg**.
1. On the **azure-sentinel-rg** page, sort the list of resources by **Type**.
1. Confirm that the resource group contains the following resources:

   | Name  | Type  | Description |
   |---|---|---|
   | **\<yourName>-Sentinel** | Log Analytics workspace | Log Analytics workspace that Microsoft Sentinel uses, with the name you chose for the workspace.|
   | **simple-vmNetworkInterface** | Network interface | Network interface for the VM. |
   | **SecurityInsights(\<yourName>-Sentinel)** | Solution | Security insights for Microsoft Sentinel. |
   | **st1\<xxxxx>** | Storage account | Storage account used by the VM, where **\<xxxxx>** represents a random string that's generated to create a unique storage account name. |
   | **simple-vm** | Virtual machine (VM) | VM to use in the demonstration. |
   | **vnet1** | Virtual network | Virtual network for the VM. |

## Configure the Microsoft Sentinel connector

Next, deploy the Azure Activity log connector for Microsoft Sentinel.

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Sentinel**.
1. On the **Microsoft Sentinel** page, select the Microsoft Sentinel workspace you created.
1. On the workspace page, select **Data connectors** under **Configuration** in the left menu.
1. On the **Data connectors** page, search for and select **Azure Activity**, and then select **Open connector page** on the **Azure Activity** screen.
1. At the bottom of the **Azure Activity** page, select **Launch Azure Policy Assignment Wizard**.
1. In the **Basics** tab of the wizard, select the ellipsis ***...*** under **Scope**. On the **Scopes** pane, select your subscription and then select **Select**.
1. Select the **Parameters** tab, and choose your Microsoft Sentinel workspace from the **Primary Log Analytics workspace** drop-down list.
1. Select the **Remediation** tab, and select the **Create a remediation task** checkbox. This action applies the subscription configuration to send the information to the Log Analytics workspace.
1. Select the **Review + Create** button to review the configuration, and then select **Create**.

The Azure Activity connector might take up to an hour to display a status of **Connected**. While the connector deploys, continue to the following units to learn about incidents in Microsoft Sentinel.

