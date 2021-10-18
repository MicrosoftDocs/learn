Tailwind Traders, a fictitious home improvement retailer is experiencing explosive growth. Apart from cloud migration for their structured, semi-structured and unstructured data, they want to use Machine Learning and AI tools to get actionable insights from their data.

Initial analysis shows that the data needs to be cleaned, modeled, and visualized before data science can be applied. They also would like to interface with all of their existing on-premises apps, cloud services subscriptions through a central interface.

What will you recommend as a solution for this scenario? Let us delve into the functionalities of Azure Synapse Analytics to find out if it fits this requirement for data analysis.

 

**Describe Azure Synapse Analytics solution**

Azure Synapse Analytics is an integrated analytics platform that brings together data integration, enterprise data warehousing, big data analytics and visualization into a single service. Azure Synapse Analytics is an evolution of Azure SQL Data Warehouse. 

Azure Synapse brings together **SQL** technologies for enterprise data warehousing, **Spark** technologies used for big data, **Pipelines** for data integration and ETL/ELT and a tight integration with other Azure services such as **Power BI, CosmosDB, and AzureML**.

In the following image, we can see the integrated end-to-end environment and how Azure Synapse Analytics provides support for Analytics workloads. You can see that through Synapse Analytics, Azure provides a unified experience to ingest, explore, prepare, manage, and serve data for immediate BI and machine learning needs.

:::image type="content" source="../media/modern-data-warehouses-process-with-synapse.png" alt-text="Diagram of modern Data warehouse process with Synapse.":::

 

**Evaluate components of Azure Synapse**

Azure Synapse Analytics can work by acting as the one stop shop to meet all of your analytical needs in an integrated environment. It does this by providing the following capabilities.

- **Dedicated SQL pools or serverless SQL pools**

	- Azure Synapse SQL is a distributed query system that enables you to implement data warehousing and data virtualization scenarios using standard T-SQL.

	- Synapse SQL offers both serverless and dedicated resource models to work with both descriptive and diagnostic analytical scenarios.

	- Read more about [Azure Synapse SQL architecture](/azure/synapse-analytics/sql/overview-architecture)

- **Apache Spark pool**

	- You can develop big data engineering and machine learning solutions using Apache Spark for Azure Synapse. 

	- For machine learning workloads, you can use SparkML algorithms and AzureML integration for Apache Spark 2.4 with built-in support for Linux Foundation Delta Lake.

	- It has full support for Scala, Python, SparkSQL, and C#.

- **Azure Synapse Pipelines**

	- Azure Synapse Pipelines leverages the capabilities of Azure Data Factory and is the cloud-based ETL and data integration service that allows you to create data-driven workflows for orchestrating data movement and transforming data at scale.

	- Using Azure Synapse Pipelines, you can ingest data from disparate data stores.

	- You can build complex ETL processes that transform data visually with data flows or by using compute services such as Azure Databricks.

- **Azure Synapse Link**

	- Azure Synapse Analytics enables you to reach out to operational data using Azure Synapse Link, and is achieved without impacting the performance of the transactional data store.

	- Typically used to perform operational analytics with near real-time hybrid transactional and analytical processing.

	- Read more about [Azure Synapse Link for Azure Cosmos DB](/azure/cosmos-db/synapse-link)

>[!Tip]
> Read about differences between Dedicated and Serverless SQL Pools with regards to security, storage options, and data formats and query language here - [Transact-SQL features supported in Azure Synapse SQL](/azure/synapse-analytics/sql/overview-features)

 

**What kind of analytics can you do with Azure Synapse Analytics?**

Following table shows the range of analytical types that Azure Synapse Analytics supports:

| **Analytics type**| **Description** |
| - | - |
| Descriptive analytics - "What is happening?"| Azure Synapse Analytics leverages the dedicated SQL pool capability that enables you to create a persisted data warehouse to perform this type of analysis. You can also make use of the serverless SQL pool to prepare data from files stored in a data lake to create a data warehouse interactively. |
| Diagnostic analytics - "Why is it happening?"| You can use the serverless SQL pool capability within Azure Synapse Analytics that enables you to interactively explore data within a data lake. Serverless SQL pools can quickly enable a user to search for additional data that may help them to understand why questions. |
| Predictive analytics - "What is likely to happen?"| Azure Synapse Analytics uses its integrated Apache Spark engine and Azure Synapse Spark pools for predictive analytics with other services such as Azure Machine Learning Services, or Azure Databricks. |
| Prescriptive analytics - "What needs to be done?"| This type of analytics looks at executing actions based on real-time or near real-time analysis of data, using predictive analytics. Azure Synapse Analytics provides this capability through both Apache Spark, Azure Synapse Link, and by integrating streaming technologies such as Azure Stream Analytics. |



**When to consider Azure Synapse Analytics?**

Following are some common enterprise data use-cases where Azure Synapse Analytics can be effectively leveraged.

| **Use case**| **Azure Synapse Analytics consideration** |
| - | - |
| Modern data warehousing| Azure Synapse Analytics provides the ability to integrate all data, including big data, to reason over data for analytics and reporting purposes from a descriptive analytics perspective, independent of its location or structure. |
| Advanced analytics| Enables organizations to perform predictive analytics using the native features of Azure Synapse Analytics, and integrating with other technologies such as Azure Databricks. |
| Data exploration and discovery| The serverless SQL pool functionality provided by Azure Synapse Analytics enables data analysts, data engineers and data scientist alike to explore the data within your data estate. This capability supports data discovery, diagnostic analytics, and exploratory data analysis. |
| Real time analytics| Azure Synapse Analytics can capture, store and analyze data in real-time or near-real time with features such as Azure Synapse Link, or through the integration of services such as Azure Stream Analytics and Azure Data Explorer. |
| Data integration| Azure Synapse Pipelines enables you to ingest, prepare, model and serve the data to be used by downstream systems. This can be used by components of Azure Synapse Analytics exclusively. It can also interact with existing Azure services that you may already have in place for your existing analytical solutions. |
| Integrated analytics| Azure Synapse Analytics provides integrated analytics landscape into one service. That way you can spend more time working with the data to bring business benefit, than spending much of your time provisioning and maintaining multiple systems to achieve the same outcomes. |
| Machine Learning| Azure Synapse Analytics can be effectively used in Machine Learning solutions as it has built-in support for AzureML. |



In the Tailwind Traders scenario above, we can leverage components of Azure Synapse Analytics such as Azure Synapse link to aggregate operational data, use dedicated SQL pools to implement data warehousing and leverage Apache spark pools for Big Data and Machine learning requirements.
