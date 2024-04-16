

Azure Database for PostgreSQL is a platform as a service (PaaS) database available in several versions, and different server configurations. Each server option offers a choice of versions for PostgreSQL community edition.

Azure Database for PostgreSQL is available in three different deployment options:

- **Flexible server** - with the option to install PostgreSQL version 11, 12, 13, 14, 15 or 16 over Linux.
- **Azure Cosmos DB for PostgreSQL** - with the option to install PostgreSQL version 12, 13, 14, 15 or 16 with the Citus extension.
- **Azure Arc-enabled PostgreSQL server** (in preview) - For this option, Microsoft provides only the software, not the hardware infrastructure. It is supported up to version 14

Azure Database for PostgreSQL flexible servers can be started and stopped, so that you aren't charged for time you aren't using the server.

> [!NOTE]
> When a PostgreSQL server is stopped, you are notified that it will restart within a certain number of days, if you do not restart it.

## Flexible server

Azure Database for PostgreSQL flexible server runs over Linux and offers several PostgreSQL versions, including the most recent. Flexible server is a fully managed database service, with a friendly user interface to configure a wide range of parameters. There's no access to the underlying operating system or file system.

Flexible server has a fully qualified domain name (FQDN) which should be used when connecting.

Flexible server provides fine grained control and flexibility with database configuration settings. For new implementations, flexible server provides the best value including the ability to stop/start the server, and a burstable compute tier that is optimized for workloads that don't require continuous high capacity. Flexible server is also designed for zone resilient high availability, with data files residing on Azure storage and maintained in three locally redundant locations. If the service fails, a new Linux VM is provisioned, and the data files are mapped to the new VM. The PostgreSQL database engine is then brought online with the new VM.

Flexible server also offers more predictable performance, more control in configuring the server, a custom maintenance window, cost optimization controls and a simplified developer experience.

> [!IMPORTANT]
> Use the full server name, which you can copy from the Overview blade. The server's IP address is not guaranteed to remain static.

## Azure Cosmos DB for PostgreSQL

The Azure Cosmos DB for PostgreSQL option runs PostgreSQL from version 12 to 16, with the Citus extension.

Azure Cosmos DB for PostgreSQL is a managed service designed to be highly scalable, allowing you to seamlessly add new nodes as required. As new nodes are added, tables are transparently distributed across multiple nodes without interrupting database operations. You can start by configuring one burstable compute node, either for development and testing purposes, and then scale up to multiple production sized nodes without reinstalling the server and without disrupting client workloads.

This distributed model allows massive scalability by scaling out rather than scaling up.

An Azure managed services means that the platform will manage your backups, high availability through auto-failover, software updates, monitoring, and more for all of the servers in your cluster.

> [!NOTE]
> [Citus](https://github.com/citusdata/citus) is an extension of PostgreSQL, and not a fork of the code, which means the same version of PostgreSQL is used, regardless of which server version you select.

The available compute options are:

### Worker Nodes

- Single Node (Burstable 1 vCore with 2GiB RAM up to 64 vCores with 256 GiB RAM) - ideal to get started or for development
- Multiple Nodes with up to 20 nodes (4 vCores with 32 GiB RAM up to 96 vCores with 672 GiB RAM)

### Coordinator Node

- Single Node which can be scaled independently from worker nodes from 4 vCores with 32 GiB RAM up to 96 vCores with 672 GiB RAM.

## Azure Arc-enabled PostgreSQL server

Azure Arc-enabled PostgreSQL server is a preview feature and is one of the database engines available as part of Azure Arc-enabled data services. Azure Arc makes it possible to run Azure data services on-premises, at the edge, and in public clouds using Kubernetes and the infrastructure of your choice. Most PostgreSQL workloads should be capable of running against Azure Arc-enabled PostgreSQL server using standard drivers.

## Which server to choose

If you require high scalability with multiple nodes, you should deploy Azure Cosmos DB for PostgreSQL. In other scenarios you should deploy Flexible server.
