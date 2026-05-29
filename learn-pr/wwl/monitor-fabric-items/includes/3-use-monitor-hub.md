Visualization tools make monitoring easier. They help you identify trends or anomalies. Monitor hub is the monitoring visualization tool in Microsoft Fabric. Monitor hub collects and aggregates data from selected Fabric items and processes. It stores Fabric activity data in a common interface so you can view the status of multiple different data integration, transformation, movement, and analysis activities in Fabric in one place, rather than monitor each separately.

## Activities displayed in the Monitor hub
Some of the activities you can see monitoring metadata for in the Microsoft Fabric Monitor hub include:

- Copy Job execution history
- Data pipeline execution history
- Dataflow Gen2 executions (Dataflow Gen1 isn't supported)
- Datamart and semantic model refreshes
- Lakehouse operations
- Notebook execution history
- Spark job and notebook execution history and job details
- User data function executions

The full list of supported item types continues to expand as new Fabric items are released.

## View the Monitor Hub
The Monitor hub can be opened by selecting **Monitor** from the Fabric navigation pane.  

 :::image type="content" source="../media/monitor-hub.png" alt-text="Screenshot of the Microsoft Fabric Monitor hub interface." :::

## View Fabric activity detail
Each activity in Monitor hub can be selected and several actions can be performed for the selected activity. Actions vary by activity and include options such as: opening the activity, retrying it, viewing activity details or historical runs.

To open the details pane for an activity, hover over the activity name and select the **View details** symbol (**i**). The details pane shows status, timing, duration, and error information.

  :::image type="content" source="../media/view-monitor-hub-details.png" alt-text="Screenshot of the Microsoft Fabric Monitor hub details interface." :::

When you select **View details**, the pane is customized for the activity you select and provides clarity about what happened. You can view metadata such as:

- Activity status
- Start and end time
- Duration
- Activity statistics

To view the full 30-day history for a specific activity, hover over the activity name, select **More options** (**...**), and then select **Historical runs**. This is useful for comparing current activity performance against past executions to identify when errors were introduced.

## Investigate what happened during a Fabric activity
To investigate what happened during an activity some activities in Monitor hub include hyperlinks that allow you to drill down into execution details. Information is provided about any errors and the success or failure of an execution. Spark activities across items can be viewed. You can view Spark applications triggered from Notebooks, Spark Job Definitions, and Pipelines. For more information, see: [Apache Spark monitoring overview](/fabric/data-engineering/spark-monitoring-overview)

## Manage failure notifications

The Monitor hub has two pages: **Activities** and **Schedule failures (Preview)**. The **Schedule failures** page lists every scheduled item that has failure notifications configured, so you can add, edit, or remove notification recipients for any item from one place — without opening each item individually.

To configure failure notifications for a scheduled item, select **+ Configure notifications** on the Schedule failures page, choose an item, and enter the recipients. Recipients can be users or groups in your Microsoft Entra tenant. You need at least the **Contributor** role in the workspace to configure notifications.

> [!NOTE]
> The Schedule failures page is currently in preview. Semantic models aren't yet supported on this page. Failure notifications apply only to scheduled runs — manually triggered runs don't generate notifications.

