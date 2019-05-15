You can use Azure Data Factory to ingest raw data collected from different sources and work with Azure Databricks to restructure the data to meet your requirements.

## What is Azure Data Factory?

Azure Data Factory is a data ingestion and transformation service that allows you to load raw data from over 70 different on-premises or cloud sources. The ingested data can be cleaned, transformed, restructured, and loaded back into a data warehouse. After the data is in the data warehouse, it's ready to use for several analytical purposes.

Data Factory supports data workflow pipelines. These pipelines are a logical group of tasks and activities that allows end-to-end data-processing scenarios.

## Integrate Data Factory and Databricks

When you integrate Databricks with Data Factory, you can take advantage of the analytical and data-transformation capabilities of Databricks. Use a Databricks notebook within your data workflow pipeline to structure and transform raw data that's loaded into Data Factory from different sources. After the data is transformed by using Databricks, load it to any data warehouse.

Data ingestion and transformation by using the collective capabilities of Data Factory and Databricks involves the following steps:

1. **Create an Azure storage account.** You'll use this storage account to store your ingested and transformed data.
1. **Create a Data Factory instance.** After you set up your storage account, create your Data Factory instance by using the Azure portal.
1. **Create a data workflow pipeline.** To create the pipeline, copy data from your source by using a copy activity in Data Factory. A copy activity allows you to copy data from different on-premises and cloud sources.
1. **Add a Databricks notebook to the pipeline.** This notebook contains the code to transform and clean the raw data as required.
1. **Analyze the data.** Now that your data is cleaned up, use Databricks notebooks to further train the data or analyze it to output the required results.

You've learned how integrating Data Factory with Databricks helps you to load and transform your data. Now let's create an end-to-end sample data workflow.