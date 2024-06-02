
As a Contoso security engineer, you need to analyze the deletions of virtual machines (VMs) from the Contoso Azure subscription, and be alerted when a similar activity occurs in the future. You decide to implement an analytics rule to create an incident when someone deletes an existing VM. You can then investigate the incident to determine the details, and close the incident when you're finished.

In this exercise, you create a Microsoft Sentinel analytics rule to detect when a VM is deleted. You then delete the VM you created at the beginning of this module, and investigate and resolve the incident the rule created.

To complete this exercise, make sure you finished the setup exercise at the beginning of the module and the Azure Activity connector now shows a status of **Connected**.

## Create an analytics rule from the wizard

Create an analytics rule that creates an incident when a VM is deleted in the Contoso Azure subscription.

1. In the Azure portal, search for and select **Microsoft Sentinel**, and then select the Microsoft Sentinel workspace you created.
1. On your Microsoft Sentinel page, select **Analytics** under **Configuration** in the left menu.
1. On the **Analytics** page, select **Create** > **Scheduled query rule**.

**General tab**

1. On the **General** tab of the wizard, provide the following information.

   - **Name**: Enter *Deleted VMs*.
   - **Description**: Enter a description to help others understand what the rule does.
   - **Tactics and techniques**: Select **Initial Access**.
   - **Severity**: Select **Medium**.
   - **Status**: Select **Enabled**.

   :::image type="content" source="../media/6-analytics-rule-wizard-create-new-rule.png" alt-text="Screenshot of the page for creating a new rule in the Analytics Rule wizard." border="true":::

1. Select **Next: Set rule logic**.

**Set rule logic tab**

1. On the **Set rule logic** tab, in the **Rule query** section, enter the following query:

    ```kusto
   AzureActivity
   | where OperationNameValue == "MICROSOFT.COMPUTE/VIRTUALMACHINES/DELETE"
   | where ActivityStatusValue == 'Success'
   | extend AccountCustomEntity = Caller
   | extend IPCustomEntity = CallerIpAddress
    ```

1. Scroll down to view or set the following configuration options:

   - Expand the  **Entity mapping** section to define the entities that return as part of the query rule, which you can use for in-depth analysis. For this exercise, use the default values.
   - In the **Query scheduling** section, configure how often the query should run, and how far back in history to observe. Set **Run query every** to **5 minutes**.
   - In the **Alert threshold** section, you can specify the number of positive results that can return for the rule before an alert is generated. Use the default value of **is greater than 0**.
   - In the **Event grouping** section, accept the default selection **Group all events into a single alert**.
   - In the **Suppression** section, for **Stop running the query after the alert is generated**, leave the default of **Off**.
   - In the **Results simulation** section, select **Test with current data**, and observe the results.

1. Select **Next: Incident settings**.

**Incident settings tab**

1. On the **Incident settings** tab, ensure that **Create incidents from alerts triggered by this analytics rule** is set to **Enabled**.
1. In the **Alert grouping** section, select **Enabled** to group related alerts into incidents. Ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
1. Ensure that **Reopen closed matching incidents** is **Disabled**.
1. Select **Next: Automated response**.

**Review and create**

1. Select **Next: Review**.
1. On the **Review and create** tab, when validation is successful, select **Create**.

## Delete a VM

To test rule detection and incident creation, delete the VM you created during setup.

1. In the Azure portal, search for and select **Virtual machines**.
2. On the **Virtual machines** page, select the checkbox next to **simple-vm**, and then select **Delete** from the toolbar.
3. On the **Delete Resources** pane, enter *delete* in the **Enter "delete" to confirm deletion** field, and then select **Delete**.
1. Select **Delete** again.

Give the operation several minutes to complete before you proceed to the next step.

## Investigate the incident

In this step, you investigate the incident Microsoft Sentinel created when you deleted the VM. It might take up to 30 minutes for the incident to appear in Microsoft Sentinel.

1. In the Azure portal, search for and select **Microsoft Sentinel**, and then select your Microsoft Sentinel workspace.
1. On your Microsoft Sentinel page, select **Incidents** under **Threat management** in the left navigation.
1. On the **Incidents** page, select the incident with the title **Deleted VMs**.
1. In the **Deleted VMs** details pane on the right, observe the details of the incident, including **Owner**, **Status**, and **Severity**. Apply the following updates:
   - Select **Owner** > **Assign to me** > **Apply**.
   - Select **Status** > **Active** > **Apply**.
1. Select **View full details**.
1. In the left pane of the **Incident** page, observe the totals for **Events**, **Alerts**, and **Bookmarks** in the **Evidence** section.
1. At the bottom of the pane, select **Investigate**.
1. On the **Investigation** page, select the following items in the investigation graph:
   - The **Deleted VMs** incident item in the center of the page showing the details of the incident.
   - The user entity representing your user account, indicating that you deleted the VM.
1. At the top of the **Investigate** page, select **Status** > **Closed**.
1. In the **Select classification** drop-down menu, select **Benign Positive - Suspicious but expected**.
1. In the **Comment** field, enter *Testing incident creation and resolution steps*, and then select **Apply**.
1. Select the close icons to close the **Investigate** and **Incident** pages.
1. On the **Incidents** page, observe that **Open incidents** and **Active incidents** now have values of **0**.

You've successfully created a Microsoft Sentinel analytics rule, deleted a VM to create an incident, and investigated and closed the incident the rule created.

## Clean up resources

To avoid incurring costs, delete the Azure resources that you created in this module when you're finished with them. To delete the resources, complete the following steps:

1. In the Azure portal, search for **Resource groups**.
1. On the **Resource groups** page, select **azure-sentinel-rg**.
1. On the **azure-sentinel-rg** page, select **Delete resource group** from the top menu bar.
1. On the **Delete a resource group** page, under **Enter resource group name to confirm deletion**, enter *azure-sentinel-rg*.
1. Select **Delete**, and then select **Delete** again.

