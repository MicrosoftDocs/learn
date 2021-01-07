Azure Synapse Analytics is an integrated analytics platform, which combines data warehousing, big data analytics, data integration, and visualization into a single environment. Azure Synapse Analytics empowers users of all abilities to gain access and quick insights across all of their data, enabling a whole new level of performance and scale.

Gartner defines a range of analytical types that Azure Synapse Analytics can support including:

## Descriptive analytics

Descriptive analytics answers the question “What is happening in my business?” The data to answer this question is typically answered through the creation of a data warehouse. Azure Synapse Analytics uses the dedicated SQL Pool capability that enables you to create a persisted data warehouse to perform this type of analysis. You can also make use of SQL Serverless to prepare data from files to create a data warehouse interactively to answer the question too.

## Diagnostic analytics

Diagnostic analytics deals with answering the question “Why is it happening?” This type of analytics may involve exploring information that already exists in a data warehouse, but typically involves a wider search of your data estate to find more data to support this type of analysis. 

You can use the same SQL serverless capability within Azure Synapse Analytics that enables you to interactively explore data within a data lake. This can quickly enable a user to search for other data that may help them to understand “Why is it happening?”

![Type of analytics](../media/types-of-analytics.png)

## Predictive analytics 

Azure Synapse Analytics also enables you to answer the question “What is likely to happen in the future based on previous trends and patterns?” by using its integrated Apache Spark engine. This can also be used with other services such as Azure Machine Learning Services, or Azure Databricks.

## Prescriptive analytics

This type of analytics looks at executing actions based on real-time or near real-time analysis of data, using predictive analytics. Azure Synapse Analytics provides this capability through both Apache Spark, Azure Synapse Link, and by integrating streaming technologies such as Azure Stream Analytics.

Azure Synapse Analytics gives the users of the service the freedom to query data on their own terms, using either serverless or dedicated resources at scale. Azure Synapse Analytics brings these two worlds together with a unified data integration experience to ingest, prepare, manage, and serve data using Azure Synapse Pipelines. In addition, you can visualize the data in the form of dashboards and reports for immediate analysis using Power BI, which is integrated into the service too.


These types of analytics are typically implemented in three common types of solution workloads as follows:

## Modern Data Warehouse workloads: 

A Modern Data Warehouse is a centralized data store that provides analytics and decision support services across the whole enterprise using structured, unstructured, or streaming data sources. Data flows into the warehouse from multiple transactional systems, relational databases, and other data sources on a periodic basis. The stored data is used for historical and trend analysis reporting. The data warehouse acts as a central repository for many subject areas and contains the "single source of truth."

SQL Analytics stores data in relational tables with columnar storage. This format significantly reduces the data storage costs, and improves query performance. Once data is stored, you can run analytics at massive scale. Compared to traditional database systems, analysis queries finish in seconds instead of minutes, or hours instead of days. A data warehouse is useful to reduce stress on production systems and to reorganize, index, or filter multiple data sources into a single storage area. To accomplish this goal, deliberate thought and design needs to be put into how you organize and structure the data. It's not a dumping ground for tables from various sources without any design put into it.

## Advanced Analytical Workloads

You can perform advanced analytics in the form of predictive or preemptive analytics using Azure Synapse Analytics. Using the tight integration with Spark, and the hybrid data integration engine with Data Integration. In a cloud data solution, data is ingested into big data stores from various sources. Once in a big data store, Hadoop, Spark, and machine learning algorithms prepare and train the data. When the data is ready for complex analysis, SQL Analytics uses PolyBase to query the big data stores.

PolyBase uses standard T-SQL queries to bring the data into SQL Analytics tables. As a result, the worlds of the Modern Data Warehouse and the Advanced Analytical Workloads are brought together.

## Real-time analytics

Real-time analytics enables you to capture data continuously from devices or applications and to process it in near real time. This enables you to you get live insights and can be set up with ease from a range of devices.
