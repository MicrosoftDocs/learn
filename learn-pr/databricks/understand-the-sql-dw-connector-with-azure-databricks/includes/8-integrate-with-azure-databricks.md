In this unit, you'll process the data by using Apache Spark on Azure Databricks. You'll learn how to extract and transform data by using Spark. You'll also learn how Spark and Azure SQL Data Warehouse can work together to meet big data needs.

The key takeaways of this unit are:

- Access data from an Azure storage account in a Databricks cluster.
- Create a DataFrame and perform operations on it.
- Learn Spark SQL.
- Learn how to extract and transform data in Spark and load output to SQL Data Warehouse.

## What is Azure Databricks?

Azure Databricks is a fully managed, cloud-based big data and machine learning platform. It enables developers to accelerate AI implementation by simplifying the process of building enterprise-grade production data applications. Built as a joint effort by Microsoft and the team that started Apache Spark, Azure Databricks provides data science and engineering teams with a single platform for big data processing and machine learning.

By combining Databricks, an end-to-end Apache Spark platform that's optimized for the cloud, with the enterprise scale and security of the Azure platform, Databricks makes it easy to run large-scale Spark workloads.

## Azure Databricks and Azure SQL Data Warehouse together

You can access SQL Data Warehouse from Azure Databricks by using the SQL Data Warehouse connector, a data source implementation for Apache Spark that uses Azure Blob storage and PolyBase in SQL Data Warehouse to transfer large volumes of data efficiently between an Azure Databricks cluster and a SQL Data Warehouse instance.

Both the Azure Databricks cluster and the SQL Data Warehouse instance access a common Blob storage container to exchange data. In Azure Databricks, Spark jobs are triggered by the SQL Data Warehouse connector to read data from and write data to the Blob storage container. On the SQL Data Warehouse side, data loading and unloading operations performed by PolyBase are triggered by the SQL Data Warehouse connector through JDBC.

> When you ran the PowerShell script at the beginning of this module, you created a common Blob storage container. As you recall, you copied the account name and account key values after you created it. The common container that the Azure Databricks cluster and the SQL Data Warehouse instance will use is `dwtemp`.

Another prerequisite is to [create a database master key](https://docs.microsoft.com/sql/relational-databases/security/encryption/create-a-database-master-key) for your Azure SQL Data Warehouse instance.

## Make a connection to SQL Data Warehouse

1. Open Azure Data Studio.
1. Navigate to the Servers list on the left-hand menu in Azure Data Studio. Right-click on the SQL Data Warehouse connection you made to the SQL Data Warehouse database, then select **New Query** from the context menu.

    ![Right-click on the SQL Data Warehouse connection then click New Query.](../media/azure-data-studio-new-query-dw.png)

## Create database master key

1. Execute following statement in the query window to create the database master key.

    ```sql
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '980AbctotheCloud427leet';
    ```

You'll receive the following message if you already have a master key defined in the database:

  ```
   There is already a master key in the database. Please drop it before performing this statement.
  ```

If you see this message, you can ignore it and continue to the following steps.

## Clone the Databricks archive

1. From the Azure portal, navigate to your deployed Azure Databricks workspace and select Launch Workspace.
1. Within the Workspace, using the command bar on the left, select Workspace, Users and select your username (the entry with house icon).
1. In the blade that appears, select the downwards pointing chevron next to your name, and select Import.
1. On the Import Notebooks dialog, select URL and paste in the following URL:
    ```
       https://github.com/MicrosoftDocs/mslearn-understanding-the-sql-dw-connector-with-azure-databricks/blob/master/DBC/02-Azure-SQL-DW.dbc?raw=true
    ```
1. Select **Import**.
1. A folder called `02-azure-sql-dw` should appear. Select that folder.
1. The folder should contain 2 notebooks that you'll use in completing this exercise.

## Complete the following notebooks

1. **01 Using Spark** - This notebook gives a quick overview on how to harness the power of the Apache Spark engine within Azure Databricks.
1. **02 Data Ingestion** - In this notebook gives instructions on how to connect your notebook to Azure SQL Data Warehouse instance and write data to a new external table.

After you have completed the notebooks, return to this screen and continue to the next step.