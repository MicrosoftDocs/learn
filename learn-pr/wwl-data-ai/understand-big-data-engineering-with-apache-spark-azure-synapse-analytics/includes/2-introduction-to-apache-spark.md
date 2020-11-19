*What is Apache Spark?*

The history of Spark started by its development by M. Zaharia in an AMPLab at UC Berkeley in 2009. 
It became an open-source project in 2010. 
Came 2013, the Spark project was donated to the Apache Software Foundation and became known under the license Apache 2.0. 
The same person that started the Spark project (M. Zaharia), founded the company Databricks, in order to get people to use Spark on a large scale. 

So the question lies now in what Spark really does and what it exactly is. 
Apache Spark is an open-source distributed general-purpose cluster-computing framework. Spark provides an interface for programming entire clusters with implicit data parallelism and fault tolerance.

First of all Spark is an in-memory processing engine. Which means that a Spark job is able to load and cache data into memory, where it can be queried repeatedly. Spark is also seen as a parallel data processing framework, which allows you development of fast data engineering processing pipelines, where batch as well as streaming and interactive analysis can be combined.
It can achieve parallelization by the abstraction layer or architectural foundation of Spark, which is something called RDD (Resilient Distributed Dataset). 

RDD is the immutable distribution of objects, where data in RDD is distributed to different nodes within a spark cluster, that achieves parallelization. It is a read-only multiset of data that is maintained in a fault tolerant way.
It is resilient because it can be recomputed from history and it's immutable because it can't be modified and it's distributed because it distributes across nodes in a cluster. 
The data in the RDD is partitioned and each partition is fed to different nodes across the cluster. 
By doing so, the operations you perform on the RDD are in parallel. 

By releasing the DataFrame API and Dataset API, it created an extra abstraction layer on top of the RDD, which encouraged the use of the Dataset API versus the RDD API (since the RDD technology is still the underlying system of the Dataset API).
The reason why SPark and the RDD were developed, was in response to limitations in MapReduce cluster where particular linear dataflow structures are enforced. 
MapReduce related programs read data from disk, map a certain type of function across the data, reduce the result of that map, and store the reduced results on disk. Spark's RDD function


There are two ways you can create an RDD. 
* Loading an external dataset
* By distributing a collection of objects

SPark integrated into Scala programming language for manipulations of distributed datasets such as local collections. 
Spark can be deployed in a traditional on-premises data center as well as in the cloud.

Apache spark does require a cluster manager as well as a distributed storage system. 
Spark can support a native spark cluster, which can be launched manually or using scripts with install packages. 
You can also run these on single machines in case you need to test. 
When it comes to distributed storage spark has different interfaces it can interact with such as HDFS, ADLS Gen 2, Cassandra and many more.
If you're running in a pseudo-distributed local mode, spark can support that to be only for dev/test purposes. 
SPark would then run on a single  machine too. 

There are different concepts used in the spark world. 
Below are some concepts often used:

*Spark Core*

The foundation of the earlier mentioned open-source project is Spark Core. 
Spark Core provides the distributed task dispatching, scheduling, and I/O functionalities through an API (application programming interface) for Java, Python, Scala, .NET, and R, which are based on the RDD abstraction. 

The interfaces as mentioned above are mirrors of a functional/higher-order model of programming where a 'driver' program invokes parallel operations such as map, filter, or reduce on the RDD by passing a function to spark which then schedules the function's execution in parallel on the cluster. 
Then, if you, for example,  do a join, it will take the RDD as input and produce new RDDs. 

RDDs are immutable and their operations are lazy; fault-tolerance is achieved by keeping track of the "lineage" of each RDD (the sequence of operations that produced it) so that it can be reconstructed if there would be data loss. RDDs can contain any type of Python, .NET, Java, or Scala objects.

Besides the RDD-oriented functional style of programming, Spark provides two restricted forms of shared variables: broadcast variables reference read-only data that needs to be available on all nodes, while accumulators can be used to program reductions in an imperative style.

*Spark SQL*
Spark SQL is an abstraction layer on top of Spark Core, where the introduction of data abstraction came in to play. 
This is known as DataFrames. 
These proved supports for structured and semi-structured data. 
Spark SQL is a domain-specific language in order to manipulate the DataFrames in Scala, Java, Python, or .NET. 
Spark SQL also proved SQL Language support. 


*Spark Streaming*
Just like Spark SQL, SPark streaming is also using the Spark Core concept, which allows fast streams for analytics. 
The way it can operate in this manner is that it ingests data in tiny mini-batches and performs RDD transformations on the minibatches. 
The way Spark Streaming is set up, enables you to follow the same code that you would write for batch analytics, therefore, eases the implementation of a Lambda architecture. The downside of this convenience is that it could come with latency penalties that are equal to mini-batch durations. 
In case you'd like to provide a streaming data engine that processes events by events, you can use spark to consume from engines that do that such as Kafka, Twitter, ZeroMQ, and others. 
The Datasets api within Spark called Structured Streaming, which has a higher-level interface, is also supportive of streaming. 


*MLib*
SPark MLib is also built on top of Spark Core engine that enables distributed machine learning. 
The reason why it can process this fast, is due to the distributed in-memory based Spark architecture, which is beneficial compared to disk-based implementations. 

 Many common machine learning and statistical algorithms have been implemented and are shipped with MLlib, which simplifies large-scale machine learning pipelines, such as correlations, Decision Trees, Linear Regressions, and many others. 


*GraphX is a framework for distributed graph-processing on top of Apche SPark. 
It's based on RDDs and therefore unsuitable for graphs that need to be updated or are used in a transactional way like graph databases. 
There are 2 separate APIs for the implementation of parallel algorithms for graph processing:
* Pregel abstraction
* MapReduce- Style API

GraphX can be viewed as being the Spark in-memory version of Apache Giraph, which utilized Hadoop disk-based MapReduce.[29]

Knowing now the different concepts of spark it is imperative to understand how this fits in with the different Data services on Azure. 
The Apache Spark version in its OSS form is currently 3.0.1, which was released in September 2020. 

Below is a table where "the when to use what" is outlined:

| | Apache Spark| HDInsight | Azure Databricks| Synapse Spark |
|--|--|--|--|--|
|What | Is an Open Source memory optimized system for managing big data workloads | Microsoft implementation of Open Source Spark  managed within the realms of Azure | AA managed Spark as a Service solution | Embedded Spark capability within Azure Synapse Analytics|
|When | When you want to benefits of spark for big data processing and/or data science work without the Service Level Agreements of a provider | When you want to benefits of OSS spark with the Service Level Agreement of a provide | Provides end to end data engineering and data science solution and management platform |Enables organizations without existing Spark implementations to fire up a Spark cluster to meet data engineering needs without the overheads of the other Spark platforms listed|
|Who |Open Source Professionals | Open Source Professionals wanting SLA's and Microsoft Data Platform experts | Data Engineers and Data Scientists working on big data projects every day | Data Engineers, Data Scientists, Data Platform experts and Data Analysts
|Why |To overcome the limitations of SMP systems imposed on big data workloads| To take advantage of the OSS Big Data Analytics platform with SLA's in place to ensure business continuity | It provides the ability to create and manage an end to end big data/data science project using one platform |It provides the ability to scale efficiently with spark clusters within a one stop shop  DataWarehousing platform of Synapse.| 





