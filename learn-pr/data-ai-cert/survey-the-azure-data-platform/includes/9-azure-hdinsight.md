Azure HDInsight provides technologies to help you ingest, process, and analyze big data. It supports batch processing, data warehousing, IoT, and data science.

## Key features

HDInsight is a low-cost cloud solution. It includes Apache Hadoop, Spark, Kafka, HBase, Storm, and Interactive Query.

- **Hadoop** includes Apache Hive, HBase, Spark, and Kafka. Hadoop stores data in a file system (HDFS). Spark stores data in memory. This difference in storage makes Spark about 100 times faster.
- **HBase** is a NoSQL database built on Hadoop. It's commonly used for search engines. HBase offers automatic failover.
- **Storm** is a distributed real-time streamlining analytics solution.
- **Kafka** is an open-source platform that's used to compose data pipelines. It offers message queue functionality, which allows users to publish or subscribe to real-time data streams.

## Ingesting data

As a data engineer, use Hive to run ETL operations on the data you're ingesting. Or orchestrate Hive queries in Azure Data Factory.

## Data processing

In Hadoop, use Java and Python to process big data. Mapper consumes and analyzes input data. It then emits tuples that Reducer can analyze. Reducer runs summary operations to create a smaller combined result set. 

Spark processes streams by using Spark Streaming. For machine learning, use the 200 preloaded Anaconda libraries with Python. Use GraphX for graph computations. 

Developers can remotely submit and monitor jobs from Spark. Storm supports common programming languages like Java, C#, and Python.

## Queries

Hadoop supports Pig and HiveQL languages. In Spark, data engineers use Spark SQL.

## Data security

Hadoop supports encryption, Secure Shell (SSH), shared access signatures, and Azure Active Directory security.