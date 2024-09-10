Preparing data for machine learning is a necessary step when you want to build effective models. Azure Databricks can efficiently process and prepare large datasets because of Spark's compute power.

Let's explore how each step in the machine learning workflow related to data can be performed in Azure Databricks.

## Store collected data in Azure storage

When you collect data from various sources, it's best to store your data in a storage solution like Azure Blob Storage or Azure Data Lake.

Storing data in an Azure storage solution instead of directly in Azure Databricks offers better scalability, enhanced security, and integration with other Azure services.

Azure storage solutions provide a robust and flexible environment for managing large datasets, ensuring that your data is readily available for processing and analysis.

To manage access to all data stored in cloud storage, use **Unity Catalog**. Unity Catalog provides a unified governance solution for all data assets, enabling you to manage permissions and access controls across your data estate.

> [!Tip]
> Learn more about how to [connect to cloud object storage using Unity Catalog](/azure/databricks/connect/unity-catalog/?azure-portal=true)

## Explore and prepare your data

After connecting to your data, you want to explore the data through **Exploratory Data Analysis** (**EDA**). Based on your findings, you prepare you data to handle missing data, perform feature engineering, and do any other data transformations that you think benefit the model's performance.

For initial analysis, use Databricks notebooks to explore and understand the data. You can use Spark SQL or PySpark to work with large datasets, summarize the data, check for null values, and understand data distributions.

### Automate feature engineering within Azure Databricks

Automated feature engineering tools and libraries, such as **Featuretools** and **AutoFeat**, are gaining popularity as they streamline the process of generating and selecting features. These tools use algorithms to automatically create features from raw data, evaluate their importance, and select the most relevant ones for modeling. This approach saves time and reduces the reliance on manual feature engineering.

### Automate your data transformations in Azure Databricks

After exploration, you can choose to automate data transformations by setting up pipelines. One way to achieve automation is by setting up **jobs** in Azure Databricks to automate notebooks and scripts. Azure Databricks Jobs allow you to schedule and run your notebooks or JAR files as jobs, enabling you to automate your data processing workflows.

To set up a job in Azure Databricks, follow these steps:

1. **Create a job**: In the Databricks workspace, navigate to the jobs tab and select on `Create job`. Provide a name for your job and specify the notebook or JAR file you want to run.
1. **Configure the job**: Set the parameters for your job, such as the cluster configuration, the schedule for running the job, and any dependencies. You can also specify email notifications for job status updates.
1. **Run and monitor the job**: Once the job is configured, you can run it manually or let it run according to the schedule you set. You can monitor the job's progress and view logs to troubleshoot any issues.

> [!Tip]
> Learn more about how to [create and run Azure Databricks jobs](/azure/databricks/jobs/create-run-jobs?azure-portal=true).

Alternatively, you can use Azure services to create automated data pipelines.

### Automate data integration with Azure Data Factory

**Azure Data Factory** is a tool for building and managing data pipelines. It allows you to create data-driven workflows for orchestrating data movement and transformation.

To create a data pipeline in Azure Data Factory, follow these steps:

1. **Create a Data Factory**: In the Azure portal, create a new Data Factory instance.
1. **Create a pipeline**: In the Data Factory UI, create a new pipeline and add activities to it. Activities can include data movement, data transformation, and control flow operations.
1. **Configure activities**: Set the parameters for each activity, such as the source and destination data stores, the transformation logic, and any dependencies.
1. **Schedule and monitor**: Schedule the pipeline to run at specified intervals and monitor its execution. You can view logs and set up alerts for any issues.

> [!Tip]
> Learn more about [Azure Data Factory](/azure/data-factory/introduction?azure-portal=true).

By automating data transformations and workflows with Azure Databricks Jobs or Azure Data Factory, you ensure consistent data processing, making your machine learning models more efficient and reliable.
