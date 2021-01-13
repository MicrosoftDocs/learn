As a security engineer working for Contoso, you recently noticed that a significant number of VMs were deleted from your Azure subscription. You want to analyze this occurrence and be alerted when a similar activity occurs in the future. You decide to implement an analytics rule to create an incident when someone deletes an existing VM. You can then investigate the incident to determine the details, and close the incident when you're finished.

In this exercise, you'll create an Azure Sentinel analytics rule, delete a VM, and investigate the incident created by the rule. 

> [!NOTE]
> To complete this exercise, you need to have completed the setup exercise earlier in the module. If you haven't done that, please do it now.

## Task 1: Create an analytics rule from the wizard

In this task, you'll create an analytics rule that will create an incident when a VM is deleted in the Contoso Azure subscription.

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. In the **Configuration** section, select **Analytics**.
3. Select **Azure Sentinel | Analytics**, select **Create**, and then select **Scheduled query rule**.
4. On the **General** page of the Analytics Rule wizard, provide the following inputs, and then select **Next: Set rule logic**.

   - **Name**: **Deleted VMs**
   - **Description**: Enter a detailed description that will help other security analysts understand what the rule does.
   - **Tactics**: Select **Impact**.
   - **Severity**: Select **Medium**.
   - **Status**: Select **Enable**.

   :::image type="content" source="../media/6-Analytics-rule-wizard-Create-new-rule.PNG" alt-text="Screenshot of the page for creating a new rule in the Analytics Rule wizard." border="true":::

5. On the **Set rule logic** page, in the **Rule query** section, enter the following query:

    ```kusto
    AzureActivity
    | where OperationName == 'Delete Virtual Machine'
    | where ActivityStatus == 'Accepted'
    | extend AccountCustomEntity = Caller
    | extend IPCustomEntity = CallerIpAddress
    ```

6. In the **Result simulation** section, select **Test with current data**, and then observe the results.
7. Still on the **Set rule logic** page, scroll down to view the following configuration options:

   - In the  **Map entities** section, you can define the entities that are returned as part of the query rule and that you can use to perform in-depth analysis. Use the default values.
   - In the **Query Scheduling** section, you can configure how often the query should run, and how far back in history to observe. Set **Run query every** to **5 minutes**.
   - In the **Alert threshold** section, you can specify the number of positive results that can be returned for the rule before an alert is generated. Use the default values.
   - In the **Event grouping** section, accept the default selection **Group all events into a single alert**.
   - In the **Suppression** section, you can configure **Stop running the query after the alert is generated** to  **On**  or  **Off**. Accept the default values.
  
8. Select **Next: Incident setting (Preview)**.
9. On the **Incident setting (Preview)** page, ensure that **Create incidents from alerts triggered by this analytics rule** is set to **Enabled**.
10. In the **Alert grouping** section, select **Enabled** to group related alerts into incidents. Ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
11. Ensure that **Reopen closed matching incidents** is **Disabled**, and then select **Next: Automated response**.
12. On the **Automated response** page, select **Next: Review**.
13. On the **Review and Create** page, verify that the validation was successful, and then select **Create**.

## Task 2: Delete a VM

In this task, you'll delete a VM to test rule detection and incident creation.

1. In the Azure portal, search for and select **Virtual machines**.
2. On the **Virtual machines** page, select the check box beside the virtual machine labeled **simple-vm**, and then select **Delete** from the toolbar.
3. On the **Delete Resources** pane, enter **yes** in the **Confirm delete** field, and then select **Delete**.

## Task 3: Investigate an incident

In this task, you'll investigate the incident created when you deleted the VM in Task 2. It might take up to 20 minutes for the incident to appear in Azure Sentinel.

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Azure Sentinel workspace.
2. In the **Threat management** section, select **Incidents**.
3. On the **Incidents** page, select the incident with the title **Deleted VMs**.
4. On the details pane, observe the details of the incident, including **Owner**, **Status**, and **Severity**. Then:
   
   1. Select **Owner** > **Assign to me** > **Apply**.
   1. Select **Status** > **Active** > **Apply**.
   1. Select **View full details**.
5. On the **Incident** page, under the **Evidence** section, observe the totals for **Events**, **Alerts**, and **Bookmarks**.
6. At the bottom of the pane on the left side, select **Investigate**.
7. On the **Investigation** page:

   1. Select **Deleted VMs** in the center of the page and observe the details of the incident.
   1. Select the entity on the graph that represents a user. Note that this is your user account, indicating that you deleted the VM.
   1. Select **Status** > **Closed**.
8. In the **Select classification** drop-down menu, select **Benign Positive - suspicious but expected**.
9. In the **Comment** field, enter **Testing incident creation and resolution steps**, and then select **Apply**.
10. At the top of the page, select **Azure Sentinel** to return to the Azure Sentinel home page, and then select **Incidents** on the menu pane.
11. On the **Incidents** page, observe that **Open incidents** and **Active incidents** now have values of 0.

## Results

After you complete this exercise, you'll have created an Azure Sentinel analytics rule, deleted a VM, and investigated the incident created by the rule.

## Clean up resources

To avoid incurring costs, delete the Azure resources that you created in this exercise when you're finished with them. To do this, complete the following steps:

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. On the header bar, select **Delete resource group**.
4. In the **TYPE THE RESOURCE GROUP NAME** field, enter **azure-sentinel-rg** and select **Delete**.
