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

