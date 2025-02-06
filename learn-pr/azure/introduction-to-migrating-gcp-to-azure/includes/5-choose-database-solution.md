Relational databases enforce strict relationships between data rows in different tables and a static schema. NoSQL databases are less strict but can store data more efficiently and are more effective for some applications. Data warehouses are amalgamations of databases from throughout your organization, designed to provide deep insights and support. Both Azure and Google Cloud provide options for all these data stores and more.

In your global cycling manufacturer, you have customer data stored in Google Cloud, Spanner, and Bigtable. The customer data is sensitive because it stores personal details including addresses and credit card details. You're assessing whether to migrate the data into your recently acquired competitor's customer relationship management system. This recently acquired system uses Azure Cosmos DB for storage. You need to understand the features of Azure database services.

In this unit, let's explore how Azure data services map to similar ones in Google Cloud.

:::image type="content" source="../media/databases-overview.png" alt-text="A diagram showing the types of service provided by Microsoft Azure and Google Cloud." border="false":::

## Choosing a relational database service

In Google Cloud, there are two relational database systems to choose from:

- **Cloud SQL**: This service is a managed relational database for MySQL, PostgreSQL, and SQL Server.
- **Spanner**: This service is a globally distributed, horizontally scalable database with strong consistency.

In Azure, instead of a single Cloud SQL database service that supports different clients, you have separate services:

- [**Azure SQL Database**](/azure/azure-sql/database/sql-database-paas-overview): A full cloud-based implementation of Microsoft's industry-leading SQL Server database system.
- [**Azure Database for MySQL**](/azure/mysql/flexible-server/overview): A full cloud-based implementation of Oracle's MySQL database server.
- [**Azure Database for MariaDB**](/azure/mariadb/overview): MariaDB is a fork of MySQL, guaranteed to remain free and open source after Oracle's acquisition of MySQL.
- [**Azure Database for PostgreSQL**](/azure/postgresql/flexible-server/service-overview): A full cloud-based implementation of the popular PostgreSQL database server.

## Choosing a NoSQL database service

In Google Cloud, there are two NoSQL services to choose from:

- **Firestore**: NoSQL document database ideal for mobile and web applications.
- **Bigtable**: Wide-column NoSQL database for large analytical and operational workloads.

In Azure, the [**Cosmos DB**](https://azure.microsoft.com/products/cosmos-db/) service has a semi-structured design and supports many different data APIs including:

- NoSQL
- MongoDB
- PostgreSQL
- Cassandra
- Gremlin
- Azure Storage Tables API

NoSQL is the native API and you should choose it if you're building a solution from scratch.

Both Google Cloud's Spanner and Azure's Cosmos DB offer global distribution, but Cosmos DB supports more data models and consistency levels.

## Choosing a data warehouse service

Google Cloud's data warehousing service is called **BigQuery** and offers a fully managed, serverless data warehouse with built-in machine learning capabilities. The equivalent services in Azure are called **Azure Synapse Analytics**. It integrates SQL data warehousing, Spark big data technologies, Data Explorer for log and time series analytics, and pipelines for data integration.

BigQuery and Azure Synapse Analytics both offer serverless data warehousing, though they have different strengths in terms of integration and performance optimization.

## Learn more

- [Google Cloud to Azure services comparison](/azure/architecture/gcp-professional/services)
- [Explore PostgreSQL architecture](/training/modules/explore-postgresql-architecture/)
- [Explore MySQL architecture](/training/modules/explore-mysql-architecture/)
- [Get started with the MongoDB API in Azure Cosmos DB](/training/modules/get-started-mongodb-api-azure-cosmos-db/)
- [Introduction to Azure Cache for Redis](/training/modules/intro-to-azure-cache-for-redis/)
- [What is Azure Synapse Analytics?](/azure/synapse-analytics/overview-what-is)
