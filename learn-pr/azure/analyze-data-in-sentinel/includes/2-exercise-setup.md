The Threat detection with Azure Sentinel Analytics exercise in this module is an optional unit. However, if you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Azure Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/)

## Task 1: Deploy Azure Sentinel using ARM template 

1. Select the following link:

    [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-analyze-data-in-sentinel%2Fsentinel-template.json?azure-portal=true)

    You're prompted to sign in to Azure.
1. On the **Custom deployment** page, provide the following information:

    |||
    | --- | --- |
    | **Subscription** | Select your Azure subscription. |
    | **Resource Group** | Select **Create new** and provide a name for the resource group such as **azure-sentinel-rg**.|
    | **Region** | From the drop-down menu, select the location where you want to deploy the Azure Sentinel.|
    | **Workspace name**  | Provide a unique name for the Azure Sentinel Workspace such as ***yourname*-sentinel**. |
    | **Location** | Accept the default value of **[resourceGroup().location]**. |
    | **Simplevm Name** | Accept the default value of **simple-vm**.|
    | **Simplevm Windows OS Version** | Accept the default value of **2016-Datacenter**.|

1. Select the **Review + create**, and then select **Create**.

    :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the Custom Deployment page." border="true":::

    > [!Note]
    > Wait for the deployment to complete. The deployment should take less than 5 minutes.

## Task 2: Check the resources created

1. In the Azure portal, search for **Resource groups**.
1. Select **azure-sentinel-rg**.
1. Sort the list of resources by **Type**.
1. The resource group should contain the resources listed in the following table.

    | Name  | Type  | Description |
    |---|---|---|
    | ***yourname*-sentinel** | Log Analytics workspace | Log Analytics workspace used by Azure Sentinel. |
    | **SecurityInsights(*yourname*-sentinel** | Solution | Security insights for Azure Sentinel. |
    | **simple-vm**| Virtual machine | Virtual machine used in the demonstration. |
    | **simple-vmNetworkInterface** | Network interface | Network interface for the  VM. |
    | **st1*xxxxx*** | Storage account | Storage account used by the virtual machine. |
    | **vnet1** | Virtual network | Virtual network for the VM. |

> [!Note]
> The resources deployed and configuration steps completed in this exercise are required in the next exercise. If you intended completing the next exercise do not delete the resources from this exercise.

## Task 3: Configure Azure Sentinel connectors 

In this task, you'll deploy an Azure Sentinel connector to Azure Activity.

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel** page, on the menu bar on the left, in the **Configuration** section, select **Data connectors**.
3. In the **Data connectors** pane, search for and select **Azure Activity**. In the details pane, select **Open connector page**.
4. In the **Azure Activity** pane, select the **Configure Azure Activity logs** link.
5. Select your subscription, and then select **Connect**.
6. When you receive a status of **Connected**, close all open panels to return to **Azure Sentinel | Data connector**.

:::image type="content" source="../media/07-azure-sentinel-connector.png" alt-text="Screenshot of the Azure Sentinel connector." border="true":::

> [!Note]
> The connector for Azure Activity could take 20 minutes to send data in Azure Sentinel. You can proceed with rest of the steps and with other units of this module. 


