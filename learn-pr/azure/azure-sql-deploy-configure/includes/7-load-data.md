Once a database or instance is deployed, verified, and configured, the next logical step is to bring data in.

## Options, options, options

There are many options available for you when it comes to loading data into Azure SQL. Many of them overlap with what's available on-premises, but there are a few that will be called out in this unit.

### Bulk copy program

Bulk copy program (bcp) is a common utility for connecting to Azure SQL from on-premises, as well as connecting to Azure SQL from an Azure Virtual Machine. You can then use it to move data into Azure SQL.  

### BULK INSERT

Bulk insert operations are similar to in SQL Server on-premises, except instead of loading data from a file (or multiple files) on your machine, you load data from Azure Blob storage. The next exercise will walk through an example of how.  

### SSIS packages

In Azure SQL, you can use packages to connect with SSIS on-premises. You can host an SSIS DB in Azure SQL Database or Azure SQL Managed Instance. Additionally, you can use the Azure-SSIS Integration Runtime (IR) for SSIS packages with tools like Azure Data Factory.

### Other options

Some other interesting options include using technologies like Spark or Azure Data Factory to load data into Azure SQL Database or Azure SQL Managed Instance. Not directly related to "loading", but it is possible to create a database leveraging an existing database for a copy or doing an import of a bacpac file. In Azure SQL Managed Instance, the T-SQL commands to restore a database natively from a URL is possible.  

## Considerations for loading data

The biggest difference between loading data on-premises and loading data into Azure SQL is that the data you want to load needs to be hosted in Azure as opposed to in files on-premises. These files and file systems on-premises can be stored in Azure Blob storage as an alternative. This strategy will also increase the efficiency at which you can load your files in and set up ETL jobs.

Another thing to keep in mind is that minimal logging is not supported, so you're always running in full recovery mode. Because of full recovery mode and limits around log throughput, you might be affected by log governance as you're loading data. Techniques like using batches and appropriately sizing them become important during a bulk load. You'll see more tips in the following exercise. Loading into a clustered columnstore index may help in avoiding transaction log limits, depending on your scenario.
