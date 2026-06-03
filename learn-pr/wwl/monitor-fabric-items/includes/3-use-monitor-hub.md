The monitoring hub is a centralized interface in Microsoft Fabric that aggregates activity data from across your workspace. Instead of opening each pipeline, dataflow, or notebook individually to check its status, you can view all recent activity in one place. The monitoring hub is where you go to answer questions like "Did last night's data load succeed?" and "How long did the notebook take to run?"

## Open the monitoring hub

To open the monitoring hub, select **Monitor** from the navigation pane on the left side of the Fabric portal. The main view displays a table of recent activities with columns for the activity name, status, item type, start time, and other metadata.

:::image type="content" source="../media/monitor-dataflow.png" alt-text="Screenshot of the Microsoft Fabric monitoring hub showing recent activity with status, item type, and start time columns." :::

## Understand activity status

Each row in the monitoring hub represents a single activity execution. The **Status** column tells you the outcome:

- **Succeeded** — The activity completed without errors. This is the expected state for routine runs.
- **Failed** — The activity encountered an error and didn't complete. Select the activity to view error details and identify the root cause.
- **In progress** — The activity is currently running. If an activity stays in this state longer than expected, it might be stuck or processing an unusually large dataset.
- **Cancelled** — Someone or something stopped the activity before it finished. Check whether the cancellation was intentional or caused by a timeout or capacity limit.

When you see a mix of statuses, focus on the failures first. A single failed dataflow can mean stale data in every downstream report.

## View activity details

To investigate a specific activity, hover over the activity name and select the **View details** symbol (**i**). The details pane opens on the right side and shows:

- **Start time and end time** — When the activity began and finished. Compare these to the activity's typical schedule to spot delays.
- **Duration** — How long the activity ran. A sudden increase in duration, even for a succeeded activity, can indicate a data volume spike or resource contention.
- **Status details** — For failed activities, this section includes error messages and error codes that help you diagnose the problem.
- **Activity-specific metadata** — Depending on the item type, you might see additional details like the number of rows processed, Spark application IDs, or refresh attempt counts.

  :::image type="content" source="../media/view-monitor-hub-details.png" alt-text="Screenshot of the Microsoft Fabric Monitor hub details interface." :::

## View historical runs

A single run tells you what happened now. Historical runs tell you what's been happening over time. To view the run history for a specific activity, hover over the activity name, select **More options** (**...**), and then select **Historical runs**. The monitoring hub displays up to 30 days of run history for that item.

:::image type="content" source="../media/historical-runs.png" alt-text="Screenshot of the monitoring hub historical runs view showing multiple runs of a pipeline with activity name, status, item type, and start time columns." :::

Historical runs help you answer questions like:

- **When did this start failing?** — If a dataflow failed today, check whether it also failed yesterday or last week. A pattern of recent failures points to a specific change that introduced the problem.
- **Is it getting slower?** — Compare durations across runs. A notebook that took 2 minutes last week but takes 8 minutes today might be processing more data or hitting resource limits.
- **Are there retry patterns?** — A semantic model refresh that regularly retries before succeeding indicates a flaky connection to the data source.

To see details for any historical run, select **More options** (**...**) for that run and then select **View detail**.

## Filter and customize the view

In a busy workspace with dozens of scheduled activities, the monitoring hub can display a long list of events. Use filters and column customization to focus on what matters.

Select the **Filter** button to narrow the view by:

- **Status** — Show only failed activities to focus on problems, or only succeeded activities to verify routine operations.
- **Item type** — Show only Dataflow Gen2 activities, only notebooks, or only pipelines. This is useful when you're troubleshooting a specific part of your data pipeline.

:::image type="content" source="../media/monitor-filter.png" alt-text="Screenshot of the monitoring hub with filters applied for Pipeline and Dataflow Gen2 item types, showing only succeeded activities." :::

Select the **Column options** button to add or remove columns. The default view shows a limited set of columns, but you can add useful columns like:

- **Submitted by** — Who or what triggered the activity (a user, a schedule, or a pipeline).
- **Location** — The workspace where the activity ran.
- **Duration** — How long the activity took.
- **End time** — When the activity finished.
- **Refresh type** — Whether the run was scheduled, manual, or triggered by a pipeline.

Customizing columns helps you compare activities side by side and spot patterns more quickly.

## Manage failure notifications

The monitoring hub includes a **Schedule failures** page where you can configure email alerts for scheduled item failures across your entire workspace from one place, rather than opening each item individually. Select **Configure notifications**, choose an item, and add recipients. You need at least the **Contributor** role in the workspace to configure notifications.

## Workspace monitoring

The monitoring hub gives you a real-time view of recent activity, but for deeper analysis, Microsoft Fabric offers **workspace monitoring**. When you enable workspace monitoring, Fabric creates an Eventhouse database in your workspace that continuously collects diagnostic logs and metrics from your Fabric items.

Unlike the monitoring hub, which provides a visual dashboard for recent activity, workspace monitoring stores raw log data that you can query with KQL or SQL. This enables advanced analysis like identifying long-term performance trends across items, correlating failures across pipelines and notebooks, and building custom Real-Time dashboards for your team's specific monitoring needs.

You enable workspace monitoring in the workspace settings under the **Monitoring** tab. Workspace monitoring retains data for 30 days and is accessible to workspace users with at least a Contributor role. For more information, see [What is workspace monitoring?](/fabric/fundamentals/workspace-monitoring-overview).