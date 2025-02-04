Databases underpin most internet and intranet applications and cloud services offer a variety of types.

In your global clothing retailer, you have systems that store both relational data in AWS RDS and NoSQL data in DynamoDB SimpleDB and Amazon DocumentDB. In the recently aquired company, which uses Azure for cloud systems, data is stored in Azure SQL Database, Azure Database for MariaDB, and in Azure Cosmos DB. You need to investigate the capabilities of all these systems to determine which can be merged and which migrated.

In this unit, you'll compare database services offered by AWS and Azure.

:::image type="content" source="../media/databases-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Amazon AWS.":::

## Understand database technologies on Azure and AWS

Relational databases enforce strict relationships between data rows in different tables and a static schema. NoSQL databases are less strict but can store data more efficiently and are more effective for some applications. Data warehouses are amalgamations of databases from throughout your organizations, designed to provide deep insights and support. Both Azure and AWS provide options for all these data stores and more.

Let's explore how AWS data services map to similar offerings in Azure:

### Relational databases

In AWS, RDS is a managed relational database service that supports six database engines: Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database, and SQL Server.

In Azure, instead of a single relational database service with six engines, you have separate services:

- [**Azure SQL Database**](/azure/azure-sql/database/sql-database-paas-overview): A full cloud-based implementation of Microsoft's industry-leading SQL Server database system.
- [**Azure Database for MySQL**](/azure/mysql/flexible-server/overview): A full cloud-based implementation of Oracle's MySQL database server.
- [**Azure Database for MariaDB**](/azure/mariadb/overview): MariaDB is a fork of MySQL, guaranteed to remain free and open source after Oracle's aquisition of MySQL.
- [**Azure Database for PostgreSQL**](/azure/postgresql/flexible-server/service-overview): A full cloud-based implementation of the popular PostgreSQL database server.

### NoSQL databases

In AWS, there are three NoSQL services to choose from:

- DynamoDB SimpleDB
- Amazon DocumentDB
- Amazon Neptune(Graph)

In Azure the [**Cosmos DB**](https://azure.microsoft.com/products/cosmos-db/) service has a semi-structured design and supports many different data APIs including:

- NoSQL
- MongoDB
- PostgreSQL
- Cassandra
- Gremlin (Graph)
- Azure Storage Tables API

NoSQL is the native API and you should choose it if you are building a solution from scratch. However, if you want to migrate a system from a MongoDB database, use the MongoDB API to reduce the amount of recoding you have to complete.

### Data warehouses

In AWS, the **Amazon Redshift** system provides data warehousing functionality. The Azure equivalent is [**Azure Synapse Analytics**](/azure/synapse-analytics/overview-what-is).

### Serverless data services

In serverless computing, a cloud service automatically scales compute resources to reflect demand. In certain usage scenarios, this approach can reduce costs for services that sometimes have low traffic:

- **Azure SQL Database**: Use the [**Serverless**](/azure/azure-sql/database/serverless-tier-overview) compute tier to implement this functionality.
- **AWS Aurora**: Use the **AWS Aurora Serverless** service to implement this functionality.

### Other database services

Caching databases are popular ways to optimize performance for cloud-native applications and often use **Redis**. [**Azure Cache for Redis**](https://azure.microsoft.com/products/cache/) is an implementation of Redis in the Azure cloud. The equivalent service in AWS is **Amazon MemoryDB for Redis**. Another non-Redis cache service is **ElastiCache**.

There are a variety of big data, analytics, and ETL/ELT services in Azure including: **Azure Databricks**, **Azure HDInsight**, and **Azure Data Factory**. Similar functionality is available in AWS with **Amazon Elastic MapReduce (EMR)**. **Amazon Athena** is also used for querying data in S3 using SQL.

## Database migration

The [Azure Database Migration Service](https://azure.microsoft.com/products/database-migration) is a tool that helps you move data, schema, and database objects to Azure. You can migrate from AWS database to Microsoft SQL Server, MySQL, PostreSQL, and MongoDB.

|Source |Target  |Offline support  |Online support  |
|---------|---------|---------|---------|
|Amazon RDS SQL | Azure SQL Database |  Yes| No |
|Amazon RDS SQL | Azure SQL Database Managed Instance |Yes   |Yes |
|Amazon RDS SQL | Azure SQL VM | Yes |Yes    |
|Amazon RDS SQL | Azure Database for MySQL - Single server    |  Yes  | No   |
|Amazon RDS SQL | Azure Database for MySQL - Flexible server  |  Yes  | Yes   |
|Amazon RDS MySQL | Azure Database for MySQL - Flexible server| Yes  | Yes  |
|Amazon RDS PostgreSQL | Database for MySQL - Flexible server | No |  Yes |

Offline support for migrating databases from AWS includes Amazon RDS SQL Server, Amazon RDS MySQL, and Amazon RDS PostgreSQL. This type of migration is a one-time transfer from the source platform to the target platform. The database is offline from the time that the migration starts to when it completes.

Online support for migrating databases from AWS includes Amazon RDS SQL, Amazon RDS MySQL, and Amazon RDS PostgreSQL. This type of migration provides support for continually synchronising a database from the source platform to the target platform. An online migration has minimal downtime.

For an up to date list of source and target database migrations supported by the Azure Database Migration Service, see [Azure Database Migration Service supported scenarios](/azure/dms/resource-scenario-status).

## Learn more

- [Relational database technologies on Azure and AWS](/azure/architecture/aws-professional/databases)
- [Explore PostgreSQL architecture](/training/modules/explore-postgresql-architecture/)
- [Explore MySQL architecture](/training/modules/explore-mysql-architecture/)
- [Get started with the MongoDB API in Azure Cosmos DB](/training/modules/get-started-mongodb-api-azure-cosmos-db/)
- [Introduction to Azure Cache for Redis](/training/modules/intro-to-azure-cache-for-redis/)
