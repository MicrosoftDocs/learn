

Optimizing and speeding up data loads to minimize the impact on the performance of ongoing queries is a key design goal in data warehousing.

Analytical systems are constantly balanced between loading and querying workloads. Some analytical systems have loading requirements that require data to be available in near real-time, others periodically throughout the business day, or at the end of the month. Most systems you'll find have a mixture of these dependants on the data sources being ingested, and type of work being done with the data.

Loading data is essential because of the need to query or analyze the data to gain insights from it. One of the main design goals in loading data is to manage or minimize the impact on analytical workloads while you load the data with the highest throughput possible.

Some of the questions you need to asked when considering data loading include:

-	Where is my data coming from?
-	Is the data set new? or do you receive changes from existing datasets?
-	How often is the data being refreshed, added to or replaced?
-	What formats are the data coming in?
-	Is the data ingestible as-is? or are transformations and cleansing tasks required?
-	Should I transform the data prior to or after loading?
-	How complex or robust does the loading process have to be?
-	Which takes priority, loading or querying/analysis?

By answering these questions, you’ll understand the design goals and considerations to the process of designing appropriate workflows and pipelines, and which tools and methods you’ll need to use. Azure Synapse Analytics has a rich set of tools and methods available to load data into SQL Pools. You can load data from relational or non-relational datastores; structured or semi-structured; on premises systems or other clouds; in batches or streams.

For the purposes of this module, we’ll consider data stored in structured and semi structured formats in Azure Blob Storage or Azure Data Lake Store. Based on the data that you work with, your data loads can include:

## Data loads directly from Azure storage with transact-sql and the copy statement

Within Azure Synapse Studio, you can write Transact-SQL code that runs against any configured SQL Pools within the workspace. Similarly, within the same Transact-SQL script, you can read and digest data from Azure Blob Storage or Azure Data Lake and insert it into a table within the SQL Pool

## Perform data loads using Azure synapse pipeline data flows.

Data flows are a key feature within the Azure Synapse Studio experience. You can access the data flows from the Integrate hub. From within the Develop hub, you’re able to access configured source repositories and run transformations against them to various destinations referred to as sinks.

## Use PolyBase by defining external tables

Using Transact-SQL, you can use PolyBase to access files that are located directly on Azure Storage as if they were structured tables within your SQL Pool. You define an **external data source** pointing to the location of the file or the folder the files reside in, the external file format, which can be GZip compressed delimited text, ORC, Parquet or JSON, and then the external table with the column attributes that map to the structure from the external files.

