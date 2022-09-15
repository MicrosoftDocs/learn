**MySQL** is a popular open-source database that works on Windows, Linux, and macOS. MySQL is available in different editions, including:

- MySQL Community Edition, the open-source version distributed by Oracle.
- MariaDB - open source and distributed by the Maria DB Foundation.
- MySQL Enterprise Edition - licensed by Oracle.
- Percona Server for MySQL - open source and similar in functionality to MySQL Community Edition.

Microsoft has implemented **Azure Database for MySQL** in Azure as Platform as a Service (PaaS) database. Azure Database for MySQL is a fully managed database service that is ready installed, ready configured with automatic backups and in-built security.

For applications that require a fast response from the database, the number of CPU cores, amount of IOPS, and amount of RAM are important factors. When a company buys on-premises hardware, it can be difficult to predict future requirements as your needs change. Azure offers the flexibility of scaling up or down as needed. You can even stop Azure Database for MySQL when it isn't required, and you aren't charged for the resource whilst it's stopped. With Azure Database for MySQL Flexible server, you can increase IOPS without increasing storage.

Azure Database for MySQL provides the MySQL Community Edition with:

- **Configuration** options for your needs
- Full **management**
- Comprehensive **security**
- Automatic **maintenance**, including backups

:::image type="content" source="../media/mysql-managed.png" alt-text="Screenshot showing Azure Database for MySQL includes full management, configuration, security, and maintenance features." lightbox="../media/mysql-managed.png":::

**Azure Database for MySQL** provides the MySQL Community edition in versions 5.7 or 8.0. You can choose to deploy it one of two modes:

- **Flexible Server** - runs on Linux. Flexible server provides a high level of flexibility in how you configure MySQL and is best suited to new developments as well as migration of production workloads.
- **Single Server** - runs on Windows. Single server is designed for minimal customization and is best suited to existing applications that already leverage single server. Azure Database for MySQL Single server isn't available in all regions and you might need to alter the deployment region or use Azure Database for MySQL Flexible server.

:::image type="content" source="../media/azure-mysql-deployment-options.png" alt-text="Screenshot showing Azure Database for MySQL deployment options: single server or flexible server." lightbox="../media/azure-mysql-deployment-options.png":::

> [!NOTE]
> Azure Database for MySQL does not allow access to the underlying operating system or file system, and some data manipulation commands aren't supported.

Both options can be deployed using one of three compute tiers:

* Basic (single server) or Burstable (flexible server). These are best suited to low concurrency workloads that don't need full compute capacity.
* General purpose. This is best suited for medium concurrency workloads.
* Memory optimized. This is the best solution for high concurrency workloads.

Pricing is per-server, and not per-database. The pricing structure is based on the configuration of the compute tier, including the number of vCores and amount of storage (GB), and, for Flexible server, the amount of IOPS.

## Zone redundant high availability

Azure Database for MySQL provides zone independent high availability with automatic failover. This ensures that data isn't lost in the event of a failure. When high availability is configured, a standby replica is provisioned and maintained with every database modification.

There are two high availability options:

- **Zone-redundant HA**. This option provides the highest level of availability, with redundancy across zones. This option can be enabled only when the server is created. This isn't supported by Azure Database for MySQL single server.
- **Same-zone HA**. This option provides lower network latency because the primary and standby servers are in the same availability zone.
