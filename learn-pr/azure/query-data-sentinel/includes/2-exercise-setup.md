The Query and visualize data in Azure Sentinel exercise in this module is an optional unit. However, if you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Azure Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/).

1. Select the following link:

    [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-query-data-sentinel%2Fsentinel-template.json?azure-portal=true)

    You're prompted to sign in to Azure.
1. On the **Custom deployment** page, provide the following information:

    |Name|Description|
    |---|---|
    |Subscription|Select your Azure subscription.|
    |Resource Group|Select **Create new** and provide a name for the resource group such as **azure-sentinel-rg**.|
    |Locations|From the drop-down menu, select the location where you want to deploy Azure Sentinel.|
    |Workspace name|Provide a unique name for the Azure Sentinel Workspace such as ***yourname*-sentinel**. |
    |Location|Accept the default value of **[resourceGroup().location]**.|
    |Simplevm Name|Accept the default value of **simple-vm**.|
    |Simplevm Windows OS Version|Accept the default value of **2016-Datacenter**.|

1. Select **Review + create**, and then select **Create**.

    :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the Custom Deployment page." border="true":::

    > [!NOTE]
    > Wait for the deployment to complete. The deployment should take less than 5 minutes.

## Task 2: Check the resources created

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. Sort the list of resources by **Type**.
4. The resource group should contain the resources listed in the following table.

    |Name|Type|Description|
    |---|---|---|
    |*yourname*-sentinel|Log Analytics workspace|Log Analytics workspace used by Azure Sentinel.|
    |simple-vmNetworkInterface|Network interface|Network interface for the VM.|
    |SecurityInsights(*yourname*-sentinel)|Solution|Security insights for Azure Sentinel.|
    |st1*xxxxx*|Storage account|Storage account used by the virtual machine.|
    |simple-vm|Virtual machine|Virtual machine used in the demonstration.|
    |vnet1|Virtual network|Virtual network for the VM.|
    
> [!NOTE]
> The resources deployed and configuration steps completed in this exercise are required in the next exercise. If you intended completing the next exercise do not delete the resources from this exercise.

## Task 3: Configure Azure Sentinel connectors

In this task, you will deploy an Azure Sentinel connector to Azure Activity.

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel** page, on the menu bar, in the **Configuration** section, select **Data connectors**.
3. In the **Data connectors** pane, search and select **Azure Activity**. 
4. In the details pane, select **Open connector page**.
5. In the **Azure Activity** pane, select the **Configure Azure Activity logs** link.
6. Select your subscription, and then select **Connect**.
7. When you receive a status of **Connected**, close all open panels to return to the **Azure Sentinel | Data connector** panel.

    :::image type="content" source="../media/02-azure-sentinel-connector.png" alt-text="Screenshot of the Azure Sentinel Data connectors page." border="true":::

> [!NOTE]
> The connector for Azure Activity could take 15 minutes to deploy. You can proceed with the rest of the steps in the exercise and with the subsequent units in this module.

