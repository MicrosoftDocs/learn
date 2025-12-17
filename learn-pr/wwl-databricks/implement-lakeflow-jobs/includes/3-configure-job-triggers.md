When you configure job triggers in Lakeflow Jobs, you enable automated pipeline execution based on data events rather than fixed schedules. Your jobs can respond to changes in source tables, new file arrivals, or run continuously to process data as it becomes available.

In this unit, you learn how to configure event-based triggers that automate your data workflows.

## Understand trigger types for automated job execution

Lakeflow Jobs supports several trigger types that determine when your jobs run. While scheduled triggers run at fixed times, event-based triggers respond to data changes in your environment.

:::image type="content" source="../media/3-configure-trigger.png" alt-text="Screenshot of the lakeflow job trigger dialog." lightbox="../media/3-configure-trigger.png":::

| Trigger type | Behavior |
|--------------|----------|
| **Table update** | Runs when monitored tables receive new data or modifications |
| **File arrival** | Runs when new files appear in a Unity Catalog storage location |
| **Continuous** | Runs immediately after the previous run completes or fails |

Each trigger type addresses different automation scenarios. Table update triggers work well when your job depends on upstream data processing. File arrival triggers handle scenarios where external systems drop files into storage locations. Continuous triggers keep your jobs running around the clock for near real-time processing.

To add a trigger to an existing job, open the job in your workspace, navigate to the **Job details** pane, and select **Add trigger** under **Schedules & Triggers**. From there, you select the trigger type and configure its settings.

## Configure table update triggers

Table update triggers run your job when source tables receive updates. This approach eliminates the need for continuously running clusters while ensuring your pipeline processes new data promptly.

A table update trigger monitors one or more Unity Catalog tables for data changes such as inserts, updates, merges, and deletes. The supported table types include:

- Unity Catalog Delta and Iceberg managed tables
- Unity Catalog external tables backed by Delta Lake
- Materialized views and streaming tables
- Unity Catalog views that depend on supported tables

When you configure a table update trigger with multiple tables, you choose between two behaviors. Select **Any table is updated** to run the job when any monitored table changes. Select **All tables are updated** to wait until every monitored table receives an update before triggering a run.

Consider a scenario where your transformation job depends on data from three source tables. If your business logic requires all three sources to be current before processing, configure the trigger with **All tables are updated**. If processing partial updates is acceptable, use **Any table is updated** for faster response times.

The following advanced options give you finer control over trigger timing:

- **Minimum time between triggers**: Sets a waiting period after a job completes before the next run can start, even if tables are updated during this window
- **Wait after last change**: Delays the trigger for a specified time after a table update, resetting if additional updates occur

These settings help you batch updates efficiently. For example, if your upstream processes update tables in rapid succession, a 60-second wait after last change ensures your job processes the complete batch rather than triggering multiple runs.

When you add a table update trigger, your job gains access to dynamic parameter values that provide context about what triggered the run:

```
{{job.trigger.table_update.updated_tables}}
{{job.trigger.table_update.<catalog.schema.table>.commit_timestamp.iso_datetime}}
{{job.trigger.table_update.<catalog.schema.table>.version}}
```

You can pass these values to your tasks to customize processing based on which tables changed or to track data lineage.

> [!TIP]
> For optimal performance with table update triggers, enable file events on the external location where your tables are stored. This one-time setup step uses cloud provider change notifications to track updates more efficiently.

## Configure file arrival triggers

File arrival triggers run your job when new files appear in a Unity Catalog external location or volume. This trigger type integrates well with scenarios where external systems deliver data files on irregular schedules.

A file arrival trigger monitors a specified path and recursively checks all subdirectories for new files. The trigger makes a best-effort check approximately every minute, though cloud storage performance can affect timing.

To configure a file arrival trigger, specify the storage location using the full path to an external location or volume:

```
/Volumes/mycatalog/myschema/myvolume/
/Volumes/mycatalog/myschema/myvolume/incoming/
```

:::image type="content" source="../media/3-configure-file-arrival-trigger.png" alt-text="Screenshot of the lakeflow file arrival trigger dialog." lightbox="../media/3-configure-file-arrival-trigger.png":::

Before creating a file arrival trigger, verify you have:

- A workspace with Unity Catalog enabled
- READ permission on the storage location
- CAN MANAGE permission on the job

Like table update triggers, file arrival triggers support advanced timing options. Use **Minimum time between triggers** to control run frequency, and **Wait after last change** to batch multiple file arrivals into a single processing run.

> [!IMPORTANT]
> File arrival triggers respond only to new files. Overwriting an existing file with the same name doesn't trigger a run. Design your file delivery processes to use unique file names for each batch.

For production workloads, enable file events on your external location. Without file events enabled, you're limited to 50 jobs with file arrival triggers per workspace, and each monitored location can contain at most 10,000 files. With file events enabled, these limitations don't apply.

## Configure continuous triggers

Continuous triggers keep your job running by starting a new run immediately after the previous one completes or fails. This approach suits scenarios requiring near real-time data processing.

When you configure a continuous trigger, your job enters a perpetual cycle: complete a run, start the next run. If a run fails, the trigger still starts a new run, making continuous jobs resilient to transient errors.

:::image type="content" source="../media/3-configure-continuous-trigger.png" alt-text="Screenshot of the lakeflow continuous trigger dialog." lightbox="../media/3-configure-continuous-trigger.png":::

Continuous triggers work well for:

- Processing streaming data where low latency matters
- Monitoring systems that need constant operation
- ETL workflows that must keep pace with high-volume data sources

Before enabling a continuous trigger, consider the cost implications. Your job continuously consumes compute resources, which can add up over time. Use serverless compute to optimize costs, as it scales automatically based on workload.

> [!NOTE]
> When you resume a paused continuous trigger while a run is still active, the scheduler waits for that run to complete before triggering a new one.

## Manage trigger lifecycle

After you configure triggers, you can pause and resume them without deleting the configuration. In the **Job details** pane under **Schedules & Triggers**, the **Pause** and **Resume** buttons control trigger state.

Pausing a trigger stops new runs from starting while allowing any active run to complete. This capability is useful during maintenance windows or when you need to investigate issues without losing your trigger configuration.

To receive notifications when trigger evaluation fails, configure email or system destination notifications on your job. This approach ensures you're informed when triggers encounter problems such as permission changes or table deletions.

Now that you understand how to configure triggers that automate job execution based on data events, you can build responsive pipelines that process data as it becomes available.
