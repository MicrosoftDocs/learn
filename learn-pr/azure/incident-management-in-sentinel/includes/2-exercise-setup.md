To complete this optional exercise, you need access to an Azure subscription to create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

## Task 1: Deploy the Azure Resource Manager template for the exercise environment

1. Select the following link.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FWayPointVenturesOrg%2Ftemplates%2Fmain%2Fsentinel-deploy%2FSentinelTemplate.json)

2. You will be prompted to sign in to your Azure subscription.
3. On the **Custom deployment** page, provide the following information:

|||
| --- | --- |
| **Subscription** | Select your Azure subscription. |
| **Resource Group** | Select **Create new** and provide a name for the resource group, for example **azure-sentinel-rg**. |
| **Locations** | From the drop-down menu select the location where you are deploying Azure Sentinel. |
| **Workspace name**  | Provide a unique name for the Azure Sentinel workspace, for example ***yourname*-sentinel**. |
| **Location** | Accept the default value **[resourceGroup().location]**. |
| **Simplevm Name** | Accept the default value **simple-vm**. |
| **Simplevm Windows OS Version** | Accept the default value **2016-Datacenter**.|

4. Select the check box for **I agree to the terms and conditions stated above** and then select **Purchase**.

> [!Note]
> Wait for the deployment to complete. The deployment should take less than five minutes.

## Task 2: Check resources created

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. Sort the list of resources by **Type**.
4. The resource group should contain the resources displayed in this table.

    | Name  | Type  | Description |
    |---|---|---|
    | ***yourname*-sentinel** | Log Analytics workspace | Log Analytics workspace used by Azure Sentinel. |
    | **SecurityInsights(*yourname*-sentinel)** | Solution | Security insights for Azure Sentinel. |
    | **simple-vm**| Virtual machine | Virtual machine (VM) used in the demonstration. |
    | **simple-vmNetworkInterface** | Network interface | Network interface for the VM. |
    | **st1*xxxxx*** | Storage account | Storage account used by the VM. |
    | **vnet1** | Virtual network | Virtual network for the VM. |

## Task 3: Configure Azure Sentinel Connectors

In this task, you will deploy Azure Sentinel connector to Azure Activity.

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace.
2. In the **Azure Sentinel** page, on the menu bar, in the **Configuration** section, select **Data connectors.**
3. In the **Data connectors** pane, search for and select **Azure Activity.** In the **details** pane, select **Open connector page.**
4. In the **Azure Activity** pane, select the link **Configure Azure Activity logs**.
5. Select your subscription and then select **Connect.**
6. When you receive status **Connected**, you can close all open blades to return to **Azure Sentinel | Data connector** blade.

> [!Note]
> The connector for Azure Activity could take 15 minutes until it displays data in the Azure Sentinel.
