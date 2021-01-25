As a security engineer working for Contoso, you recently notice that a significant number of VMs has been deleted from your Azure subscription. You want to simulate a deleted VM, analyze this occurrence, and understand the key elements of the potential threat in Azure Sentinel.

In this exercise, you will delete a VM, manage threat hunting queries, and save key findings with bookmarks.

- Delete a VM
- Manage Azure Sentinel threat hunting queries.
- Save key findings with bookmarks.

> [!NOTE]
> To complete this exercise, you need to have completed the setup exercise earlier in the module. If you have not done so, please complete it now.

## Task 1: Delete a VM

In this task, you'll delete a VM to test rule detection and incident creation.

1. In the Azure portal, search for and select **Virtual machines**.
2. On the Virtual machines page, select the check box beside the virtual machine labeled **simple-vm**, and then select **Delete** from the toolbar.
3. In the **Delete Resources** pane, enter **yes** in the **Confirm delete** field and select **Delete**.

## Task 2: Manage Azure Sentinel threat hunting queries

In this task, you'll create and manage threat hunting queries to review events related to deleting the VM in task 1. It may take up to 5 minutes after deleting the VM for the event to appear in Azure Sentinel.

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. Select **Azure Sentinel**, on the menu bar, in the **Threat management** section, select **Hunting**.
3. On the **Hunting** page, select **New Query**.
4. On the **Create custom query** page, provide the inputs in the following table, and then select **Create**.

   - **Name**: **Deleted VMs**
   - **Description**: Enter a detailed description that will help other security analysts understand what the rule does.
   - **Custom query**:

    ```kusto
      AzureActivity
      | where OperationName == 'Delete Virtual Machine'
      | where ActivityStatus == 'Accepted'
      | extend AccountCustomEntity = Caller
      | extend IPCustomEntity = CallerIpAddress
      ```
  
   - **Tactics**: Select **Impact**.

5. On the **Hunting** page, on the **Queries** tab, enter **Deleted VMs** in the **Search queries field**.
6. In the list of queries, select the star icon beside **Deleted VMs** to mark the query as a favorite.
7. Select the **Deleted VMs** query and then, in the details pane, select **View Results**.

    >[!NOTE]
    >It might take up to 15 minutes for the deleted VM event to be sent to Azure Sentinel. You can periodically choose to run the query on the **Results** tab if the VM deletion event is not appearing.

8. On the Logs page, in the **Results** section, select the event listed. It should have **{ "action": "Microsoft.Compute/virtualMachines/delete"** in the **Authorization** column. This is the event from the Azure Activity log that indicates the VM was deleted.
9.  Remain on this page for the next task.

## Task 3: Save key findings with bookmarks

In this task, you will use bookmarks to save events and do more hunting.

1. On the **Logs** page, in the **Results** section, select the check box beside the event listed and then select **Add bookmark**.
2. In the **Add bookmark** pane, select **Create**.
3. At the top of the page, select **Azure Sentinel** on the breadcrumb trail.
4. On **Hunting** page, select the **Bookmarks** tab.
5. In the list of bookmarks, select the bookmark that begins with **Deleted VMs**.
6. In the details page, select **Investigate**.
7. On the **Investigation page**, select **Deleted VMs** in the center of the page and observe the details of the incident.
8. On the **Investigation page**, select the entity on the graph that represents a user. This is your user account, indicating that you deleted the VM.

## Results

After completing this exercise, you will have deleted a VM, managed threat hunting queries, and saved key findings with bookmarks.

## Clean up the resources

When you are finished with the resources, you'll want to delete the Azure resources you have created in this exercise to avoid incurring costs. To do this, complete the following steps:

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. In the header bar, select **Delete resource group**.
4. In the **TYPE THE RESOURCE GROUP NAME:** field enter the name of the resource group **azure-sentinel-rg** and select **Delete**.
