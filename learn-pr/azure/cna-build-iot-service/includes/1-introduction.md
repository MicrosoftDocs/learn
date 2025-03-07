Cloud-native applications are modular in nature, with loosely coupled, self-contained components. You can develop each of these components independently by using an arbitrary combination of technology stacks, while still allowing for their interaction through well-defined programming interfaces. These components can include software running on IoT devices and a range of Azure services such as Azure IoT Central, Azure Functions, and Azure Cosmos DB. These services can be used for collection, processing, and storage of device telemetry.

In this module, you extend your cloud-native application to provide IoT functionality by integrating its components with an Azure IoT service and by using Cosmos DB to provide a persistent data store.

## Scenario: Generate, collect, and process IoT telemetry

Suppose you work for Adatum Corporation, a manufacturer of home appliances. You lead a small development team tasked with building a multiple-feature app for smart refrigerators.

Your team developed a refrigerator-inventory app that businesses can use to easily identify the items they need to restock. They can also set up this app to automatically reorder required items. For this purpose, you used an Azure Kubernetes Service (AKS) cluster-hosted Node.js app, which processes messages from refrigerators and sends them to a management web app. Azure Database for PostgreSQL serves as the data store.

Your team also designed and implemented the prototype of a solution that uses Azure IoT Central for IoT telemetry collection and processing. This prototype serves as the basis for extending the IoT data pipeline that you focus on in this module.

Because of the loosely coupled nature of cloud-native applications, you can choose managed data stores when that makes more sense than running your own in a container. In this scenario, you're considering the use of managed data stores such as Cosmos DB for selectively aggregated content and Azure Blob Storage for raw metrics. You want to evaluate their suitability for streaming scenarios. Based on your initial research, you found out that Cosmos DB offers a range of performance and functionality benefits compared to traditional, relational data stores, such as Azure Database for PostgreSQL. You also determined that Azure Blob Storage can accommodate high data throughput requirements while providing practically unlimited capacity at low cost.

With these advantages in mind, your team can develop and deploy an IoT service with no effect on the existing inventory service.

## Prerequisites

* Basic familiarity with Azure
* Basic understanding of cloud computing
* Basic familiarity with programming concepts

## Learning objectives

After completing this module, you'll know more about how to:

* Describe the architecture and components of IoT services.
* Describe the characteristics and functionality of Azure Cosmos DB.
* Integrate Azure data stores with IoT pipelines.
* Implement Azure Cosmos DB for processing telemetry data.
* Analyze and manage telemetry data.
* Integrate web apps with IoT pipelines.
