Certain applications produce a massive number of events from almost as many sources. These application scenarios are often referred to as _Big Data_. Big Data can require extensive infrastructure.

Suppose you're designing the architecture for an airplane engine manufacturing application. Each manufactured engine has hundreds of sensors. Before an airplane can be flown, the engines are connected to a test harness and put through their paces. Additionally, cached in-flight data is streamed when the airplane is connected to ground equipment.

For this architecture, you might choose a messaging solution that uses _event hubs_. Event hubs can receive and process millions of events per second. Data sent to an event hub can be transformed in real time and stored for later analysis. 

### Things to know about Azure Event Hubs

[Azure Event Hubs](/azure/event-hubs/event-hubs-about) is a fully managed, real-time data ingestion service. Let's review the characteristics of the service:

- Azure Event Hubs supports real time data ingestion and microservices batching on the same stream. 

- You can send and receive events in many different languages. Messages can also be received from Azure Event Hubs by using Apache Storm.

- Events received by Azure Event Hubs are added to the end of its data stream.
   - The data stream orders events according to the time they event is received.
   - Consumers can seek along the data stream by using time offsets.

- Event Hubs implements a _pull_ model that differentiates it from other messaging services like Azure Service Bus queues.
   - Event Hubs holds each message in its cache and allows it to be read.
   - When a message is read from Event Hubs, it's not deleted. The message remains for other consumers.

- Event Hubs doesn't have a built-in mechanism to handle messages that aren't processed as expected. 

- Azure Event Hubs scales according to the number of [purchased throughput (processing) units](https://azure.microsoft.com/pricing/details/event-hubs/). Performance features vary for each pricing tier, such as Basic, Standard, or Premium.

#### Business scenario

Let's examine how Azure Event Hubs and other Azure services can contribute to the architecture for the airplane engine manufacturing application.

:::image type="content" source="../media/event-hubs-integration.png" alt-text="Diagram that shows how Azure Event Hubs and other Azure services contribute to the architecture for an airplane engine manufacturing application." border="false":::

- Azure Event Hubs captures streaming data from the airplane engine testing equipment.

- Azure Blob Storage stores the engine test data.

- Azure Stream Analytics identifies patterns in the sensor engine test data. 

- Power BI makes decisions for engine manufacturing improvements based on the test data patterns. 

### Things to consider when using Azure Event Hubs 

As you plan for how Azure Event Hubs can be a part of your messaging solution, consider the following points. 

- **Consider common implementations**. Identify whether your application scenario is suited for event-hubs messaging. There are several common scenarios where Azure Event Hubs is a great messaging solution. Event hubs are ideal for live dashboarding, supporting analytics pipelines like clickstreams, and detecting anomalies like fraud or outlier actions. Event hubs are also a good solution for processing transactions with real-time analysis and archiving data.

- **Consider language and framework integration**. Azure Event Hubs supports sending and receiving events in many different languages. The robust language and framework support makes it easy to integrate Event Hubs with other Azure and non-Azure services.

- **Consider pricing tier and throughput units**. Choose the pricing tier that offers the features and capabilities required by your application. Control how your Azure Event Hubs implementation scales by purchasing the necessary throughput or processing units. A single throughput unit equates to:
   - **Ingress**: Up to 1 MB per second or 1,000 events per second (whichever comes first)
   - **Egress**: Up to 2 MB per second or 4,096 events per second

- **Cosider pull model benefits**. Investigate how the pull model implemented by Event Hubs can benefit your application communication. Event Hubs holds a message in its cache and allows it to be read. When a message is read, it isn't deleted. The message remains for other consumers.

- **Consider message failures**. Remember Azure Event Hubs doesn't handle messages that aren't processed as expected. Suppose a message consumer malfunctions because of data format. Event Hubs won't detect this issue. The message remains until its `time-to-live` setting has expired.

- **Consider data stream access**. Event Hubs adds received events to the end of its data stream, and the events are ordered according to the time they're received. Event consumers can seek along the data stream by using time offsets.