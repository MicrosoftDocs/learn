Azure Databricks is an Apache Spark-based analytics platform optimized for the Microsoft Azure cloud services platform. 
It is designed by the founders of Apache Spark. 
Azure Databricks is the integrated Databricks solution for Azure to provide one-click setup, streamlined workflows, and an interactive workspace that enables collaboration between data scientists, data engineers, and business analysts.
Currently Azure Databricks runs on Spark 3.0.

Azure Databricks is a fast, easy, and collaborative Apache Spark-based analytics service. For a big data pipeline, the data (raw or structured) is ingested into Azure through Azure Data Factory in batches, or streamed near real-time using Kafka, Event Hub, or IoT Hub. This data lands in a data lake for long term persisted storage, in Azure Blob Storage or Azure Data Lake Storage. As part of your analytics workflow, use Azure Databricks to read data from multiple data sources such as Azure Blob Storage, Azure Data Lake Storage, Azure Cosmos DB, or Azure SQL Data Warehouse and turn it into breakthrough insights using Spark.

The components of Azure Databricks are as follows:

* Spark SQL and DataFrames: Spark SQL is the Spark module for working with structured data. A DataFrame is a distributed collection of data organized into named columns. It is conceptually equivalent to a table in a relational database or a data frame in R/Python.

* Streaming: Real-time data processing and analysis for analytical and interactive applications. Integrates with HDFS, Flume, and Kafka.

* MLlib: Machine Learning library consisting of common learning algorithms and utilities, including classification, regression, clustering, collaborative filtering, dimensionality reduction, as well as underlying optimization primitives.

* GraphX: Graphs and graph computation for a broad scope of use cases from cognitive analytics to data exploration.

* Spark Core API: Includes support for R, SQL, Python, Scala, and Java.

Apache Spark in Azure Databricks builds on the capabilities of Spark by providing a zero-management cloud platform that includes:

* Fully managed Spark clusters
* An interactive workspace for exploration and visualization
* A platform for powering your favorite Spark-based applications
* Fully managed Apache Spark clusters in the cloud
* Azure Databricks has a secure and reliable production environment in the cloud, managed and supported by Spark experts. You can:

Even though Synapse Analytics and Azure Databricks both have Spark components there are some differences. 
Databricks has a proprietary data processing engine called the Databricks runtime. 
It is build on an optimized version of the open-source version of Apache Spark.
Azure Databricks also supports Spark 3.0 since september and compared to Azure Synapse Analytics it might not have the same capabilities since Synapse Analytics Spark Pool run on Spark. 2.4. 

Within Azure Databricks you also have the possibility to set up a GPU cluster and can differentiate between standard or high-concurrency cluster modes. 
Synapse Spark Pools are Open-source Apache Spark based, which differ from the Databricks runtime in Azure Databricks. 
It does have support for .NET Spark applications that is built in. 

When you look at the notebook environments that are available within Synapse Studio and on the Azure Databricks platform, there are some differences. 
Within Synapse it's based on Nteract Notebooks, in which you can collaborate within notebooks, but one of the collaborators needs to save in order to see changes. There is no automation in the versioning and not yet integration with GIT, which is the case in Azure Databricks. 
In Azure Databricks, the notebook environment is kind of like working together in a word document where you can track and see changes that people made while writing in the same notebook. It also automates the versioning of the notebooks. 

When you look at accessing storage accounts like Azure Data Lake Storage Gen2, there is a different feel between the products. 
In synapse, the underlying storage for the workspace is an ADLS Gen 2 storage. If you, for example, have files in the ADLS Gen 2 storage account, you could go through the Synapse Studio and create a new notebook, which automatically connects without having to mount a data lake like you have to do in Azure Databricks. 

In Synapse Analytics, the delta lake is the open-source version of delta lake whereas in Azure Databricks, Databricks Delta is built on top of the open-source delta lake, which creates a different interaction. 

However, Synapse is the one stop shop, since it has a traditional SQL Engine as well as a Spark engine, which can also be integrated and suitable for different roles within your organization. 
Synapse is a data warehousing solution that also comes with a workspace environment as well as an interface with Synapse Studio from which you can manage, develop, integrate the various aspects. 

When you look at Azure Databricks, it is truly built as a data platform for analytics with a strong focus on Spark, Databricks Delta, and others. However, it is not a one stop shop like Azure Synapse Analytics is considered to be, since it won't come with an integrated SQL Engine for data warehousing solutions. It would still have to be mounted. 

