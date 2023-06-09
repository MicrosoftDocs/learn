IoT solutions usually include several components that span from device communication and management to event processing, data ingestion, and analysis. Deploying all these components independently on compute, network, and storage-based infrastructures can be a complex and time-consuming task. Even more challenging is managing, monitoring, and operating these systems at significant scale.

Recall in the distributor example, there are thousands of trucks of which you're hoping to monitor the health and status. Each truck will need to have a connected IoT device that is sending telemetry data to be processed, stored, and analyzed.

Here, you'll learn about the canonical IoT architecture, how Azure SQL Database can support the architecture, and a template you can use for any IoT scenario.

## Construct IoT solutions with Azure

A typical IoT solution typically has the following components:

:::image type="content" source="../media/2-generic-iot.svg" alt-text="Diagram of the canonical IoT architecture." border="false":::

Let's identify and describe the roles and responsibilities of each of these components:

- **Individual edge devices**: From intelligent sensors to industrial PCs aggregating multiple signals, these devices send telemetry messages and receive commands from the cloud.
- **Cloud gateway**: Manage bi-directional communications with devices, like queueing events and messages. They're also used for device provisioning and management.
- **Stream processing**: Perform real-time streaming for capturing low latency events like alarms and thresholds to be plotted on a dashboard. Event processing can also perform batch processing and storing for large amounts of data for future analysis.
- **Warm storage**: Persist low-latency events and messages that need to be ingested efficiently and at a high rate. At the same time, warm storage needs to be able to be queried concurrently by a combination of point lookup and aggregated queries.
- **Cold storage**: Retain raw, original messages that can be further processed and curated with big data and analytical engines to extract insights. Cold storage should be optimized for large data volumes at a reasonable cost.
- **Dashboarding/Reporting**: This real-time analysis is mostly comparing trends and values over time and is referred to often as hybrid transactional/analytical processing (HTAP).
- **Analytics/ML**: Perform additional analytics and even machine learning to build models with actionable insights.

Fortunately, the Azure platform offers a full portfolio of platform-as-a-service (PaaS) services that integrate seamlessly and cover all the needs of modern, scalable IoT solutions. A sample architecture shows a selection of services available.

:::image type="content" source="../media/2-azure-iot.svg" alt-text="Diagram of the canonical IoT architecture using Azure services." border="false":::

For device connectivity and management, *IoT Hub* (1) provides secure and reliable communication for your (IoT) applications, connecting virtually any device and offering comprehensive per-device authentication options, built-in device management, and predictable performance and availability. IoT Hub, which is built on *Azure Event Hubs* (event store), can process and manage millions of events per second, with easy consumption through APIs and several Azure services.

*Azure Stream Analytics* (2), as an example, is a real-time analytics service designed for mission-critical workloads to build end-to-end, serverless streaming pipelines with just a few clicks. With Azure Stream Analytics, your IoT solution can analyze and react in real time to specific event patterns or thresholds generated by your device fleet, and you can use it to populate dashboards and reports capturing low-latency phenomena in the system.

To process the remaining amount of all the events generated by devices that need to be captured, stored, and analyzed, you can use another PaaS service like *Azure Functions* (3). Azure Functions is an event-driven, serverless compute platform that natively connects to the IoT Hub event store. Azure Functions can consume batches of incoming messages and process them following your customizable logic written in one of the many programming languages supported.

Other services within the Azure platform can be plugged-in with minimum effort; a great example is *Azure Logic Apps* (4). Azure Logic Apps can help you automate critical workflows without writing a single line of code by providing a myriad of out-of-the-box connectors to other services and the ability to graphically design complex process that can be used in areas like data integration, management, or orchestration. Actions like triggering a dataset refresh in Power BI when certain events are happening at the database level become simple and intuitive to implement with Logic Apps. Another example is *Azure Machine Learning* (5), which you can use to create and train complex machine-learning models using the IoT data.

*Azure SQL* (6), which includes SQL Server on Azure VM, Azure SQL Managed Instance, and Azure SQL Database, is a great choice to address the warm storage requirements. Azure SQL has great integrations with the aforementioned Azure services:

