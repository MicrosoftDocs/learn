In this unit, you process the data using Apache Spark on Azure Databricks. You'll learn how to extract and transform data using Spark, and how Spark and Azure SQL Data Warehouse (SQL DW) can work together to solve big data needs.

The key takeaways of this unit are:

1. Access data from an Azure Storage account in a Databricks cluster
1. Create DataFrame and perform operations on it
1. Learn Spark SQL
1. How to extract and transform data in Spark and load output to SQL Data Warehouse

## What is Azure Databricks?

Azure Databricks is a fully managed, cloud-based Big Data and Machine Learning platform, which empowers developers to accelerate AI and innovation by simplifying the process of building enterprise-grade production data applications. Built as a joint effort by the team that started Apache Spark and Microsoft, Azure Databricks provides data science and engineering teams with a single platform for Big Data processing and Machine Learning.

By combining the power of Databricks, an end-to-end, managed Apache Spark platform optimized for the cloud, with the enterprise scale and security of Microsoft's Azure platform, Azure Databricks makes it simple to run large-scale Spark workloads.

## Azure Databricks and Azure SQL Data Warehouse together

You can access SQL DW from Azure Databricks using the SQL Data Warehouse connector (referred to as the SQL DW connector), a data source implementation for Apache Spark that uses Azure Blob Storage, and PolyBase in SQL DW to transfer large volumes of data efficiently between an Azure Databricks cluster and a SQL DW instance.

Both the Azure Databricks cluster and the SQL DW instance access a common Blob Storage container to exchange data between these two systems. In Azure Databricks, Spark jobs are triggered by the SQL DW connector to read data from and write data to the Blob Storage container. On the SQL DW side, data loading and unloading operations performed by PolyBase are triggered by the SQL DW connector through JDBC.

> This common Blob Storage container was created when you ran the PowerShell script at the beginning of this module. As you recall, you copied the account name and account key values after it was created. The common container that the Azure Databricks cluster and the SQL DW instance will use is `dwtemp`.

Another pre-requisite is to [create a database master key](https://docs.microsoft.com/sql/relational-databases/security/encryption/create-a-database-master-key) for your Azure SQL Data Warehouse instance.

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