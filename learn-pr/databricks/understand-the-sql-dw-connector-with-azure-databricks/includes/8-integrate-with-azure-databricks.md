In this unit, you'll process the data by using Apache Spark on Azure Databricks. You'll learn how to extract and transform data by using Spark. You'll also learn how Spark and Azure Synapse Analytics can work together to meet big data needs.

In this unit, you will:

- Access data from an Azure storage account in a Databricks cluster.
- Create a DataFrame and perform operations on it.
- Learn Spark SQL.
- Learn how to extract and transform data in Spark and load output to Azure Synapse Analytics.

## What is Azure Databricks?

Azure Databricks is a fully managed, cloud-based big data and machine learning platform. It enables developers to accelerate AI implementation by simplifying the process of building enterprise-grade production data applications. Built in a joint effort by Microsoft and the team that started Apache Spark, Azure Databricks provides data science and engineering teams with a single platform for big data processing and machine learning.

By combining an end-to-end, managed Apache Spark platform optimized for the cloud with the enterprise scale and security of the Azure platform, Azure Databricks makes it easy to run large-scale Spark workloads.

## Azure Databricks and Azure Synapse Analytics together

You can access Azure Synapse Analytics from Azure Databricks by using the Azure Synapse Analytics connector. Azure Synapse Analytics connector is a data source implementation for Apache Spark that uses Azure Blob storage and PolyBase in Azure Synapse Analytics to transfer large volumes of data efficiently between an Azure Databricks cluster and a Azure Synapse Analytics instance.

Both the Azure Databricks cluster and the Azure Synapse Analytics instance access a common Blob storage container to exchange data. In Azure Databricks, Spark jobs are triggered by the Azure Synapse Analytics connector to read data from and write data to the Blob storage container. On the Azure Synapse Analytics side, data loading and unloading operations performed by PolyBase are triggered by the Azure Synapse Analytics connector through JDBC.

> [!NOTE]
> When you ran the PowerShell script at the beginning of this module, you created a common Blob storage container. As you recall, you copied the account name and account key values after you created it. `dwtemp` is the common container that the Azure Databricks cluster and the Azure Synapse Analytics instance will use.

## Make a connection to Azure Synapse Analytics

1. Open Azure Data Studio.

1. Go to the **Servers** list in the menu on the left side of Azure Data Studio. Right-click the Azure Synapse Analytics connection that you made earlier and select **New Query**.

    ![Right-click the Azure Synapse Analytics connection and select New Query](../media/azure-data-studio-new-query-dw.png)

## Create a database master key

- Run this statement in the query window to create a database master key.

    ```sql
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '980AbctotheCloud427leet';
    ```

   You'll receive this message if you already have a master key defined in the database.

    ```
    There is already a master key in the database. Please drop it before performing this statement.
    ```

    If you see this message, you can ignore it and continue with the following steps.

## Clone the Databricks archive

1. In the Azure portal, go to your deployed Azure Databricks workspace and select **Launch Workspace**.

1. In the workspace, on the menu on the left side, select **Workspace**, select **Users**, and then select your user name (the entry with house icon).

1. In the pane that appears, select the down arrow next to your name, and then select **Import**.

1. In the **Import Notebooks** dialog box, select **URL** and paste in this URL:

    ```
       https://github.com/MicrosoftDocs/mslearn-understanding-the-sql-dw-connector-with-azure-databricks/blob/master/DBC/02-Azure-SQL-DW.dbc?raw=true
    ```

1. Select **Import**.

1. A folder called `02-azure-sql-dw` should appear. Select that folder.

1. The folder should contain two notebooks that you'll use to complete this exercise.

## Complete the notebooks

- **01 Using Spark**. This notebook provides a quick overview of using the Apache Spark engine within Azure Databricks.
- **02 Data Ingestion**. This notebook provides instructions for connecting your notebook to an Azure SQL Data Warehouse instance and writing data to a new external table.

After you complete the notebooks, return to this screen and continue to the knowledge check.