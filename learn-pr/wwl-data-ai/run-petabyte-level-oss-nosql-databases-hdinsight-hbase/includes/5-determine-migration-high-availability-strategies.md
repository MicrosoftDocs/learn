A frequent challenge that customers face is migrating HBase clusters from on-premises or between versions during cluster upgrades. HDInsight HBase offers the below options to migrate, upgrade, and protect against data loss.  

## Copy the hbase folder 

The strategy of copying the /hbase folder is typically used for periodic backups or migrations. HDInsight HBase stores all its data and metadata files that have been flushed to disk under /hbase folder . 

> [!NOTE] 
> This process does not offer the real time replication between clusters and neither does not offer granularity of migrating specific tables.

Run the below steps in sequence to back up/migrate a HDInsight cluster HDInsight /hbase is stored at the below location wasbs://<containername>@<accountname>.blob.core.windows.net/hbase

1. Figure out the path where the /hbase folder is located in the source cluster
1. Stop all writes into the source cluster and force a flush to disk to ensure nothing is in memory.  
1. Copy the data in /hbase  to the target Azure Storage destination using AzCopy for Blob Storage or AdlCopy for Data Lake Storage.
1. If this for a DR scenario the data can be stored in a different region periodically for future use in the eventuality of a disaster.  
1. If this a for a HBase migration the data can be copied to the /hbase folder freshly created HDInsight HBase cluster. 

More information on the HBase hbase folder copy process can be found in the [HDInsight hbase folder Copy documentation](https://docs.microsoft.com/azure/hdinsight/hbase/apache-hbase-backup-replication#snapshots). 

## Export and Import

Export and Import offers better control of back up process and you can choose to back up specific tables instead of the entire folder. This process uses the Export utility of the HBase cluster to export selected tables to the local storage that is attached to the cluster. Post export the tables that can then be imported from the target cluster. More information on working with Export and Import can be found in the [HDInsight HBase Export and Import documentation](https://docs.microsoft.com/azure/hdinsight/hbase/apache-hbase-backup-replication#export-then-import).


## Copy Tables

Copy tables are efficient copy mechanism and enables fine grained control over full or partial table copy process and uses the HBase read and write paths to copy part or all of the table row by row from source to destination. The source and destination clusters can be the same or different clusters. More information on working with Copy Tables can be found in [HDInsight HBase Copy Tables documentation](https://docs.microsoft.com/azure/hdinsight/hbase/apache-hbase-backup-replication#copy-tables). 


## Snapshots

Snapshots can enable point in time backups to enable table rollback requirements. A snapshot is not a copy of the actual table data but is metadata information that can help admins to go back to a previous state of the tables. Snapshots operate at an HDFS level and do not involve Master and Region servers for optimizing cluster resources. More information on working with Snapshots can be found in [HDInsight HBase Snapshots documentation](https://docs.microsoft.com/azure/hdinsight/hbase/apache-hbase-backup-replication#snapshots).

## Replication 

HBase replication feature can be used to ensure high availability and business continuity during a disaster. Data is copied data between clusters in an asynchronous manner and replications can work within regions and between Azure regions ensuring global HADR models. More information on working with HBase Replication can be found in [HDInsight HBase Replication documentation](https://docs.microsoft.com/azure/hdinsight/hbase/apache-hbase-backup-replication#replication). 

