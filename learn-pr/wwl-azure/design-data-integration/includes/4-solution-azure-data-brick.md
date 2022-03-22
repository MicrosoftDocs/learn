[Azure Databricks](/azure/databricks/) is a fully managed, cloud-based Big Data and Machine Learning platform, which empowers developers to accelerate AI and innovation. Azure Databricks provides data science and engineering teams with a single platform for Big Data processing and Machine Learning. Azure Databricks’ managed Apache Spark platform makes it simple to run large-scale Spark workloads.

Azure Databricks offers three environments for developing data intensive applications: Databricks SQL, Databricks Data Science & Engineering, and Databricks Machine Learning.

| **Environment**| **Description** |
| - | - |
| **Databricks SQL**| Provides an easy-to-use platform for analysts who want to run SQL queries on their data lake, create multiple visualization types to explore query results from different perspectives, and build and share dashboards. |
| **Databricks Data Science &amp; Engineering**| Provides an interactive workspace that enables collaboration between data engineers, data scientists, and machine learning engineers. For a big data pipeline, the data (raw or structured) is ingested into Azure through Azure Data Factory in batches, or streamed near real-time using Apache Kafka, Event Hub, or IoT Hub. This data lands in a data lake for long term persisted storage, in Azure Blob Storage or Azure Data Lake Storage. As part of your analytics workflow, use Azure Databricks to read data from multiple data sources and turn it into breakthrough insights using Spark. |
| **Databricks Machine Learning**| An integrated end-to-end machine learning environment incorporating managed services for experiment tracking, model training, feature development and management, and feature and model serving. |


 

Let us analyze a situation for Tailwind Traders, a heavy machinery manufacturing organization and arrive at the best Azure Databricks environment that is applicable for them. Tailwind Traders is leveraging Azure cloud services for their big data needs – the data is both batch and streaming data. They have data engineers, data scientists and data analysts who collaborate produce quick insightful reporting for many stakeholders.

In the above scenario, you would choose Databricks Data Science and Engineering environment because:

- It provides an integrated Analytics ‘workspace’ based on Apache Spark that allows collaboration between different users

- Using Spark components like Spark SQL and Dataframes it can handle structured data and integrates with real-time data ingestion tools like Kafka and Flume for processing streaming data

- Secure data integration capabilities built on top of Spark that enable you to unify your data without centralization and Data scientists can visualize data in a few clicks, and use familiar tools like Matplotlib, ggplot, or d3.

- The runtime abstracts out the infrastructure complexity and the need for specialized expertise to set up and configure your data infrastructure so users can use the languages they are skilled in like Python, Scala, R and explore the data

- This also integrates deeply with Azure databases and stores: Synapse Analytics, Cosmos DB, Data Lake Store, and Blob storage for Tailwind Traders big data storage needs

- Integration with Power BI allows for quick and meaningful insights which is a requirement for Tailwind Traders.

- Databricks SQL is not the right choice since it cannot handle unstructured data

- Databricks Machine Learning is also not the right environment choice since machine learning is not their requirement right now.

 

## How Azure Databricks works

Azure Databricks has a Control plane and a Data plane. 

- The Control Plane hosts Databricks jobs, notebooks with query results, and the cluster manager. The Control plan also has the web application, hive metastore, and security access control lists (ACLs) and user sessions. These components are managed by Microsoft in collaboration with Databricks and do not reside within your Azure subscription.

- The Data Plane contains all the Databricks runtime clusters hosted within the workspace. All data processing and storage exists within the client subscription. This means no data processing ever takes place within the Microsoft/Databricks-managed subscription.
 

 

## When to use Azure Databricks

Azure Databricks is entirely based on Apache Spark and as such is a great tool for those already familiar with the open-source cluster-computing framework. As a unified analytics engine, it’s designed specifically for big data processing and data scientists can take advantage of built-in core API for core languages like SQL, Java, Python, R, and Scala.

 

 

You can use Azure Databricks as a solution for the following scenarios.

- **Data science preparation of data** - Create, clone and edit clusters of complex, unstructured data, turn them into specific jobs and deliver them to data scientists and data analysts for review

- **Find relevant insights in the data** - Recommendation engines, churn analysis, and intrusion detection are common scenarios that many organizations solve across multiple industries using Azure Databricks.

- **Improve productivity across data and analytics teams** - Create a collaborative environment and shared workspaces for data engineers, analysts, and scientists to work together across the data science lifecycle with shared workspaces, saving teams precious time and resources.

- **Big data workloads** – Leverage Data Lake and engine to get the best performance and reliability for your big data workloads, and to create no-fuss multi-step data pipelines

- **Machine learning programs** – Leverage integrated end-to-end machine learning environment incorporating managed services for experiment tracking, model training, feature development and management, and feature and model serving