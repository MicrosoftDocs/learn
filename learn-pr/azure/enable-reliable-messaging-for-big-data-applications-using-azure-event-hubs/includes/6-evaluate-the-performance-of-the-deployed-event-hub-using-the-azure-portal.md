## Motivation

When using Event Hubs it is crucial that you can see that a hub is working, and that it performs as expected. In the banking example, the bank has deployed an Azure Event Hub, and you have configured sender and receiver applications ready for testing the payment processing solution. The sender application collects customer's credit card data, and the receiver application verifies that the credit card is valid.

As a first step in the bank's evaluation of Event Hubs in a payment solution, you need to verify that the Event Hub is up and running. The bank's reputation requires payment processing to be robust and reliable, even at times of exceptional demand, so you need to know how to test that Event Hub messaging works, even when the Event Hub is temporarily unavailable; and you need to be able to present metrics to management, and to customers, to help them be reassured that the Event Hub (as a key component of the payment processing solution) is working.

## How do you use the Azure Portal to view Event Hub activity?

In the Azure portal, the Overview page for an Event Hub shows message counts. These message counts represent the data (events) that are being received by the Event Hub and the data being passed onto consuming applications. You can choose the timescale for viewing these events.

![View Event Hub messages](../images/view-messages.png)

## How can you test Event Hub resilience?

To find out what happens when an application sends messages to an Event Hub, and then the Event Hub becomes temporarily unavailable to consuming applications, you can use the Azure Portal to disable the Event Hub.

When you then re-enable the Event Hub, you can re-run your receiver application and use Event Hub Metrics for your namespace to check whether all sender messages have been successfully transmitted and received.

As well as checking for incoming and outgoing messages, other useful metrics include:

- Throttled Requests: The number of requests that were throttled because the throughput unit usage was exceeded.
- ActiveConnections: The number of active connections on a namespace, or Event Hub.
- Incoming/Outgoing Bytes: The number of bytes sent to/received from the Azure Event Hubs service over a specified period.

## Summary

The Azure Portal provides message counts and other metrics, that you can use as a health check for your Event Hubs. In the next unit, you will use your knowledge of Event Hub metrics to confirm when applications are successfully sending and receiving messages through your Event Hub.
