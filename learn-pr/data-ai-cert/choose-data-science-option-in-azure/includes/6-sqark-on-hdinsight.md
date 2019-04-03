ApacheSpark is an open-source Big Data platform that uses scale-out, i.e. multiple machines work together to process data. Unlike Hadoop, Spark works in-memory as much as possible. This results in much faster processing than Hadoop.

## What is HDInsight?

HDInsight is an Azure Platform as a Service (PaaS)  Apache Haddop offering. It is based on the Hortonworks distribution of Hadoop. When you provision an HDInsight cluster, you specify which type a Hadoop platform you want. For scalable machine learning, we are only concerned with the HDInsight Spark implementation.

Data scientists who are comfortable working with the native Spark interface and want complete custom control of the data science process, should consider HDInsight Spark. For the data science team looking for a user friendly, secure, collaborative, Spark based environment, with everything you need, Azure Databricks may be a better solution.

Spark on HDInsight supports massive scale for data querying, wrangling, and machine learning model training. A cluster has a master server that controls the other servers of the cluster. By working on a problem split among multiple machines, performance is greatly enhanced. For HDInsight to run, it needs Azure Blob storage because it needs a place to store data.

A version of HDInsight Spark is offered that includes R Server as a processing front end. The R Server proprietary model training libraries scale out machine learning over the Spark cluster for Big Data model training. HDInsight integrates with other Azure Services as shown below.

![Screenshot of Spark Framework](../media/6-spark-framework.png)

HDInsight provides several benefits.

- You can quickly spin up big data clusters on demand, scale them up or down based on your usage needs, and pay only for what you use.
- Extract, transform, and load your big data clusters on demand with Hadoop MapReduce and Apache Spark.
- Meet industry and government compliance standards and protect your enterprise data assets using an Azure Virtual Network, encryption, and integration with Azure Active Directory.
- Integrate seamlessly with other Azure services, including Data Factory and Data Lake Storage, for building comprehensive analytics pipelines.
- Use your preferred productivity tools, including Visual Studio, Eclipse, IntelliJ, Jupyter, and Zeppelin. 
- Write code in familiar languages such as Scala, Python, R, JavaScript, and .NET.

