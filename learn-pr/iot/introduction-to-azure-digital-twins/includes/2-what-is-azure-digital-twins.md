Across the many industries where the Internet of Things (IoT) is featured today, IoT environments are often large in scale, providing device data from sensors throughout buildings, factories, farms, railways, stadiums, energy networks, and even entire cities. Such environments generate a large amount of IoT device data that needs to be organized before it can be consumed and processed into logical insights.

Azure Digital Twins is a platform as a service (PaaS) offering that enables the creation of digital twin graphs that parallel entire real-world environments. Through these digital models you can organize data ingested from IoT devices, contextualize data with business logic or information from connected business systems, and query the data to create dashboards or other digital solutions that enable meaningful insights about your environment, both right now and as patterns over time. These insights can help drive better products, optimized operations, reduced costs, and breakthrough customer experiences.

## Model your business environment

In Azure Digital Twins, you freely define the types of digital entities that represent your environment, including the people, places, and things that it contains.

Using the vocabulary that fits your business, you define your own twin types in terms of their properties, telemetry, components, and relationships. These custom twin types are called **models**. You can design your own model sets from scratch, or get started with a pre-existing set of industry ontologies based on common vocabulary for your industry. You can also bring models from outside of Azure Digital Twins and convert them to be usable in Azure Digital Twins. In the factory scenario for this module, you'll design a model to represent the concept of a robotic arm. That model will have a boolean property indicating an alert that the latest package was not picked up.

After creating models to define the types of entity in your environment, you create instances of each model to represent the actual, specific environment entities. These instances are called **digital twins** (or just **twins** for simplicity). In this module scenario, you'll use the robotic arm model to create multiple robotic arm twins. Each twin will be based on the model, so each twin will have that boolean property representing the pickup failure alert.

>[!TIP]
>From a programming perspective, models are similar to class definitions, and twins are like instances of those classes.

Finally, digital twins are connected to each other via **relationships** to form a conceptual graph of your complete environment. You'll create a twin to represent the entire distribution center, and use relationships to indicate that the center *contains* each of the robotic arm twins that you've created. Using relationships like this can help you to aggregate data from twins that are conceptually connected to each other, such as determining the average hourly efficiency across all robotic arms in the factory.

## Sync and contextualize IoT and business system data

Digital twin graphs in Azure Digital Twins are live, up-to-date representations of the real world.

To keep digital twin properties current against your environment, you'll connect your solution to IoT Hub, which manages **physical IoT devices**. When physical devices send data to the cloud, you'll route that data into Azure Digital Twins.

You can also ingest data from **other data sources**, using REST APIs or connectors to other Azure services such as Logic Apps. These methods can help you input data from business systems and incorporate them into your twin graph.

Once data reaches Azure Digital Twins, you'll connect external compute resources, such as Azure functions, to define exactly how your digital twins are updated in response. In this way, you can flexibly customize data processing to reflect your business logic.

## Query for environment insights

Azure Digital Twins provides a **query API** for extracting insights from the live execution environment. The API can query with extensive search conditions, including property values, relationships, relationship properties, model information, and more. You can also combine queries to gather a broad range of insights about your environment. The data produced by the API can be used to create dashboards, generate warnings or alerts, and more.

You can also query historized twin data collected over time, using the **data history** feature. This feature connects an Azure Digital Twins instance to an Azure Data Explorer cluster, so that graph updates are automatically stored in Azure Data Explorer. From there, the data can be queried using the Azure Digital Twins query plugin for Azure Data Explorer. This provides a wider pool of environment data and the ability to identify patterns over time.

Here is an example of historized twin updates shown in Azure Data Explorer, illustrating the changing values of outflow from a salt machine in a dairy factory over time.

:::image type="content" source="../media/2-data-history.png" alt-text="Screenshot of Azure Data Explorer showing a query of historized data with results plotted on a graph over time." border="false" lightbox="../media/2-data-history.png":::

## Visualize

Azure Digital Twins provides ways to visualize your environment in two or three dimensions.

Azure Digital Twins Explorer is a **2D interface** that can help you build and interact with your graph. Here's an example of the graph for the module scenario shown in Azure Digital Twins Explorer.

:::image type="content" source="../media/2-3-factory-graph.png" alt-text="Screenshot of Azure Digital Twins Explorer showing a 2D graph. In the graph, one distribution center twin is connected to six arm twins via six lines labeled contains." border="false" lightbox="../media/2-3-factory-graph.png":::

Azure Digital Twins 3D Scenes Studio (preview) is an **immersive visual 3D environment**, where end users can monitor, diagnose, and investigate operational digital twin data with the visual context of 3D assets. With a digital twin graph and curated 3D model, subject matter experts can leverage the studio's low-code builder to map the 3D elements to digital twins in the Azure Digital Twins graph, and define UI interactivity and business logic for a 3D visualization of a business environment. The 3D scenes can then be consumed in the hosted 3D Scenes Studio, or in a custom application that leverages the embeddable 3D viewer component. Here's an example of the module scenario as a scene in 3D Scenes Studio.

:::image type="content" source="../media/2-factory-3d.png" alt-text="Screenshot of 3D Scenes Studio showing a 3D visualization. The scene shows a 3D mesh of a room containing six stations, each with a robotic arm. An alert box displays additional information about one of the arms." border="false" lightbox="../media/2-factory-3d.png":::

## Export twin data

The data in your Azure Digital Twins instance can be routed to downstream Azure services or external destinations, for custom storage and processing.

The built-in **data history** feature can be used to automatically historize twin data to Azure Data Explorer, where it can be queried as historical data over time.

Digital twin data can be sent to other Azure services or ultimately outside of Azure through **event routes**, which utilize Azure Event Hubs, Event Grid, and Service Bus to send data through custom flows.

Here are some things you can do with event routes in Azure Digital Twins:

* Store Azure Digital Twins data in Azure Data Lake
* Analyze Azure Digital Twins data with Azure Synapse Analytics, or other Microsoft data analytics tools
* Integrate larger workflows with Logic Apps
* Send data to custom applications for flexible and customized actions

Flexible egress of data is another way that Azure Digital Twins can connect into a larger solution, and support your custom needs for continued work with these insights.
