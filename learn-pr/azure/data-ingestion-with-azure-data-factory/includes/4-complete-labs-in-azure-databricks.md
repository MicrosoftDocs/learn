Now that you have your storage account and Azure Data Factory up and running, it's time to switch to your Databricks workspace to complete rest of the workflow. We will use a sample dataset to create an ADF pipeline and use sample notebooks to transform and analyze the data.

> [!NOTE]
> To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your Azure Databricks workspace and select **Launch Workspace**.
1. Within the Workspace, using the command bar on the left, select **Workspace**, **Users** and select your username (the entry with house icon).
1. In the blade that appears, select the downwards pointing chevron next to your name, and select **Import**.

![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. On the Import Notebooks dialog, select URL and paste in the following URL:
   ```html
   https://github.com/solliancenet/proj-learning-paths-public/blob/master/modern-data-warehouse/03-Data-Ingestion-Via-ADF.dbc?raw=true
   ```
1. Select **Import**.
1. A folder named after the archive should appear. Select that folder.
1. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. **01 Getting Started** - This notebook contains instructions for setting up your storage account and ADF. If you have already done these in the previous unit, you can skip this notebook.
1. **02 Data Ingestion** - In this notebook you create an Azure Data Factory (ADF) v2 pipeline to ingest data from a public dataset into your Azure Storage account. Once the data is ingested you use Databricks notebook function to examine the data.
1. **03 Data Transformation** - This notebook contains instructions to create connectivity between your Azure Data Factory and Databricks workspace. You use a sample notebook to add to your ADF pipeline that will transform and restructure your data. You will also perform some basic aggregation on the sample dataset to generate required reports.