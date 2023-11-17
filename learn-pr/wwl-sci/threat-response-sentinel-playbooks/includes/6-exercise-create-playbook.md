
As a Security Operations Analyst working for Contoso, you recently notice that a significant number of alerts are generated when someone deletes a virtual machine. You want to analyze such occurrences in the future and reduce the alerts generated for false positive occurrences.

## Exercise: Threat response using Microsoft Sentinel playbooks

You decide to implement a Microsoft Sentinel playbook to automate responses to an incident.

In this exercise, you'll explore the Microsoft Sentinel playbooks by performing the following tasks:

- Configure Microsoft Sentinel Playbook permissions.

- Create a playbook to automate an action to respond to incidents.

- Test your playbook by invoking an incident.

> [!NOTE]
> You need to have completed the Exercise Setup unit, in order to be able to complete this exercise. If you have not done so, complete it now, and then continue with the exercise steps.

### Task 1: Configure Microsoft Sentinel Playbook permissions

1. In the Azure portal, search for and select Microsoft Sentinel, and select the previously created Microsoft Sentinel workspace.

1. In the **Microsoft Sentinel** page, on the menu bar, in the **Configuration** section, select **Settings**.

1. In the **Settings** page, select the **Settings** tab and scroll down and expand the **Playbook permissions**

1. In **Playbook permissions**, select the **Configure permissions** button.

    :::image type="content" source="../media/06-sentinel-playbook-permissions.png" alt-text="Screenshot of the Microsoft Sentinel Playbook permissions." border="true":::

1. In the **Manage permissions** page under the **Browse** tab, select the resource group that your Microsoft Sentinel workspace belongs to. Select **Apply**.

    :::image type="content" source="../media/06-manage-permissions.png" alt-text="Screenshot of the Microsoft Sentinel Playbook Manage permissions page." border="true":::

1. You should see the **Finished adding permissions** message.

### Task 2: Work with Microsoft Sentinel playbooks

1. In the Azure portal, search for and select Microsoft Sentinel, and select the previously created Microsoft Sentinel workspace.

1. In the **Microsoft Sentinel** page, on the menu bar, in the **Configuration** section, select **Automation**.

1. On the top menu, select **Create** and **Playbook with incident trigger**.

1. In the  **Create Playbooks** page, on the **Basics** tab, specify the following settings:

    | **Settings** | **Value** |
    | --- | --- |
    | Subscription | Select your Azure subscription. |
    | Resource group | Select the resource group of your Microsoft Sentinel service. |
    | Playbook name | **ClosingIncident** *(you can choose any name)* |
    | Region | Select the same location as the location of Microsoft Sentinel. |
    | Log Analytics workspace | **Don't enable diagnostic logs** |

1. Select  **Next:Connections >**, then select **Next: Review and Create >**

1. Select **Create and continue to designer**

    > [!NOTE]
    > Wait for the deployment to complete. The deployment should take less than 1 minute. If it keeps running you may need to refresh the page.

1. In the **Logic Apps Designer** pane, you should see the **Microsoft Sentinel incident (preview)** displayed.

    :::image type="content" source="../media/06-azure-sentinel-trigger.png" alt-text="Screenshot of the Microsoft Sentinel trigger." border="true":::

1. On the **Microsoft Sentinel incident (preview)** page, select the **Change connection** link.

1. On the **Connections** page, select **Add new**.

1. On the Microsoft Sentinel page, select **Sign in**.

    :::image type="content" source="../media/06-sign-in-aad-tenant.png" alt-text="Screenshot of the authorizing API connection." border="true":::

1. On the **Sign in to your account** page, provide the credentials for your Azure subscription.

1. Back on the **Microsoft Sentinel incident (preview)** page, you should see you're connected to your account. Select **+ New step**.

1. In the **Choose an operation** window, in the search field,  type **Microsoft Sentinel**.

1. Select the **Microsoft Sentinel** Icon.

1. On the **Actions** tab, locate and select **Get incident (Preview)**.

1. In the **Get Incident (Preview)** window, select the **Incident ARM ID field**. The **Add dynamic content** window opens.

    > [!TIP]
    > When you select a field, a new window opens to help you fill these fields with dynamic content.

1. On the **Dynamic content** tab, in the search box, you can start entering **Incident ARM**, and then select the entry from the list, as the following screenshot displays.

    :::image type="content" source="../media/06-get-incident.png" alt-text="Screenshot of Get Incident." border="true":::

