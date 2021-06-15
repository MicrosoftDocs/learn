In this exercise, you configure [Azure Event Hubs](/azure/event-hubs/event-hubs-about) as an input for Azure Stream Analytics to ingest streaming vehicle telemetry data. Event Hubs acts as the entry point to a near-real-time analytics pipeline built on Azure Event Hubs, Azure Stream Analytics, and Power BI.

1. From your Stream Analytics job's blade in the [Azure portal](https://portal.azure.com/), select **Inputs** in the left-hand navigation menu.

    ![The Inputs link is selected in the left-hand menu.](../media/inputs-link.png "Inputs link")

2. From the Inputs blade, select **+ Add stream input** in the top toolbar, then select **Event Hub** to create a new Event Hub input.

    ![The Add stream input button and Event Hub menu item are highlighted.](../media/stream-analytics-add-input-link.png "Add stream input - Event Hub")

3. In the **New Input** blade, configure the following:

    - **Name:** Enter "eventhub".
    - **Select Event Hub from your subscriptions:** Selected.
    - **Subscription:** Make sure the subscription you are using for this lab is selected.
    - **Event Hub namespace:** Select the Event Hub namespace you are using for this lab.
    - **Event Hub name:** Create and event hub name named **telemetry**.
    - **Event Hub consumer group:** Select **Use existing**, then select **$Default**.
    - **Authentication mode:** Select **Connection string**.
    - **Event Hub policy name:** Select **Use existing**, then select **Read**.
    - Leave all other values at their defaults.

        ![The New Input form is filled out with the previously mentioned settings entered into the appropriate fields.](../media/stream-analytics-new-input.png "New Input")

4. Select **Save** on the bottom of the form when you have finished entering the values.
