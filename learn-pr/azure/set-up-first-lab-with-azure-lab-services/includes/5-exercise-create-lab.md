Educators can create labs containing VMs for students using the Azure Lab Services portal. In this unit, you create a lab with Windows 11 Pro image.  Once a lab is created, you configure the template VM and publish the lab.

During the process, you'll:

- Create a lab
- Create a template virtual machine
- Connect to the template virtual machine using Remote Desktop Connection (RDP).

## Create a lab

The following steps show how to create a lab with Azure Lab Services.

1. Sign into the [Azure Lab Service website](https://labs.azure.com).
1. Select **New lab**.  

    :::image type="content" source="../media/new-lab-button.png" alt-text="Screenshot of Azure Lab Services portal.  New lab button is highlighted.":::

1. In the **New Lab** window, choose the basic settings for the lab.
    1. Set the **Name** to *Lab101*.
    1. Set the **Virtual machine image** to **Windows 11 Pro**.

       For this scenario, select **Windows 11 Pro** so you can easily connect to the lab using RDP.

    1. Accept the default **Virtual machine size**.

        :::image type="content" source="../media/new-lab-window.png" alt-text="Screenshot of the New lab window for Azure Lab Services.":::

    1. On the **Virtual machine credentials** page, specify default administrator credentials for all VMs in the lab. Specify the **name** and the **password** for the administrator.  By default all the student VMs will have the same password as the one specified here.

        :::image type="content" source="../media/new-lab-credentials.png" alt-text="Screenshot of the Virtual Machine credentials window for Azure Lab Services.":::

        > [!NOTE]
        > Make a note of user name and password. They won't be shown again.

    1. On the **Lab policies** page, leave the default selections and select **Next**.

    1. On the **Template virtual machine settings** window, leave the selection on **Create a template virtual machine**, and then choose **Finish**.

1. You should see the following screen that shows the status of the template VM creation.

    :::image type="content" source="../media/create-template-vm-progress.png" alt-text="Screenshot of status of the template VM creation.":::

1. When the lab is completed, you'll see the **Template** page of the lab.

   :::image type="content" source="../media/lab-template-page.png" alt-text="Screenshot of Template page of a lab.":::

## Connect to the template VM from Windows using RDP

Typically, the Remote Desktop client is already installed and configured on Windows.  As a result, all you need to do is select the command to connect to your template VM.

1. On the template page for your lab, ensure the VM is running and select the **Connect to template** button.

   If it's not running, choose **Start template** and wait for it to start up.

    :::image type="content" source="../media/connect-template-vm.png" alt-text="Screenshot of My virtual machines page for Azure Lab Services.  The Connect to template VM button is highlighted.":::

Once connected, you can install required software to the template VM. (We aren't installing any software in this exercise.)

## Publish a lab

In this step, you publish the lab. When you publish the template VM, Azure Lab Services creates VMs for students in the lab by using the template. All virtual machines have the same configuration as the template.

1. On the **Template** page, select **Publish** on the toolbar.

    :::image type="content" source="../media/template-page-publish-button.png" alt-text="Screenshot of Azure Lab Services template page. The Publish template menu button is highlighted.":::

1. Select **OK** when warned that publishing is a permanent action.

   You see the **status of publishing** the template on page.

1. Wait until the publishing is complete.

1. Select **Virtual machine pool** on the left menu or select **Virtual machines** tile on the dashboard page to see the list of available machines. Confirm that you see virtual machines that are in **Unassigned** state. These VMs aren't assigned to students yet. They should be in **Stopped** state.

    :::image type="content" source="../media/virtual-machines-stopped.png" alt-text="Screenshot of virtual machines stopped.  The virtual machine pool menu is highlighted.":::

    > [!NOTE]
    > When an educator turns on a student VM, quota for the student isn't affected. Quota for a user specifies the number of lab hours available to a student outside of the scheduled class time.

At this point, you would normally navigate to the **Users** page, add lab users, and send them invitations to the lab. But for this example scenario, since you don't have actual students, you will skip that step. If you're using Teams or Canvas integration, the users are automatically created and populated for you (there is no need to add users).

## Set a schedule for the lab

Create a scheduled event for the lab so that VMs in the lab are automatically started and stopped at specific times. The user quota (default: 10 hours) you specified earlier is the extra time assigned to each student outside this scheduled time.

1. Switch to the **Schedule** page, and select **Add scheduled event** on the toolbar.  **Add scheduled event** will be disabled if the lab is actively being published.

    :::image type="content" source="../media/add-schedule-button.png" alt-text="Screenshot of the Add scheduled event button on the Schedules page. The Schedules menu and Add scheduled event button are highlighted.":::

1. On the **Add scheduled event** page, do the following steps:
    1. Confirm that **Standard** is selected the **Event type**.  
    2. Select the **start date** for the class.
    3. Select the **start time** at which you want the VMs to be started.
    4. Select the **stop time** at which the VMs are to be shut down.
    5. Select the **time zone** for the start and stop times you specified.
1. On the same **Add scheduled event** page, select the current schedule in the **Repeat** section.  
1. On the **Repeat** dialog box, you can choose options to repeat the schedule every week, select the days where the schedule is in effect, and select an end date.

   We won't do that here so that you minimize the chances for incurring unexpected costs.

1. On the **Add scheduled event** page, for **Notes (optional)**, enter any description or notes for the schedule.
1. On the **Add scheduled event** page, select **Save**.
1. Navigate to the start date in the calendar to verify that the schedule is set.

    :::image type="content" source="../media/schedule-calendar.png" alt-text="Screenshot of the Schedule page for Azure Lab Services.  Repeating schedule, Monday through Friday shown in the calendar.":::

