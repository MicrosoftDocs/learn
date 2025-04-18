Security operations analysts use Microsoft Sentinel to monitor and respond to security incidents in their organization. In these exercises we investigate security incidents using Microsoft Sentinel in Microsoft Azure, and in the Microsoft Defender portal Unified Security Operations Platform.

## [Azure portal](#tab/azure-portal)

As a Contoso security operations analyst, you need to analyze the deletions of virtual machines (VMs) from the Contoso Azure subscription, and be alerted when a similar activity occurs in the future. You decide to implement an analytics rule to create an incident when someone deletes an existing VM. You can then investigate the incident to determine the details, and close the incident when you're finished.

In this exercise, you create a Microsoft Sentinel analytics rule to detect when a VM is deleted. You then delete the VM you created at the beginning of this module, and investigate and resolve the incident the rule created.

To complete this exercise, make sure you finished the setup exercise at the beginning of the module, and the Azure Activity connector now shows a status of **Connected**.

## Create an analytics rule from the wizard

Create an analytics rule that creates an incident when a VM is deleted in the Contoso Azure subscription.

1. In the Azure portal, search for and select **Microsoft Sentinel**, and then select the Microsoft Sentinel workspace you created.
1. On your Microsoft Sentinel page, select **Analytics** under **Configuration** in the left menu.
1. On the **Analytics** page, select **Create** > **Scheduled query rule**.

## General tab

1. On the **General** tab of the wizard, provide the following information.

   - **Name**: Enter *Deleted VMs*.
   - **Description**: Enter a description to help others understand what the rule does.
   - **Tactics and techniques**: Select **Initial Access**.
   - **Severity**: Select **Medium**.
   - **Status**: Select **Enabled**.

   :::image type="content" source="../media/6-analytics-rule-wizard-create-new-rule.png" alt-text="Screenshot of the page for creating a new rule in the Analytics Rule wizard." border="true":::

1. Select **Next: Set rule logic**.

## Set rule logic tab

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

## Incident settings tab

1. On the **Incident settings** tab, ensure that **Create incidents from alerts triggered by this analytics rule** is set to **Enabled**.
1. In the **Alert grouping** section, select **Enabled** to group related alerts into incidents. Ensure that **Grouping alerts into a single incident if all the entities match (recommended)** is selected.
1. Ensure that **Reopen closed matching incidents** is **Disabled**.
1. Select **Next: Automated response**.

## Review and create

1. Select **Next: Review**.
1. On the **Review and create** tab, when validation is successful, select **Create**.

## Delete a VM

To test rule detection and incident creation, delete the VM you created during setup.

1. In the Azure portal, search for and select **Virtual machines**.
1. On the **Virtual machines** page, select the checkbox next to **simple-vm**, and then select **Delete** from the toolbar.
1. On the **Delete Resources** pane, enter *delete* in the **Enter "delete" to confirm deletion** field, and then select **Delete**.
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

You successfully created a Microsoft Sentinel analytics rule, deleted a VM to create an incident, and investigated and closed the incident the rule created.

## Clean up resources

To avoid incurring costs, delete the Azure resources that you created in this module when you're finished with them. To delete the resources, complete the following steps:

1. In the Azure portal, search for **Resource groups**.
1. On the **Resource groups** page, select **azure-sentinel-rg**.
1. On the **azure-sentinel-rg** page, select **Delete resource group** from the top menu bar.
1. On the **Delete a resource group** page, under **Enter resource group name to confirm deletion**, enter *azure-sentinel-rg*.
1. Select **Delete**, and then select **Delete** again.

## [Defender portal](#tab/defender-portal)

In this exercise you walk through the process of reviewing, modifying, investigating, and responding to a security incident within the Unified Security Operations Platform.

   > [!NOTE]
   > When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

1. Open the simulated environment by selecting this link: **[Microsoft Defender portal](https://app.highlights.guide/start/1e5185e8-b314-48fe-b848-965232192baa?token=bba5e99b-3887-4a6c-b0d8-3099d15a4c23)**.

   > [!NOTE]
   > The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature isn't available within the simulation." When this occurs, select OK and continue the exercise steps.  
   >
   >:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

## Task: Review the Incident Queue and Apply Filters

1. In the Microsoft Defender portal navigation menu:
    1. Expand **Investigation & response**.
    1. Expand  **Incidents & alerts**.
    1. Select **Incidents**.

1. Within the Incident Queue, filter the incidents for high severity and a status of active.
1. Select "add filter."
1. Set the filter to categories and set the value to ***Ransomware**.
1. Select the "User account compromise identified from a known attack pattern" incident and view the summary on the right hand menu

## Task: Generate an Incident Summary with Copilot for Security

1. Continuing with the same incident from the previous task, select the name to enter the incident page.
1. After entering the incident, allow Copilot to review the incident and generate an incident summary.
1. Review the summary details to understand what took place in the incident.

## Task: Review an Alert

1. Within the alert timeline, select the "Malicious URL In Proxy logs."
1. Review the details under "what happened."
1. Check which analytic rule generated this alert.
1. Within the incident graph, select the IP address "10.50.0.16."
1. Select the node and choose "view details" to see related details to the IP.
1. In the alert timeline, select "Connection to a suspicious domain related to credential phishing."
1. Review the process tree to review the sequence of processes being performed on the workstation up until the incident.

## Task: Review the Incident Assets (Entities)

1. Within the incident, select the "assets" tab near the top.
1. Select "users."
1. Select the user’s name.
1. Review the details in the side menu.
1. Select "devices."
1. Select the first device.
1. Select "open device page."
1. Review the details shown on the page.

## Task: Review the Evidence and Response

1. Navigate back to the incident page.
1. Select the "Evidence and Response" tab near the top.
1. Select a few items of evidence and review the details in the side menu.

## Task: Review the Recommended Actions

1. Select the "Recommended actions" tab.
1. Review the list of listed actions.
1. Select through the list to see the details, implementation status, impact, implementation steps, and history.

## Task: Close an Incident

1. Within the incident, select "Manage Incident."
1. Set the status to resolved.
1. Within the classification, select a categorization.
1. Select save.

---
