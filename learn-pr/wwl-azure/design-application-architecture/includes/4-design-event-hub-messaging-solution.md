There are certain applications that produce a massive number of events from almost as many sources. We often refer to this as Big Data. Big Data can require extensive infrastructure.

Let’s imagine you work for Contoso Aircraft Engines. The engines your employer manufactures have hundreds of sensors. Before an aircraft can be flown, its engines are connected to a test harness and put through their paces. Additionally, cached in-flight data is streamed when the aircraft is connected to ground equipment.

In this situation, you might choose an event hubs-based messaging solution. Event hubs can receive and process millions of events per second. Data sent to an event hub can be transformed in real-time and stored for later analysis. 

## How Azure Event Hub works

[Azure Event Hubs](/azure/event-hubs/event-hubs-about) is a fully managed, real time data ingestion. Event Hubs support real time data ingestion and microservices batching on the same stream. Here are some common scenarios for Event Hubs. 

- Anomaly detection (fraud/outliers) and live dashboarding

- Analytics pipelines, such as clickstreams, and archiving data

- Transaction processing with real-time analysis

This diagram shows how Event Hubs could be used in the aircraft engine application.

- Event hub captures streaming data from the testing equipment.

- The data is stored in Azure blob storage.

- Azure Stream Analytics to identify patterns in the sensor data. 

- Power BI is used to make decisions on manufacturing improvements. 

:::image type="content" source="../media/event-hubs-integration.png" alt-text="A diagram displays how the preceding scenario can be achieved using Event Hubs and Azure Stream Analytics.":::



## Considerations for Event Hub

When selecting Event Hub, consider the following: 

- **Expect language and framework integration**. You can send and receive events in many different languages. Messages can also be received from Event Hubs using Apache Storm.

- **Choose a tier and throughput**. Scaling of Event Hubs is controlled by how many throughput units or processing units you [purchase](https://azure.microsoft.com/pricing/details/event-hubs/). Other performance aspects depend on the pricing tier chosen. Basic, standard, premium, and dedicated pricing tiers are available. A single throughput unit equates to:

	- Ingress: Up to 1 MB per second or 1000 events per second (whichever comes first).

	- Egress: Up to 2 MB per second or 4096 events per second.

- **Remember Event Hubs uses a pull model**. The pull model used by Event Hubs differentiates it from some other messaging services, such as Azure Service Bus Queues. The pull model means that Event Hubs simply holds the message in its cache and allows it to be read. When a message is read from Event Hubs, it isn't deleted but is left to be read, as needed, by more consumers.

- **Account for data failures.** There's no built-in mechanism to handle messages that aren't processed as you expect them. For example, imagine your consumer malfunctions because of data format. Event Hubs won't detect this and delete the message once its time-to-live has expired. 

- **Process the data stream.** Events received by Event Hubs are added to the end of its data stream. This data stream orders events by the time they are received, and consumers can seek along this stream using time offsets.