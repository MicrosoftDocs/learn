

Azure Database for PostgreSQL is a platform as a service (PaaS) database available in several versions, and different server configurations. Each server option offers a choice of versions for PostgreSQL community edition.

Azure Database for PostgreSQL is available as the following deployment option:

- **Flexible server** - with the option to install PostgreSQL version 11, 12, 13, 14, 15 or 16.

Azure Database for PostgreSQL flexible servers can be started and stopped, so that you aren't charged for time you aren't using the server.

> [!NOTE]
> When a PostgreSQL server is stopped, you are notified that it will restart within a certain number of days, if you do not restart it.

Azure Database for PostgreSQL flexible server is a fully managed database service in Azure, with a friendly user interface to configure a wide range of parameters and offers several PostgreSQL versions, including the most recent. There's no access to the underlying operating system or file system.

Flexible server has a fully qualified domain name (FQDN) which should be used when connecting.

Flexible server provides fine grained control and flexibility with database configuration settings. For new implementations, flexible server provides the best value including the ability to stop/start the server, and a burstable compute tier that is optimized for workloads that don't require continuous high capacity. Flexible server is also designed for zone resilient high availability, with data files residing on Azure storage and maintained in three locally redundant locations. If the service fails, a new Linux VM (virtual machine) is provisioned, and the data files are mapped to the new VM. The PostgreSQL database engine is then brought online with the new VM.

Flexible server also offers: more predictable performance, more control in configuring the server, a custom maintenance window, cost optimization controls, and a simplified developer experience.

> [!IMPORTANT]
> Use the full server name, which you can copy from the Overview blade. The server's IP address is not guaranteed to remain static.
