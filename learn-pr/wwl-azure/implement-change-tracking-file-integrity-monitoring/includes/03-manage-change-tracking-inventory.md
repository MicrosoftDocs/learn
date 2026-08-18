After you enable Change Tracking and Inventory, configure its data collection rules (DCRs) to track the files and registry keys that matter to your organization. You can also review software and Windows service changes and search the collected data in Azure Monitor Logs.

## Change Tracking and Inventory user interface

You can review and configure Change Tracking and Inventory from a monitored VM:

1. In the Azure portal, go to **Virtual machines**, and then select a monitored VM.
2. Under **Operations**, select **Change tracking**.
3. Use the change type and time range filters to focus the results.
4. Select a change to review its details. Change types include:

   - Daemons
   - Files
   - Registry
   - Software
   - Windows services

Events automatically display on the timeline, as displayed in the graphic.

Inventory data is stored in the connected Log Analytics workspace. Use the **Inventory** view or query the `ConfigurationData` table in Azure Monitor Logs to review the current configuration state.

### Modify Change Tracking or Inventory settings

On the VM's **Change tracking** pane, select **Settings** to open **Data Collection Rule Configuration**. Select the workspace and DCR that you want to edit. Changes to a DCR apply to every machine associated with that rule.

You can then modify the settings for the following Change Tracking elements:

- Windows Files
- Linux Files
- Windows Registry
- Windows Services
- File Content

The following table has the data collection frequency for these various tracked elements.

|Change type|Frequency|
|----|----|
|Windows registry|50 minutes|
|Windows file|30 to 40 minutes|
|Linux file|15 minutes|
|Windows services|10 to 30 minutes, default: 30 minutes|
|Linux daemons|5 minutes|
|Windows software|30 minutes|
|Linux software|5 minutes|

You can customize collection frequency only for Windows files and Windows services. Use the current ranges in the [Change Tracking and Inventory support matrix](/azure/azure-change-tracking-inventory/change-tracking-inventory-support-matrix#change-tracking-and-inventory-data-collection).

#### Track Windows files

Use the following procedure to configure tracking for Windows files:

1. On the **Data Collection Rule Configuration** pane, select **Windows Files**.
2. Select **Add** > **Add Windows file setting**.
3. Enter the required information, and then select **Add**.

The following table lists the configurable properties and explains their meaning.

| Property | Explanation |
| -------- | ----------- |
|Enabled|True if the setting is applied, and False otherwise.|
|Item Name|Friendly name of the file to be tracked.|
|Group|A group name for logically grouping files.|
|Path|The path to check for the file, for example, `c:\temp\*.txt`. You can also use environment variables, such as `%winDir%\System32\*.*`.|
|Path Type|The type of path. Possible values are File and Folder.|
|Recursion|True if recursion is used when searching for the item to be tracked, and False otherwise.|

#### Track Windows Registry

To track changes to the Registry, use the following procedure:

1. On the VM's **Change tracking** pane, select **Settings**.
2. On the **Data Collection Rule Configuration** pane, select **Windows Registry**.
3. Select **Add** > **Add Windows registry setting**.
4. Enter the required information, and then select **Add**.

The following table lists the configurable properties and explains their meaning.

| Property             | Explanation                                                  |
| -------------------- | ------------------------------------------------------------ |
| Enabled              | True if the setting is applied, and False otherwise.         |
| Item Name            | Friendly name of the registry key to track.                  |
| Group                | A group name for logically grouping registry keys.           |
| Windows Registry Key | Key name with path, for example: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\Common Startup`. |

Change Tracking and Inventory supports only keys under `HKEY_LOCAL_MACHINE` and doesn't support registry recursion.

#### Search logs for change records

You can use Azure Monitor Logs to search for change records. From the VM's **Change tracking** pane, open **Logs**, and then enter a query.

The following sample query returns the most recent inventory records for Microsoft services that were set to Auto, but were reported as being Stopped.

```
ConfigurationData
| where ConfigDataType == "WindowsServices" and SvcStartupType == "Auto"
| where SvcState == "Stopped"
| summarize arg_max(TimeGenerated, *) by SoftwareName, Computer
```

> [!NOTE] 
> Results are limited to the most recent record for the specified software name and computer.

The following example query returns change records for removed software.

```
ConfigurationChange
| where ConfigChangeType == "Software" and ChangeCategory == "Removed"
| order by TimeGenerated desc
```

For a complete configuration walkthrough, see [Configure Change Tracking and Inventory data collection rules](/azure/azure-change-tracking-inventory/tutorial-change-workspace-configure-data-collection-rule).
