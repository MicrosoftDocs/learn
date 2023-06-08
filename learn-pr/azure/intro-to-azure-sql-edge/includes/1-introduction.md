The Internet of Things (IoT) offers many benefits to organizations and their customers. A key benefit is the ability to collect data at your network edge and use it to detect important patterns, including usage statistics. However, with increasing data volumes, the challenge is how to usefully gather it. Developers need a platform that's powerful enough to ingest, store, and perform analytics on collected data.

Azure SQL Edge is an IoT and IoT Edge optimized relational-database engine. It's based on the same engine and technologies as Microsoft SQL Server and supports the same tool sets. As such, it interacts with SQL Server-based technologies, such as Azure SQL and SQL Server. As the following image illustrates, Azure SQL Edge interacts with components at the network edge, including edge gateways, IoT devices, and edge servers.

:::image type="content" source="../media/overview-sql-edge.png" alt-text="Depiction of the interaction between Azure SQL Edge, Azure SQL, and SQL Server. Displayed within Azure SQL Edge are edge servers, edge gateways, and IoT devices.":::

## Example scenario

Let's imagine you work for an automotive manufacturing company. You're working on an IoT app that ingests data from several IoT sensors in the vehicles your company manufactures. It's important that the data is usable all the time, regardless of whether the vehicles' apps are online or offline. Another goal is to use the data to help with product development, so it must synchronize easily with cloud-based database systems built in Azure SQL.

You don't want to create new apps on a proprietary system, solely for vehicle-sensor data that arrives at the edge. Another important requirement is the ability to develop the app by using the SQL Server skills your development team already possesses. You want to examine how you can achieve your company's goals for this app by implementing Azure SQL Edge.

## What will we be doing?

Learning how to evaluate whether Azure SQL Edge can interact correctly with your edge-based apps and IoT devices. Also learning how Azure SQL Edge's familiar engine and toolset enable you to optimize data ingestion and analysis. In this module, you learn that Azure SQL Edge is:

- Powerful enough to support edge compute.
- Secure enough to help meet the privacy needs of IoT applications.
- Compatible with a familiar ecosystem of products, tools, and services.

## What is the main goal?

Determining how Azure SQL Edge and its familiar features can help you support the full range of IoT scenarios.
