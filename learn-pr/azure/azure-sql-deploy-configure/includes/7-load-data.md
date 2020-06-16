Once a database or instance is deployed, verified, and configured, the next logical step is to bring data in.

## Options, options, options

There are many options available for you when it comes to loading data into Azure SQL. Many of them overlap with what's available on-premises, but there are a few that will be called out in this unit.

### Bulk copy program

Bulk copy program (bcp) is a very common utility for connecting to Azure SQL from on-premises, as well as connecting to Azure SQL from an Azure Virtual Machine. You can then use it to move data into Azure SQL.  

### BULK INSERT

Bulk insert operations are very similar to in SQL Server on-premises, except instead of loading data from a file (or multiple files) on your machine, you load data from Azure Blob storage. The next exercise will walk through an example of how.  

### SSIS packages

In Azure SQL, you can use this to connect with SSIS on-premises. You can host an SSIS DB in Azure SQL Database or Azure SQL Managed Instance. Additionally, you can use the Azure-SSIS Integration Runtime (IR) for SSIS packages.

### Other options

Some other interesting options include using technologies like Spark or Azure Data Factory to load data into Azure SQL Database or Azure SQL Managed Instance. Not directly related to "loading", but it is possible to create a database leveraging an existing database for a copy or doing an import of a bacpac file. In Azure SQL Managed Instance, the T-SQL commands to restore a database natively from a URL is possible.  
