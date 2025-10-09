Connecting to external storage and databases is a core capability that extends Unity Catalog's governance beyond your Databricks environment. Rather than copying data into Unity Catalog, you can create governed connections that provide secure, auditable access to data in its original location. Unity Catalog supports connections to various external sources including cloud storage like Azure Data Lake Storage, relational databases such as Azure SQL Database, PostgreSQL, MySQL, and others, and some data platforms outside Azure. Unity Catalog serves as the foundation for all of these external connectivity capabilities. In this unit, we'll walk through four essential concepts: storage credentials, lakehouse federation, foreign catalogs & connections, and Delta Sharing.

## Explore storage credentials and external locations

When Databricks interacts with cloud storage, it needs two things: a way to authenticate, and a definition of where the data lives. Storage credentials answer the how, by describing the authentication method Databricks should use. This could be an Azure Managed Identity, a service principal, or another supported mechanism. External locations answer the where, by linking a cloud storage path to a credential.

Think of storage credentials as the "keys" and external locations as the "address." Together, they ensure that all access to external data is governed through Unity Catalog. This model prevents ad hoc connections and enforces a single set of policies across users.

For example, a team might create a storage credential tied to a managed identity, and then define an external location for a secure container in Azure Data Lake Storage. From there, data can be read into Databricks as external tables:

```sql
CREATE STORAGE CREDENTIAL finance_cred
WITH AZURE_MANAGED_IDENTITY NAME 'finance-identity';

CREATE EXTERNAL LOCATION finance_data
URL 'abfss://finance@mydatalake.dfs.core.windows.net/'
WITH CREDENTIAL finance_cred;
```

## Understand Lakehouse Federation

Lakehouse Federation allows Databricks to query data where it already resides, without copying it into the lakehouse first. This is especially valuable when operational systems like Azure SQL Database contain important datasets that need to be combined with Delta tables in Databricks.

The federation process begins with a connection, which stores the authentication details and endpoint of the external system. Once the connection exists, you can create a foreign catalog that exposes the schemas and tables from that system inside Unity Catalog. To a user, these foreign catalogs behave like native Databricks catalogs, meaning queries can join across internal and external data seamlessly.

Here's what that looks like for an Azure SQL Database:

```sql
CREATE CONNECTION sales_sql_conn
TYPE sqlserver
OPTIONS (
  host 'myazuresqldb.database.windows.net',
  database 'salesdb',
  port 1433,
  user 'sql_admin',
  password '********'
);

CREATE FOREIGN CATALOG sales_sql_catalog
USING CONNECTION sales_sql_conn;
```

This approach reduces duplication, keeps sensitive systems governed under Unity Catalog, and creates a unified view of data regardless of where it lives.

### Foreign Catalogs and Connections

Connections and foreign catalogs are the two key objects that make federation possible. A connection is the secure link into an external system, while a foreign catalog is the logical representation of that system inside Databricks. Once a foreign catalog is created, its schemas and tables are immediately available for queries, subject to the same governance and permissions as internal Databricks data.

This means a data analyst can query tables in Azure SQL Database and Delta Lake side by side, or a data scientist can join operational data with historical data for richer insights, all without manually exporting files or moving data between systems.

## Share data securely with Delta Sharing

Delta Sharing extends Databricks' governance model beyond the boundaries of a single organization. It is an open protocol for secure data exchange, which means you can provide live, governed datasets to other Databricks workspaces or even to external clients that do not use Databricks at all.

There are two main patterns. In Databricks-to-Databricks sharing, the provider workspace creates a share, adds tables to it, and assigns recipients. The recipient workspace then sees those tables directly in their Unity Catalog. In open sharing, the provider issues a secure URL and recipients can connect using Delta Sharing connectors in tools such as pandas, Apache Spark, or Power BI.

Setting up a share is straightforward. First, create the share, then add tables to it, and finally assign recipients:

```sql
CREATE SHARE sales_share;
ALTER SHARE sales_share ADD TABLE sales_sql_catalog.dbo.transactions;
CREATE RECIPIENT partner_recipient;
```

Recipients query the data directly from the provider, ensuring consistency without the need for duplication or manual file transfers.