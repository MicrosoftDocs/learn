To complete this optional exercise, you need access to an Azure subscription to create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn) before you begin.

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
    | **Simplevm Windows OS Version** | Accept the default value **2022-Datacenter**.|

1. Select **Review + create**, and then select **Create**.

   :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the Custom Deployment page." border="true":::

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

## Configure Azure Activity logs

In this task, you use a diagnostic setting to send the Azure Activity log to the Microsoft Sentinel workspace.

1. In the Azure portal, search for and select **Monitor**.
1. On the **Monitor** page, select **Activity log**, and then select **Export Activity Logs**.
1. Select the subscription that contains the exercise resources, and then select **Add diagnostic setting**.
1. Enter a name for the diagnostic setting.
1. Under **Categories**, select the activity log categories that you want to collect.
1. Under **Destination details**, select **Send to Log Analytics workspace**, and then select the subscription and workspace that you created for Microsoft Sentinel.
1. Select **Save**.

> [!NOTE]
> Azure Activity log data can take up to 90 minutes to begin flowing to the workspace.
