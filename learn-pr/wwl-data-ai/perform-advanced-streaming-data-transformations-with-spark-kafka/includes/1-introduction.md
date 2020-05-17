By using Azure HDInsight with Apache Kafka and Apache Spark, you can create real-time streaming data analytics pipelines and applications on the cloud.

Apache Kafka is a distributed messaging system that takes incoming streaming data from multiple systems and makes it available to other applications in real-time. Apache Kafka works by creating a queue of ordered data, then replicating the data across multiple machines so that there is no single point of failure, and making it available to what are referred to as publishers or consumers. Publishers are the clients that create the messages and add them to the Kafka queue, and consumers receive the messages based on their subscriptions.

Apache Spark is a parallel processing system that enables you to take data from systems such as Apache Kafka and transform and react to the data. Apache Kafka enables you to harness and save the data, and Apache Spark enables you to modify and process the data. When used together, Spark can ingest small batches or continuous streams of data from Kafka, and process it real time using what’s called structured streaming. When companies implement structured streaming they can use a single architecture to process batch data, real-time streaming data, or a combination of the two, which enables companies to up level their applications as they move from batch processing to include real-time processing, without having to learn, or implement different frameworks.

By using Apache Kafka and Apache Spark on Azure HDInsight, you can create this architecture in a matter of minutes, and are able to benefit from the scalability and high-availability of an online cloud provider. This also enables companies that have created on-premises Kafka and Spark applications to migrate these workloads to cloud more easily.

With your job as a Data Engineer in the banking industry, you need to be able to start process incoming streaming and batch data with very low latency, and you believe Apache Spark and Apache Kafka may be the right tools for the job.

## Learning objectives

At the end of this module, you will:

- Use HDInsight
- Stream data with Apache Kafka
- Describe spark structured streaming
- Create a Kafka Spark architecture
- Provision HDInsight to perform data transformations
- Creat a Kafka producer
- Stream Kafka data to a Jupyter Notebook 
- Replicate data to a secondary cluster

