Cloud-native applications are modular in nature, with loosely coupled, self-contained components. You can develop each of these components independently, using an arbitrary combination of technology stacks, while still allowing for their interaction via well-defined programming interfaces. 

These components can include software running on IoT devices and a range Azure services designed for collection, processing, and storage of device telemetry, such as Azure IoT Central, Azure Functions, and Azure Cosmos DB. 

## Scenario: Generate, collect, and process IoT telemetry

Suppose you work for Adatum Corporation, a manufacturer of home appliances. You lead a small development team tasked with building a multi-feature app for smart fridges.

Your team has developed a fridge inventory app that businesses can use to easily identify the items they need to restock. They can also set up this app to automatically reorder required items. For this purpose, you used an Azure Kubernetes Service (AKS) cluster-hosted Node.js app, which processes messages from fridges and sends them to a management web app, with the Azure Database for PostgreSQL serving as the data store. 

Your team has also designed and implemented the prototype of a solution that leverages Azure IoT Central for IoT telemetry collection and processing. This prototype will serve as the basis for extending the IoT data pipeline that you'll focus on in this module.

Because of the loosely coupled nature and modularity of cloud-native applications, you don't want to use them to store telemetry data. Instead, you're considering leveraging managed data stores, such as Cosmos DB for selectively aggregated content and Azure Blob Storage for raw metrics. You want to evaluate their suitability for streaming scenarios. Based on your initial research, you found out that Cosmos DB offers a range of performance and functionality benefits compared to traditional, relational data stores, such as Azure Database for PostgreSQL. You also determined that Azure Blob Storage can accommodate high data throughput requirements while providing practically unlimited capacity at low cost. 

Because of the loosely coupled nature of cloud-native applications, your team can develop and deploy an IoT service with no impact on the existing inventory service.

## Prerequisites

* Basic familiarity with Azure
* Basic understanding of cloud computing
* Basic familiarity with programming concepts

## Learning objectives

After completing this module, you'll be able to:

* Describe architecture and components of IoT services.
* Describe the characteristics and functionality of Azure Cosmos DB.
* Integrate Azure data stores with IoT pipelines.
* Implement Azure Cosmos DB for processing telemetry data.
* Analyze and manage telemetry data.
* Integrate web apps with IoT pipelines.