You can use Azure Data Factory to ingest raw data collected from different sources and work with Azure Databricks to restructure it as per your requirements.

## What is Azure Data Factory?

Azure Data Factory (ADF) is a data ingestion and transformation service that allows you to load raw data from over 70 different on premises or cloud sources. The ingested data can be cleaned, transformed, restructured, and loaded back into a data warehouse, from where it's ready to use for several analytical purposes.
Azure Data Factory supports data workflow pipelines, a logical group of task and activities, that allows end-to-end data processing scenarios.

## ADF and Azure Databricks

The integration of Azure Databricks with ADF allows you to add Databricks notebooks within an ADF pipeline to leverage the analytical and data transformation capabilities of Databricks. You can add a notebook within your data workflow to structure and transform raw data loaded into ADF from different sources. Once the data is transformed using Databricks, you can then load it to any data warehouse source.

Data ingestion and transformation using the collective capabilities of ADF and Azure Databricks essentially involves the following steps:

1. **Create Azure storage account** - The fist step is to create an Azure storage account to store your ingested and transformed data.
1. **Create an Azure Data Factory** - Once you have your storage account setup, you need to create your Azure Data Factory using Azure portal.
1. **Create data workflow pipeline** - After your storage and ADF is up and running, you start by creating a pipeline, where the first step is to copy data from your source using ADF's Copy activity. Copy Activity allows you to copy data from different on-premises and cloud sources.
1. **Add Databricks notebook to pipeline** - Once your data is copied to ADF, you add your Databricks notebook to the pipeline, after copy activity. This notebook may contain syntax and code to transform and clean raw data as required.
1. **Perform analysis on data** - Now that your data is cleaned up and structured into the required format, you can use Databricks notebooks to further train or analyze it to output required results.

You have learned what Azure Data Factory is and how its integration with Azure Databricks helps you to load and transform your data. Now let's create an end-to-end sample data workflow.