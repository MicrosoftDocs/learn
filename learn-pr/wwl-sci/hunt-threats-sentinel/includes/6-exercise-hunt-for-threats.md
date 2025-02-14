As a security engineer working for Contoso, you recently noticed that a significant number of virtual machines (VMs) were deleted from your Azure subscription. You want to simulate a deleted VM, analyze this occurrence, and understand the key elements of the potential threat in Microsoft Sentinel.

In this exercise, you delete a VM, manage threat-hunting queries, and save key findings with bookmarks.

> [!NOTE]
> To complete this exercise, you need to have completed the setup exercise earlier in the module. If you haven't done that, please do it now.

## Delete a VM

In this task, you delete a VM to test rule detection and incident creation.

1. In the Azure portal, search for and select **Virtual machines**.
2. On the **Virtual machines** page, select the check box beside the virtual machine labeled **simple-vm**, and then select **Delete** from the toolbar.
3. In the **Delete Resources** pane, confirm the deletion and then select **Delete**.

## Manage Microsoft Sentinel threat-hunting queries

In this task, you create and manage threat-hunting queries to review events related to deleting the VM in the previous task. It might take up to 5 minutes for the event to appear in Microsoft Sentinel after you delete the VM.

1. In the Azure portal, search for and select **Microsoft Sentinel**, and then select the previously created Sentinel workspace.
2. On the **Microsoft Sentinel** page, on the menu bar, in the **Threat management** section, select **Hunting**.
3. On the **Hunting** page, select the **Queries** tab. Then choose **New Query**.
4. On the **Create custom query** page, provide the following inputs, and then select **Create**.

   - **Name**: Enter **Deleted VMs**.
   - **Description**: Enter a detailed description that helps other security analysts understand what the rule does.
   - **Custom query**: Enter the following code.

     ```kusto
       AzureActivity
       | where OperationName == 'Delete Virtual Machine'
       | where ActivityStatus == 'Accepted'
       | extend AccountCustomEntity = Caller
       | extend IPCustomEntity = CallerIpAddress
     ```
  
   - **Tactics**: Select **Impact**.

5. On the **Hunting** page, on the **Queries** tab, enter **Deleted VMs** in the **Search queries** field.
6. In the list of queries, select the star icon beside **Deleted VMs** to mark the query as a favorite.
7. Select the **Deleted VMs** query. In the details pane, select **View Results**.

   >[!NOTE]
   >It might take up to 15 minutes for the deleted VM event to be sent to Microsoft Sentinel. You can periodically choose to run the query on the **Results** tab if the VM deletion event doesn't appear.

8. On the **Logs** page, in the **Results** section, select the listed event. It should have `"action": "Microsoft.Compute/virtualMachines/delete"` in the **Authorization** column. This is the event from the Azure Activity log that indicates that the VM was deleted.
9. Remain on this page for the next task.

## Save key findings with bookmarks

In this task, you use bookmarks to save events and do more hunting.

1. On the **Logs** page, in the **Results** section, select the check box beside the listed event. Then select **Add bookmark**.
2. On the **Add bookmark** pane, select **Create**.
3. At the top of the page, select **Microsoft Sentinel** on the breadcrumb trail.
4. On the **Hunting** page, select the **Bookmarks** tab.
5. In the list of bookmarks, select the bookmark that begins with **Deleted VMs**.
6. On the details page, select **Investigate**.
7. On the **Investigation** page, select **Deleted VMs** and observe the details of the incident.
8. On the **Investigation** page, select the entity on the graph that represents a user. This is your user account, which indicates that you deleted the VM.

## Results

In this exercise, you deleted a VM, managed threat-hunting queries, and saved key findings with bookmarks.

## Clean up Azure resources

After you finish using the Azure resources that you created in this exercise, delete them to avoid incurring costs:

1. In the Azure portal, search for **Resource groups**.
2. Select your resource group.
3. In the header bar, select **Delete resource group**.
4. In the **TYPE THE RESOURCE GROUP NAME** field, enter the name of the resource group and select **Delete**.
