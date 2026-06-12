Fabric provides several tools for loading data into a warehouse. The first is **data pipelines** — a visual, low-code way to ingest and orchestrate data at scale. You build workflows that move data from source to destination, apply transformations, and schedule recurring loads without writing code.

A data pipeline can contain multiple activities — Copy, Dataflow, stored procedure calls, and more — chained together into a single workflow. A common starting point is a **Copy job**, which handles straightforward source-to-destination data movement through a guided wizard.

## Create a Copy job

To create a Copy job:

1. In your workspace, select **+ New item**. Under **Get data**, select **Copy job**.
2. Enter a name for your Copy job and select **Create**.
3. On the **Choose data source** page, select your source from the **OneLake catalog**, then select **Next**.
4. Preview the selected dataset and confirm your selection, then select **Next**.
5. On the **Choose data destination** page, select your destination warehouse from the **OneLake catalog**.
6. Choose the copy mode: **Full copy** loads all source data on every run. **Incremental** loads only rows that changed since the previous run.
7. Adjust the destination schema and table name as needed, then select **Next**.
8. Optionally, select **Edit column mapping** to rename columns, change data types, or exclude columns from the load.
9. Review the summary on the **Review + save** page and select **Save + Run**.

The Copy job runs and a new pipeline activity appears in the pipeline canvas. Navigate to your warehouse to preview the table and confirm the load succeeded.

For example, you could create a Copy job that loads daily sales CSV files from Azure Blob Storage into your warehouse each morning before your analytics team arrives.

## Schedule and monitor a pipeline

After you create a pipeline, you can schedule it to run automatically. Select **Schedule** from the pipeline editor toolbar to set a recurring frequency.

:::image type="content" border="false" source="../media/3-schedule-data-pipeline.png" alt-text="Screenshot showing where to schedule a data pipeline from the pipeline designer." lightbox="../media/3-schedule-data-pipeline.png":::

In the schedule configuration, you set the start date, recurrence pattern (hourly, daily, weekly), and time zone. You can also configure a schedule from **Settings** in the **Home** menu.

:::image type="content" border="false" source="../media/3-schedule-configuration.png" alt-text="Screenshot showing the configuration properties when you schedule a data pipeline." lightbox="../media/3-schedule-configuration.png":::

Once a scheduled pipeline runs, you can monitor execution history, check run status, and review error details from the pipeline's monitoring view. This helps you identify and troubleshoot failed loads before they affect downstream reports.
