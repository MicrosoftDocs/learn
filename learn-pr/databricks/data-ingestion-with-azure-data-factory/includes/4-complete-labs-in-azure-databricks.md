You now have your storage account and data factory instance up and running. Switch to your Databricks workspace to complete the rest of the workflow. We'll use a sample dataset to create a Data Factory pipeline and use sample notebooks to transform and analyze the data. 

> [!NOTE]
> To complete the following procedures, you must have already deployed your Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. In the Azure portal, go to your Databricks workspace and select **Launch workspace**.
1. In the left pane, select **Workspace**, select **Users**, and then select your username (the entry with the house icon).
1. In the pane that appears, select the downward-pointing chevron next to your name, and then select **Import**.

    ![A screenshot showing the menu option to import the archive](../media/import-archive.png)

1. In the **Import Notebooks** pane, select **URL**, and paste in the following URL:

   ```html
   https://github.com/MicrosoftDocs/mslearn-data-ingestion-with-azure-data-factory/blob/master/DBC/03-Data-Ingestion-Via-ADF.dbc?raw=true
   ```

1. Select **Import**.
1. A folder named after the archive should appear. Select that folder. The folder contains one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

1. **01 Getting Started** - This notebook contains instructions for setting up your storage account and Azure Data Factory (ADF). If you've already set up these in the previous unit, you can skip this notebook.
1. **02 Data Ingestion** - In this notebook, you create a Data Factory v2 pipeline to ingest data from a public dataset into your storage account. After the data is ingested, you use a Databricks notebook function to examine the data.
1. **03 Data Transformation** - This notebook contains instructions to create connectivity between your Azure Data Factory and Databricks workspace. You will add a Databricks Notebook activity to your ADF pipeline that will run a sample notebook to transform and restructure your data. You'll also perform some basic aggregation on the sample dataset to generate required reports.