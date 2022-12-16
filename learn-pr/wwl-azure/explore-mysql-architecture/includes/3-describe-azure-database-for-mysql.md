**MySQL** is a popular open-source database server that works on Windows, Linux, and macOS. MySQL is available in different editions, including:

- MySQL Community Edition - the open-source version distributed by Oracle.
- MariaDB - open source and distributed by the Maria DB Foundation.
- MySQL Enterprise Edition - licensed by Oracle.
- Percona Server for MySQL - open source and similar in functionality to MySQL Community Edition.

Microsoft has implemented **Azure Database for MySQL** in Azure as a Platform as a Service (PaaS) database. Azure Database for MySQL is a fully managed database service that is ready installed, ready configured with automatic backups and in-built security.

For applications that require a fast response from the database, the number of CPU cores, amount of IOPS, and amount of RAM are important factors. When a company buys on-premises hardware, it can be difficult to predict future requirements as your needs change. Azure offers the flexibility of scaling up or down as needed. You can even stop Azure Database for MySQL when it isn't required, and you aren't charged for the resource whilst it's stopped. You can also increase IOPS without increasing storage.

Azure Database for MySQL provides the MySQL Community Edition with:

- **Configuration** options for your needs.
- Full **management**.
- Comprehensive **security**.
- Automatic **maintenance**, including backups.

:::image type="content" source="../media/mysql-managed.png" alt-text="Screenshot showing Azure Database for MySQL includes full management, configuration, security, and maintenance features." lightbox="../media/mysql-managed.png":::

**Azure Database for MySQL** provides the MySQL Community edition in versions 5.7 or 8.0. 

> [!NOTE]
> Azure Database for MySQL does not allow access to the underlying operating system or file system, and some data manipulation commands aren't supported.

Azure Database for MySQL can be deployed using one of three compute tiers:

* Burstable. This tier is best suited to low concurrency workloads that don't need full compute capacity.
* General purpose. This tier is best suited for medium concurrency workloads.
* Memory optimized. This tier is the best solution for high concurrency workloads.

Pricing is per-server, and not per-database. The pricing structure is based on the configuration of the compute tier, including the number of vCores, the amount of storage (GB), and the amount of IOPS.

## Zone redundant high availability

Azure Database for MySQL provides zone independent high availability with automatic failover. This ensures that data isn't lost in the event of a failure. When high availability is configured, a standby replica is provisioned and maintained with every database modification.

There are two high availability options:

- **Zone-redundant HA**. This option provides the highest level of availability, with redundancy across zones. This option can be enabled only when the server is created.
- **Same-zone HA**. This option provides lower network latency because the primary and standby servers are in the same availability zone.
