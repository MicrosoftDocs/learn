This exercise is optional. To complete it, you need access to an Azure subscription where you can create Azure resources. If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

To deploy the prerequisites for the exercise, perform the following steps.

1. Click the link below.

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F101-azure-sentinel%2Fazuredeploy.json)

2. You will be promted to sign in your Azure subscription.
3. In the **Custom deployment** page provide the following information:

|||
| --- | --- |
| **Subscription** | Select your Azure subscription |
| **Resource Group*** | Select **Create new** and provide name for the resource group, for example **azure-sentinel-rg** .|
| **Locations*** | From the drop-down menu select the location where you deployng the Azure Sentinel. |
| **Workspace name***  | Provide unique name for the Azure Sentinel Workspace, for example ***yourname*-sentinel**. |
| **Location** | Accept the default value **[resourceGroup().location]**. |
| **Simplevm Name** | Accept the default value **simple-vm**.|
| **Simplevm WIndows OS Version** | Accept the default value **2016-Datacenter**.|

4. Select the checkbox for **I agree to the terms and conditions stated above** and then select **Purchase**

![Screenshot that present Custom Deployment](../media/07-Custom-Deployment.PNG)

> [!Note]

> Wait for the deployment to complete. The deployment should take less than 5 minute.

**Task 2: Configure Azure Sentinel Connectors**

In this task, you will deploy Azure Sentinel connector to Azure Activity.

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** page, on the left side in the menu bar, in the **Configuration** section, select **Data connectors.**
3. In the **Data connectors** pane, search for and select **Azure Activity.** In the detailed pane on the right site click on **Open connector page.**
4. In the **Azure Activity** pane, click on the link **Configure Azure Activity logs**.
5. Click on your subscription and then click **Connect.**
6. When you receive status **Connected** , you can close all open blades to return on **Azure Sentinel| Data connector** blade.

![Screenshot that present Azure Sentinel Connector](../media/07-Azure-Sentinel-Connector.PNG)

> [!Note]

> The connector for Azure Activity could take 15 minutes until shows some date in the Azure Sentinel.

## Check resources created

1. In the Azure portal, search for **Resource groups**.
1. Select **azure-sentinel-rg**.
1. Sort the list of resources by **Type**.
1. The resource group should contain the resources shown in this table.

    | Name  | Type  | Description |
    |---|---|---|
    | ***yourname*-sentinel** | Log Analytics Workspace | Log Analytics workspace used by Azure Sentinel |
    | **SecurityInsights(*yourname*-sentinel** | Solution | Security insights for Azure Sentinel |
    | **simple-vm**| Virtual machine | Virtual machine used in the demonstration |
    | **simple-vmNetworkInterface** | Network interface | Network interface for the  VM. |
    | **st1*xxxxx*** | Storage account | Storage account used by the virtual machine. |
    | **vnet1** | Virtual network | Virtual network for the VM. |

## Exercise: Threat detection with Azure Sentinel Analytics

As a security engineer working for Contoso, you recently notice that significant number of VMs has been deleted from your Azure subscription. You want to analyze that occurrence in the future and been alerted when similar activity occurs.
You decide to implement an analytics rule to create an incident when someone delete existing VM.

In this exercise, you will explore an Azure Sentinel analytics rule. You will perform the following tasks:
- Create an incident rule from an existing template.
- Create a scheduled query rule by using your own KQL code.
- Adjust KQL from an existing analytic rule.

> [!NOTE]
> If you choose to perform the exercise in this module be aware you may incur costs in your Azure Subscription. To estimate the cost refer to [Azure Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/azure-sentinel/)

## Task 1: Create an analytics rule from analytics rule wizard.** 

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the menu bar, in the **Configuration** section, select **Analytics**.
3. In the **Azure Sentinel | Analytics** blade, select **Create** and then select **Scheduled Query Rule**.
4. In the **General** page provide the inputs in the following table and then select  **Next:Set rule logic.**

|||
| --- | --- |
| Name | Provide a descriptive name to explain what type of suspicious activity the alert detects. |
| Description | Enter a detailed description that will help other security analysts understand what the rule does. |
| Tactics | From the **Tactics** drop-down menu, choose one among the available categories of attacks to classify the rule following the MITRE tactics. |
| Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
| Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generate large number of false positives. |

![Screenshot Analytics Rule wizard-Create new rule](../media/07-Analytics-rule-wizzard-Create-new-rule.PNG)

6.In the **Set rule logic** page, int the **Rule query** section enter the following query:

```kusto
AzureActivity
| where OperationName == 'Delete Virtual Machine'
| where ActivityStatus == 'Accepted'
| extend AccountCustomEntity = Caller
| extend IPCustomEntity = CallerIpAddress
```

7. In the **Result simulation** section **Test with current data** and observe the results.

![Screenshot Analytics Rule Logic](../media/07-Rule-Logic.PNG)

8. In the  **Map entities**  section, you can define the entities that are returned as part of the query rule and that you can use to perform in-depth analysis.
9. In the **Query Scheduling** section, you can configure how often the query should run, and how far in history to look back. Accept the default values.
10. In the **Alert threshold** section, you can specify the number of positive results that can be returned for the rule before an alert gets generated. Accept the default values.
11. In the **Event grouping** section, accept the default selection to **Group all events into a single alert.**
12. In the **Suppression** section, you can configure **Stop running the Query after the alert is generated** to  **On**  or  **Off.** 
13. Accept the default values and then select **Next: Incident setting (preview)**.
9. In the **Incident setting (preview)** page, ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule.
10. In the **Alert grouping** section, select **Enabled** to group related alerts into incidents, and ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
11. Ensure that **Re-open closed matching incidents** is **Disabled**, and then select **Next: Automated response**.

![Screenshot Analytics Incident Settings](../media/07-Incident-Settings.PNG)

12. In the **Automated response**  page, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contains Logic App Azure Sentinel connector are displayed.
12. Select **Next:Review**.
14. In the **Review and Create** page, verify that the validation was successful, and then select **Create**.

**Task 2: Create Analytics rule from existing template.**

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the menu bar, in the **Configuration** section, select **Analytics**.
3. In the **Azure Sentinel | Analytics** blade, select **Rule templates.**
4. In the search field, enter and select **Create incidents based on Azure Security Center alerts**.  
5. In the details pane, select **Create rule**.
6. In the **General** pane, observe the name of the analytics rule, and verify that the **Status** of the rule is **Enabled**.
7. In the **Analytics rule logic** section, verify that in the drop-down menu for the Microsoft security service, **Azure Security Center** is selected.
8. In the **Filter by severity** section, select **Custom**, and then in the drop-down menu, select **High** and **Medium**.
9. If you want to further filter the alerts from Azure Security Center, you can add additional text in **Include specific alerts** or **Exclude specific alerts**.
10. Select **Next:Review**, and then on the **Review and Create** page, select **Create**.

## Results

After completing this exercise, you will have created an incident rule from an existing template and created a scheduled query rule by using your own query code.

## Clean Up the Resources

1. In the Azure portal, search for **Resource groups**.
1. Select **azure-sentinel-rg**.
1. In the header bar select **Delete resource group**.
1. In the **TYPE THE RESOURCE GROUP NAME:** field type the name of the resource group **azure-sentinel-rg** and select **Delete**.


