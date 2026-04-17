[Azure Databricks](/azure/databricks/introduction) is a fully managed, cloud-based Big Data and Machine Learning platform, which empowers developers to accelerate AI and innovation. Azure Databricks provides data science and engineering teams with a single platform for big data processing and Machine Learning. The Azure Databricks managed Apache Spark platform makes it simple to run large-scale Spark workloads.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=05b91305-ff35-44e1-a340-2033a5c3679c]

### Things to know about Azure Databricks

Azure Databricks is entirely based on Apache Spark, and it's a great tool for users who are already familiar with the open-source cluster-computing framework. Databricks is designed specifically for big data processing. Data scientists can take advantage of the built-in core API for core languages like SQL, Java, Python, R, and Scala.

Azure Databricks has a Control plane and a Compute plane:

- **Control Plane**: Hosts Databricks jobs, notebooks with query results, and the cluster manager. The Control plane also has the web application, security access control lists (ACLs), and user sessions. Microsoft manages these components in collaboration with Azure Databricks.
  
- **Compute Plane**: Contains all the Azure Databricks runtime clusters that are hosted within the workspace. All data processing and storage exists within the client subscription. 

Azure Databricks offers three environments for developing data intensive applications.

- **Databricks SQL**: Azure Databricks SQL provides an easy-to-use platform for analysts who want to run SQL queries on their data lake. You can create multiple visualization types to explore query results from different perspectives, and build and share dashboards.
  
- **Databricks Data Science & Engineering**: Azure Databricks Data Science & Engineering lets data teams work together in an interactive workspace. Data is brought into Azure through batch or real-time tools like Azure Data Factory, Kafka, Event Hubs, or IoT Hub. Data is stored in Azure Blob Storage or Data Lake Storage. Databricks reads data from these sources and uses Spark to generate insights.
  
- **Databricks Machine Learning**: Azure Databricks Machine Learning is an integrated end-to-end machine learning environment. It incorporates managed services for experiment tracking, model training, feature development and management, and feature and model serving.

#### Business scenario

Let's analyze a scenario for Tailwind Traders in the heavy machinery manufacturing division. Tailwind Traders is using Azure cloud services for their big data needs. They're working with both batch data and streaming data. The division employs data engineers, data scientists, and data analysts who collaborate to produce quick insightful reporting for many stakeholders. To fulfill the big data requirements, you plan to recommend Azure Databricks and implement the Data Science and Engineering environment.

Let's review why Azure Databricks can be the right choice to meet these requirements.

-	Azure Databricks is an analytics workspace built on Apache Spark.

-	Supports collaboration and handles both structured and streaming data.
  
-	Integrates with real-time tools like Kafka and Flume.
  
-	Lets users work with Python, Scala, or R.
  
-	Connects to Azure databases and storage solutions, meeting big data needs.
  
-	Works with Power BI for fast insights.
  
-	Databricks SQL and Machine Learning aren't suitable here, as unstructured data and machine learning aren't required.


### Things to consider when using Azure Databricks

You can use Azure Databricks as a solution for multiple scenarios. Consider how the service can benefit your data integration solution for Tailwind Traders.

- **Consider data science preparation of data**. Create, clone, and edit clusters of complex, unstructured data. Turn the data clusters into specific jobs. Deliver the results to data scientists and data analysts for review.
  
- **Consider insights in the data**. Implement Azure Databricks to build recommendation engines, churn analysis, and intrusion detection.
  
- **Consider productivity across data and analytics teams**. Create a collaborative environment and shared workspaces for data engineers, analysts, and scientists. Teams can work together across the data science lifecycle with shared workspaces, which helps to save valuable time and resources.
  
- **Consider big data workloads**. Use Azure Data Lake and the engine to get the best performance and reliability for your big data workloads. Create no-fuss multi-step data pipelines.
  
- **Consider machine learning programs**. Take advantage of the integrated end-to-end machine learning environment. It incorporates managed services for experiment tracking, model training, feature development and management, and feature and model serving.

> [!Tip]
> Learn more with self-paced training, [Explore Azure Databricks](/training/wwl-databricks/explore-azure-databricks/).
