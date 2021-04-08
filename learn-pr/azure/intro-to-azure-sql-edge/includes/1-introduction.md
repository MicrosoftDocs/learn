The Internet of Things (IoT) offers many benefits to organizations and the users of their products and services. One benefit is the ability to collect data at your network edge, and use this data to detect important patterns, such as usage statistics. However, with increasing volumes of data, the challenge has been how to usefully gather this data. Developers need a platform that is powerful enough to ingest, store, and perform analytics on this collected data!!

Azure SQL Edge is an IoT and IoT Edge optimized relational database engine. Azure SQL Edge is based on the same engine and technologies as Microsoft SQL Server and supports the same tool sets. Therefore, it can interact with SQL-based technologies, such as Azure SQL, and SQL Server. As indicated in the following image, Azure SQL Edge can interact with components at the network edge, such as edge gateways, IoT devices, and edge servers.

:::image type="content" source="../media/overview-sql-edge.png" alt-text="The interaction between Azure SQL Edge, Azure SQL, and SQL Server. Displayed within Azure SQL Edge is edge servers, edge gateways, and IoT devices.":::

## Example scenario

Let's imagine you work for an automotive manufacturing company. You're working on an IoT app that will ingest data from many IoT sensors throughout the vehicles your company manufactures. It's important that the data can be used at all times, whether the vehicles' apps are online or offline. The goal is also to use the data to help with product development. This means that the data should be easy to synchronize with cloud-based database systems built in Azure SQL.

You don't want to duplicate effort and create new apps on a proprietary system solely for the data arriving at the edge from your vehicle sensors. Another important requirement is the ability to develop the app by using the SQL Server skills your development team already possesses. Here, you'll see how you can achieve your company's goals for this app by implementing Azure SQL Edge.

## What will we be doing?

By the end of this session, you'll be able to evaluate whether Azure SQL Edge is appropriate for interaction with your apps and IoT devices at the edge. You'll also describe how Azure SQL Edge's familiar engine and toolset features enable you to optimize data ingest and analysis. You'll learn that Azure SQL Edge is:

- Powerful enough to support edge compute.
- Secure enough to help meet the privacy needs of IoT applications.
- Compatible with a familiar ecosystem of products, tools, and services.

## What is the main goal?

The main goal is to determine how Azure SQL Edge and its familiar features can help you support the full range of IoT scenarios.