- Stream processing results from Azure Stream Analytics can be persisted directly in Azure SQL’s disk-based or in-memory optimized tables for low latency and high throughput, to be then queried and analyzed. Azure Stream Analytics uses a SQL dialect, extensible with custom code, which covers the most advanced scenarios, and can scale up and down to cover the most challenging workloads.
- Azure Functions can be bound to the incoming message flow that will trigger processing on one end, and can use Azure SQL client libraries on the other end to define data shape and form before persisting what’s needed in a relational or non-relational format in the database.
- Azure Logic Apps contains several connectors for Azure SQL, which include triggers and actions based on incoming events.
- Azure Machine Learning can easily use the data stored in Azure SQL to create and train models.

## Achieve IoT scale with Azure SQL Database

Azure SQL Database specifically has great scalability, which is crucial to the success of large IoT systems. Azure SQL Database has proven that it's able to ingest millions of events per second for IoT, combining in-memory technologies with columnar index structures. In-memory technology speeds up data insertion and columnar index structures can help optimize storage utilization (through up to 100x compression) and support large aggregations and time-series analysis.

Depending on your workload and requirements, there are several options available to scale an Azure SQL Database instance. You can independently scale up Azure SQL Database's compute and storage, or you can scale out using read-replicas or database sharding.

Here are some considerations for achieving scale with Azure SQL Database:

- A single instance can scale up to 128 vCores (with M-Series hardware configuration) or 100 TB (with the Hyperscale service tier). These limits mean you can ingest millions of messages per second and store trillions of them in a single database, simplifying your data management operations.
- One of the greatest advantages that Azure SQL has on other technologies is the ability to ingest a large number of messages but also to let users query them with the minimum latency possible. Azure Blob Storage, as an example, is great for ingesting messages. However, to query them, you need a distributed engine like Spark or similar that usually takes minutes before being able to serve results on a large scale. On the other end, Cosmos DB is fast and scalable, but again to support analytical queries like aggregations and such, it needs to rely on external query engines like Synapse.
- You can add Multiple secondary replicas to scale out read workloads and support tens of thousands of concurrent queries on ingested data. With Hyperscale, you can additionally create up to 30 named replicas in a matter of minutes, which enables you to obtain read-scale on the fly.
- Where additional scalability is required, Azure SQL Database provides Elastic Database tools to partition messages (for example, using device or message ID as sharding keys) across multiple database instances, providing linear scale for compute and storage.
- When ingesting messages from hundreds of thousands of devices, Azure SQL Database provides the ability to batch multiple requests into a single database interaction, increasing overall scalability and maximizing resource utilization.
- In-memory technologies in Azure SQL Database let you achieve significant performance improvements with various workloads, including transactional, analytical, and hybrid (HTAP). In-memory optimized tables help increase number of transactions per second and reduce latency for scenarios like large data ingestion from IoT devices. Clustered columnstore indexes help reduce storage footprint through compression (up to 10 times) and improve performance for reporting and analytics queries on ingested messages.
- Azure SQL Database scales well on both relational and non-relational data structures. Multi-model databases enable you to store and work with data represented in multiple data formats such as relational data, graphs, JSON/XML documents, and key-value pairs, but still benefit from all the aforementioned capabilities, like in-memory technologies.
- In many IoT scenarios, historical analysis of ingested data is an important part of database workload. Temporal Tables in Azure SQL Database allow you to track and analyze full history of your data points without the need for custom code. By keeping data closely related to time context, the stored data points can be interpreted as valid only within the specific period. This property of Temporal Tables allows for efficient time-based analysis and getting insights from the data evolution.

## Recipe for IoT solutions using Azure SQL Database

You now understand how and why Azure SQL Database is a good fit for IoT applications. Following the distributor scenario, you'll deploy and configure a baseline IoT solution and implement the best practices for achieving scale. The template you deploy can be a great starting point for other IoT scenarios that you or your organization seek to create.

:::image type="content" source="../media/2-azure-sql-iot.svg" alt-text="Diagram of the architecture for an IoT solution with Azure SQL Database." border="false":::

The template is an Azure Resource Manager (ARM) template, which uses JSON files to define the infrastructure and configuration for a solution. Typically, there's a template file and a parameters file, which contain what to deploy and specifications respectively. You can then deploy the template and parameters with the Azure CLI or Azure PowerShell. In the exercises that follow, you'll explore the contents and configurations of what's deployed and the associated code samples.
