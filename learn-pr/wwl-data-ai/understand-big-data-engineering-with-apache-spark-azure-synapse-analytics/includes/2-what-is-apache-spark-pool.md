In this section, the goal is to  give you a clear understanding of the differences between Apache Spark and Spark Pools in Azure Synapse Analytics.

**Apache Spark in Azure Synapse Analytics**

A Spark Pool in Azure Synapse Analytics is one of Microsoft's implementation of Apache Spark, version Spark 2.4 for the Azure Cloud. 

Azure Synapse Analytics enables you to have a one-stop shop for your Analytics environment. 
With the addition of Spark Pools in Azure Synapse Analytics, it is now possible to benefit from the features of Apache Spark in the same environment where you can set up your data warehousing solution. 

The spark Pools within Azure Synapse Analytics are compatible with different Azure Storage solutions such as ADLS Gen2 and Blob Storage.
This enables you to store data in Azure while processing this data with Spark pools.
Some of the official Apache Spark documentation relies on using the spark console. 
At this moment, the spark console is not available on Azure Synapse Spark, so therefore it is highly recommended to use the notebook or IntelliJ experiences instead.

**Spark Pools in Azure Synapse Analytics, a fully managed and integrated Spark service**

Benefits of using Spark Pools in Azure Synapse Analytics are listed below:
* Speed and Efficiency: Quick start-up time for nodes, automatic shut-down when instances are not used within 5 min after last job, unless there is a live notebook connection. 
* Ease of creation: Creating a spark pool can be done through the Azure portal, PowerShell, or .NET SDK for Azure Synapse Analytics. 
* Ease of use: Within the Azure Synapse Analytics workspace, you can connect directly to the Spark pool and interact with the integrated notebook experience, or use custom notebooks derived from Nteract. Notebook integration helps you in developing interactive data processing and visualization pipelines. 
* REST APIs: In order to monitor and submit jobs remotely, you can use Apache Livy as Rest API Spark job server. 
* Integration with third-party IDEs: Azure Synapse Analytics provides an IDE for IntelliJ to create and submit applications to the spark pool
* Pre-loaded Anaconda libraries: Over 200 Anaconda libraries pre-installed on the Spark Pool  in Azure Synapse Analytics. 
* Scalability: Possibility for autoscale, such that Pools can be up/down scaled as required by adding or removing nodes. 

Spark Pools in Azure Synapse include the following components that are available on the Spark Pools by default.

- [Spark Core](https://spark.apache.org/docs/2.4.5/). Includes Spark Core, Spark SQL, GraphX, and MLlib.
- [Anaconda](https://docs.continuum.io/anaconda/)
- [Apache Livy](https://github.com/cloudera/hue/tree/master/apps/spark/java#welcome-to-livy-the-rest-spark-server)
- [Nteract notebook](https://nteract.io/)

The supported languages and runtime versions for Apache spark and dependent components in Azure Synapse analytics can be found here:
- [Apache Spark components in Azure Synapse Analytics](https://docs.microsoft.com/azure/synapse-analytics/spark/apache-spark-version-support)

**Spark pool architecture**

![Spark Architecture](../media/spark-architecture.png)

It is imperative to understand the components of Apache Spark, through understanding how Spark runs on Azure Synapse Analytics.
The different spark applications act as independent sets of processes on a pool. 
It is coordinated by the SparkContext object in a main (driver) program. 

![Map Reduce compared to Spark](../media/map-reduce-versus-spark.png)

The SparkContext is able to connect to the cluster manager, which allocates resources across applications. 
The cluster manager is [Apache Hadoop YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html). 

![Key objects and Relations within Spark using YARN](../media/apache-yarn-spark-memory.png)

Once connected, Spark gets the executors on nodes in the pool.
Those processes run computations and store data for your application. 
What follows is that your application code (defined by JAR or Python files passed to SparkContext) will be sent to the executors. 
Finally, the SparkContext object is able to send tasks to the executors to run.

The SparkContext object runs your main function. 
What follows is the execution of the various parallel operations on the nodes. 
Then, the SparkContext object will collect all the results of the operations that were sent to the nodes. 
The nodes are able to read and write data from and to the file system. 
The nodes then caches the transformed data in-memory as Resilient Distributed Datasets (RDDs).

The SparkContext object connects to the Spark pool in Azure Synapse Analytics. 
It is responsible for converting an application to a directed acyclic graph (DAG). 
The graph consists of individual tasks that get executed within an executor process on the nodes. 
Each application gets its own executor processes, which stays up for the duration of the whole application and run tasks in multiple threads.


