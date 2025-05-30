Relational databases enforce strict relationships between data rows in different tables and a static schema. NoSQL databases are less strict, but they can store data more efficiently and are more effective for some applications. Data warehouses are amalgamations of databases from throughout your organization that can provide deep insights and support. Both Azure and Google Cloud provide options for all these data stores and more.

In the scenario of the global cycling retailer, you have customer data stored in Google Cloud, Spanner, and Bigtable. The customer data is sensitive because it stores personal details, including addresses and credit card information. You're assessing whether to migrate the data into your recently acquired competitor's customer relationship management (CRM) system. This CRM system uses Azure Cosmos DB for storage. You need to understand the features of Azure database services.

In this unit, let's explore how Azure data services map to similar ones in Google Cloud.

:::image type="content" source="../media/databases-overview.png" alt-text="Diagram that shows the types of services provided by Microsoft Azure and Google Cloud, with databases highlighted." border="false":::

## Choose a relational database service

Google Cloud has two relational database systems to choose from:

- **Cloud SQL**: This service is a managed relational database for MySQL, PostgreSQL, and SQL Server.
- **Spanner**: This service is a globally distributed, horizontally scalable database with strong consistency.

In Azure, instead of a single SQL database service that supports various clients, there are separate services:

- [Azure SQL Database](/azure/azure-sql/database/sql-database-paas-overview): A full cloud-based implementation of the Microsoft SQL Server database system.
- [Azure Database for MySQL](/azure/mysql/flexible-server/overview): A full cloud-based implementation of Oracle's MySQL database server.
- [Azure Database for MariaDB](/azure/mariadb/overview): A full cloud-based implementation of MariaDB. MariaDB is a fork of MySQL that remained free and open source after Oracle's acquisition of MySQL.
- [Azure Database for PostgreSQL](/azure/postgresql/flexible-server/service-overview): A full cloud-based implementation of the PostgreSQL database server.

## Choose a NoSQL database service

Google Cloud has two NoSQL services to choose from:

- **Firestore**: NoSQL document database for mobile and web applications.
- **Bigtable**: Wide-column NoSQL database for large analytical and operational workloads.

In Azure, the [Azure Cosmos DB](https://azure.microsoft.com/products/cosmos-db/) service has a semistructured design. It supports many data APIs, including:

- NoSQL
- MongoDB
- PostgreSQL
- Cassandra
- Gremlin
- Azure Table Storage REST API

NoSQL is the native API. You should choose it if you're building a solution from scratch.

Both Google Cloud Spanner and Azure Cosmos DB offer global distribution, but Azure Cosmos DB supports more data models and consistency levels.

## Choose a data warehouse service

Google Cloud's data warehousing service is *BigQuery*. It's fully managed and has built-in machine learning capabilities. The equivalent service in Azure is *Azure Synapse Analytics*. It integrates SQL data warehousing, Spark big-data technologies, Azure Data Explorer for log and time-series analytics, and pipelines for data integration.

BigQuery and Azure Synapse Analytics both offer serverless data warehousing, though they have different strengths in terms of integration and performance optimization.

## Learn more

- [Google Cloud to Azure services comparison](/azure/architecture/gcp-professional/services)
- [Explore PostgreSQL architecture](/training/modules/explore-postgresql-architecture/)
- [Explore MySQL architecture](/training/modules/explore-mysql-architecture/)
- [Get started with the MongoDB API in Azure Cosmos DB](/training/modules/get-started-mongodb-api-azure-cosmos-db/)
- [Introduction to Azure Cache for Redis](/training/modules/intro-to-azure-cache-for-redis/)
- [What is Azure Synapse Analytics?](/azure/synapse-analytics/overview-what-is)
