## Exercise: Hunt threats with Azure Sentinel
<!-- Review errors in the Problems pane at the bottom." -->
As a security engineer working for Contoso, you recently notice that a significant number of VMs has been deleted from your Azure subscription. You want to simulate a deleted VM, analyze this occurrence and understand the key elements of the potential threat in Azure Sentinel.
In this exercise, you will delete a VM, manage threat hunting queries, and save key findings with bookmarks.

- Delete a VM
- Manage Azure Sentinel threat hunting queries.
- Save key findings with bookmarks.

> [!NOTE]
> If you choose to perform the exercise in this module, be aware you may incur costs in your Azure Subscription. To estimate the cost, refer to [Azure Sentinel Pricing](https://azure.microsoft.com/pricing/details/azure-sentinel/)

## Task 1: Delete a VM

In this task, you'll delete a VM to test rule detection and incident creation.

1. In the Azure portal, search for and select **Virtual machines**.
2. On the Virtual machines page, select the check box<!-- Remember that per MS Style: "Use check box, not box or checkbox, to refer to a check box in UI." --> beside the virtual machine labeled **simple-vm**, and then select **Delete** from the toolbar.
3. In the **Delete Resources** pane, type<!-- Type is a non-accessibility word, as not everyone uses a keyboard. Search and replace with "enter." --> **yes** in the **Confirm delete** field and then select **Delete**.

## Task 2: Manage Azure Sentinel threat hunting queries

In this task, you'll create and manage threat hunting queries to review events related to deleting the VM in task 1. It may take up to 5 minutes after deleting the VM for the event to appear in Azure Sentinel.

1. In the Azure portal, search for and select **Azure Sentinel**, and then select the previously created Sentinel workspace.
2. On the **Azure Sentinel** blade, on the menu bar, in the **Threat management** section, select **Hunting**.
3. On the Hunting page, select **New Query**.
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
   - **Tactics**: Select **Initial Access**.

5. On the **Hunting** page, on the **Queries** tab, type **Deleted VMs** in the **Search queries field**.
6. In the list of queries, select the star icon beside **Deleted VMs** to mark the query as a favorite.
7. Select the Deleted VMs query and then, in the details pane, select **View Results**.
8. On the Logs page, in the Results section, select the event listed. It should have **{ "action": "Microsoft.Compute/virtualMachines/delete"** in the Authorization column. This is the event from the Azure Activity log that indicates the VM was deleted.
9. Remain on this page for the next task.

## Task 3: Save key findings with bookmarks

In this task, you will use bookmarks to save events and do more hunting.

1. On the **Logs** page, in the **Results** section, select the check box beside the event listed and then select **Add bookmark**.
2. In the **Add bookmark** pane, select **Create**.
3. At the top of the page, select **Azure Sentinel** on the breadcrumb trail<!-- Is there another phrase we could use besides "breadcrumb trail?" It might not globalize well. -->.
4. On Hunting page, select the Bookmarks tab.
5. In the list of bookmarks, select the bookmark that begins with **Deleted VMs**.
6. In the details page, select **Investigate**.
7. On the **Investigation page**, select **Deleted VMs** in the center of the page and observe the details of the incident.
8. On the **Investigation page**, select the entity on the graph that represents a user. Note that this is your user account, indicating that you deleted the VM.

## Results

After completing this exercise, you will have deleted a VM, managed threat hunting queries, and saved key findings with bookmarks.

## Clean up the resources

Next, you'll want to clean up the resources you have created. Complete the following steps:

1. In the Azure portal, search for **Resource groups**.
2. Select **azure-sentinel-rg**.
3. In the header bar select **Delete resource group**.
4. In the **TYPE THE RESOURCE GROUP NAME:** field type the name of the resource group **azure-sentinel-rg** and select **Delete**.
