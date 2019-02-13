Now it's time to perform some analytics on a sample data set using Spark's Structured Streaming and the Azure Event Hubs you created.  

![NOTE]
To complete the following procedures you must already have deployed your Azure Databricks workspace in your Azure portal.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select **Launch Workspace**.
2. Within the Workspace, using the command bar on the left, select **Workspace**, **Users**, and select your username (the entry with house icon).
3. In the blade that appears, select the downwards pointing chevron next to your name, and select Import.
4. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
     https://github.com/MicrosoftDocs/mslearn-streaming-in-azure-databricks/blob/master/DBC/08-Streaming.dbc?raw=true
    ```
5. Select Import.
6. A folder named after the archive should appear. Select that folder.
7. The folder will contain one or more notebooks that you'll use in completing this lab.

## Complete the following notebooks

Complete the following notebooks within the 08-Streaming folder:

- **01-Getting started** -  This notebook gets you started with your Azure Event Hubs. If you already created your Event Hubs in the previous unit, you can skip this notebook.
- **02-Spark-Structured-Streaming** - In this notebook you work on a sample data set  to perform some batch and interactive processing. You'll also create streaming queries to update the destination data set.
- **03-Event-Hubs** - This notebook gives detailed instructions on how to perform near-real time processing of messages using Spark Structured Streaming by sending a batch of messages to Event Hubs.
- **04-Streaming-with-Databricks-Delta** - In this notebook you finally write your streaming data to a Data Lake storage.