1. Select **+ New step**.

1. In the **Choose an operation** window, in the search field,  type **Microsoft Sentinel**.

    > [!TIP]
    > In the For you tab, Recent selections should display the Microsoft Sentinel Icon.

1. Select the **Microsoft Sentinel** Icon.

1. From the **Actions** tab, locate and select **Update incident (Preview)**.

1. In the **Update incident (Preview)** window, provide the following inputs:

    | Settings | Values |
    | --- | --- |
    | Specify Incident ARM id | **Incident ARM ID** |
    | Specify Owner Object Id / UPN | **Incident Owner Object ID** |
    | Specify Assign/Unassign owner | From the drop-down menu, select **Unassign** |
    | Severity | You can leave the default **Incident severity** |
    | Specify Status | From the drop-down menu, select **Closed**. |
    | Specify Classification reason | From the drop-down menu, select an entry like **Undetermined**, or select **Enter custom value**, and select IncidentClassification Dynamic content. |
    | Close reason text | Write descriptive text. |

    :::image type="content" source="../media/06-change-incident-status.png" alt-text="Screenshot of the Get Incident status." border="true":::

1. Select the **Incident ARM ID field**. The **Add dynamic content** window opens, in the search box, you can start entering **Incident ARM**. Select **Incident ARM ID** and then select the **Owner Object Id / UPN** field.

1. The **Add dynamic content** window opens, in the search box, you can start entering **Incident owner**. Select **Incident Owner Object ID** and then fill in the remaining fields using the table entries.

1. When done, choose **Save** from the Logic Apps Designer menu bar, and then close the Logic Apps Designer.

### Task 3: Invoke an incident and review the associated actions

1. In the Azure portal, in the **Search resources, services, and docs** text box, type **virtual machines**, and then select **Enter**.

1. On the **Virtual machines** page, locate and select the **simple-vm** virtual machine, and then on the header bar, select **Delete**.

1. On the **Delete simple-vm** page, select **Delete with VM** for both the **OS Disk** and the **Network Interface**.

1. Select the box to acknowledge **I have read and understand that this virtual machine as well as any selected resources will be deleted**, then select **Delete** to delete the virtual machine.

    :::image type="content" source="../media/06-delete-simple-vm.png" alt-text="Screenshot of the Delete simple-vm page." border="true":::

    > [!NOTE]
    > This task creates an incident based on the analytics rule that you created earlier in the exercise setup unit. Incident creation can take up to 15 minutes. Wait for it to complete before proceeding to the next step.

### Task 4: Assign the playbook to an existing incident

1. In the Azure portal, search for and select Microsoft Sentinel, and then select the previously created Microsoft Sentinel workspace.

1. On the **Microsoft Sentinel | Overview** page, on the menu bar, in the **Threat management** section, select **Incidents**.

    > [!NOTE]
    > As mentioned in the previous note, Incident creation can take up to 15 minutes. Refresh the page until incident appears in the **Incidents** page.

1. On the **Microsoft Sentinel | Incidents** page, select an incident that has been created based on the deletion of the virtual machine.

1. In the details pane, select **Actions** and **Run playbook (Preview)**.

    :::image type="content" source="../media/06-incident-run-playbook.png" alt-text="Screenshot of the Incident detail pane actions to run playbook." border="true" lightbox="../media/06-incident-run-playbook.png":::

1. On the **Run playbook on incident** page, in the **Playbooks tab,** you should see the **ClosingIncident** playbook, select **Run**.

1. Verify that you receive the message **Playbook was triggered successfully**.

1. Close the **Run playbook on incident** page, to return to the **Microsoft Sentinel | Incidents** page.

1. In the **Microsoft Sentinel | Incidents** page, on the header bar, select **Refresh**. You'll notice that the incident disappears from the pane. On the **Status** menu, select **Closed**, and then select **OK**.

    > [!NOTE]
    > It could take up to 5 minute for Alerts to be shown as **Closed**

    :::image type="content" source="../media/06-header-refresh.png" alt-text="Screenshot of the header bar." border="true":::

1. Verify that the incident displays again and notice the **Status** column to check that it's **Closed**.

### Clean up the resources

1. In the Azure portal, search for **Resource groups**.

1. Select **azure-sentinel-rg**.

1. On the header bar, select **Delete resource group**.

1. In the **TYPE THE RESOURCE GROUP NAME:** field, enter the name of the resource group **azure-sentinel-rg** and select **Delete**.
