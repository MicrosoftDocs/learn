---
ms.custom:
  - build-2023
---
Azure Synapse Analytics is a powerful cloud-based solution for Enterprise Data Warehousing (EDW), engineered to harness the computing capability of Massively Parallel Processing (MPP) by enabling rapid execution of queries on petabytes of data, making it the ideal platform for large-scale data analytics.

With near real-time analytics capabilities available on SQL Server 2022, you can replicate data to dedicated SQL pools using Azure Synapse Link for SQL.

Azure Synapse Link for SQL works like this: the source database writes data into a landing zone, which is then pushed into the target dedicated SQL pool by an ingestion service. This service can run continuously for near-real-time data processing or in schedule mode.

The technology running in the backend uses a new change feed processor that has been integrated into the Azure SQL Database and SQL Server 2022 engines to enable this functionality.

## Architecture overview

Let's review how Azure Synapse Link for SQL works:

:::image type="content" source="../media/module-2-real-time-analytics.png" alt-text="Diagram showing how Azure Synapse Analytics Link for SQL Server works.":::

**1.** Azure Synapse Analytics workspace where you configure Azure Synapse Link.

**2.** Dedicated SQL pool as the target database. A dedicated SQL pool is a group of analytical resources in Azure Synapse Analytics workspace.

**3.** A link service for SQL Server, which is the source SQL Server instance.

**4.** A link service for the Landing Zone, which serves as the temporary repository for data before it's delivered to the dedicated SQL pool. 

**5.** The linked connection signals the self-hosted runtime to synchronize data based on the selected tables. These tables are extracted from SQL Server as a snapshot in the form of Parquet files and stored in the landing zone. The ingestion service automatically retrieves these Parquet files from the landing zone and converts them into T-SQL such as `CREATE TABLE` statements. These statements are executed in the SQL dedicated pools to synchronize the data.

**6.** The SQL Server engine monitors committed log changes, adds them to the change feed queue, and then transforms them into Parquet files. These files are temporarily stored in the landing zone before being converted into T-SQL statements and added to the SQL dedicated pools for synchronization.

You have the option to configure the steps above through Azure portal or PowerShell.

### Flexible data replication

With Azure Synapse Link for SQL, you have the flexibility to pause the data replication from the link connection and then resume it as needed. You don't have to worry about data cleanup in the landing zone, as a background thread is responsible for removing committed files within approximately 24 hours, given that the link connection remains running. 

When the link is stopped then the entire landing zone folder is removed automatically.

## Exercise: Create Azure Synapse Link for SQL Server 2022

To run this exercise, make sure you're running SQL Server 2022 with the latest [**AdventureWorks**](/sql/samples/adventureworks-install-configure) database. You will also need a SQL Server user with read access to the source database.

1. Select your Synapse Analytics workspace or create a new one on Azure portal.

    :::image type="content" source="../media/module-2-synapse-link-01.png" alt-text="Screenshot showing the list of Synapse workspace resource on Azure portal.":::

1. On your Synapse workspace **Overview** page, select **Open Synapse Studio**.
1. On the **Manage** page, select the **SQL pools** tab.
1. Create a new dedicated SQL pool or select the row for a pre-existing dedicated SQL pool and use its **&#9655;** icon to start it; confirming that you want to resume it when prompted. 

    > [!NOTE]
    > This dedicated SQL pool is the target where we're going to replicate SQL Server data to.

1. On the **Home** page, select **New**, and then **SQL script**.

    :::image type="content" source="../media/module-2-synapse-link-02.png" alt-text="Screenshot showing the new SQL script option on Synapse Studio.":::

1. Make sure you're connected on the dedicated SQL pool created, and run the following command to create a master key for your SQL database:

    ```sql
    CREATE MASTER KEY
    ```

### Create the linked services

Create the linked service responsible to communicate with your SQL Server 2022.

