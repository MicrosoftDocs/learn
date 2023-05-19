This *query and visualize data* exercise is an optional unit. If you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware that you might incur costs in your Azure Subscription. To estimate the cost, refer to [Microsoft Sentinel Pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).

To deploy the prerequisites for the exercise, perform the following tasks.

## Task 1: Create resources

1. Select the following link:

   [![Deploy To Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-query-data-sentinel%2Fsentinel-template.json?azure-portal=true)

   You're prompted to sign in to Azure.

1. On the **Custom deployment** page, provide the following information:

   | Name | Description |
   |:-----|:------------|
   | Subscription | Select your Azure subscription. |
   | Resource group | Select **Create new** and provide a name for the resource group such as *azure-sentinel-rg*. |
   | Region | From the dropdown menu, select the location where you want to deploy Microsoft Sentinel. |
   | Workspace Name | Provide a unique name for the Microsoft Sentinel Workspace such as *\<yourName>-sentinel*. |
   | Location | Accept the default value of **[resourceGroup().location]**. |
   | Simplevm Name | Accept the default value of **simple-vm**. |
   | Simplevm Windows OS Version | Accept the default value of **2016-Datacenter**. |

1. Select **Review + create**, and then select **Create**.

   :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the Custom Deployment page." border="true":::

   > [!NOTE]
   > Wait for the deployment to complete. The deployment should take less than 5 minutes.

## Task 2: Check the resources created

1. In the Azure portal, search for *Resource groups*.
1. Select **azure-sentinel-rg**.
1. Sort the list of resources by **Type**.
1. The resource group should contain the resources listed in the following table.

    |Name|Type|Description|
    |---|---|---|
    | \<yourName>-sentinel | Log Analytics workspace | Log Analytics workspace used by Microsoft Sentinel, with the workspace name that you chose in the previous task. |
    | simple-vmNetworkInterface | Network Interface | Network interface for the virtual machine (VM). |
    | SecurityInsights(\<yourName>-sentinel) | Solution | Security insights for Microsoft Sentinel. |
    | st1*xxxxx* | Storage account | Storage account used by the VM. The random string *xxxxx* creates a unique storage account name. |
    | simple-vm | Virtual machine | Virtual machine used in the demonstration. |
    | vnet1 | Virtual network | Virtual network for the VM. |

> [!NOTE]
> The resources and configuration in this exercise are required in the next exercise. If you intend to complete the next exercise, don't delete these resources.

## Task 3: Configure Microsoft Sentinel connectors

In this task, you deploy a Microsoft Sentinel connector to Azure Activity.

1. In the Azure portal, search for and select **Microsoft Sentinel**. Select the Microsoft Sentinel workspace that you created in the previous task.
1. On the **Microsoft Sentinel** page, on the menu bar, under **Configuration**, select **Data connectors**.
1. In the **Data connectors** pane, search and select **Azure Activity**.
1. In the details pane, select **Open connector page**.

   :::image type="content" source="../media/02-azure-sentinel-connector.png" alt-text="Screenshot of the Microsoft Sentinel Data connectors page." border="true":::

1. In the **Azure Activity** screen, under **Instructions**, verify your **Prerequisites** and then follow the **Configuration** steps.
1. When you receive a status of **Connected**, close all open panels to return to the **Microsoft Sentinel | Data connector** panel.

> [!NOTE]
> The connector for Azure Activity could take 15 minutes to deploy. You can proceed with the rest of the steps in the exercise and with the subsequent units in this module.
