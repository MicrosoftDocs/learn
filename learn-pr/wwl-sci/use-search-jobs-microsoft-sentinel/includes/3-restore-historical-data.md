When you need to do a full investigation on data stored in archived logs, restore a table from the Search page in Microsoft Sentinel. Specify a target table and time range for the data you want to restore. Within a few minutes, the log data is restored and available within the Log Analytics workspace. Then you can use the data in high-performance queries that support full KQL.

A restored log table is available in a new table that has a ***_RST** suffix. The restored data is available as long as the underlying source data is available. But you can delete restored tables at any time without deleting the underlying source data. To save costs, we recommend you delete the restored table when you no longer need it.

## Limitations of log restore

Before you start to restore an archived log table, be aware of the following limitations:

- Restore data for a minimum of two days.
- Restore up to 60 TB.
- Restore is limited to one active restore per table.
- Restore up to four archived tables per workspace per week.
- Limited to two concurrent restore jobs per workspace.

> [!NOTE]
> Tables with the Auxiliary table plan don't support data restore. Use a search job to retrieve data that's in long-term retention from an Auxiliary table.

## Restore archived log data

To restore archived log data in Microsoft Sentinel, specify the table and time range for the data you want to restore. Within a few minutes, the log data is available within the Log Analytics workspace. Then you can use the data in high-performance queries that support full Kusto Query Language (KQL).

Restore archived data directly from search or from a saved search.

1. In the [Defender portal](https://security.microsoft.com/), select **Microsoft Sentinel** > **Data lake exploration** > **Search & restore**. In the [Azure portal](https://portal.azure.com), the **Search** page is listed under **General**.

### [Defender portal](#tab/defender-portal)

1. 1. Restore log data using one of the following methods:

   - Select :::image type="icon" source="../media/restore-button.png" border="false"::: **Restore** at the top of the page. In the **Restoration** pane on the side, select the table and time range you want to restore, and then select **Restore at the bottom of the pane**.

     :::image type="content" source="../media/restore-defender.png" alt-text="Screenshot of restoring a specific site search.":::

   - Select **Saved searches**, locate the search results you want to restore, and then select **Restore**. If you have multiple tables, select the one you want to restore and then select **Actions > Restore** in the side pane. For example:

      :::image type="content" source="../media/restore-defender-saved.png" alt-text="Screenshot of restoring a specific site search.":::

1. Wait for the log data to be restored. View the status of your restoration job by selecting on the **Restoration** tab.

### [Azure portal](#tab/azure-portal)

1. Restore log data using one of the following methods:

   - Select :::image type="icon" source="../media/restore-button.png" border="false"::: **Restore** at the top of the page. In the **Restoration** pane on the side, select the table and time range you want to restore, and then select **Restore at the bottom of the pane**.

   - Select **Saved searches**, locate the search results you want to restore, and then select **Restore**. If you have multiple tables, select the one you want to restore and then select **Actions > Restore** in the side pane. For example:

      :::image type="content" source="../media/restore-azure.png" alt-text="Screenshot of restoring a specific site search.":::

1. Wait for the log data to be restored. View the status of your restoration job by selecting on the **Restoration** tab.

---

## View restored log data

View the status and results of the log data restore by going to the **Restoration** tab. You can view the restored data when the status of the restore job shows **Data Available**.

1. In Microsoft Sentinel, select **Search** > **Restoration**.

1. When your restore job is complete and the status is updated, select the table name and review the results.

   In the [Azure portal](https://portal.azure.com), results are shown in the **Logs** query page. In the [Defender portal](https://security.microsoft.com/), after you select the table name on the **Microsoft Sentinel** > **Data lake exploration** > **Search & restore** > **Restoration** tab, results are shown in the **Advanced hunting** page.

   For example:

   :::image type="content" source="../media/restored-data-logs-view-defender.png" alt-text="Screenshot that shows the logs query pane with the restored table results.":::

   The **Time range** is set to a custom time range that uses the start and end times of the restored data.

## Delete restored data tables

To save costs, we recommend you delete the restored table when you no longer need it. When you delete a restored table, the underlying source data isn't deleted.

1. In the [Defender portal](https://security.microsoft.com/), go to **Microsoft Sentinel** > **Data lake exploration** > **Search & restore** > **Restoration** and identify the table you want to delete.

1. Select **Delete** for that table row to delete the restored table.

For example:

   :::image type="content" source="../media/delete-restore.png" alt-text="Screenshot that shows the delete restored table page in the Defender portal.":::
