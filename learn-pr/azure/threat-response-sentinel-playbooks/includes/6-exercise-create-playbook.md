## Exercise: Threat response using Azure Sentinel Plabooks

As a security engineer working for Contoso, you recently notice that significant number of alerts are generated when someone delete a virtual machine. You want to analyze that occurrence in the future and reduce the alerting of fault postive occurence.
You decide to implement Azure Sentinel playbook to automate respond on an incident.

In this exercise, you will explore the Azure Sentinel playbooks. You will perform the following tasks:
- Create a playbook to automate an action to respond on incidents.
- Create a playbook from Azure Sentinel repo on Github

### Task 1: Work with Azure Sentinel Playbooks

1. In the Azure portal, search for and select Azure Sentinel and select the previously created Sentinel workspace.
2. In the **Azure Sentinel** blade, on the left side in the menu bar, in the **Configuration** section, select **Playbooks.**
3. Click on **+Add Playbook.**
4. On the  **Logic App** blade, in the **Basics** tab, specify the following settings:

| **Settings** | **Value** |
| --- | --- |
| Subscription | the name of the Azure subscription you are using in this lab |
| Resource group | Select the resource group of your Azure Sentinel service |
| Logic App name | **ClosingIncident** _(you can choose any name)_ |
| Select the location | **Region** |
| Location | Select same location as the location of the Azure Sentinel |
| Log Analytics | **Off** |

5. Select  **Review + Create**  and then select  **Create**.

**Note** : Wait for the deployment to complete. The deployment should take less than 1 minute.

6. Once the deployment is complete, select **Go to resource**.
7. In the Logic Apps Designer pane, scroll down and select **Blank Logic App.**
8. In the search field type and select **Azure Sentinel**.
9. In the Triggers tab, select **When a response to an Azure Sentinel Alert is triggered (preview)**.

![](RackMultipart20201115-4-1yrme86_html_985baf0d737c4c8a.png)

10. In the Azure Sentinel, verify that for the Tenant in the drop-down menu, **Default Directory** is selected and then select **Sign in.**

![](RackMultipart20201115-4-1yrme86_html_70cdc921bd1e87c2.png)

11. Provide the credential for your Azure subscription and then select **+ New step.**
12. In the **Choose an operation** window, in the search field type and select **Azure Sentinel**.
13. From the **Actions** tab, locate and select **Alert-Get Incident (Preview).**
14. In the **Alert-Get Incident (Preview)** provide the following inputs and then select **New Step.**

> [!Tip]

> When you select the field, a new window will pop up to help you filling these entries with dynamic content. Under the **Dynamic content** tab, in the search box you can start typing

| Specify subscription id: | **Subscription ID** |
| --- | --- |
| Specify resource group: | **Resource group** |
| Specify workspace id: | **Workspace ID** |
| Specify alert id: | **System Alert ID** |

![](RackMultipart20201115-4-1yrme86_html_81ef71a7e187add6.png)

15. In the **Choose an operation** window, in the search field type and select **Azure Sentinel.**
16. From the **Actions** tab, locate and select **Change incident status (Preview).**
17. In the **Change incident status (Preview)** provide the following inputs:

| Specify subscription id: | **Subscription ID** |
| --- | --- |
| Specify resource group: | **Resource group** |
| Specify workspace id: | **Workspace ID** |
| Identifier | From the drop-down menu select **Alert** |
| Specify alert / incident | **System Alert ID** |
| Specify status | From the drop-down menu select **Closed** |
| Close reason | From the drop-down menu select **Custom Value** and then type **Incident Resolved** |
| Close reason text | Write descriptive text |

![](RackMultipart20201115-4-1yrme86_html_4a68b097a4c7f7ca.png)

18. Once that you save the logic app, you can close the Logic Apps Designer.

### Task 2: Assign the Playbook on existing incident.

1. In the Azure portal, search for and select Azure Sentinel, and then select the previously created Azure Sentinel workspace.
2. In the **Azure Sentinel | Overview** page, in the menu bar, in the **Threat management** section, select **Incidents.**
3. In the **Azure Sentinel | Incidents** page, select the incident that has been created based on deletion of the VM.
4. In the detailed pane, on the right side, select **View full details.**
5. In the **Incident** page, in the detailed pane, in the list of the **Alerts,** in the rightest position, select the link **View playbooks.**
6. In the **Alert playbooks** page, select **ClosingIncident** playbook and then select **Run.**
7. Verify that you receive the message **Playbook was triggered successfully.**
8. Close the **Alert** page, and then close **Incident** page to return on **Azure Sentinel | Incidents** page.
9. In the **Azure Sentinel | Incidents** page, in the header bar select **Refresh.** You will notice that the incident will disappear from the pane. From the **Status** menu select **Closed** and select **OK.**

![](RackMultipart20201115-4-1yrme86_html_9317719c2500d4a4.png)

10. Verify that the incident is shown again, but notice the **Status** column, it states that is **Closed.**

