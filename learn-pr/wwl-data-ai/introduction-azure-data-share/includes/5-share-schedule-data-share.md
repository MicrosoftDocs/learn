Azure Data Share offers two ways to share your data:

*	Snapshot-based sharing
*	In-place sharing

##  Snapshot-based sharing

When you, as a data provider, set up a snapshot-based share, the data moves from your Azure subscription to the data consumer's Azure subscription, through an invitation  sent to the recipients for that data share. 

When you have created a dataset to be shared with a third-party, the data consumer will receive an email with the invitations in which they can choose to accept and trigger full snapshots of the dataset that you shared with them. The snapshot based sharing option, is a point in time representation of the data that was shared. 

Once the data consumer has accepted, the data will land in their storage account and can receive regular, incremental updates to the data that you’ve shared with them to make sure they have the latest version of the data. 

The incremental updates of the data that you shared, can be scheduled through a snapshot schedule on an hourly or daily basis. The data consumer has to subscribe to this snapshot schedule. Therefore, if your data changes regularly, and the data consumer needs to have the most recent data, this snapshot-based sharing might be an option. 

The Azure Data platform services that currently support snapshot-based sharing are:

-	Azure Synapse Analytics
-	Azure SQL Database
-	Azure Blob Storage
-	Azure Data Lake Storage (Gen1 and Gen2)
-	Azure Data Explorer

In the case of sharing from SQL-based sources, the data consumer can also choose whether they receive data in Parquet or CSV.

## In-place sharing

When data providers use in-place sharing, data won't be copied and resides where it's stored in the data providers Azure subscription. 
Once in-place sharing is set up through the invitation flow by the data provider, a symbolic link between a data provider's source data store and the data consumer's target data store is created.
This enables the data consumer to read and query data using its target data store.
Any changes in the data providers source data store, is immediately available to the data consumer to read and query.  

NOTE: In-place sharing is currently in preview for Azure Data Explorer.

Now that you understand the Azure Data Share sharing methods, in the next unit let’s start sharing data with Azure Data Share.