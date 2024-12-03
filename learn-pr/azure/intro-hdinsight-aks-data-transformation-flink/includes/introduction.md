Apache Flink is a powerful framework and distributed processing engine for stateful computations over both unbounded and bounded data streams. Developed and maintained by the Apache Software Foundation and it's known for its low-latency and high-throughput processing capabilities. Apache Flink's processing engine is based on a distributed streaming dataflow architecture, which translates into low latency of data processing. 

Some of the key features that Apache Flink offers include: 
- Operations on bounded and unbounded streams 
- In-memory performance 
- Support for both streaming and batch computations 
- Low latency and high throughput operations 
- Exactly once processing 
- High Availability 
- State and fault tolerance 
- Fully compatible with Hadoop ecosystem 
- Unified SQL APIs for both stream and batch  processing

Apache Flink has three main APIs: 

- DataStream API for bounded or unbounded streams of data
- SQL & Table API
- API for low-level stream processing operations

Apache Flink is widely used in industries such as finance, telecommunications, healthcare, and e-commerce for real-time data processing, streaming analytics and machine learning.  Here are some common use cases for Apache Flink: 

- Stream processing 
- Fraud detection  
- Real-time recommendations  
- IoT data processing 
- Log analysis 
- Anomaly detection 
- Rule-based alerting 
- Business process monitoring 
- Web application (social network) 

## Apache Flink in HDInsight on AKS

Apache Flink clusters in HDInsight on AKS are fully managed service. The main benefits of creating an Apache Flink cluster in HDInsight on AKS are listed, 

|	Feature 	|	Description 		|
|	-	|	-		|
|	Ease of creation 	|	You can create a new Apache Flink cluster in HDInsight on AKS in minutes using the Azure portal, Azure PowerShell, or the SDK. Refer to [Get started with Apache Flink cluster in HDInsight on AKS](/azure/hdinsight-aks/flink/flink-create-cluster-portal). 		|
|	Ease of use 	|	Apache Flink clusters in HDInsight on AKS include portal based configuration management and scaling. Additionally, with job management API, you use the REST API or Azure portal for job management. 		|
|	REST APIs 	|	Apache Flink clusters in HDInsight on AKS include [Job management API](/azure/hdinsight-aks/flink/flink-job-management), a REST API-based Apache Flink job submission method to remotely submit and monitor jobs on Azure portal. 		|
|	Deployment Type 	|	Apache Flink can execute applications in Session mode or Application mode. Currently, HDInsight on AKS supports only Session clusters. You can run multiple Apache Flink jobs on a Session cluster. App mode is on the roadmap for HDInsight on AKS clusters. 		|
|	Support for Metastore 	|	Apache Flink clusters in HDInsight on AKS can support catalogs with Hive Metastore in different open file formats with remote checkpoints to [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction). 		|
|	Support for Azure Storage 	|	Apache Flink clusters in HDInsight AKS can use [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) as File sink. Refer to [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction) for more information. 		|
|	Integration with Azure services 	|	Apache Flink cluster in HDInsight on AKS comes with integration to Kafka along with [Azure Event Hubs](/azure/hdinsight-aks/flink/flink-how-to-setup-event-hub) and [Azure HDInsight on AKS](/azure/hdinsight-aks/flink/process-and-consume-data). You can build streaming applications using the Event Hubs or HDInsight on AKS. 		|
|	Adaptability 	|	HDInsight on AKS allows you to scale the Apache Flink cluster nodes based on schedule with the Autoscale feature. Refer to [Automatically scale Azure HDInsight on AKS clusters](/azure/hdinsight-aks/hdinsight-on-aks-autoscale-clusters). 		|
|	State Backend 	|	HDInsight on AKS uses the [RocksDB](http://rocksdb.org/) as default StateBackend. [RocksDB](http://rocksdb.org/) is an embeddable persistent key-value store for fast storage. 		|
|	Checkpoints 	|	Checkpointing is enabled in HDInsight on AKS clusters by default. Default settings on HDInsight on AKS maintain the last five checkpoints in persistent storage. If your job fails, the job can be restarted from the latest checkpoint. 		|
|	Incremental Checkpoints 	|	[RocksDB](http://rocksdb.org/) supports Incremental Checkpoints. We encourage the use of incremental checkpoints for large state You need to enable this feature manually. Setting a default in your `flink-conf.yaml: state.backend.incremental: true` enables incremental checkpoints, unless the application overrides this setting in the code. This statement is true by default. You can alternatively configure this value directly in the code (overrides the config default) `EmbeddedRocksDBStateBackend` backend = new `EmbeddedRocksDBStateBackend(true);`. 

By default, we preserve the last five checkpoints in the checkpoint dir configured. This value can be changed by changing the configuration on configuration management section `state.checkpoints.num-retained: 5`.

Apache Flink clusters in HDInsight on AKS include the following components. They're available on the clusters by default. 

- [DataStreamAPI](https://nightlies.apache.org/flink/flink-docs-release-1.17/docs/dev/datastream/overview/#what-is-a-datastream) 

- [TableAPI & SQL](https://nightlies.apache.org/flink/flink-docs-release-1.17/docs/dev/table/overview/#table-api--sql)

 For more information, see [Roadmap](/azure/hdinsight-aks/whats-new#roadmap-of-features)
