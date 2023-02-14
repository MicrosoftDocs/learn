
[Azure Databricks](/azure/databricks/introduction/) is a fully managed, cloud-based Big Data and Machine Learning platform, which empowers developers to accelerate AI and innovation. Azure Databricks provides data science and engineering teams with a single platform for big data processing and Machine Learning. The Azure Databricks managed Apache Spark platform makes it simple to run large-scale Spark workloads.

### Things to know about Azure Databricks

Azure Databricks is entirely based on Apache Spark, and it's a great tool for users who are already familiar with the open-source cluster-computing framework. As a unified analytics engine, it's designed specifically for big data processing. Data scientists can take advantage of the built-in core API for core languages like SQL, Java, Python, R, and Scala.

Azure Databricks has a Control plane and a Data plane:

- **Control Plane**: Hosts Databricks jobs, notebooks with query results, and the cluster manager. The Control plane also has the web application, hive metastore, and security access control lists (ACLs), and user sessions. These components are managed by Microsoft in collaboration with Azure Databricks and don't reside within your Azure subscription.
- **Data Plane**: Contains all the Azure Databricks runtime clusters that are hosted within the workspace. All data processing and storage exists within the client subscription. No data processing ever takes place within the Microsoft/Databricks-managed subscription.

Azure Databricks offers three environments for developing data intensive applications.

- **Databricks SQL**: Azure Databricks SQL provides an easy-to-use platform for analysts who want to run SQL queries on their data lake. You can create multiple visualization types to explore query results from different perspectives, and build and share dashboards.
- **Databricks Data Science & Engineering**: Azure Databricks Data Science & Engineering is an interactive *workspace* that enables collaboration between data engineers, data scientists, and machine learning engineers. For a big data pipeline, the data (raw or structured) is ingested into Azure through Azure Data Factory in batches, or streamed near real-time by using Apache Kafka, Azure Event Hubs, or Azure IoT Hub. The data lands in a data lake for long term persisted storage within Azure Blob Storage or Azure Data Lake Storage. As part of your analytics workflow, use Azure Databricks to read data from multiple data sources and turn it into breakthrough insights by using Spark.
- **Databricks Machine Learning**: Azure Databricks Machine Learning is an integrated end-to-end machine learning environment. It incorporates managed services for experiment tracking, model training, feature development and management, and feature and model serving.

#### Business scenario

Let's analyze a scenario for Tailwind Traders in the heavy machinery manufacturing division. Tailwind Traders is using Azure cloud services for their big data needs. They're working with both batch data and streaming data. The division employs data engineers, data scientists, and data analysts who collaborate to produce quick insightful reporting for many stakeholders. To fulfill the big data requirements, you plan to recommend Azure Databricks and implement the Data Science and Engineering environment.

Let's review why Azure Databricks can be the right choice to meet these requirements.

- Azure Databricks provides an integrated Analytics *workspace* based on Apache Spark that allows collaboration between different users.
- By using Spark components like Spark SQL and Dataframes, Azure Databricks can handle structured data. It integrates with real-time data ingestion tools like Kafka and Flume for processing streaming data.
- Secure data integration capabilities built on top of Spark enable you to unify your data without centralization. Data scientists can visualize data in a few steps, and use familiar tools like Matplotlib, ggplot, or d3.
- The Azure Databricks runtime abstracts out the infrastructure complexity and the need for specialized expertise to set up and configure your data infrastructure. Users can use existing languages skills for Python, Scala, and R, and explore the data.
- Azure Databricks integrates deeply with Azure databases and stores like Azure Synapse Analytics, Azure Cosmos DB, Azure Data Lake Storage, and Azure Blob Storage. It supports diverse data store platforms, which satisfies the Tailwind Traders big data storage needs.
- Integration with Power BI allows for quick and meaningful insights, which is a requirement for Tailwind Traders.
- Azure Databricks SQL isn't the right choice because it can't handle unstructured data.
- Azure Databricks Machine Learning is also not the right environment choice because machine learning isn't a requirement in this scenario.

### Things to consider when using Azure Databricks

You can use Azure Databricks as a solution for multiple scenarios. Consider how the service can benefit your data integration solution for Tailwind Traders.

- **Consider data science preparation of data**. Create, clone, and edit clusters of complex, unstructured data. Turn the data clusters into specific jobs. Deliver the results to data scientists and data analysts for review.
- **Consider insights in the data**. Implement Azure Databricks to build recommendation engines, churn analysis, and intrusion detection.
- **Consider productivity across data and analytics teams**. Create a collaborative environment and shared workspaces for data engineers, analysts, and scientists. Teams can work together across the data science lifecycle with shared workspaces, which helps to save valuable time and resources.
- **Consider big data workloads**. Exercise Azure Data Lake and the engine to get the best performance and reliability for your big data workloads. Create no-fuss multi-step data pipelines.
- **Consider machine learning programs**. Take advantage of the integrated end-to-end machine learning environment. It incorporates managed services for experiment tracking, model training, feature development and management, and feature and model serving.