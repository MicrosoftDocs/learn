You now have your storage account and data factory instance up and running. Switch to your Databricks workspace to complete rest of the workflow. We'll use a sample dataset to create a Data Factory pipeline and use sample notebooks to transform and analyze the data.

> [!NOTE]
> To complete the following procedures, you must have already deployed your Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your Databricks workspace and select **Launch workspace**.
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

- **01 Getting Started:** This notebook contains instructions for setting up your storage account and your data factory instance. If you've already set up these items in the previous unit, you can skip this notebook.
- **02 Data Ingestion:** In this notebook, you create a Data Factory v2 pipeline to ingest data from a public dataset into your storage account. After the data is ingested, you use a Databricks notebook function to examine the data.
- **03 Data Transformation:** This notebook explains how to create a connection between your data factory and your Databricks workspace. You use a sample notebook to add code to your Data Factory pipeline that will transform and restructure your data. You'll also do some basic aggregation on the sample dataset to generate the required reports.