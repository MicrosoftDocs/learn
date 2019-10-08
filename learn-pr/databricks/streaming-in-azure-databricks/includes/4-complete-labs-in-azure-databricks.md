Now it's time to perform some analytics on a sample data set by using Spark Structured Streaming and the Azure event hub that you created.  

> [!NOTE]
> To complete the following procedures, you must already have deployed your Azure Databricks workspace in the Azure portal.

## Clone the Databricks archive

1. From the Azure portal, go to your deployed Azure Databricks workspace and select **Launch Workspace**.
2. In the Workspace, by using the command bar on the left, select **Workspace** > **Users** > your username (the entry with the house icon).
3. In the blade that appears, select the downward-pointing chevron next to your name, and select **Import**.
4. In the **Import Notebooks** dialog box, select **URL** and paste in the following URL:
    ```
     https://github.com/MicrosoftDocs/mslearn-streaming-in-azure-databricks/blob/master/DBC/08-Streaming.dbc?raw=true
    ```
5. Select **Import**.
6. A folder named after the archive should appear. Select it. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete four notebooks

Complete the following notebooks in the 08-Streaming folder:

- **01-Getting started**:  This notebook gets you started with your event hub. If you already created your event hub in the previous unit, you can skip this notebook.
- **02-Spark-Structured-Streaming**: In this notebook, you work on a sample dataset to perform some batch and interactive processing. You'll also create streaming queries to update the destination dataset.
- **03-Event-Hubs**: This notebook gives detailed instructions on how to perform processing of messages in near real time through Spark Structured Streaming, by sending a batch of messages to Event Hubs.
- **04-Streaming-with-Databricks-Delta**: In this notebook, you finally write your streaming data to Azure Data Lake storage.