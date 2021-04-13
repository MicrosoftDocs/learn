Many organizations today work with big data. Because of the huge volume and variety of data, and speed with which this data is being generated, organizations need systems capable of bringing management and control to this data. 

In the past, organizations attempted to get control by using relational databases management systems. But it's the success of open source software, combined with the benefits of hosted  platforms, that have begun to reap success. 

## What is big data?

The term *big data* is used to describe the vast volumes of both structured and unstructured data that organizations are able to collect. The data can be extremely useful for organizations. Specifically, if an organization is able to analyze the data for insights, the organization is better able to make decisions. These decisions can help the organization become more successful. For example, analysis of big data might enable a commercial organization to recognize customer habits; this could lead to increased sales. 

## Azure HDInsight definition

By using Azure HDInsight, you can bring control and management to your big data. Azure HDInsight: 

- Is a fully managed, cloud-based analytics service. 
- Is cloud distribution of Hadoop components.
- Makes it easy, fast, and cost-effective to process huge volumes of data.
- Supports the use open-source frameworks, such as:

   - Hadoop
   - Apache Spark
   - Apache Hive
   - Apache Kafka
   - Apache Storm

   > [!NOTE] 
   > With these frameworks, you can enable a broad range of scenarios such as extract, transform, and load (ETL), data warehousing, machine learning, and IoT. 

Azure HDInsight provides the following benefits to organizations working with big data: 

- **Open**. Enables you to create optimized clusters for a variety of open source frameworks. 
- **Reliable**. Provides an end-to-end service level agreement on all your production workloads.
- **Scalable**. Enables you to scale workloads as required to respond to changes in demand. 

   > [!TIP]
   > By creating clusters on demand, you can reduce your costs, paying only for what you use. 

- **Secure**. Enables you to protect your enterprise data assets through integration with: 

   - Azure Virtual Network
   - Azure encryption technologies
   - Azure Active Directory

- **Compliant**. Meets popular industry and government compliance standards.
- **Monitored**. Integrates with Azure Monitor logs to provide a single interface with which you can monitor all your clusters.


## How Azure HDInsight can help you work with big data

You can use Azure HDInsight for a variety of scenarios in big data processing. Your data can be:

- Historical data. This is data that's already collected and stored.
- Real-time data. This is data that's directly streamed from the source. 

The scenarios for processing this data can be summarized in the following categories:

- Batch processing
- Data warehousing
- Internet of things
- Data science
- Hybrid

Let's examine each of these more closely.

### Batch processing

Organizations use batch processing jobs to prepare big data for further analysis. Typically, this process involves three stages:

1. Reading source data files from heterogeneous data sources
2. Processing the data
3. Writing the data to scalable storage

> [!NOTE]
> This process is often referred to as ETL. 

You can use the transformed data for data warehousing or data science.

> [!TIP]
> A significant requirement for ETL is compute scale-out to help process large data volumes.

### Data warehousing

A data warehouse provides an organization with somewhere to store big data while waiting to perform analysis on that data. Data warehousing enables you to:

- Store your data
- Prepare your data for analysis 
- Provide the prepared data in a structured format that can be queried using analytical tools

In the following diagram, Apache Hadoop on HDInsight is used to gather and store data from a number of sources. Apache Spark and Apache Hive prepare and analyze the data. Finally, the data is modelled for use with BI tools. Power BI is used for data visualization. 

:::image type="content" source="../media/architecture-data-warehouse.png" alt-text="A diagram depicting the preceding scenario.":::

Components in this scenario include: 

- Apache Spark is a parallel processing framework. It supports in-memory processing which helps boost the performance of big-data analytic applications. 
- Apache Hive in HDInsight is a data warehouse system for Apache Hadoop. Hive enables data summarization, querying, and analysis of data. You can use these components to perform  queries at petabyte scales over both structured or unstructured data, in any format. 

> [!TIP]
> Hive queries are written in HiveQL, which is a query language similar to SQL.

### Internet of things

As displayed in the following diagram, you can use HDInsight to process streaming data received in real-time from different kinds of devices and sensors. In this example, stream processing is provided by a number of open source frameworks in HDInsight. These are: 

- Apache Spark
- Apache Kafka
- Apache Storm

Azure gateway services and IoT hubs direct data from various sources to these frameworks for processing. The processed data is then passed to:

- Long term storage
- Real-time apps
- Real-time dashboards

:::image type="content" source="../media/architecture-iot.png" alt-text="A diagram that depicts the scenario described in the preceding text.":::

### Data science

You can use HDInsight to complete common data science tasks such as:

- Data ingestion
- Feature engineering
- Modelling
- Model evaluation

In the following scenario:

1. Data is collected from an on-premises data source by using Azure Data Factory. 
2. The ingested data is then stored in Azure storage (either Azure Blob Storage or a Data Lake Store). 
3. Azure Spark on HDInsight processes the data in readiness for Azure Machine Learning. Data is also visualized using Power BI.

:::image type="content" source="../media/architecture-data-science.png" alt-text="A diagram that displays the scenario described in the preceding text description.":::

### Hybrid

For organizations with on-premises big data infrastructure, you can use HDInsight to extend into Azure. This enables you to get the benefits of the advanced analytics capabilities of the Azure cloud. In the following scenario:

- The on-premises big data infrastructure consists of metadata stores and a Hadoop or Spark distribution on local VMs. 
- An Azure ExpressRoute circuit connects the on-premises corporate network environment to Azure virtual networks. 
- WANdisco LiveData Migrator for Azure replicates the data received from on-premises to Azure HDInsight. 

:::image type="content" source="../media/architecture-hybrid.png" alt-text="A diagram that represents the text in the preceding scenario.":::