Apache HBase is an open-source, NoSQL database that is built on Apache Hadoop. HBase provides random access and strong consistency for large amounts of unstructured and semi structured data in a schemaless database organized by column families. HDInsight 3.6 HBase clusters come with Apache HBase 1.1.2 and Apache Phoenix 4.7.0. HDInsight 4.0 HBase clusters come with Apache HBase 2.1.6 and Apache Phoenix 5.

From a user perspective, HBase is similar to a database. Data is stored in the rows and columns of a table, and data within a row is grouped by column family. HBase is a schemaless database in the sense that neither the columns nor the type of data stored in them need to be defined before using them. The open-source code scales linearly to handle petabytes of data on thousands of nodes.

HBase has the following features that make it unique

- Strongly consistent read and writes

- Low latency operations

- Automatic Sharding

- Automatic Region Server failovers

- Hadoop/HDFS/MapReduce integration

- Java Client API

- Supports Thrift and REST for non-java front ends

- Block cache and Bloom Filters


Azure HDInsight HBase with Apache Phoenix brings the following additional benefits

- SQL and No SQL interfaces

- Flexible capacity planning

- Global distribution and replication with Azure networking

- Separation of Compute and Storage

- Tightly integrated with HDInsight Enterprise security features

- HDInsight HBase accelerated writes for ultra-low latency reads and writes

- Apache Phoenix for real time SQL like querying

Using Azure HDInsight with HBase enables you to run NoSQL databases at massive scale. As a Data Engineer for a Contoso, you need to be able to run benchmark tests to understand the performance and scale of HDInsight HBase before you use the platform for mission critical production scenarios.

In this module, you will learn appropriate scenarios to deploy HDInsight HBase clusters, learn about architectural patterns, deploy a cluster for your load testing scenarios and understand read and write throughput and latencies.

By the end of this module, you will be able to determine if HBase is a good fit for your use case, understand best practices for great performance and run a benchmark to test the performance.