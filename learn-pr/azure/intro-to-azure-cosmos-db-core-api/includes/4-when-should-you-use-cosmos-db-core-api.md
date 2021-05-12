Azure Cosmos DB SQL API is a fully managed NoSQL database service for modern app development that provides guaranteed single-digit millisecond response times and 99.999-percent availability, backed by SLAs with automatic and instant scalability.

For enterprise scenarios, Azure Cosmos DB SQL API has a comprehensive suite of financially backed [service level agreements (SLAs)](https://azure.microsoft.com/support/legal/sla/cosmos-db/) that cover throughput, consistency, availability, and latency.

## Common use cases for the Azure Cosmos DB SQL API

### IoT/telemetry

IoT sensor workloads can be diverse and unpredictable. These workloads require a database platform that is responsive and capable of elastic scale to meet the needs of as many, or as few, data collection devices deployed at any point in time. In many cases, IoT workloads can also write massive volumes of data and would benefit from a write-optimized database platform. Azure Cosmos DB SQL API is optimized for write-heavy workloads. Operations on a single document are atomic with fast and predictable indexed write speeds. Azure Cosmos DB SQL API is also globally distributed and elastic to meet the needs of various IoT workloads.

:::image type="complex" source="../media/4-iot-case.svg" alt-text="IoT workload diagram" border="false":::

Architectural diagram for an IoT workload that includes:

1. IoT device sensors that are increasing in number
1. Azure IoT Hub that receives data from the IoT device sensors
1. Azure Databricks, which ingests and aggregates the real-time data from Azure IoT Hub
1. Azure Cosmos DB SQL API that stores the aggregated results from Azure Databricks
1. Azure Synapse Analytics that performs near real-time analysis over the data in Azure Cosmos DB

:::image-end:::

In this example, a growing number of IoT devices are sending sensor data to an Azure IoT Hub. Azure Databricks then ingests and aggregates the data for storage in Azure Cosmos DB SQL API. Azure Synapse Analytics then performs near real-time analysis over the data using [Azure Synapse Link for Azure Cosmos DB](/azure/cosmos-db/synapse-link).

### Retail/marketing

Azure Cosmos DB SQL API is a great fit for retail and marketing workloads that can experience dramatic and unexpected swings in usage at any point throughout the year. The elastic scale of Azure Cosmos DB SQL API ensures that the database platform can handle requests during peak usage, and save money during non-peak times.

> [!NOTE]
> Microsoft's e-commerce platform, which includes Windows Store and Xbox Live, uses Azure Cosmos DB SQL API extensively.

:::image type="complex" source="../media/4-retail-case.svg" alt-text="Retail workload diagram" border="false":::

Architectural diagram for a retail workload that includes:

1. A user browser connecting to the website on Azure App Service
1. An Azure Blob Storage account containing static site data (such as JavaScript files)
1. An Azure Cosmos DB SQL API account with a container for inventory data and a container for shopping cart data
1. An Azure Search instance that builds a searchable catalog by indexing the Azure Cosmos DB SQL API account with inventory data.

:::image-end:::

In this example, a JavaScript web application, built on content stored in Azure Blob Storage, uses Azure Cosmos DB SQL API as it's backing database. Multiple accounts are used to manage different facets of the solution such as the shopping cart, inventory, or catalog. Azure Cosmos DB SQL API data is then indexed by Azure Search to provide a rich search experience to end users.

### Web/mobile

Many modern social applications generate a plethora of user-generated content that is diverse in quantity, shape, and volume. Azure Cosmos DB SQL API is a great candidate for this workload as this API can store data of varying schemas. Consider the SQL API for data that may have schemas that change or evolve over time as the company's initiatives expand into new areas.

:::image type="complex" source="../media/4-web-case.svg" alt-text="Web workload diagram" border="false":::

Architectural diagram for a web workload that includes:

1. A user browser connecting to a URL
1. Azure Traffic Manager to determine the correct redirect destination
1. Three Azure App Service instances in three Azure regions (North Europe, West US, East US)
1. A globally distributed Azure Cosmos DB SQL API account

:::image-end:::

In this example, a user is using a URL to access a web site in their browser. The URL points to Azure Traffic Manager, which then uses a built-in algorithm to determine which Azure App Service endpoint to redirect the user to. Since Azure Cosmos DB SQL API is capable of global distribution, you only need one account that is replicated across multiple regions.

## Module Scenario

Consider the scenario from the beginning of this module:

> Suppose you work as the lead developer at a retail company. Your team is building your online storefront. The new storefront will be designed to be accessible across various devices including mobile. The team expects a spike in demand when the storefront is published and various "grand opening" sales begin.

One key part of your store's success is the ability for company to notify users of shipping updates regardless of what device they place the order on or are currently using. Your team has worked hard on a sophisticated system to manage tracking the status of an order in detail. With Azure Cosmos DB's tight integration with other Azure services, you can consider building solutions that use order data in Azure Cosmos DB SQL API to send notification to your user's mobile devices when their package ships, or is out for delivery.

:::image type="complex" source="../media/4-retail-scenario.svg" alt-text="Retail scenario diagram" border="false":::

Architectural diagram for a retail workload that includes:

1. A growing number of users ordering products
1. A collection of compute resources handling requests from the storefront instances
1. Azure Cosmos DB storing purchase data
1. Azure Databricks processing that data for storage elsewhere
1. Azure Functions, triggered off of change feed, processing data events
1. Azure Notification Hub, triggered by Azure Functions, that notifies the user of new events
1. A mobile device to receive notifications

:::image-end:::

This example is similar to the example from the introduction of this module. To build on the first example, your team has decided to introduce Azure Cosmos DB SQL API as the database of choice. Now, your team can use Azure Databricks to prepare and aggregate data for deeper analysis in analytical engines. Your team can also use services such as Azure Functions to react to data events with Azure Cosmos DB, and then send notifications to mobile devices using Azure Notification Hubs.
