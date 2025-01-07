To complete this optional exercise, you need access to an Azure subscription to create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

> [!NOTE]
> If you perform the exercises in this module, you might incur costs in your Azure subscription. To estimate the costs, see [Microsoft Sentinel pricing](https://azure.microsoft.com/pricing/details/microsoft-sentinel).

To deploy the prerequisites for the exercise, perform the following tasks.

## Deploy the Azure Resource Manager template for the exercise environment

1. Select the following link:

    [![Deploy To Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-hunt-threats-sentinel%2Fsentinel-template.json?azure-portal=true)

    You're prompted to sign in to Azure.
1. On the **Custom deployment** page, provide the following information:

    | Name  | Description |
    |---|---|
    | **Subscription** | Select your Azure subscription. |
    | **Resource Group** | Select **Create new** and provide a name for the resource group, such as `azure-sentinel-rg`. |
    | **Region** | Select an Azure region. |
    | **Workspace name**  | Provide a unique name for the Microsoft Sentinel workspace, such as `<yourName>-sentinel`, where *\<yourName>* represents the workspace name that you chose in the previous task. |
    | **Location** | Accept the default value **[resourceGroup().location]**. |
    | **Simplevm Name** | Accept the default value **simple-vm**. |
    | **Simplevm Windows OS Version** | Accept the default value **2016-Datacenter**.|

1. Select **Review + create**, and then select **Create**.

    > [!NOTE]
    > Wait for the deployment to finish. The deployment should take less than five minutes.

## Check created resources

1. In the Azure portal, search for **Resource groups**.
2. Select your resource group.
3. Sort the list of resources by **Type**.
4. The resource group should contain the resources displayed in this table:

    | Name  | Type  | Description |
    |---|---|---|
    | `<yourName>-sentinel` | Log Analytics workspace | Log Analytics workspace used by Microsoft Sentinel, where *\<yourName>* represents the workspace name that you chose in the previous task. |
    | `simple-vmNetworkInterface` | Network interface | Network interface for the virtual machine (VM). |
    | `SecurityInsights(<yourName>-sentinel)` | Solution | Security insights for Microsoft Sentinel. |
    | `simple-vm` | Virtual machine | VM used in the demonstration. |
    | `st1<xxxxx>` | Storage account | Storage account used by the VM, where *\<xxxxx>* represents a random string generated to create a unique storage account name. |
    | `vnet1` | Virtual network | Virtual network for the VM. |

## Configure Microsoft Sentinel connectors

In this task, you deploy a Microsoft Sentinel connector to Azure Activity.

1. In the Azure portal, search for and select **Microsoft Sentinel**, and then select the previously created Microsoft Sentinel workspace.
1. On the **Microsoft Sentinel** page, on the menu bar, in the **Configuration** section, select **Data connectors**.
1. On the **Data connectors** pane, search for and select **Azure Activity**. On the details pane, select **Open connector page**.
1. Review the **Prerequisites**. You need to have the owner role assigned for Azure Policy assignment scopes.
1. If you have a subscription connected with the *legacy method*, you're directed to disconnect it using the **Configuration** instructions for "1. Disconnect your subscriptions from the legacy method".
1. If you didn't have the connector configured with the legacy method, proceed to "2. Connect your subscriptions..." in the **Configuration** area.
1. Select **Launch Azure Policy Assignment Wizard>**.
1. In the **Basics** tab, select the ellipsis button (...) under **Scope** and choose your subscription from the drop-down list. Then choose **Select**.
1. Select the **Parameters** tab, choose your *uniquename-sentinel* workspace from the **Primary Log Analytics workspace** drop-down list.
1. Select the **Remediation** tab and check the **Create a remediation task** box.
1. Select the **Review + Create** button to review the configuration.
1. Select **Create** to finish.

> [!NOTE]
> The connector for Azure Activity uses policy assignments, so it might take 15 to 30 minutes to display a status of **Connected**.
