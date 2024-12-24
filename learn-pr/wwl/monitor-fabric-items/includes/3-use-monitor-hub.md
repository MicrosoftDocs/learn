Visualization tools make monitoring easier. They help you identify trends or anomalies. Monitor hub is the monitoring visualization tool in Microsoft Fabric. Monitor hub collects and aggregates data from selected Fabric items and processes. It stores Fabric activity data in a common interface so you can view the status of multiple different data integration, transformation, movement, and analysis activities in Fabric in one place, rather than monitor each separately.

## Activities displayed in the Monitor hub
Some of the activities you can see monitoring metadata for in the Microsoft Fabric Monitor hub include:

- Data pipeline execution history
- Dataflow executions
- Datamart and semantic model refreshes
- Spark job and notebook execution history and job details

## View the Monitor Hub
The Monitor hub can be opened by selecting **Monitor** from the Fabric navigation pane.  

 :::image type="content" source="../media/monitor-hub.png" alt-text="Screenshot of the Microsoft Fabric Monitor hub interface." :::

## View Fabric activity detail
Each activity in Monitor hub can be selected and several actions can be performed for the selected activity. Actions vary by activity and include options such as: opening the activity, retrying it, viewing activity details or historical runs. To view this information, select the ellipsis that appears when you hover over an activity. 

  :::image type="content" source="../media/view-monitor-hub-details.png" alt-text="Screenshot of the Microsoft Fabric Monitor hub details interface." :::

When you select **View detail**, the screen that appears is customized for the activity you select and provides clarity about what happened during the activity. You can view metadata such as:

- Activity status
- Start and end time
- Duration
- Activity statistics

## Investigate what happened during a Fabric activity
To investigate what happened during an activity some activities in Monitor hub include hyperlinks that allow you to drill down into execution details. Information is provided about any errors and the success or failure of an execution. Spark activities across items can be viewed. You can view Spark applications triggered from Notebooks, Spark Job Definitions, and Pipelines. For more information, see: [Apache Spark monitoring overview](/fabric/data-engineering/spark-monitoring-overview)

