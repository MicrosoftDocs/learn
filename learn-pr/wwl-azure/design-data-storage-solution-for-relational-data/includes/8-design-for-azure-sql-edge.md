[Azure SQL Edge](/azure/azure-sql-edge/overview) is an optimized relational database engine geared for IoT and IoT Edge deployments. Azure SQL Edge is built on the same engine as SQL Server and Azure SQL. This means that the developers with SQL server skills can reuse their code to build edge-specific solutions on Azure SQL Edge. Azure SQL Edge provides capabilities to stream, process, and analyze relational and non-relational such as JSON, graph and time-series data.

Azure SQL Edge is available with two different editions, as described in the following table. These editions have identical feature sets, and only differ in terms of their usage rights and the amount of memory and cores they can access on the host system.

- Azure SQL Edge Developer. For development only. Each Azure SQL Edge Developer container is limited to up to 4 cores and 32 GB memory.

- Azure SQL Edge. For production. Each Azure SQL Edge container is limited to up to 8 cores and 64 GB memory.

## Understand Azure SQL Edge deployment models

Azure SQL Edge supports two deployment modes.

- **Connected deployment through Azure IoT Edge.** Azure SQL Edge is available on the Azure Marketplace and can be deployed as a module for Azure IoT Edge

- **Disconnected deployment.** Disconnected deployment through Azure SQL Edge container images which can be pulled from docker hub and deployed either as a standalone docker container or on a Kubernetes cluster.

> [!IMPORTANT] 
> Azure SQL Edge is optimized for IoT use cases and workloads. SQL Server and SQL Database, in contrast, are built for mission-critical, data-management solutions, and line-of-business (LOB) apps.

## How does Azure SQL Edge work?

Azure SQL Edge is a containerized Linux application. The startup-memory footprint is less than 500 megabytes (MB). This allows users design and build apps that run on many IoT devices. SQL Edge can:

- Capture continuous data streams in real time

- Integrate the data in a comprehensive organizational data solution

The following diagram shows SQL Edge's capability of capturing and storing streaming data.

:::image type="content" source="../media/sql-edge.png" alt-text="Diagram shows SQL Edge's capability of capturing and storing streaming data.":::


With IoT data it is important not only to capture continuous real-time streams of increasing amounts of data but also derive valuable insights about it. Azure SQL Edge supports a built-in streaming engine to help address these needs. It has the following features

- The Streaming engine allows transformation, Windowed aggregation, Simple anomaly detection and classification of incoming data streams

- A time-series storage engine that allows storage of time-indexed data. This can be aggregated and stored in cloud for future analysis

The following diagram shows Azure SQL Edge interacts with components at the network edge including edge gateways, IoT devices, and edge servers.

:::image type="content" source="../media/sql-edge-connection.png" alt-text=" Diagram shows Azure SQL Edge interacts with components at the network edge including edge gateways, IoT devices, and edge servers.":::



Security is a primary concern when deploying IoT apps to the edge. Because Azure SQL Edge is based on SQL Server technology, one of the most secure database platforms available, it has the same security features of SQL Server Enterprise. Also the same security policies and practices are extended from cloud to the edge.

Securing Azure SQL Edge deployments involves the steps described in the following table:

1. Platform and system security. This includes the physical docker host, the operating system on the host, and the networking systems connecting the physical device to applications and clients.

2. Authentication and authorization. SQL authentication refers to the authentication of a user when connecting to Azure SQL Edge using username and password. Authorization refers to the permissions assigned to a user within a database in Azure SQL Edge 

3. Database object security. "Securables" are the server, database, and objects the database contains. Encryption enhances security. Data protection with Transparent Data Encryption (TDE) enables compliance with many security regulations. Always Encrypted provides separation between users who own the data and those who manage it 

4. Application security. Azure SQL Edge security best practices include writing secure client applications.

## Scenario - Real time ingestion of data

Let's imagine you work for an automotive manufacturing company. You're working on an IoT app that ingests data from several IoT sensors in the vehicles your company manufactures. It's important that the data is usable all the time, regardless of whether the vehicles' apps are online or offline. Another goal is to use the data to help with product development. This means that the data must synchronize easily with cloud-based database systems built in Azure SQL.

You've been tasked to recommend a solution specifically for SQL Server and should be powerful enough to support edge compute. It should be secure enough to help meet the privacy needs of IoT applications.

Azure SQL Edge is best suited to support the above requirement due to its small footprint and is edge-optimized for IoT devices.

## When do we use Azure SQL Edge?

Azure SQL Edge is ideal for:

| Requirement| SQL Edge capability |
| - | - |
| Connectivity limitations| Azure SQL Edge supports solutions that work with, or without, network connectivity. |
| Slow or intermittent broadband connection| Azure SQL Edge provides a powerful, local database. It negates needing to forward all data to a cloud-based database, which eliminates latency. |
| Data security and privacy concerns| Azure SQL Edge implements RBAC and ABAC, encryption, and data classification. This helps you secure and control access to your IoT apps' data. |
| Synchronization and connectivity to back-end systems| Azure SQL Edge provides ease of exchanging data with other systems like Azure SQL Database, SQL Server, and Azure Cosmos DB. |
| Familiarity| Azure SQL Edge shares the same codebase as SQL Server. Developers with skills in SQL Server or SQL Database can reuse their code and skills |