1. Select the **Manage** hub button, and then select **Linked services**.
1. Select **+ New**, and then select the **SQL Server** component.
1. In the **New linked service** page, provide the following settings:
    - **Name**: SQLServerLS
    - **Description**: Connection to AdventureWorksLT database
    - **Connect via integration runtime**: 
        - Select to create a new Self-Hosted integration runtime, and choose **Option 1** to launch and install it on the same server where SQL Server is installed. Skip the installation step if the integration runtime is already installed.
    - **Server name**: *Select your SQL Server instance name*
    - **Database name**: AdventureWorksLT
    - **Authentication type**: SQL authentication
    - **User name**: *SQL User with read permission*
    - **Password**: *The password for the SQL account you selected*

    Use the **Test Connection** option to ensure your connection settings are correct before continuing!

1. Select **Create**.

1. For the landing zone, you can either use a pre-existing **ADLS Gen2** storage accounts or create a new one. Make sure that you've granted your Azure Synapse workspace managed identity permissions to the Azure Data Lake Storage Gen2 storage account that's used as the landing zone. For more information, see [Grant permissions to a managed identity in an Azure Synapse workspace - Azure Synapse Analytics](/azure/synapse-analytics/security/how-to-grant-workspace-managed-identity-permissions#grant-the-managed-identity-permissions-to-adls-gen2-storage-account).

Next, create the linked service responsible to communicate with your landing zone on Azure Data Lake Storage Gen2.

1. Select the **Manage** hub button, and then select **Linked services**.
1. Select **+ New**, and then select the **Azure Data Lake Storage Gen2** component.
1. Add the new linked service with the following settings:
    - **Name**: *Provide the name of your preference*
    - **Authentication type**: System Assigned Managed Identity
    - **Storage account name**: *Select the storage account you have granted access previously*
   
    Use the **Test Connection** option to ensure your connection settings are correct before continuing!


### Create the Azure Synapse Link connection

1. In Synapse Studio, on the **Integrate** page, on the **&#65291;** drop-down menu, select **Link connection**. Then create a new linked connection with the following settings:
    - **Source type**: SQL Server
    - **Source linked service**: *The first linked service created responsible to connect to your SQL Server.*
    - **Source tables**: Select the following tables:
        - **Sales.SalesPerson**
        - **Person.EmailAddress**

        :::image type="content" source="../media/module-2-synapse-link-04.png" alt-text="Screenshot showing the New link connection page.":::

    > [!NOTE]
    > Some target tables display an error due to the use of custom data types or because data in the source table is not compatible with the default structure type of *clustered columnstore index*.

1. Select **Continue**.
1. In the **Target pool settings**, select the dedicated SQL pool created, and then select **Continue**. 

    :::image type="content" source="../media/module-2-synapse-link-05.png" alt-text="Screenshot showing the target pool settings configuration.":::    

1. In the **Connection settings**, configure the link connection as follows:

    :::image type="content" source="../media/module-2-synapse-link-06.png" alt-text="Screenshot showing the connection settings configuration.":::

    > [!NOTE]
    > You can generate a Landing Zone SAS token, selecting **+ Generate token**.

1. With the new Azure Synapse Link connection open, you can update the target table name, distribution type, and structure type.

1. Select **Publish all** to save the new link connection to the service. 

1. Select **Start** to initiate the link connection. This process may take a few minutes to complete.
 
    :::image type="content" source="../media/module-2-synapse-link-07.png" alt-text="Screenshot showing the start process of the link connection.":::

    > [!NOTE]
    > In case of the error *'Some unknown error happened: FileSystem not found.'*, ensure that there's a container in the storage account you designated as the landing zone, with the same name on the **landing zone folder path** when registering the linked service for your landing zone.
    >
    > In case of the error *'The database master key is missing.'*, run `DROP MASTER KEY` and `CREATE MASTER KEY` to recreate the master key in the SQL pool, and select **Start** to initiate the link connection again.

After the replication has started, you can navigate to the **Tables** node on the **Data** hub for the dedicated SQL pool and expand it to check the new replicated tables. You can also insert dummy data into **Sales.SalesPerson** or **Person.EmailAddress** at the source, and execute a `SELECT` statement at the destination to confirm if the data has been replicated.
