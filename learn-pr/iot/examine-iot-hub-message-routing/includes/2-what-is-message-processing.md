Message processing includes the series of actions that we use to communicate, modify, evaluate, react to, and store message information.

The following Azure IoT Reference Architecture diagram illustrates the primary message processing pathways.

:::image type="content" source="../media/m04-l01-message-processing-paths-ref-arch-66c9e87f.png" alt-text="Diagram that shows the primary message processing pathways for an IoT solution.":::

As you can see, message processing involves a broad spectrum of protocols, services, and standards. Here are some of the topics that can be investigated in more depth:

* **Message features**: To support seamless interoperability across protocols, Azure IoT Hub defines a common set of message features for all device-facing protocols.
* **Message routing**: This Azure IoT Hub feature enables users to route device-to-cloud messages to service endpoints like Azure Storage containers, Event Hubs, Service Bus queues, and Service Bus topics. Routing also provides a querying capability to filter the data before routing it to the endpoints. In addition to device telemetry data, you can also send non-telemetry events that can be used to trigger actions.
* **Event Grid**: Azure Event Grid is a fully managed event routing service that uses a publish-subscribe model. Azure IoT Hub and Event Grid work together to integrate Azure IoT Hub events into Azure and non-Azure services, in near-real time. Azure IoT Hub publishes device events and telemetry events.
* **Message enrichment**: Message enrichment is the ability of the Azure IoT Hub to stamp messages with additional information before the messages are sent to the designated endpoint.
* **Azure Stream Analytics**: Azure Stream Analytics (ASA) is a real-time analytics and complex event-processing engine that is designed to analyze and process high volumes of fast streaming data from multiple sources simultaneously. ASA supports inputs and outputs using a wide range storage options.
* **Azure Functions**: Azure Functions is a solution for easily running small pieces of code, or "functions," in the cloud. Azure Functions lets you develop serverless applications on Microsoft Azure and is a great solution for processing data, integrating systems, and working with the internet of things. Azure Functions provides several templates to help you to get you started with key IoT scenarios.
* **Warm and cold storage**: For architectures that produce significant amounts of data, a common pattern is to split the data into "warm" and "cold" data stores. Traditionally, data stored in cold storage is accessed infrequently, while data stored in warm storage is accessed frequently.
