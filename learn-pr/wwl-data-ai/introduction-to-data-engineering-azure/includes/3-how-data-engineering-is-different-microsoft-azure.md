
## How is Data Engineering Different in Microsoft Azure
Data engineering in Microsoft Azure is similar to data engineering in other environments, but it also has some unique characteristics that are specific to Azure. Some of the key differences include:

1. **Scale and Performance:** Microsoft Azure provides a scalable and highly available infrastructure for data engineering, which allows data engineers to easily process and store large amounts of data. Azure services such as Azure Data Lake Storage, Azure SQL Database, and Azure Cosmos DB can handle large amounts of data with high performance.

2. **Integration with Azure services:** Microsoft Azure provides a wide range of services that can be easily integrated with data engineering workloads. This includes data integration services such as Azure Data Factory, Azure Data Lake Storage, and Azure Databricks, as well as data visualization and analytics services such as Azure Power BI and Azure Machine Learning.

3. **Data Governance and Security:** Azure provides comprehensive data governance and security features, such as Azure Purview for data discovery and cataloging, Azure Policy for governance and Azure AD for authentication and authorization. These features help to ensure that data is accurate, consistent, and protected.

4. **Big Data and Machine Learning:** Azure provides services like Azure HDInsight and Azure Databricks for big data processing and analytics, and Azure Machine Learning for machine learning and AI. These services can be easily integrated with data engineering workloads to build powerful big data and machine learning pipelines.

5. **Hybrid Capabilities:** Azure provides hybrid capabilities such as Azure Arc, Azure Stack and Azure Data Box that allow data engineering work to be done both on-premises and in the cloud, providing flexibility and the ability to keep sensitive data on-premises

6. **Automation and DevOps:** Azure provides automation and DevOps capabilities such as Azure DevOps, Azure Automation and Azure Monitor that allow data engineers to easily automate, deploy and monitor their data pipelines, making the data engineering process more efficient and reliable.

 ![Hybrid approach when migrating to cloud from on-premises.](../media/3-hybrid-etl-cloud-approach.png)
## Data Governance using Azure Purview
Azure Purview is a data governance solution provided by Microsoft that helps organizations discover, understand, and govern their data. It is used to discover, classify, and understand data across various data sources such as databases, data lakes, and cloud services, and then make that data discoverable and understandable to business users and analysts.

Data Governance in Azure Purview is enabled through several features:

1. **Data Discovery:** Azure Purview automatically discovers and classifies data across various data sources, making it easy to find and understand data. It can discover data across on-premises and cloud sources, including Azure Data Lake Storage, Azure SQL Database, and AWS S3.

2. **Data Catalog:** Azure Purview creates a unified data catalog that allows users to search and discover data across multiple sources. The catalog provides detailed information about data sources, including data lineage, data quality, and data security.

3. **Data Classifications:** Azure Purview allows users to classify data according to predefined or custom classifications, such as sensitive data, personal data, and confidential data. This makes it easy to understand the data and its usage, as well as to implement data governance policies.

4. **Data Lineage:** Azure Purview tracks the flow of data through different systems, providing a clear understanding of the data lineage, which makes it easier to identify the source of data, how it is transformed and where it is used.

5. **Data Governance Policies:** Azure Purview allows users to implement data governance policies, such as data quality and data security policies, to ensure that data is accurate, consistent, and protected.

6. **Data Governance Workflow:** Azure Purview also allows users to create data governance workflows that enable data stewards and data owners to collaborate in the data governance process.

7. **Integration with other Azure services:** Azure Purview also integrates with other Azure services such as Azure Data Factory and Azure Data Catalog, making it easy to implement data governance in existing data pipelines and data platforms.

Azure Purview is a powerful data governance solution that can help organizations discover, understand, and govern their data. It provides a single view of data across multiple sources and makes it easy to implement data governance policies, which allows organizations to improve data quality, security, and compliance.

 ![integrating Azure Purview into your data engineering design.](../media/3-data-engineering-and-azure-purview.png)
## High Throughput of real-time data with Azure Event Hubs and Azure Stream Analytics
Azure Event Hubs and Azure Stream Analytics are two Azure services that can be used to process high throughput, real-time data. 

Azure Event Hubs is a fully managed, real-time data ingestion service that can handle millions of events per second. It can be used to collect, store, and process data streams from various sources such as IoT devices, social media, and log files. Event Hubs can be used to handle high throughput data by creating multiple partitions that can be read and written to in parallel. 

Azure Stream Analytics is a real-time data stream processing service that can be used to analyze and process data streams from various sources such as Event Hubs, IoT devices, and Azure Data Lake Storage. Stream Analytics allows data engineers to perform complex data processing and analytics tasks such as filtering, aggregation, and windowing on the data streams in near real-time. It also support SQL-like language for querying data which makes it easy for data engineers to process data streams.

Together, Azure Event Hubs and Azure Stream Analytics can be used to handle high throughput, real-time data, by allowing data engineers to collect, store, and process data streams in near real-time. Data streams can be collected and stored in Event Hubs and then processed and analyzed in near real-time using Stream Analytics.

This combination enables data engineers to handle high-throughput data in real-time, and provide real-time insights and analytics to the business. Event Hubs allows data engineers to handle a large amount of data in parallel while Stream Analytics allows to process it in near real-time, and this combination allows data engineers to build real-time data processing pipelines that can handle high-throughput data with low latency.

![Ingesting data with Azure Event Hub and Azure Stream Analytics.](../media/3-high-throughput-streaming-ingestion.png)