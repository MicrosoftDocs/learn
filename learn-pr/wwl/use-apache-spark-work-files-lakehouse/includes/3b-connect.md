You can use a Fabric notebook to connect to data held in Azure blob storage, an Azure SQL Database, and other storage options. By connecting to a data source, you can use the data in analytical processes even through it is not stored in a Fabric lakehouse. You can also use Spark code to filter and process the data before loading it into the lakehouse, enabling you to use Spark as a powerful tool for data ingestion into your Fabric analytics environment.

## Connect to Azure blob storage

The following PySpark code connects to data held in Azure blob storage, reads data into a DataFrame, and then displays the data.

```python
# Azure Blob Storage access info
blob_account_name = "azureopendatastorage"
blob_container_name = "nyctlc"
blob_relative_path = "yellow"

# blob_sas_token = "add your SAS token here" 
# Construct the path for connection
wasbs_path = f'wasbs://{blob_container_name}@{blob_account_name}.blob.core.windows.net/{blob_relative_path}'

# WASBS path for connection including SAS token
# wasbs_path = f'wasbs://{blob_container_name}@{blob_account_name}.blob.core.windows.net/{blob_relative_path}?{blob_sas_token}'

# Read parquet data from Azure Blob Storage path
blob_df = spark.read.parquet(wasbs_path)

# Display the Azure Blob DataFrame
display(blob_df)
```

> [!NOTE]
> This example shows how to connect to data held in Azure Open Datasets, which does not require a SAS token. To connect to your own data, you will need to generate a SAS token and add it to the code in the appropriate places indicated in the comments.

### Configure alternate authentication

The previous example connects to the source data with a SAS token, before reading the data into a DataFrame. Depending on where your data is stored, you might need to use a different authentication type, such as Service Principal or OAuth. Here's an example connecting to an Azure SQL Database with a Service Principal:

```python
# Azure SQL Database connection info
server_name = "your_server_name.database.windows.net"
port_number = 1433  # Default port number for SQL Server
database_name = "your_database_name"
table_name = "YourTableName" # Database table

client_id = "YOUR_CLIENT_ID"  # Service principal client ID
client_secret = "YOUR_CLIENT_SECRET"  # Service principal client secret

# Build the Azure SQL Database JDBC URL with Service Principal 
jdbc_url = f"jdbc:sqlserver://{server_name}:{port_number};database={database_name};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;Authentication=ActiveDirectoryServicePrincipal"

# Properties for the JDBC connection 
properties = {
    "user": client_id,
    "password": client_secret
            }

# Read table from Azure SQL Database using Entra ID Service Principal
sql_df = spark.read.jdbc(url=jdbc_url, table=table_name, properties=properties)

# Display the Azure SQL dataframe
display (sql_df)
```

> [!TIP]
> For more information about connecting using Microsoft Entra authentication, see **[Connect using Microsoft Entra authentication](/sql/connect/jdbc/connecting-using-azure-active-directory-authentication)**.

## Write data into a lakehouse file

After connecting to your dataand loading it into a dataframe, you can save it into a lakehouse. For example, the following code saves a dataframe in *Parquet* format, which supports structured, semi-structured, and unstructured data. Parquet has an optimized columnar storage structure, and efficient compression capabilities.

```python
# Write dataframe to Parquet file format
parquet_output_path = "Files/your_folder/your_file_name"

df.write.mode("overwrite").parquet(parquet_output_path)

print(f"DataFrame has been written to Parquet file: {parquet_output_path}")
```

> [!NOTE]
> Fabric lakehouses also support other file formats, including delimited text, JSON, Delta, Avro, ORC, and others.

## Write to a Delta table

Delta tables are a key feature of Fabric lakehouses because they support ACID transactions, a transaction log, and more. You can ingest and load your external data into a Delta table via notebooks. Delta tables are based on Parquet with the addition of a log file. Lakehouse tables are saved in Delta format, as indicated by the triangular Delta (&Delta;) icon next to the table name in the Fabric user interface.

The following code saves a Delta table:

```python
# Write dataframe to Delta table
delta_table_name = "your_delta_table_name"
df.write.format("delta").mode("overwrite").saveAsTable(delta_table_name)

# Confirm load as Delta table
print(f"DataFrame has been written to Delta table: {delta_table_name}")
```

> [!TIP]
> Learn more about Delta tables in **[Work with Delta Lake tables in Microsoft Fabric](/training/modules/work-delta-lake-tables-fabric/)**.

### Optimize Delta table writes

Spark is a parallel-processing framework, with data stored on one or more worker nodes, which means it scales well for large data. However, unless managed, Spark can store a large number of small data files, known as the *small file problem*, which can degrade query performance. *V-Order* and *Optimize write* are optimization options that are enabled by default in Fabric.

* **V-Order** enables faster and more efficient reads by various compute engines, such as Power BI, SQL, and Spark. V-order applies special sorting, distribution, encoding, and compression on parquet files at write-time.
* **Optimize write** improves the performance and reliability by increasing files sizes, and so reducing the number of files written. It's useful for scenarios where the Delta tables have suboptimal or nonstandard file sizes, or where the extra write latency is tolerable.

> [!TIP]
> Learn more about **[Delta Lake table optimization and V-Order](/fabric/data-engineering/delta-optimization-and-v-order)**.