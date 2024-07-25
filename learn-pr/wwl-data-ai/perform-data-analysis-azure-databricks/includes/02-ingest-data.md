# Ingest data with Azure Databricks
Azure Databricks is a powerful cloud-based platform for data analytics, designed to help organizations process large volumes of data efficiently. It combines the best of Databricks and Azure to provide an integrated environment for streaming analytics, machine learning, and big data processing. Let us understand how to ingest data into Azure Databricks:

## Set Up Azure Databricks Workspace
- First, you need an Azure subscription. Once you have that, you can create an Azure Databricks workspace through the Azure portal.

## Create a Databricks Cluster
- After setting up your workspace, you need to create a cluster. This is where your data processing jobs will run. You can configure the cluster with the required performance settings based on your workload.

![Azure Databricks Cluster](../media/08-azure-databricks-cluster.png)

## Data Ingestion Methods
There are multiple ways to ingest data into Azure Databricks:
- **Using Data Factory:** Azure Data Factory can be used for data integration. You can create data pipelines that ingest data into Azure Databricks from various data sources.
- **Event Hubs and IoT Hubs:** For real-time data ingestion, you can use Azure Event Hubs or IoT Hubs to stream data directly into Databricks.
- **Blob Storage and Data Lake:** You can ingest data from Azure Blob Storage or Azure Data Lake using the DBFS (Databricks File System) or directly via Spark APIs.
- **Mount Points:** Set up mount points in Databricks to seamlessly access data stored in Blob Storage or Data Lake as if they were on a local file system.

## Import and Use Data in Notebooks
- With your data ingested, you can start using Azure Databricks notebooks to perform analysis. You can use PySpark, Scala, R, or SQL to manipulate and visualize the data.
- Load your data into DataFrames and perform transformations or analytics as required.

![Azure Databricks Notebooks](../media/09-azure-databricks-notebooks.png)