There are two possible ways of sharing your data:

*	Snapshot-based share
*	In-place share

##  Snapshot based share

When you set up a snapshot-based sharing, the data will move from your subscription (data provider) to the person or organization’s Azure subscription (data consumer), through an invitation  sent to the recipients for that data share. 

When you have created a dataset to be shared with a third-party, the data consumer will receive an email with the invitations in which they can choose to accept and trigger full snapshots of the dataset that you shared with them. The snapshot based sharing option, is a point in time representation of the data that was shared. 

Once the data consumer has accepted, the data will land in their storage account and can receive regular, incremental updates to the data that you’ve shared with them to make sure they have the latest version of the data. 

The Azure Data platform services that are currently supported are:
-	Azure Synapse Analytics
-	Azure SQL Database
-	Azure Blob Storage
-	Azure Data Lake Storage (Gen1 and Gen2)
-	Azure Data Explorer

The incremental updates of the data that you shared, can be scheduled through a snapshot schedule on an hourly or daily basis. The data consumer has to subscribe to this snapshot schedule. Therefore, if your data changes regularly, and the data consumer needs to have the most recent data, this snapshot-based sharing might be an option. 

In the case of sharing from SQL-based sources, the data consumer can also choose whether they receive data in parquet or csv.

## In-place share

With in-place sharing, data providers can share data where it resides without copying the data. After sharing relationship is established through the invitation flow, a symbolic link is created between the data provider's source data store and the data consumer's target data store. Data consumer can read and query the data in real time using its own data store.
Changes to the source data store are available to the data consumer immediately. In-place sharing is currently in preview for Azure Data Explorer.
