When you need to do a full investigation on data stored in archived logs, restore a table from the Search page in Microsoft Sentinel. Specify a target table and time range for the data you want to restore. Within a few minutes, the log data is restored and available within the Log Analytics workspace. Then you can use the data in high-performance queries that support full KQL.

A restored log table is available in a new table that has a ***_RST** suffix. The restored data is available as long as the underlying source data is available. But you can delete restored tables at any time without deleting the underlying source data. To save costs, we recommend you delete the restored table when you no longer need it.

## Limitations of log restore
Before you start to restore an archived log table, be aware of the following limitations:

- Restore data for a minimum of two days.
- Restore data more than 14 days old.
- Restore up to 60 TB.
- Restore is limited to one active restore per table.
- Restore up to four archived tables per workspace per week.
- Limited to two concurrent restore jobs per workspace.

## Restore archived log data

To restore archived log data in Microsoft Sentinel, specify the table and time range for the data you want to restore. Within a few minutes, the log data is available within the Log Analytics workspace. Then you can use the data in high-performance queries that support full KQL.

You can restore archived data directly from the Search  page or from a saved search.

1. In the Azure portal, go to Microsoft Sentinel and select the appropriate workspace.
1. Under General, select Search.
1. Restore log data in one of two ways:

    - At the top of Search page, select Restore, or
    - Select the Saved Searches tab and Restore on the appropriate search.

1. Select the table you want to restore.
1. Select the time range of the data that you want restore.
1. Select Restore.
1. Wait for the log data to be restored. View the status of your restoration job by selecting on the Restoration tab.

## View restored log data

View the status and results of the log data restore by going to the Restoration tab. You can view the restored data when the status of the restore job shows Data Available.

1. In your Microsoft Sentinel workspace, select Search > Restoration.

1. When your restore job is complete, select the table name.

1. Review the results.


The Logs query pane shows the name of table containing the restored data. The Time range is set to a custom time range that uses the start and end times of the restored data.

## Delete restored data tables

To save costs, we recommend you delete the restored table when you no longer need it. When you delete a restored table, Azure doesn't delete the underlying source data.

1. In your Microsoft Sentinel workspace, select Search > Restoration.

1. Identify the table you want to delete.

1. Select Delete for that table  row. 


