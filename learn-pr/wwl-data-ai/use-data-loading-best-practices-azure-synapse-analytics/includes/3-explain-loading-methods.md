Azure Synapse Analytics has a rich set of tools and methods available to load data into SQL Pools. You can load data from relational or non-relational datastores; structured or semi-structured; on premises systems or other clouds; in batches or streams.

For the purposes of this module, we’ll consider data stored in structured and semi structured formats in Azure Blob Storage or Azure Data Lake Store. Based on the variety of data that you work with, your data loads can include:

## Data loads directly from Azure storage with transact-sql and the copy statement

Within Azure Synapse Studio, you can write Transact-SQL code that runs against any configured SQL Pools within the workspace. Similarly, within the same Transact-SQL script, you can read and digest data from Azure Blob Storage or Azure Data Lake and insert it into a table within the SQL Pool

## Perform data loads using Azure synapse pipeline data flows.

Data flows are a key feature within the Azure Synapse Studio experience. You can access the data flows from the Integrate hub. From within the Develop hub, you’re able to access configured source repositories and run transformations against them to a variety of destinations referred to as sinks.

## Use polybase by defining external tables

Using Transact-SQL, you can use PolyBase to access files that are located directly on Azure Storage as if they were structured tables within your SQL Pool. You define an **external data source** pointing to the location of the file or the folder the files reside in, the external file format, which can be GZip compressed delimited text, ORC, Parquet or JSON, and then the external table with the column attributes that map to the structure from the external files.
> [!div class="mx-imgBorder"]  
> ![Azure Synapse Studio](../media/azure-synapse-studio.png)
