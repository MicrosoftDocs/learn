The process of consuming data streams, analyzing them, and deriving actionable insights out of them is called event processing. An event processing pipeline has three distinct components:

- **Event producer**: Examples include sensors or processes that generate data continuously, such as a heart rate monitor or a highway toll lane sensor.
- **Event processor**: An engine to consume event data streams and derive insights from them. Depending on the problem space, event processors either process one incoming event at a time, such as a heart rate monitor, or process multiple events at a time, such as Azure Stream Analytics processing the highway toll lane sensor data.
- **Event consumer**: An application that consumes the data and takes specific action based on the insights. Examples of event consumers include alert generation, dashboards, or even sending data to another event processing engine.

![Event processing engine insights](../media/3-event-processing-engine.png)