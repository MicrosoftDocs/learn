
To complete this optional exercise, you need access to an Azure subscription to create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware that you might incur costs in your Azure Subscription. To estimate the costs, see [Microsoft Sentinel pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).

To deploy the prerequisites for the exercise, follow the steps in these tasks.

## Task 1: Deploy the Azure Resource Manager template for the exercise environment

1. Select the following button:

    [![Deploy To Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-incident-management-sentinel%2Fsentinel-template.json?azure-portal=true)

    You'll be prompted to sign in to Azure.
1. On the **Custom deployment** page, provide the following information:

    | Name  | Description |
    | --- | --- |
    | **Subscription** | Select your Azure subscription. |
    | **Resource Group** | Select **Create new** and provide a name for the resource group: `azure-sentinel-rg`. |
    | **Locations** | From the drop-down menu, select the location where you're deploying Microsoft Sentinel. |
    | **Workspace name**  | Provide a unique name for the Microsoft Sentinel workspace: `<yourName>-Sentinel`. |
    | **Location** | Accept the default value, **[resourceGroup().location]**. |
    | **Simplevm Name** | Accept the default value, **simple-vm**. |
    | **Simplevm Windows OS Version** | Accept the default value, **2016-Datacenter**.|

1. Select **Review + create**, then select **Create**.

    > [!NOTE]
    > Wait for the deployment to finish. The deployment should take less than five minutes.

## Task 2: Check created resources

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. Sort the list of resources by **Type**.
4. The resource group should contain the resources displayed in this table:

    | Name  | Type  | Description |
    |---|---|---|
    | `<yourName>-Sentinel` | Log Analytics workspace | Log Analytics workspace that Microsoft Sentinel uses, where *\<yourName>* represents the workspace name that you chose in Task 1. |
    | `simple-vmNetworkInterface` | Network interface | Network interface for the VM. |
    | `SecurityInsights(<yourName>-Sentinel)` | Solution | Security insights for Microsoft Sentinel. |
    | `simple-vm` | Virtual machine | Virtual machine (VM) used in the demonstration. |
    | `st1<xxxxx>` | Storage account | Storage account used by the VM, where *\<xxxxx>* represents a random string that's generated to create a unique storage account name. |
    | `vnet1` | Virtual network | Virtual network for the VM. |

## Task 3: Configure Microsoft Sentinel connectors

In this task, you'll deploy Microsoft Sentinel connectors to Azure Activity.

1. In the [Azure portal](https://portal.azure.com), search for and select Microsoft Sentinel, and then select the previously created Microsoft Sentinel workspace.
2. On the **Microsoft Sentinel** page, in the **Configuration** section on the menu bar, select **Data connectors**.
3. On the **Data connectors** pane, search for and select **Azure Activity**. On the **details** pane, select **Open connector page**.
4. On the **Azure Activity** pane, select the **Configure Azure Activity logs** link.
5. Select your subscription and then select **Connect**.
6. When you receive a status of **Connected**, you can return to **Microsoft Sentinel | Data connectors**.
7. On the **Microsoft Sentinel** | **Data connectors** pane, make sure the **Azure Activity** connector has a status of **Connected**.

> [!NOTE]
> The connector for Azure Activity might take 15-30 minutes until it displays a status of **Connected**.

