Now that you've seen how Azure SQL appears in SSMS, let's explore a tool that may be new to you called Azure Data Studio (ADS). ADS is a source-open tool that provides a lightweight editor and other tools (including Notebooks which you'll see soon) for interacting with Azure Data Services (including SQL Server on-prem, Azure SQL, Azure Database for PostgreSQL, and more). Let's take a brief tour to get acquainted.  

## Connect with Azure Data Studio

1. On your local device open Azure Data Studio (ADS). When opening for the first time, you'll first be prompted to make a connection.  

    If you are prompted to enable preview features, select **Yes**.  

    :::image type="content" source="../media/4-azure-data-studio-connect.png" alt-text="Opening Azure Data Studio":::  

    If you don't see this window, or at any time want to add an additional connection, you can select the **New connection** button in the **Servers** bar. In the example below, you also get a preview of what a SQL Server connection would look like, but in this exercise you will not connect to SQL Server.  

    :::image type="content" source="../media/4-new-connection.png" alt-text="How to create a new connection in ADS":::  

1. Next, connect to your Azure SQL Database logical server. Complete the login box with the following values and select **Connect**.

    |Parameter  |Value  |
    |---------|---------|
    |**Connection type**     | Microsoft SQL Server       |
    |**Server**     | Enter the name of your logical server        |
    |**Authentication type**     | SQL Login        |
    |**User name**     |  cloudadmin       |
    |**Password**     | Enter the password for the cloudadmin account        |
    |**Remember password**     | Selected        |
    |**Database**     | AdventureWorks        |
    |**Server group**     | Leave as `<Default>`        |
    |**Name (optional)**     |  Leave blank       |


1. In the **Connections** tab, under **Servers**, you should now see your Azure SQL Database connection (SQL Server connection shown in image for comparison only).  

    :::image type="content" source="../media/4-azure-data-studio-servers.png" alt-text="Comparing SQL Server and SQL Database in ADS":::  

1. Finally, to run queries in ADS, it's very similar to SSMS. Right-click on a database or server name and select **New query**.

1. For Azure SQL Database, since you are not really getting a full "server", **`USE [DatabaseName]`** is not supported to change the database context. You must either change the connection to specifically connect to the database you want to run a query on or use the drop-down. Change to the context of your **AdventureWorks** database by selecting the drop-down box next to **master** and run `SELECT @@VERSION`.  

    :::image type="content" source="../media/4-new-query-azure-data-studio.png" alt-text="Querying in ADS":::

    Later in this exercise, you'll dive in to why that result is different from what you see in SQL Server.

## Set up easy file access with ADS  

Now that you're connected, you might want an easy way to access scripts and Jupyter notebooks. A Jupyter notebook (often referred to just as "Notebooks") is a way of integrating runnable code with text. If you aren't familiar with Jupyter notebooks, you will be soon.

1. First, in ADS, select **File > Open Folder**.  

    :::image type="content" source="../media/4-open-folder.png" alt-text="Opening a folder in ADS":::  

1. Next, navigate to where you extracted the zip file of the resources for this exercise. If you followed the prerequisites, the path should be similar to `C:\Users\<machine-username>\mslearn-azure-sql-fundamentals`. Once you're there, select **Select Folder**.  

1. Next, select the **Explorer** icon from the left taskbar to navigate through the files in the module. Note that this zip file contains all of the resources needed for the Azure SQL Fundamentals learning path, so you only need to download and configure this once!

    Throughout the module and learning path exercises, you'll be instructed at various points to open a notebook (file ending in `.ipynb`), and you can access those from here directly. Alternatively, you can access them from the Notebook icon tab.  

## Verify deployment

Once you've deployed an instance of SQL (Azure SQL or SQL Server), there are typically some queries you would run to verify your deployment. In Azure SQL, some of these queries vary from SQL Server. In this step, you'll see what and how things change from SQL Server, and what is new.  

There are two options for completing this exercise:

- T-SQL in SSMS (follow along this page)
- SQL Notebooks in Azure Data Studio

Both exercises contain the same commands and content, so you can choose the option you prefer.

### Option 1: T-SQL is SSMS

In this option, you'll walk through some common queries against system functions, Dynamic Management Views (DMV), and catalog views you can use post deployment as a "sanity check" in SSMS. You will see which ones work the same as SQL Server, which ones don't, and which ones are new to Azure SQL.

1. Connect to your Azure SQL Database logical server in SSMS if you have not already.
1. Right-click on the AdventureWorks database and select New Query.
1. You can first take a look at the version you deployed using the well-known system function ``@@VERSION``.

    ```sql
    SELECT @@VERSION
    ```

    :::image type="content" source="../media/4-version.png" alt-text="Result of SELECT @@VERSION":::  

    Looks a bit different from SQL Server. But we can tell this is Azure SQL which is "versionless". The version number is not comparable to SQL Server. Azure SQL Database includes the most up-to-date changes in line with the latest release of SQL Server. However, querying the system function @@VERSION is common method to verify you can "query" SQL Server.

1. Next, you can determine the specific type of Azure SQL deployment. The number returned is one of the possible options below.

    1 = Personal or Desktop Engine  
    2 = Standard  
    3 = Enterprise  
    4 = Express  
    5 = SQL Database  
    6 = SQL Data Warehouse  
    8 = SQL Managed Instance  

    Run the following T-SQL to see if you get the expected result.

    ```sql
    SELECT SERVERPROPERTY('EngineEdition');
    ```

    :::image type="content" source="../media/4-engine-edition.png" alt-text="Results for Engine Edition":::  

    The result is 5, which makes sense because you deployed Azure SQL Database, not Managed Instance or SQL Server Enterprise. Note there is no special number for SQL Server in Azure Virtual Machine. The number would correspond to the Edition you installed in the Virtual Machine. Personal or Desktop Engine is a legacy edition no longer used with SQL Server.

1. Next, let's examine the catalog views sys.databases and sys.objects. Typically, you look at these to verify the install and the status of system databases and a sanity check for system objects in your database.

    ```sql
    SELECT * FROM sys.databases;
    SELECT * FROM sys.objects;
    ```

    :::image type="content" source="../media/4-sys-databases-objects.png" alt-text="Results for sys.databases and sys.objects":::  

    In the first result set, you'll notice that system databases msdb, tempdb, and model are not listed but only master and your user database. This is because the master database for a database server for Azure SQL Database is not the same as the physical master database installed with SQL Server. In Azure SQL Managed Instance, you will see the normal set of system database as with any SQL Server.

    However, sys.objects looks very similar to a normal SQL Server including system tables, internal tables, and user objects for the sample AdventureWorksLT database.

1. Let's next verify that all schedulers are online and we're detecting the expected available CPUs given we deployed with a 2 vCore model.

    ```sql
    SELECT * FROM sys.dm_os_schedulers where STATUS = 'VISIBLE ONLINE';
    ```

    :::image type="content" source="../media/4-schedulers.png" alt-text="Results for sys.dm_os_schedulers":::  

    Two VISIBLE ONLINE schedulers are what you would expect when 2 vCores are available for the SQL Server where your SQL Database is deployed.

1. For a SQL Server deployment, you may normally look at DMVs like sys.dm_os_sys_info AND sys.dm_process_memory to see limits for CPU, memory, and workers. These DMVs are not supported with Azure SQL Database, since the details of the host supporting the database are not exposed or controlled by the user. So the DMV sys.dm_user_db_resource_governance can be used to review capacities and limits for your deployed Azure SQL Database. Run and review the query results below and compare this to your Pricing Tier and the limits documented for your deployed tier.

    ```sql
    SELECT * FROM sys.dm_user_db_resource_governance;
    ```

    :::image type="content" source="../media/4-resource-governance.png" alt-text="Results showing resource governance limits":::

1. Finally, a common technique to look at an SQL Server is to examine a list of active requests. Just like SQL Server, you can use sys.dm_exec_requests to view currently running SQL requests.

    ```sql
    SELECT * FROM sys.dm_exec_requests;
    ```

    :::image type="content" source="../media/4-dm-exec-requests.png" alt-text="Results showing dm_exec_requests":::

    There is a difference in using sys.dm_exec_requests for Azure SQL Database than SQL Server or Managed Instance. This DMV only shows active requests related to your database including background tasks (or background tasks that don't have a database context that show up as "master"). This is because the nature of Azure SQL Database deployment where each database is deployed on its own SQL Server instance.

### Option 2: SQL Notebooks in Azure Data Studio

For this option, you'll use the notebook **VerifyDeployment.ipynb** which is under `02-DeployAndConfigure\verifydeployment\VerifyDeployment.ipynb` in the GitHub repository or zip file you downloaded earlier. Navigate to that file in ADS to complete this part of the exercise, and then return here. In the same folder, you'll also find extra notebooks containing the results of the same queries on Azure SQL Managed Instance and SQL Server 2019.  

If you are unable to complete the exercise for any reason, you can review the results in the [corresponding notebook file on GitHub](https://github.com/MicrosoftDocs/mslearn-azure-sql-fundamentals/blob/master/02-DeployAndConfigure/verifydeployment/VerifyDeployment.ipynb?azure-portal=true).
