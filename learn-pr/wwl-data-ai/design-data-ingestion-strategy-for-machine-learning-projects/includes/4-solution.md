To move and transform data, you can use a **data ingestion pipeline**. A data ingestion pipeline is a sequence of tasks that move and transform the data. By creating a pipeline, you can choose to trigger the tasks manually, or schedule the pipeline when you want the tasks to be automated.

## Create a data ingestion pipeline

To create a data ingestion pipeline, you can choose which Azure service to use.

### Azure Synapse Analytics

A commonly used approach to create and run pipelines for data ingestion is using the data integration feature of **Azure Synapse Analytics**, also known as **Azure Synapse Pipelines**. With Azure Synapse Pipelines you can create and schedule data ingestion pipelines through the easy-to-use UI, or by defining the pipeline in JSON format.

When you create an Azure Synapse pipeline, you can easily copy data from one source to a data store by using one of the many standard connectors.

> [!Tip]
> Learn more about the [copy activity in Azure Synapse Analytics, and all supported data stores and formats](https://learn.microsoft.com/azure/data-factory/copy-activity-overview).

To add a data transformation task to your pipeline, you can use a UI tool like **mapping data flow** or use a language like SQL or Python.

Azure Synapse Analytics allows you to choose between different types of compute that can handle large data transformations at scale: serverless SQL pools, dedicated SQL pools, or Spark pools.

> [!Tip]
> Learn more about how to [perform data integration at scale with Azure Synapse Analytics](https://learn.microsoft.com/training/paths/data-integration-scale-azure-data-factory/). 

### Azure Databricks

Whenever you prefer a code-first tool and to use SQL or Python to create your pipelines, you can also use **Azure Databricks**. Azure Databricks allows you to define your pipelines in a notebook, which you can schedule to run. 

Azure Databricks uses Spark clusters, which distribute the compute to transform large amounts of data in less time than when you don't use distributed compute. 

> [!Tip]
> Learn more about [data engineering with Azure Databricks](https://learn.microsoft.com/training/paths/data-engineer-azure-databricks/) and how to [prepare data for machine learning with Azure Databricks](https://learn.microsoft.com/training/modules/prepare-data-for-machine-learning-azure-databricks/)

### Azure Machine Learning

**Azure Machine Learning** provides compute clusters, which automatically scale up and down when needed. You can create a pipeline with the Designer, or by creating a collection of scripts. Though Azure Machine Learning pipelines are commonly used to train machine learning models, you could also use it to extract, transform and store the data in preparation for training a machine learning model. 

Whenever you want to perform all tasks within the same tool, creating and scheduling an Azure Machine Learning pipeline to run with an on-demand compute cluster may best suit your needs. 

However, Azure Synapse Analytics and Azure Databricks offer more scalable compute that allow for transformations to be distributed across compute nodes. Therefore, your data transformations may perform better when you execute them with either Azure Synapse Analytics or Azure Databricks instead of using Azure Machine Learning.


