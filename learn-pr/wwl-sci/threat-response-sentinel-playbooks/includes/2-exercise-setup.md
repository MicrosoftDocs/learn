
The Create a Microsoft Sentinel playbook exercise in this module is an optional unit. However, if you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Microsoft Sentinel Pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/).

## Task 1: Deploy Microsoft Sentinel

1. Select the following link:

    [![Deploy To Azure.](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-threat-response-sentinel-playbooks%2Fsentinel-template.json?azure-portal=true)

    You're prompted to sign in to Azure.

1. On the **Custom deployment** page, provide the following information:

    | Label | Description |
    | --- | --- |
    | Subscription | Select your Azure subscription. |
    | Resource Group | Select Create new and provide a name for the resource group such as `azure-sentinel-rg`.|
    | Region | From the drop-down menu, select the region where you want to deploy the Microsoft Sentinel. |
    | Workspace name | Provide a unique name for the Microsoft Sentinel workspace such as `<yourName>-Sentinel`, where *\<yourName>* represents the workspace name that you chose in the previous task. |
    | Location | Accept the default value of **[resourceGroup().location]**. |
    | Simplevm Name | Accept the default value of **simple-vm**.|
    | Simplevm Windows OS Version | Accept the default value of **2016-Datacenter**.|

    :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the custom deployment inputs for a Microsoft template." border="true":::

1. Select **Review + create**, and then, when the data has been validated select **Create**.

     > [!NOTE]
     > Wait for the deployment to complete. The deployment should take less than five minutes.

    :::image type="content" source="../media/02-custom-deployment-success.png" alt-text="Screenshot of the successful custom deployment." border="true":::

## Task 2: Check the resources created

1. On the Deployment Overview page, select  **Go to resource group**. The resources for your custom deployment appear.

1. Select **Home** and in **Azure services**, search for and select **Resource groups**.

1. Select **azure-sentinel-rg**.

1. Sort the list of resources by **Type**.

1. The resource group should contain the resources displayed in the following table.

    | Name | Type | Description |
    | --- | --- |
    | `<yourName>-Sentinel` |Log Analytics workspace|Log Analytics workspace used by Microsoft Sentinel, where *\<yourName>* represents the workspace name that you chose in the previous task. |
    | `simple-vmNetworkInterface` |Network interface|Network interface for the VM. |
    | `SecurityInsights(<yourName>-Sentinel)` |Solution|Security insights for Microsoft Sentinel. |
    | `st1<xxxxx>` |Storage account|Storage account used by the virtual machine. |
    | `simple-vm` |Virtual machine|Virtual machine (VM) used in the demonstration. |
    | `vnet1` |Virtual network|Virtual network for the VM. |

> [!NOTE]
> The resources deployed and configuration steps completed in this exercise are required in the next exercise. If you intended completing the next exercise do not delete the resources from this exercise.

## Task 3: Configure Microsoft Sentinel Connectors

1. In the Azure portal, search for **Microsoft Sentinel**, and then select the previously created Microsoft Sentinel workspace.

1. On the **Microsoft Sentinel | Overview** pane, in the left menu, under **Configuration**, select **Data connectors**.

1. In the **Data connectors** pane, search for and select **Azure Activity**. In the details pane, select **Open connector page**.

1. In the **Azure Activity** pane, select the **Configure Azure Activity logs** link.

1. Select your subscription, and then select **Connect**.

1. When you receive a status of **Connected**, close all open panels to return to the **Microsoft Sentinel | Data connector** panel.

    :::image type="content" source="../media/02-azure-sentinel-connector.png" alt-text="Screenshot that displays the Microsoft Sentinel connector." border="true":::

    > [!Note]
    > The connector for Azure Activity could take 15 minutes until Microsoft Sentinel displays a date. You can continue performing the rest of the steps in this unit and subsequent units in this module.

## Task 4: Create an analytics rule

1. In the Azure portal, search for and select **Microsoft Sentinel**, and then select the previously created Microsoft Sentinel workspace.

1. On the **Microsoft Sentinel** page, on the menu bar, in the **Configuration** section, select **Analytics**.

1. On the **Microsoft Sentinel | Analytics** page, select **Create** and then select **Scheduled Query Rule**.

1. On the **General** page, provide the inputs in the following table, and then select  **Next: Set rule logic >**.

    | Label | Description |
    | --- | --- |
    | Name | Provide a descriptive name, such as **Delete Virtual Machines**, to explain what type of suspicious activity the alert detects. |
    | Description | Enter a detailed description that will help other security analysts understand what the rule does. |
    | Tactics | From the **Tactics** drop-down menu, choose **Initial Access** category to classify the rule following the MITRE tactics. |
    | Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
    | Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generates a large number of false positives. |

1. On the **Set rule logic** page, in the **Rule query** section, enter the following query:

    ```kusto
      AzureActivity
      | where OperationName == 'Delete Virtual Machine'
      | where ActivityStatus == 'Accepted'
      | extend AccountCustomEntity = Caller
      | extend IPCustomEntity = CallerIpAddress
    ```

1. In the **Query Scheduling** section, you can configure how often the query should run. Select query to run on every 5 min.

1. Accept the default values for all other settings and then select **Next: Incident setting (Preview)**.

1. On the **Incident setting (preview)** tab, ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule. And then select **Next: Automated response**.

1. On the **Automated response** tab, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contain a Logic App Microsoft Sentinel connector are displayed.

1. Select **Next: Review**.

1. On the **Review and Create** page, verify that the validation passed, and then select **Create**.

> [!NOTE]
> You can learn more about Microsoft Sentinel analytics rules in the "Threat detection with Microsoft Sentinel analytics" module.

