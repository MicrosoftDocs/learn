
[Azure SQL Edge](/azure/azure-sql-edge/overview) is an optimized relational database engine geared for IoT and IoT Edge deployments. Azure SQL Edge is built on the same engine as SQL Server and Azure SQL. Developers with SQL Server skills can reuse their code to build edge-specific solutions on Azure SQL Edge. Azure SQL Edge provides capabilities to stream, process, and analyze relational and nonrelational data.

### Things to know about Azure SQL Edge

Let's review the characteristics of Azure SQL Edge that make it useful to include in a relational data storage solution.

- Azure SQL Edge is a containerized Linux application. The startup-memory footprint is less than 500 MB.

- You can design and build apps that run on many IoT devices. Capture continuous data streams in real time, or integrate data in a comprehensive organizational data solution. The following diagram shows how SQL Edge captures and stores streaming data.

   :::image type="content" source="../media/sql-edge.png" alt-text="Diagram shows how SQL Edge captures and stores streaming data." lightbox="../media/sql-edge-large.png" border="false":::

- Access a built-in streaming engine to help derive insights from data streams.

   - Perform transformation, Windowed aggregation, Simple anomaly detection, and classification of incoming data streams.

   - Use time-series storage for time-indexed data, which can be aggregated and stored in the cloud for future analysis.

- Azure SQL Edge interacts with components at the network edge including edge gateways, IoT devices, and edge servers.

   :::image type="content" source="../media/sql-edge-connection.png" alt-text=" Diagram shows how Azure SQL Edge interacts with components at the network edge, including edge gateways, IoT devices, and edge servers." lightbox="../media/sql-edge-connection-large.png" border="false":::

- Azure SQL Edge is available in two editions that have identical feature sets. The editions offer different usage rights and the amount of memory and cores accessible on the host system.

   | Azure SQL Edge Developer | Azure SQL Edge |
   | --- | --- |
   | Each Azure SQL Edge Developer container is limited to up to four cores and 32-GB memory. | Each Azure SQL Edge container is limited to up to eight cores and 64-GB memory. |
   | Development only | Production |

#### Deployment security

Security is a primary concern when deploying IoT apps to the edge. Because Azure SQL Edge is based on SQL Server technology, one of the most secure database platforms available, it has the same security features of SQL Server Enterprise. The same security policies and practices are extended from cloud to the edge.

Ensuring protection for Azure SQL Edge deployments involves four steps:

1. **Platform and system security**. This security step includes the physical docker host, the operating system on the host, and the networking systems that connect the physical device to applications and clients.

1. **Authentication and authorization**. SQL authentication refers to the authentication of a user when connecting to Azure SQL Edge by using their username and password. Authorization refers to the permissions assigned to a user within a database in Azure SQL Edge.

1. **Database object security**. Database objects or _securables_ are the server, database, and other objects in the database. Encryption enhances security. Data protection with Transparent Data Encryption (TDE) enables compliance with many security regulations. "Always Encrypted" provides separation between users who own the data and administrators who manage the data. 

1. **Application security**. Azure SQL Edge security best practices include writing secure client applications.

#### Deployment options

Azure SQL Edge as two deployment options:

- **Connected deployment**: For connected deployment, Azure SQL Edge is available on the Azure Marketplace and can be deployed as a module for Azure IoT Edge. 

- **Disconnected deployment**: Disconnected deployment is accomplished through Azure SQL Edge container images. The images can be pulled from docker hub and deployed either as a standalone docker container or on a Kubernetes cluster.

> [!IMPORTANT] 
> Azure SQL Edge is optimized for IoT use cases and workloads. SQL Server and SQL Database, in contrast, are built for mission-critical, data-management solutions, and line-of-business (LOB) apps.

#### Business scenario

Consider a business scenario for real-time ingestion of data in an automotive manufacturing company. Developers are working on an IoT app that ingests data from several IoT sensors in the vehicles manufactured by the company. It's important that the data is usable all the time, regardless of whether the vehicles' apps are online or offline. Another goal is to use the data to help with product development. The data must synchronize easily with cloud-based database systems built in Azure SQL. You've been asked to recommend a solution specifically for SQL Server that should be powerful enough to support edge compute. The strategy should be secure enough to help meet the privacy needs of IoT applications. Azure SQL Edge is best suited to support these requirements due to its small footprint, and because it's edge-optimized for IoT devices.

### Things to consider when using Azure SQL Edge

Consider how Azure SQL Edge can be included in your relational data storage plan for Tailwind Traders:

- **Consider network connectivity limitations**. Keep working if network connectivity isn't available. Azure SQL Edge supports solutions that work with, or without, network connectivity.

- **Consider slow or intermittent broadband connection**. Continue working with a local database if there are slow connection speeds or intermittent connectivity issues. Azure SQL Edge provides a powerful, local database. It negates needing to forward all data to a cloud-based database, which eliminates latency.

- **Consider data security and privacy concerns**. Address concerns about sensitive data and privacy. Azure SQL Edge implements RBAC and ABAC, encryption, and data classification. You can secure and control access to your IoT app data.

- **Consider synchronization and connectivity to back-end systems**. Synchronize your workloads with back-end systems. Azure SQL Edge makes it easy to exchange data with other systems like Azure SQL Database, SQL Server, and Azure Cosmos DB.

- **Consider code and skill familiarity**. Take advantage of developer knowledge about working with SQL. Azure SQL Edge shares the same codebase as SQL Server. Developers with skills in SQL Server or SQL Database can reuse their code and skills.