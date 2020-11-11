Connectors are Azure Data Factory objects that enable your Linked Services and Datasets to connect to a wide variety of data sources and sinks. These can include connections to Azure resources and third-party connectors such as Amazon S3 or Google cloud. There are nearly 100 connectors that are available, and they work with the Copy, Data Flow, Look up, Get Metadata, and Delete activities that can be found within Azure Data Factory.

The file formats that are supported include:
-	Avro format
-	Binary format
-	Delimited text format
-	JSON format
-	ORC format
-	Parquet format

There are too many data stores to list, but the following table lists the categories of data stores and two examples of the types of connectors that exist

| Category | Data Store example|
| - | - |
| Azure | Azure Data Lake Store, Azure Synapse Analytics |
| Databases | Netezza, Greenplum |
| NoSQL stores | Cassandra, MongoDB |
| File | FTP, Google Cloud Storage |
| Generic protocols | REST, ODBC | 
| Services & Apps | Dynamics, SalesForce |

The list of connectors is constantly evolving. You can keep upto date with the latest list, and the activity support by looking at the [connectors overview page]( https://docs.microsoft.com/azure/data-factory/connector-overview)
