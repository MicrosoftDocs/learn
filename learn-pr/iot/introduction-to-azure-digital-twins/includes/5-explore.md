:::image type="content" source="../media/solutions.png" alt-text="Diagram of an Azure Digital Twins solution steps.](../media/solutions.png" lightbox="../media/solutions.png":::

In a solution context, Azure Digital Twins is the platform that you can use to model any environment and connect sensors and business systems to the model to control the present, track the past, and predict the future.

To enable this promise, a typical customer would need to model their environment by using the Digital Twins Definition Language (DTDL). They would keep this model of their environment live with the data coming from their:

- Operational systems, that is, IoT data.
- Business systems, such as CRM, ERP, human resources, and finance.

The insights that are generated in the digital twin would then need to be plugged into business systems to drive action and close the digital feedback loop.

:::image type="content" source="../media/overview.png" alt-text="Diagram of the sources and uses of Azure Digital Twins." lightbox="../media/overview.png":::

:::image type="content" source="../media/data-flow.png" alt-text="Diagram of the data flow in digital twin solutions." lightbox="../media/data-flow.png":::

## Open modeling language (DTDL)

Real-world environments in Azure Digital Twins are modeled as a topology graph. The entities that make up the graph are called twins. Each type of twin is described as a collection of properties, telemetry, commands, relationships, and components. Twin definitions are expressed in DTDL, a language that's based on JSON-LD.

## Live execution environment

Azure Digital Twins is a live execution environment to bring your digital twins to life in a live graph representation.

After you've defined your custom business vocabulary in Azure Digital Twins, you can create a graph of twins. Typically, customers create graphs programmatically by driving the topology with data already available in other databases. For example, they might use data from building information management systems.

In Azure Digital Twins, all data changes generate events. Incoming telemetry, property changes to the graph, creation, or deletion of twins all result in events that custom business logic can react to. Developers can define event handlers for processing events within the graph and propagate data through the graph.

Azure Digital Twins also provides a powerful query system to extract insight from your modeled environment.

## Input from IoT and business systems

Input from IoT and business systems can be fed into Azure Digital Twins to connect assets that include IoT devices using Azure IoT Hub, Azure Logic Apps, and REST APIs.

You can use IoT Hub to connect to IoT and IoT Edge devices to keep the live execution environment up to date with operational data.

IoT data isn't a mandatory component for your digital twin solutions. You can also drive Azure Digital Twins from other data sources by using REST APIs. Or you can create Azure Logic Apps connectors based on the system you want to collect data from. A combination of different data sources, either IoT or not, can be the feeding mechanism for your digital twin.

## Output to Time Series Insights, storage, and analytics

Azure Digital Twins provides means to output insights to external services such as Azure Time Series Insights, storage, and analytics by using event routes to downstream services like Azure Synapse Analytics.

Developers can define event routes that send selected data out to downstream services. Supported endpoints include Azure Event Hubs, Azure Event Grid, or Azure Service Bus.

Examples include cold storage such as Azure Data Lake, machine learning, or other analytics with Azure Synapse or workflow integration with Logic Apps.

Integration with Azure Time Series Insights can be used to track data over time and apply historian analytics.

## What does a digital twin solution architecture look like?

The following diagram shows how different capabilities come together to form a digital twin solution. Each functional building block provides examples of Azure services or external systems that can serve for the purpose. This diagram is only an example. Other components or Azure services also can be part of a digital twin solution.

:::image type="content" source="../media/architecture.png" alt-text="Graphical representation of an Azure Digital Twins solution architecture." lightbox="../media/architecture.png":::
