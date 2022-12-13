Azure Database for PostgreSQL is a platform as a service (PaaS) database available in several versions, and different server configurations. Each server option offers a choice of versions for PostgreSQL community edition.

Azure Database for PostgreSQL is available in three different deployment options:

- **Flexible server** - with the option to install PostgreSQL version 11, 12, or 13 over Linux.
- **Hyperscale Citus** - with the option to install PostgreSQL version 11, 12, 13 or 14 with the Citus extension.
- **Azure Arc-enabled PostgreSQL Hyperscale** (in preview) - PostgreSQL with the Citus extension that allows either a single node or multiple nodes on any infrastructure including on-premises or multicloud. For this option, Microsoft provides only the software, not the hardware infrastructure.

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

## Hyperscale Citus

The Azure Database for PostgreSQL Hyperscale Citus option runs PostgreSQL version 14, with the Citus extension.

Hyperscale Citus is designed to be highly scalable, allowing you to seamlessly add new nodes as required. As new nodes are added, tables are transparently distributed across multiple nodes without interrupting database operations. You can start by installing the Basic Tier, either for development and testing purposes, and then scale up to multiple nodes without reinstalling the server and without disrupting client workloads.

This distributed model allows massive scalability by scaling out rather than scaling up.

> [!NOTE]
> Citus is an extension of PostgreSQL, and not a fork of the code, which means the same version of PostgreSQL is used, regardless of which server version you select.

The available compute tiers are:

- Basic (2 - 8 vCores) - ideal to get started or for development
- Standard (8 to 1000 + vCores)

## Which server to choose

If you require high scalability with multiple nodes, you should deploy Hyperscale Citus. In other scenarios you should deploy Flexible server.
