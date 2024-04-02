The design and development of queries often includes solving practical time handling problems in the Azure Stream Analytics service. Time handling design decisions are closely related to event ordering factors.

It is important to understand how time is managed for time-based streaming data even if you won't be exposed to advanced timing scenarios.

## Background time concepts

Consider the following definitions for background time concepts:

 -  **Event time**: The time when the original event happened. For example, when a moving car on the highway approaches a toll booth.
 -  **Processing time**: The time when the event reaches the processing system and is observed. For example, when a toll booth sensor sees the car and the computer system takes a few moments to process the data.
 -  **Watermark**: An event time marker that indicates up to what point events have been ingressed to the streaming processor. Watermarks let the system indicate clear progress on ingesting the events. By the nature of streams, the incoming event data never stops, so watermarks indicate the progress to a certain point in the stream. The watermark concept is important. Watermarks allow Stream Analytics to determine when the system can produce complete, correct, and repeatable results that don’t need to be retracted. The processing can be done in a guaranteed way that's predictable and repeatable. For example, if a recount needs to be done for some error handling condition, watermarks are safe starting and ending points.

## Choosing the best starting time

Stream Analytics gives users two choices for picking event time:

 -  **Arrival time**: Arrival time is assigned at the input source when the event reaches the source. You can access arrival time by using the **EventEnqueuedUtcTime** property for Event Hubs inputs, **IoTHub.EnqueuedTime** property for IoT Hub, and using the **BlobProperties.LastModified** property for blob input. Using arrival time is the default behavior, and best used for data archiving scenarios, where there's no temporal logic necessary.
 -  **Application time** (also named Event Time): Application time is assigned when the event is generated, and it's part of the event payload. To process events by application time, use the **Timestamp by** clause in the select query. If the **Timestamp by** clause is absent, events are processed by arrival time. It’s important to use a timestamp in the payload when temporal logic is involved. That way, delays in the source system or in the network can be accounted for.

## How time progresses in Azure Stream Analytics

When using application time, the time progression is based on the incoming events. It’s difficult for the stream processing system to know if there are no events, or if events are delayed. For this reason, Azure Stream Analytics generates heuristic watermarks in the following ways for each input partition:

 -  Whenever there's any incoming event, the watermark is the largest event time we have seen so far minus the out-of-order tolerance window size.
 -  Whenever there is no incoming event, the watermark is the current estimated arrival time (the elapsed time on behind the scenes VM processing the events from last time an input event is seen plus that input event’s arrival time) minus the late arrival tolerance window. The arrival time can only be estimated, because the real arrival time is generated on the input event broker, such as Event Hubs, and not the Azure Stream Analytics VM processing the events.

The design serves two more purposes, besides generating watermarks:

 -  The system generates results in a timely fashion with or without incoming events. You have control over how timely they want to see the output results. In the Azure portal, on the **Event ordering** page of your Stream Analytics job, you can configure the **Out of order events** setting. When configuring that setting, consider the trade-off of timeliness with tolerance of out-of-order events in the event stream. The late arrival tolerance window is important to keep generating watermarks, even in the absence of incoming events. At times, there may be a period where no incoming events come in, such as when an event input stream is sparse. That problem is exacerbated by the use of multiple partitions in the input event broker. Streaming data processing systems without a late arrival tolerance window may suffer from delayed outputs when inputs are sparse and multiple partitions are used.
 -  The system behavior has to be repeatable. Repeatability is an important property of a streaming data processing system. The watermark is derived from arrival time and application time. Both are persisted in the event broker, and thus repeatable. In the case the arrival time has to be estimated in the absence of events, Azure Stream Analytics journals the estimated arrival time for repeatability during replay to support of failure recovery.

Notice that when you choose to use **arrival time** as the event time, there is no need to configure the out-of-order tolerance and late arrival tolerance. Since **arrival time** is guaranteed to be monotonically increasing in the input event broker, Azure Stream Analytics simply disregards the configurations.

> [!NOTE]
> You can review additional information describing [more advanced time handling considerations](/azure/stream-analytics/stream-analytics-time-handling).
