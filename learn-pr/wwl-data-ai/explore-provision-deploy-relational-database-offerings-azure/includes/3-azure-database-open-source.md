::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=ce78f373-359f-4e5a-b411-4e0d2cdfbf70]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

In addition to Azure SQL services, Azure data services are available for other popular relational database systems, including MySQL and PostgreSQL. The primary reason for these services is to enable organizations that use them in on-premises apps to move to Azure quickly, without making significant changes to their applications.

## What are MySQL and PostgreSQL?

MySQL and PostgreSQL are relational database management systems that are tailored for different specializations.

MySQL started life as a simple-to-use open-source database management system. It's a popular open source relational database for *Linux, Apache, MySQL, and PHP* (LAMP) stack apps. It's available in several editions; Community, Standard, and Enterprise. The Community edition is available free-of-charge, and has historically been popular as a database management system for web applications, running under Linux. Versions are also available for Windows. Enterprise edition provides a comprehensive set of tools and features, including enhanced security, availability, and scalability. The Standard and Enterprise editions are commercial versions of the software and aren't free.

PostgreSQL is an object-relational database. You can store data in relational tables, but a PostgreSQL database also enables you to store custom data types, with their own nonrelational properties. The database management system is extensible; you can add code modules to the database, which can be run by queries. Another key feature is the ability to store and manipulate geometric data, such as lines, circles, and polygons.

PostgreSQL has its own procedural language called *PL/pgSQL*. This language extends the standard relational query language, SQL, with features that enable you to write stored procedures that run inside the database.

## Azure Database for MySQL

Azure Database for MySQL is a PaaS implementation of MySQL in the Azure cloud, based on the MySQL Community Edition.

The Azure Database for MySQL service supports high availability with automatic failover, and scalability as required. You only pay for what you use. Automatic backups are provided, with point-in-time restore for up to 35 days (seven days by default).

The server provides connection security to enforce firewall rules and, optionally, require TLS connections. Many server parameters enable you to configure server settings such as lock modes, maximum number of connections, and timeouts.

Azure Database for MySQL scales to large databases without the need to manage hardware, network components, virtual servers, software patches, and other underlying components.

Certain operations aren't available with Azure Database for MySQL. These functions are primarily concerned with security and administration. Azure manages these aspects of the database server itself.

### Benefits of Azure Database for MySQL

You get the following features with Azure Database for MySQL:

- High availability features built-in.
- Predictable performance.
- Easy scaling that responds quickly to demand.
- Secure data, both at rest and in motion.
- Automatic backups and point-in-time restore for up to 35 days (seven days by default).
- Enterprise-level security and compliance with legislation.

The system uses pay-as-you-go pricing so you only pay for what you use.

Azure Database for MySQL servers provides monitoring functionality to add alerts, and to view metrics and logs.

### Azure Database for MySQL Flexible Server

The flexible-server deployment option is a fully managed database service designed to provide more granular control and flexibility over database management functions and configuration settings. It provides cost optimization controls. With an Azure free account, you can use Flexible Server free for 12 months.

## Azure Database for PostgreSQL

If you prefer PostgreSQL, you can choose Azure Database for PostgreSQL to run a PaaS implementation of PostgreSQL in the Azure Cloud. This service provides the same availability, performance, scaling, security, and administrative benefits as the MySQL service.

Some features of on-premises PostgreSQL databases aren't available in Azure Database for PostgreSQL. These features are mostly concerned with the extensions that users can add to a database to perform specialized tasks. Azure Database for PostgreSQL supports a set of extensions and modules. For the current list, see [Extensions and modules in Azure Database for PostgreSQL](/azure/postgresql/extensions/concepts-extensions-by-engine).

### Azure Database for PostgreSQL Flexible Server

The flexible-server deployment option for PostgreSQL is a fully managed database service. It provides a high level of control and server configuration customizations, and provides cost optimization controls. With an Azure free account, you can use Flexible Server free for 12 months.

### Benefits of Azure Database for PostgreSQL

Azure Database for PostgreSQL is a highly available service. It contains built-in failure detection and failover mechanisms.

Users of PostgreSQL are familiar with the **pgAdmin** tool, which you can use to manage and monitor a PostgreSQL database. You can continue to use this tool to connect to Azure Database for PostgreSQL. However, some server-focused functionality, such as performing server backup and restore, aren't available because the server is managed and maintained by Microsoft.

When you enable query store, Azure Database for PostgreSQL records information about queries run against databases on the server, and saves them in a database named *azure_sys*. You query the *query_store.qs_view* view to see this information, and use it to monitor the queries that users are running. This information can help you fine-tune the queries performed by your applications.

::: zone-end
