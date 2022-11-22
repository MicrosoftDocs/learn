Azure Digital Twins is a platform as a service (PaaS) offering that enables the creation of knowledge graphs (a way to integrate information extracted from multiple data sources). In the case of Azure Digital Twins, the knowledge graph is based on interconnected digital entities that combine to represent a larger, interactive environment. The size and complexity of the environment is dependent upon your business needs, and could represent things like buildings, factories, farms, energy networks, railways, stadiums, and more—even entire cities. The digital entities defined within your environment, which are referred to as digital twins within an Azure Digital Twins solution, can be used to gain insights that drive better products, optimized operations, reduced costs, and breakthrough customer experiences.

> [!TIP]
> "Azure Digital Twins" refers to the Azure Digital Twins service as a whole. "Digital twin(s)" or just "twin(s)" refers to the digital entities represented within your solution.

Azure Digital Twins can be used to build customized, connected solutions that:

 -  Model any environment, and bring digital twins to life in a scalable and secure manner.
 -  Connect assets such as IoT devices and existing business systems.
 -  Use a robust event system to build dynamic business logic and data processing.
 -  Integrate with Azure data, analytics, and AI services to help you track the past and then predict the future.

> [!NOTE]
> Digital twins (in Azure Digital Twins) and device twins (in IoT Hub) may sound similar, but they are two different things. IoT Hub device twins often focus on describing the aspects and capabilities of a device itself, while digital twins are more conceptual representations that can store user-defined insights about a digital entity or many related entities (entities that could be representing a device or many related devices). It is also worth noting that IoT Hub device twins can be connected to Azure Digital Twins (the service) as part of an end-to-end solution that represents devices across services.

## Simple Azure Digital Twins environment scenario

Consider the following example where we define an environment that represents a small building (the Azure Digital Twins graph shown below). In this example, our building is composed of digital twins that represent the floors of the building, and the rooms on each floor. The lines on the Graph that connect a Floor to a Room are called relationships. Relationships help to define how our digital twins are related to one another. In this case, the relationship tells us that a floor “contains” rooms. The graph shows that our building has two floors, and each floor contains one room, but our environment could be expanded to include more floors and more rooms on each floor, or we could create more levels of detail, such as adding digital twins that represent digital entities within the rooms.

:::image type="content" source="../media/m11-l02-simple-twins-environment-fb572ff0.png" alt-text="Diagram that shows an Azure Digital Twins graph that represents a small building with two floors and one room on each floor.":::
