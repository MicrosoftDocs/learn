When using Event Hubs, it's crucial for you to monitor your hub to ensure that it's working and performing as expected.

Continuing with the banking example, suppose that you've deployed Azure Event Hubs and configured sender and receiver applications. Your applications are ready for testing the payment processing solution. The sender application collects customer's credit card data and the receiver application verifies that the credit card is valid. Due to the sensitive nature of your employer's business, it's essential that your payment processing is robust and reliable, even when it's temporarily unavailable.

You must evaluate your Event Hub by testing that your Event Hub is processing data as expected. The metrics available in the Event Hubs allow you to ensure that it's working fine.

## How do you use the Azure portal to view your Event Hub activity?

The Azure portal > Overview page for your Event Hub shows message counts. These message counts represent the data (events) received and sent by the Event Hub. You can choose the timescale for viewing these events.

![Screenshot of the Azure portal displaying the Event Hub namespace with message counts.](../media/6-view-messages.png)

## How can you test Event Hub resilience?

Azure Event Hubs keeps receiving messages from the sender application even when it's unavailable. The messages received during this period are transmitted successfully as soon as the hub becomes available.

To test this functionality, you can use the Azure portal to disable your Event Hub.

When you re-enable your Event Hub, you can rerun your receiver application and use Event Hubs metrics for your namespace to check whether all sender messages have been successfully transmitted and received.

Other useful metrics available in the Event Hubs include:

- Throttled Requests: The number of requests that were throttled because the throughput unit usage was exceeded.
- ActiveConnections: The number of active connections on a namespace or Event Hub.
- Incoming/Outgoing Bytes: The number of bytes sent to/received from the Event Hubs service over a specified period.

## Summary

The Azure portal provides message counts and other metrics that you can use as a health check for your Event Hubs.
