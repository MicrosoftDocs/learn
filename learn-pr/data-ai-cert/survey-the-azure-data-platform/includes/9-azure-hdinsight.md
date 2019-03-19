Azure HDInsight provides technologies for ingesting, processing, and analyzing big data to support batch processing, data warehousing, IoT, and Data Science.

## Key Features

Azure HDInsight is a low-cost cloud solution containing several technologies including Apache Hadoop, Apache Spark, Apache Kafka, Apache HBase, Interactive Query, and Apache Storm.

**Apache Hadoop** includes Apache Hive, Apache HBase, Spark, and Kafka. Hadoop stores data using a file system (HDFS) while Spark stores data in memory, making Spark approximately 100 times faster.

**Apache HBase** is a NoSQL database built upon Hadoop commonly used for search engines and includes automatic failover.

**Apache Storm** is a distributed real-time streamlining analytics solution.

**Apache Kafka** is an open-source platform used to compose data pipelines and to provide message queue functionality which provides publishing/subscribing of real-time data streams.

## Ingesting Data

Data Engineers can use Apache Hive to perform ETL operations on the data that is being ingested. Alternatively, the Hive queries can be orchestrated by Azure Data Factory.

## Processing Data

In Hadoop, Data Engineers use Java and Python to process big data. Mapper consumes input data, analyzes the data and emits tuples for further analysis by Reducer. Reducer performs summary operations creating a smaller combined result set. In Spark, streams are processed using Spark Streaming. Data Engineers can use the 200 pre-loaded Anaconda libraries with Python for machine learning and can use GraphX for graph computations. Developers can remotely submit and monitor jobs from Apache Spark. Apache Storm supports common programming languages like Java, C#, and Python.

## Querying Data

In Hadoop, there are two languages, Pig and HiveQL. In Apache Spark, Data Engineers use Spark SQL.

## Securing Data

Hadoop supports encryption, Secure Shell (SSH), Shared Access Signatures, and Azure Active Directory security.