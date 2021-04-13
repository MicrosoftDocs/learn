The use cases for Apache Spark and sql integration within Synapse analytics are as following:

* Dealing with different type of analytics
* Scalability 
* Big data computational powers 
* Flexibility in the use of Spark and SQL languages and frameworks

Since Apache Spark is integrated in Synapse Analytics, there is more to that than giving use for the big data analytics framework Apache Spark enables. 
When you deploy a synapse cluster, ADLS Gen2 capacity that can store Spark SQL Tables is provisioned with it. 

If you use Spark SQL Tables, you might know that these tables can be queried from a SQL-server-based T-SQL language without you having to use commands like CREATE EXTERNAL TABLE. Within synapse analytics, these queries integrate natively with data files that are stored in an Apache Parquet format. 

The other thing to take in mind is that beyond the capabilities mentioned above, the Azure Synapse Studio experience gives you an integrated notebook experience. 
Within this notebook experience, you can attach a SQL or Spark pool, and develop and execute, for example,  transformation pipelines using Python, Scala, and native Spark SQL. 

So, let's say you would like to write to a SQL pool after you've performed engineering tasks in spark. 
You can reference the SQL Pool data as a source for joining with Spark Dataframes that can contain data from other files. 
When you decide to use the Azure Synapse Apache Spark to Synapse SQL connector, you're now able to efficiently transfer data between the Spark and SQL Pools. 

The Azure Synapse Apache Spark pool to Synapse SQL connector is a data source implementation for Apache Spark. It uses the Azure Data Lake Storage Gen2 and PolyBase in SQL pools to efficiently transfer data between the Spark cluster and the Synapse SQL instance.