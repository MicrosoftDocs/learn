
Retention policies define when to remove or archive data in a Log Analytics workspace. Archiving lets you keep older, less used data in your workspace at a reduced cost. To configure data retention and archiving, you must have at least contributor rights on the Log Analytics workspace.

## Retention and archiving
During the interactive retention period, data is available for monitoring, troubleshooting, and analytics. When you no longer use the logs, but still need to keep the data for compliance or occasional investigation, you can archive the logs to reduce costs.

Archived data stays in the same table, alongside the data that's available for interactive queries. When you set a total retention period that's longer than the interactive retention period, Log Analytics automatically archives the relevant data immediately at the end of the retention period.

When you shorten an existing retention policy, Azure Monitor waits 30 days before removing the data, so you can revert the change and prevent data loss in the event of an error in configuration. You can purge data immediately when required.

When you increase the retention policy, the new retention period applies to all data that's already been ingested into the table and hasn't yet been purged or removed.

If you change the archive settings on a table with existing data, the relevant data in the table is also affected immediately. For example, you might have an existing table with 180 days of interactive retention and no archive period. You decide to change the retention policy to 90 days of interactive retention without changing the total retention period of 180 days. Log Analytics immediately archives any data that's older than 90 days and none of the data is deleted.

## Configuring default Log Analytics Workspace retention policy
You can set the workspace default retention policy in the Azure portal to 30, 31, 60, 90, 120, 180, 270, 365, 550, and 730 days. You can set a different policy for specific tables by configuring the retention and archive policy at the table level. If you're on the free tier, you'll need to upgrade to the paid tier to change the data retention period.

To set the default workspace retention policy:
1. From the Log Analytics workspaces menu in the Azure portal, select your workspace.
1. Select **Usage and estimated costs** in the left pane.
1. Select **Data Retention** at the top of the page.
1. Adjust the slider to increase or decrease the number of days, and then select **OK**.

## Configure retention and archive policies by table
By default, all tables in your workspace inherit the workspace's interactive retention setting and have no archive policy. You can modify the retention and archive policies of individual tables, except for workspaces in the legacy Free Trial pricing tier. The Analytics log data plan includes 30 days of interactive retention. You can increase the interactive retention period to up to 730 days though this will increase costs.

To set the retention and archive duration for a table in the Azure portal:
1. From the Log Analytics workspaces menu, select **Tables**. The Tables screen lists all the tables in the workspace.
1. Select the context menu for the table you want to configure and select **Manage table**. 
1. Configure the retention and archive duration in the Data retention settings section of the table configuration screen.