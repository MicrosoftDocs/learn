## Transforming and processing event data

To transform and process event data in Microsoft Fabric eventstream, you can use the event processor editor. The event processor editor is a no-code experience that allows you to drag and drop to design the event data processing logic. You can use it to [process](/fabric/real-time-analytics/event-streams/process-events-using-event-processor-editor) your data before it's ingested into your lakehouse

## Add and manage event processors in eventstream

To add and manage event processors in eventstream in Microsoft Fabric, you can use the event processor editor. The event processor editor is a no-code experience that allows you to drag and drop to design the event data processing logic. You can use it to process your data before its ingested into your lakehouse. 

* You can add a Lakehouse destination and enter the necessary parameters in the right pane, then select Open event processor. The Event processing editor screen appears.
* In the Event processing editor canvas, select the eventstream node. You can preview the data schema, rename the column, or change the data type in the right Eventstream pane.
* From the Operations menu in the ribbon, select an operator to add event processing logic.
  * For example, select Manage fields.
* Select the line between the eventstream and the lakehouse and press the Delete key to remove the connection between them. You must delete this connection before you can insert the Manage fields operator between them.
* On the left edge of the eventstream node, click and drag the green circle with your mouse to connect it to the Manage fields operator node.
* Follow the same process to connect the Manage fields operator node to the lakehouse node.
* Select the Manage fields operator node.
* In the Manage fields configuration panel, select the fields you want to output.
* If you want to add all fields, select Add all fields.
  * You can also add a new field with the [built-in functions](/fabric/real-time-analytics/event-streams/process-events-using-event-processor-editor) to aggregate the data from upstream

## Event processors available in eventstream

You can use the event processor editor to transform your event data according to your business needs. The event processor provides six operators, which you can use to transform your event data. These operators include:

1. **Aggregate**: Use the Aggregate transformation to calculate an aggregation (Sum, Minimum, Maximum, or Average) every time a new event occurs over a period of time.
2. **Filter rows**: Use the Filter rows transformation to filter out rows that don’t meet specific criteria.
3. **Join streams**: Use the Join streams transformation to join two or more streams based on a common key.
4. **Manage fields**: Use the Manage fields transformation to manipulate fields in your data stream.
5. **Select columns**: Use the Select columns transformation to select specific columns from your data stream.
6. **Sort rows**: Use the Sort rows transformation to sort rows in your data stream based on one or more columns.

## Use Filter to select events based on conditions



## Use Enrich to add additional information to ev
## Use Aggregate to group and summarize events

## Use Join to combine events from different sources
