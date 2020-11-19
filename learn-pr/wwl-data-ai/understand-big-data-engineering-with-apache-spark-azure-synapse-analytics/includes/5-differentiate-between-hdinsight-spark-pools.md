 
HDInsight is Microsoft's implementation of Open Source Spark, managed within the realms of the Azure Cloud. 
If you want the benefits of OSS spark with the Service Level Agreement of a provider, in this case Microsoft, HDInsight would be a good start. 
The audience for HDInsight are usually Open Source Professionals that still want the SLA's as well ass the Microsoft Data Platform experts.
The reason for using HDInsight is to take advantage of the OSS Big Data Analytics platform with SLA's in place to ensure business continuity.

HDInsight makes it easier to create and configure a Spark cluster in Azure. 
Spark clusters in HDInsight are compatible with Azure Blob storage, Azure Data Lake Storage Gen1, or Azure Data Lake Storage Gen2. 
Therefore, it is possible to use HDInsight Spark clusters to process your data stored in Azure. 

[For the components and the versioning information, see Apache Hadoop components and versions in Azure HDInsight](https://docs.microsoft.com/azure/hdinsight/hdinsight-component-versioning)

Apache Spark clusters in HDInsight include the following components that are available on the clusters by default:

* Spark Core: Includes Spark Core, Spark SQL, Spark streaming APIs, GraphX, and MLlib.
* Anaconda
* Apache Livy
* Jupyter notebook
* Apache Zeppelin notebook
* HDInsight Spark clusters an ODBC driver for connectivity from BI tools such as Microsoft Power BI.

In order to understand the components of Spark it is imperative to understand how Spark runs on HDInsight clusters.

Spark applications run as independent sets of processes on a cluster. Coordinated by the SparkContext object in your main program (called the driver program).

The SparkContext can connect to several types of cluster managers, which give resources across applications. These cluster managers include Apache Mesos, Apache Hadoop YARN, or the Spark cluster manager. 

In HDInsight, Spark runs using the YARN cluster manager. 
Once connected, Spark gets executors on the workers nodes in the cluster.
The executors on the worker nodes in a cluster are defined as processes that run computations and store data for an application. 
Then, it sends your application code (defined by JAR or Python files passed to SparkContext) to the executors. 
Once the application code arrives to the executors, the SparkContext sends the tasks to the executors to run.
Tasks are executed within an executor process that runs on the worker nodes, however, each application will get its own executor process. 
The cluster will stay up as long as the application is active and runs all tasks in multiple threads. 

The SparkContext runs the user's main function and executes the all the parallel operations on the worker nodes. 
Next, the SparkContext collects the results of the operations. 
The worker nodes read and write data from and to the Hadoop distributed file system. 
The worker nodes also cache transformed data in-memory as Resilient Distributed Datasets (RDDs).

The SparkContext connects to the Spark primary and is responsible for converting an application to a directed graph (DAG) of individual tasks.



