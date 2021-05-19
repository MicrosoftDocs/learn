Adatum's management team wants to leverage IoT capabilities to extend the scope of services it delivers to its customers, including automated monitoring, alerting, and self-servicing of smart appliances. Your development team plans to provide the desired functionality by implementing a robust and feature-rich IoT pipeline in a manner that adheres to the foundational design principles of cloud-native applications. To accomplish this objective, you decide to explore the concepts of IoT services architecture.

## What is IoT services architecture?

The term *Internet of Things (IoT)* represents a network of interconnected devices involved in generating, processing, or storing sensor-generated telemetry. At a high level, an IoT solution consists of two primary groups of components:

- Device-side. This group comprises of devices that serve primarily as sources of telemetry but might also perform some of initial telemetry processing and analytics.
- Cloud-side. This group comprises of cloud-based services that are optimized for data collection, persistence, and analytics.

In your intended design, smart fridges represent the device-side, while Azure IoT Central and Azure Cosmos DB accommodate data collection, persistence, and analytics.

:::image type="content" source="../media/2-iot-sample-architecture.png" alt-text="Sample high-level architecture of IoT services that includes Azure IoT Central and Cosmos DB.":::

Another approach to the IoT services architecture divides it into Things, Insights, and Actions. Things represent IoT devices generating telemetry that, through Insights-based analysis, is turned into Actions, which deliver meaningful business benefits. As an example, consider a sensor of a smart refrigerator (the thing), which sends temperature data. That data serves as the basis of evaluation whether the refrigerator is fully operational (the insight). The insight, in turn, can trigger an alert that leads to an updated maintenance schedule (the action).

A more detailed look at Azure IoT architecture allows you to distinguish between its core and optional components.The core components include:

- IoT devices that can securely register with the cloud and support the sending and reception of data.
- A cloud gateway service that serves the role of a hub, relays data from devices, and provides device management capabilities.
- Stream processors that consume the device data, integrate with data processing components, and deliver data into storage.
- A range of data stores that provide data persistence and aggregation. Storage can be part of the hot or warm path, or the cold path. The hot or warm path consists of the data required for near-real time reporting and visualization. The cold path consists of data that's stored for a longer term and used for batch processing.
- Analytics services that retrieve insights from raw telemetry data and integrate with business processes and systems, such as Customer Relationship Management (CRM).
- Programming and management interfaces that simplify administration of IoT solutions.

Optional components include:

- IoT Edge devices that serve as brokers for management and data flow for IoT devices, whenever direct communication with the cloud is restricted or not possible. They might, for example, play a role in device provisioning, data filtering, aggregation, and buffering, protocol translation, or event rules processing.
- Data transformation services that perform ingress tasks such as protocol translation, data conversion, and data aggregation.
- User management subsystem that implements role-based access control (RBAC) and allows for the delegation of management tasks.
- Machine learning that analyzes telemetry data to detect trends and correlations and provides functionality such as predictive analytics.
- Bulk device provisioning services that accommodate scenarios involving large-scale deployments.

:::image type="content" source="../media/2-iot-architecture-high-level.png" alt-text="High-level architecture of IoT services that includes Azure IoT Hub.":::

## IoT services data pipeline

The flow of device-generated data typically consists of several stages, including:

- Storage. Preserving data for a short term or a longer term, relying on technologies such as in-memory caches, temporary queues, databases, and data lakes.
- Routing. Delivering data to one or more storage endpoints, analysis processes, and actions.
- Analysis. Evaluating and processing data records based on customizable criteria.
- Action. Responding to customizable rules in order to address a condition indicated by the state or value of collected data.

## Azure IoT services and technologies

Microsoft offers a comprehensive portfolio of services that deliver various types of IoT functionality, including:

- Azure IoT Central. This service implements a wide range of IoT capabilities, including telemetry collection, processing, and analytics as well as secure device management. Azure IoT Central:
  - Helps you minimize custom development efforts and administrative overhead.
  - Lets you leverage cloud agility and scalability.
  - Supports built-in integration with a number of other Azure services.
  - Simplifies the development and implementation of custom IoT solutions and also supports ad-hoc testing with built-in mock devices.
  - Integrates with Time Series Insights and has the ability to define rules for generating alerts. This might help you eliminate the need for dedicated stream processing services, such as Stream Analytics.
- Azure IoT Hub. This service is optimized for reliable and secure bidirectional communications between IoT devices and cloud services. Just as Azure IoT Central, it incorporates Device Provisioning Service (DPS) as a helper service for in-bulk, zero-touch, just-in-time provisioning of IoT devices.
- Azure Event Hub. This service offers auto-scalable ingestion of telemetry data at very high throughput rates. Event hubs are suitable for supplementing Azure IoT Hub and Azure IoT Central services in scenarios that involve the collection of non-device telemetry data that originates from sources such as weather feeds or social media streams. Unlike specialized IoT solutions, Event Hubs doesn't offer per-device identity and device management capabilities.
- Azure Logic Apps. This service is optimized for scenarios that involve automating and integrating business processes. It relies on a visual designer, included in the Azure portal, to build workflows that include connectors to a wide range of first-party and third-party systems, without the need for custom programming.
- Azure Functions. This service is highly versatile, but in the context of IoT scenarios, its primary use cases include processing of telemetry egressing Azure IoT Hub and Azure IoT Central. For example, an Azure IoT hub could forward its telemetry to an Azure function to perform a simple format conversion and store the results in Azure Cosmos DB. Similar to Azure Logic Apps, Azure Functions facilitates business integration scenarios.
- Azure Stream Analytics. This is a real-time analytics and complex event-processing engine that is optimized for high volumes of streaming data that originates from IoT devices, social media feeds, and applications. Azure Stream Analytics supports operations such as windowing, stream aggregations, and external data source joins.
- Azure Time Series Insights. This is a highly performing analytics, storage, and visualization service for time series data that provides capabilities such as filtering and aggregation. Its visualization capabilities include support for overlays of different time series, dashboard comparisons, accessible tabular views, and heat maps. Azure Time Series also offers a JavaScript controls library that facilitates embedding time series charts into custom applications. It's optimized for scenarios that require aggregation over large sets of data.
- Azure Data Lake Storage. This is a distributed data store that is capable of persisting large amounts of data without requiring its transformation or schema definition. Its extensive processing capabilities that are available through integration with Azure Data Lake Analytics, make it a suitable choice for big data analytics scenarios.
- Azure SQL Database. This is a managed relational data store that is optimized for scenarios that require transactional support, enforceable schema constraints, and involve complex queries.
- Azure Cosmos DB. This is a cloud-native NoSQL database that offers features such as multiple-region writes, auto-scaling, support for multiple consistency models, schema-on-read, and latency guarantees for read and write operations.
- Azure Databricks. This service offers managed, Spark-based processing of big data. In the context of IoT scenarios, you can leverage its support for advanced analytics, beyond the functionality that's built into Azure IoT Central applications.
- Azure Synapse. This is an managed analytics service that is optimized for massive parallel processing workloads. Azure Synapse typically hosts aggregated data and acts as the data source for business intelligence (BI) tools.
