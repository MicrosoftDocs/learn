There are certain applications that produce a massive number of events from almost as many sources. We often hear the term "Big Data" applied to these situations, and they require unique infrastructure to handle them.

Imagine you work for Contoso Aircraft Engines. The engines your employer manufactures have hundreds of sensors. Before an aircraft can be flown each morning, its engines are connected to a test harness and put through their paces. Additionally, cached in-flight data is streamed when the aircraft is connected to ground equipment.

You want to use historic sensor data to find patterns in the sensor readings that indicate engine failure is likely to happen soon. You want the real-time sensor readings to be compared against these failure patterns. You can then warn users in near real time if an engine is showing worrisome readings.

## What is Azure Event Hubs?

[Event Hubs](https://azure.microsoft.com/services/event-hubs/) is an intermediary for the publish-subscribe communication pattern. Unlike [Event Grid](https://azure.microsoft.com/services/event-grid/), however, it's optimized for extremely high throughput, a large number of publishers, security, and resiliency.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2yuat]

Whereas Event Grid fits perfectly into the publish-subscribe pattern in that it simply manages subscriptions and routes communications to those subscribers, Event Hubs performs quite a few extra services. These extra services make it look more like a service bus or message queue than a simple event broadcaster.

#### Partitions

As Event Hubs receives communications, it divides them into partitions. Partitions are buffers into which the communications are saved. Because of the event buffers, events aren't ephemeral, and an event isn't missed just because a subscriber is busy or even offline. The subscriber can always use the buffer to "catch up." By default, events stay in the buffer for 24 hours before they automatically expire. The buffers are called partitions because the data is divided amongst them. Each partition has a separate set of subscribers.

#### Capture

Event Hubs can send all your events immediately to [Azure Data Lake](https://azure.microsoft.com/services/storage/data-lake-storage/) or Azure Blob storage for inexpensive, permanent persistence.

#### Authentication

All publishers are authenticated and issued a token. This means Event Hubs can accept events from external devices and mobile apps without worrying that fraudulent data from prankers could ruin your analysis.

## Using Event Hubs

Event Hubs has support for pipelining event streams to other Azure services. Using it with Azure Stream Analytics, for instance, allows complex analysis of data in near real time, with the ability to correlate multiple events and look for patterns. In this case, Stream Analytics would be considered a subscriber.

For our aircraft engines, we'll set up our architecture so that Event Hubs will authenticate the communications from our engines. We'll then have it use capture to save all the data to Data Lake. Later, we can use all that data to retrain and improve our machine-learning models. Finally, Stream Analytics subscribers pick up our event streams. Stream Analytics uses our machine-learning model to look for patterns in the sensor data that might indicate problems.

Because we have several partitions, and each engine sends all its data to only one partition, each instance of our Stream Analytics subscriber only needs to deal with a subset of our overall data. It doesn't have to filter and correlate over all of it.

## Which service should I choose?

Just like our queue choice, selecting between these two event delivery services can seem tricky at first. Both support *At Least Once* semantics.

#### Choose Event Hubs if:

- You need to support authenticating a large number of publishers.
- You need to save a stream of events to Data Lake or Blob storage.
- You need aggregation or analytics on your event stream.
- You need reliable messaging or resiliency.  

Otherwise, if you need a simple event publish-subscribe infrastructure with trusted publishers (for instance, your own web server), you should choose Event Grid.

Event Hubs lets you build a big data pipeline capable of processing millions of events per second with low latency. It can handle data from concurrent sources and route it to various stream-processing infrastructures and analytics services. It enables real-time processing and supports repeated replay of stored raw data.
