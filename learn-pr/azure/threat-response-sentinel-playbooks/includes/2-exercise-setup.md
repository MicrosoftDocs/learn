The Create an Azure Sentinel playbook exercise in this module is an optional unit. However, if you want to perform this exercise, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following tasks.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware you might incur costs in your Azure Subscription. To estimate the cost, refer to [Azure Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/).

## Task 1: Deploy Azure Sentinel

1. Select the following link:

    [![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMicrosoftDocs%2Fmslearn-security-ops-sentinel%2Fmain%2Fmslearn-threat-response-sentinel-playbooks%2Fsentinel-template.json?azure-portal=true)

    You're prompted to sign in to Azure.
1. On the **Custom deployment** page, provide the following information:

    |||
    | --- | --- |
    | Subscription | Select your Azure subscription. |
    | Resource Group | Select Create new and provide a name for the resource group such as azure-sentinel-rg.|
    | Region | From the drop-down menu, select the region where you want to deploy the Azure Sentinel. |
    | Workspace name  | Provide a unique name for the Azure Sentinel workspace such as *yourname*-sentinel. |
    | Location | Accept the default value of [resourceGroup().location]. |
    | Simplevm Name | Accept the default value of simple-vm.|
    | Simplevm Windows OS Version | Accept the default value of 2016-Datacenter.|

1. Select **Review + create**, and then select **Create**.

    :::image type="content" source="../media/02-custom-deployment.png" alt-text="Screenshot of the Custom Deployment page." border="true":::

    > [!Note]
    > Wait for the deployment to complete. The deployment should take less than five minutes.

## Task 2: Check the resources created

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. Sort the list of resources by **Type**.
4. The resource group should contain the resources displayed in the following table.

    |Name|Type|Description|
    |---|---|---|
    |*yourname*-sentinel|Log Analytics workspace|Log Analytics workspace used by Azure Sentinel.|
    |simple-vmNetworkInterface|Network interface|Network interface for the VM.|
    |SecurityInsights(*yourname*-sentinel)|Solution|Security insights for Azure Sentinel.|
    |st1*xxxxx*|Storage account|Storage account used by the virtual machine.|
    |simple-vm|Virtual machine|Virtual machine used in the demonstration.|
    |vnet1|Virtual network|Virtual network for the VM.|

> [!Note]
> The resources deployed and configuration steps completed in this exercise are required in the next exercise. If you intended completing the next exercise do not delete the resources from this exercise.

## Task 3: Configure Azure Sentinel Connectors

1. In the Azure portal, search for **Azure Sentinel**, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel | Overview** page, on the menu bar, in the **Configuration** section, select **Data connectors**.
3. In the **Data connectors** pane, search for and select **Azure Activity**. In the details pane, select **Open connector page**.
4. In the **Azure Activity** pane, select the **Configure Azure Activity logs** link.
5. Select your subscription, and then select **Connect**.
6. When you receive a status of **Connected**, close all open panels to return to the **Azure Sentinel | Data connector** panel.

    :::image type="content" source="../media/02-azure-sentinel-connector.png" alt-text="Screenshot that displays the Azure Sentinel connector." border="true":::

    > [!Note]
    > The connector for Azure Activity could take 15 minutes until Azure Sentinel displays a date. You can continue performing the rest of the steps and continue with the subsequent units in this module.

## Task 4: Create an analytics rule

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Azure Sentinel workspace.
2. On the **Azure Sentinel** page, on the menu bar, in the **Configuration** section, select **Analytics**.
3. On the **Azure Sentinel | Analytics** page, select **Create** and then select **Scheduled Query Rule**.
4. On the **General** page, provide the inputs in the following table, and then select  **Next: Set rule logic >**.

    |||
    | --- | --- |
    | Name | Provide a descriptive name such as **Delete Virtual Machines** to explain what type of suspicious activity the alert detects. |
    | Description | Enter a detailed description that will help other security analysts understand what the rule does. |
    | Tactics | From the **Tactics** drop-down menu, choose **Initial Access** category to classify the rule following the MITRE tactics. |
    | Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
    | Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generates a large number of false positives. |
    
5. On the **Set rule logic** page, in the **Rule query** section, enter the following query:

    ```kusto
      AzureActivity
      | where OperationName == 'Delete Virtual Machine'
      | where ActivityStatus == 'Accepted'
      | extend AccountCustomEntity = Caller
      | extend IPCustomEntity = CallerIpAddress
    ```

6. In the **Query Scheduling** section, you can configure how often the query should run. Select query to run on every 5 min.
7. Accept the default values for all other settings and then select **Next: Incident setting (Preview)**.
8. On the **Incident setting (preview)** tab, ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule. And then select **Next: Automated response**.
9. On the **Automated response** tab, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contain a Logic App Azure Sentinel connector are displayed.
10. Select **Next: Review**.
11. On the **Review and Create** page, verify that the validation passed, and then select **Create**.

> [!NOTE]
> You can learn more about Azure Sentinel analytics rules in the "Threat detection with Azure Sentinel analytics" module.
