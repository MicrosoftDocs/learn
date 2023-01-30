

Data engineering in Microsoft Azure is similar to data engineering in other environments, but it also has some unique characteristics that are specific to Azure. Some of the key differences include:

1. **Scale and Performance:** Microsoft Azure provides a scalable and highly available infrastructure for data engineering, which allows data engineers to easily process and store large amounts of data. Azure services such as Azure Data Lake Storage, Azure SQL Database, and Azure Cosmos DB can handle large amounts of data with high performance.

2. **Integration with Azure services:** Microsoft Azure provides a wide range of services that can be easily integrated with data engineering workloads. This includes data integration services such as Azure Data Factory, Azure Data Lake Storage, and Azure Databricks, as well as data visualization and analytics services such as Azure Power BI and Azure Machine Learning.

3. **Data Governance and Security:** Azure provides comprehensive data governance and security features, such as Azure Purview for data discovery and cataloging, Azure Policy for governance and Azure AD for authentication and authorization. These features help to ensure that data is accurate, consistent, and protected.

4. **Big Data and Machine Learning:** Azure provides services like Azure HDInsight and Azure Databricks for big data processing and analytics, and Azure Machine Learning for machine learning and AI. These services can be easily integrated with data engineering workloads to build powerful big data and machine learning pipelines.

5. **Hybrid Capabilities:** Azure provides hybrid capabilities such as Azure Arc, Azure Stack and Azure Data Box that allow data engineering work to be done both on-premises and in the cloud, providing flexibility and the ability to keep sensitive data on-premises

6. **Automation and DevOps:** Azure provides automation and DevOps capabilities such as Azure DevOps, Azure Automation and Azure Monitor that allow data engineers to easily automate, deploy and monitor their data pipelines, making the data engineering process more efficient and reliable.

 ![Hybrid approach when migrating to cloud from on-premises.](../media/3-hybrid-etl-cloud-approach.png)

## Data Governance using Azure Purview

Azure Purview is a powerful data governance solution that can help organizations discover, understand, and govern their data. It provides a single view of data across multiple sources and makes it easy to implement data governance policies, which allows organizations to improve data quality, security, and compliance.

 ![integrating Azure Purview into your data engineering design.](../media/3-data-engineering-and-azure-purview.png)

## High Throughput of real-time data with Azure Event Hubs and Azure Stream Analytics

Azure Event Hubs and Azure Stream Analytics are two Azure services that can be used to process high throughput, real-time data. 

Azure Event Hubs is a fully managed, real-time data ingestion service that can handle millions of events per second. It can be used to collect, store, and process data streams from various sources such as IoT devices, social media, and log files. Event Hubs can be used to handle high throughput data by creating multiple partitions that can be read and written to in parallel. 

Azure Stream Analytics is a real-time data stream processing service that can be used to analyze and process data streams from various sources such as Event Hubs, IoT devices, and Azure Data Lake Storage. Stream Analytics allows data engineers to perform complex data processing and analytics tasks such as filtering, aggregation, and windowing on the data streams in near real-time. It also support SQL-like language for querying data which makes it easy for data engineers to process data streams.

![Ingesting data with Azure Event Hub and Azure Stream Analytics.](../media/3-high-throughput-streaming-ingestion.png)