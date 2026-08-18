It's important to know whether your files have been modified and how they changed. Change Tracking and Inventory can store the before and after contents of tracked files and use Azure Monitor alerts to notify you about critical changes.

## Enable file content tracking

With file content tracking, you can compare file contents before and after a tracked change. To enable and use file content tracking, use the following procedure:

1. In the Azure portal, go to **Virtual machines**, and then select a monitored VM.
2. Under **Operations**, select **Change tracking**, and then select **Settings**.
3. On the **Data Collection Rule Configuration** pane, select **File Content** > **Link**.
4. Select the subscription and storage account that will store file contents.
5. Confirm the managed identity used to access the storage account.
6. Turn on **Upload file content for all settings**, and then select **Save**.

> [!TIP] 
> File content tracking requires a storage account. Grant the VM's managed identity the **Storage Blob Data Contributor** role for the content container.

### Review the contents of a tracked file

After Change Tracking and Inventory detects a change for a tracked file, you can review the file contents on the **Change Details** pane. Use the following procedure:

1. In the Azure portal, open the VM's **Change tracking** pane.
2. Select a file in the list of changes, and then select **View File Content Changes**.

  > [!NOTE] 
  > The change details pane displays the before and after file information for each property.

3. By default, you review the file contents in a side-by-side layout. Select **Inline** to review an inline layout of the changes.

### Create alerts on changes

You can configure alerts on file changes. For example, if someone edited the Hosts file on a VM, that would impact the way that name resolution occurred on that VM. It would be important to know that this change had occurred.

To configure an alert on a file change similar to this, use the following procedure:

1. On the VM's **Change tracking** pane, open **Logs**.
2. Enter the following query:

   ```
   ConfigurationChange | where FieldsChanged contains "FileContentChecksum" and FileSystemPath contains "hosts"
   ```

3. Select **New alert rule** to open the alert creation page. Review the query and configure the alert logic.

   > [!TIP] 
   > In this case, because the file is critical, you want the alert to be triggered if there's even one change detected across all the machines in the environment.

4. Select or create an action group, and then configure the notification or automation action.

## Additional reading

To learn more, review the following document.

- [Configure Change Tracking and Inventory data collection rules](/azure/azure-change-tracking-inventory/tutorial-change-workspace-configure-data-collection-rule)
- [Create and manage action groups in the Azure portal](/azure/azure-monitor/alerts/action-groups)
