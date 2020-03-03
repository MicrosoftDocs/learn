You need to calculate the requirements of your existing workload, before creating the Cosmos DB database.

### Estimate data size

To start with, note down the existing data size. If the migrated application will have more or less data, multiply average data size by number of rows. The value from either approach is the minimum database size of the new database.

### Estimate existing throughput

Estimate the existing read rate, from query and get operations. Estimate the existing write rate, from insert, update, and delete operations.

## Create the Cosmos DB database

Once you have the estimated throughput, you can create your Azure Cosmos DB account and tables.

Azure Cosmos DB can elastically scale storage and throughput. Because of this, the estimates are a starting point and storage and throughput can be altered at any time.

To estimate request units (RUs) and storage you can use this online calculator:

[Estimate Request Units and Data Storage](https://aka.ms/AA58ejk)

### Create the database

To create the database, use the following steps:

1. Create a new resource in the Azure portal and choose a Cosmos DB account. Specify **Cassandra** as the **API**.
2. Create a new virtual network during the creation process, or use a pre-existing virtual network, and configure the firewall to allow access.

### Create the required tables

To create the tables, use CSQLSH, or create the tables in the Azure portal, in Data Explorer. Specify the estimated throughput in RUs at this point. To create the tables in **Data Explorer**, use the following steps:

1. Once your Cosmos DB account is created, select your Cosmos DB account and click **Data Explorer**.
1. In **Data Explorer**, click **New Table**.
1. Specify a schema name for the **Keyspace name**.
1. Specify a table name for **tableid**.
1. Specify a list of columns for **CREATE TABLE**.
    For example,**(customerid int, firstname text, lastname text, email text, stateprovince text, PRIMARY KEY ((stateprovince), customerid))**
1. Specify a **Throughput**.
