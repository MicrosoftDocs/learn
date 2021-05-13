## Exercise: Threat detection with Azure Sentinel Analytics

As a security engineer working for Contoso, you recently noticed that a significant number of VMs has been deleted from your Azure subscription. You want to analyze this  occurrence and be alerted when a similar activity occurs in the future. You decide to implement an analytics rule to create an incident when someone deletes an existing VM.

In this exercise, you'll explore an Azure Sentinel analytics rule and perform the following tasks:
- Create an incident rule from an existing template.
- Invoke an incident and review the associated actions.
- Create an analytics rule from an existing template.

> [!NOTE] 
> You need to complete the Exercise Setup unit, in order to be able to complete this exercise. If you have not done so, complete it now, and then continue with the exercise steps.

### Task 1: Create an analytics rule from the analytics rule wizard 

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Azure Sentinel workspace.
2. Open **Azure Sentinel**, on the menu bar, in the **Configuration** section, select **Analytics**.
3. Open **Azure Sentinel | Analytics**, select **Create** and then select **Scheduled query rule**.
4. Open **General** page, provide the inputs in the following table, and then select  **Next: Set rule logic**. 

  |||
  | --- | --- |
  | Name | Provide a descriptive name to explain what type of suspicious activity the alert detects. |
  | Description | Enter a detailed description that will help other security analysts understand what the rule does. |
  | Tactics | From the **Tactics** drop-down menu, choose one among the available categories of attacks to classify the rule following the MITRE tactics. |
  | Severity | Select the **Severity** drop-down menu to categorize the level of importance of the alert as one of four options: High, Medium, Low, or Informational. |
  | Status | Specify the status of the rule. By default, the status is **Enable.** You can select **Disable** to disable the rule if it generates large numbers of false positives. |

  :::image type="content" source="../media/07-analytics-rule-wizard-create-new-rule.png" alt-text="Screenshot Analytics Rule wizard-Create new rule." border="true":::

5. On the **Set rule logic** page, in the **Rule query** section, enter the following query:

  ```kusto
  AzureActivity
  | where OperationName == 'Delete Virtual Machine'
  | where ActivityStatus == 'Accepted'
  | extend AccountCustomEntity = Caller
  | extend IPCustomEntity = CallerIpAddress
  ```

6. In the **Result simulation** section, select **Test with current data**, and then observe the results.

  :::image type="content" source="../media/07-rule-logic.png" alt-text="Screenshot Analytics Rule Logic." border="true":::

7. In the  **Map entities**  section, you can define the entities that are returned as part of the query rule and that you can use to perform in-depth analysis.
8. In the **Query Scheduling** section, you can configure how often the query should run, and how far in history to search. Select query to run on every 5 min.
9. In the **Alert threshold** section, you can specify the number of positive results that can be returned for the rule before an alert gets generated. Accept the default values.
10. In the **Event grouping** section, accept the default selection to **Group all events into a single alert.**
11. In the **Suppression** section, you can configure **Stop running the Query after the alert is generated** to  **On**  or  **Off.** 
12. Accept the default values and then select **Next: Incident setting (Preview)**.
13. In the **Incident setting (preview)** page, ensure that **Enabled** is selected for creation of incidents from alerts triggered by this analytics rule.
14. In the **Alert grouping** section, select **Enabled** to group related alerts into incidents, and ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
15. Ensure that **Reopen closed matching incidents** is **Disabled**, and then select **Next: Automated response**.

  :::image type="content" source="../media/07-incident-settings.png" alt-text="Screenshot Analytics Incident Settings." border="true":::

16. In the **Automated response**  page, you can select a playbook to run automatically when the alert is generated. Only the playbooks that contain Logic App Azure Sentinel connector are displayed.
17. Select **Next: Review**.
18. In the **Review and create** page, verify that the validation was successful, and then select **Create**.

### Task 2: Invoke an incident and review the associated actions

1. In the Azure portal, in the **Search resources, services, and docs** text box, enter **virtual machines**, and then select **Enter**.
2. On the **Virtual machines** page, locate and select the **simple-vm** virtual machine, and then on the header bar, select **Delete**. In the **Delete virtual machine** prompt select **Yes**.
3. In the **Delete virtual machine** prompt, select **Yes** to delete the virtual machine.

> [!Note]
> This task creates an incident based on the analytics rule that you created in Task 1. Incident creation can take up to 15 minutes. You can proceed with rest of the steps of this unit and then observe the results at later time.

### Task 3: Create an analytics rule from an existing template

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace.
2. Open **Azure Sentinel**, on the menu bar, in the **Configuration** section, select **Analytics**.
3. Open **Azure Sentinel | Analytics**, select **Rule templates.**
4. In the search field, enter and select **Create incidents based on Azure Security Center alerts**.  
5. In the details pane, select **Create rule**.
6. In the **General** pane, observe the name of the analytics rule, and verify that the **Status** of the rule is **Enabled**.
7. In the **Analytics rule logic** section, verify that in the drop-down menu for the Microsoft security service, **Azure Security Center** is selected.
8. In the **Filter by severity** section, select **Custom**, and then in the drop-down menu, select **High** and **Medium**.
9. If you want to further filter the alerts from Azure Security Center, you can add additional text in **Include specific alerts** or **Exclude specific alerts**.
10. Select **Next: Review**, and then on the **Review and Create** page, select **Create**.

### Results

After completing this exercise, you'll have created an incident rule from an existing template and created a scheduled query rule by using your own query code.

After you finished with the exercise you should delete resources to avoid incurring costs.

### Clean up the resources

1. In the Azure portal, search for **Resource groups**.
1. Select **azure-sentinel-rg**.
1. On the header bar, select **Delete resource group**.
1. In the **TYPE THE RESOURCE GROUP NAME:** field, enter the name of the resource group **azure-sentinel-rg** and select **Delete**. 
