There are different configurations of the HDInsight service that can be used for different analytical scenarios. In fact, HDInsight contains so many OSS analytics technologies, it could be considered a one stop shop for meeting your advanced analytical needs. All the various cluster types that are available can meet the needs of the business scenarios outlined below. With each cluster type, you have complete control over how you manage each of those scenarios within HDInsight.  

Many businesses have similar requirements when it comes to the scenarios for processing and analyzing data to derive business value. These requirements can include:  

## Batch processing  

HDInsight can be used to extract, transform, and load (ETL) or extract, load, and transform (ELT) operations on both structured and unstructured data using either both Hadoop or Spark and the data processing frameworks including Hive and Sqoop.   
 
## Data warehousing  

Traditionally done by on-premises relational databases such as SQL Server, and more recently with Azure SQL Data Warehouse over structured data at petabyte scale. HDInsight enables interactive queries at petabyte scale over structured or unstructured data in many formats. This capability can work well if you manage your data operations and reporting requirements using HDInsight Hadoop with Hive.  

## Streaming data  

Streaming data can be ingested from a variety of sources using HDInsight via an Event Hub or IoT Hub using Spark Streaming.   

## Data science  

Microsoft Machine Learning Server is available as a deployment option when you create HDInsight clusters in Azure. This capability provides data scientists, statisticians, and R programmers with on-demand access to scalable, distributed methods of analytics on HDInsight.  

## Hybrid  

Some organizations already have on-premises big data infrastructures. You can extend the capability to the cloud using HDInsight. 

The key decision point for selecting the correct HDInsight cluster configuration option, is based on the workload that the HDInsight cluster will service. Should your organization work with multiple workloads, it is not uncommon to switch to different HDInsight configurations to match the workload that needs processing.


|**Workload Type**|**Cluster Type**|
|-|-| 
|Batch movement of data|Apache Hadoop| 
|Data Science – Batch and Streaming|Apache Spark|
|Transactional workloads|HBase|
|Ad hoc Analytics/Data warehousing|Apache Interactive Query|
|Streaming analysis|Apache Kafka|

> [!IMPORTANT] 
> HDInsight clusters are available in various types, each for a single workload or technology. There is no supported method to create a cluster that combines multiple types, such as Hadoop and HBase on one cluster. If your solution requires technologies that are spread across multiple HDInsight cluster types, an Azure virtual network can connect the different required cluster types. 