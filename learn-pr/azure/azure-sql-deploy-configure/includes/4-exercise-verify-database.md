Now that you've seen how Azure SQL appears in SQL Server Management Studio (SSMS), let's explore an open-source tool called Azure Data Studio. Azure Data Studio provides a lightweight editor and other tools for interacting with Azure Data Services, such as SQL Server on-premises, Azure SQL, and Azure Database for PostgreSQL. Let's take a brief tour to get acquainted.

## Connect with Azure Data Studio

1. On your local device, open Azure Data Studio. When opening for the first time, you'll be prompted to make a connection.  

    If you're prompted to enable preview features, select **Yes**.  

    :::image type="content" source="../media/4-azure-data-studio-connection-window.png" alt-text="Screenshot of the opening view of Azure Data Studio.":::  

    If you don't have this window, or at any time you want to add another connection, you can select the **New connection** button on the **Servers** bar. In the following example, you also get a preview of what a SQL Server connection would look like. In this exercise, you won't connect to SQL Server.  

    :::image type="content" source="../media/4-new-connection.png" alt-text="Screenshot of how to create a new connection in Azure Data Studio.":::  

1. Connect to your Azure SQL Database logical server. Complete the login box with the following values and select **Connect**.

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

1. On the **Connections** tab, under **Servers**, you should now see your Azure SQL Database connection. (The SQL Server connection shown in the following image is for comparison only.)  

    :::image type="content" source="../media/4-azure-data-studio-servers.png" alt-text="Screenshot that compares SQL Server and SQL Database in Azure Data Studio.":::  

1. Running queries in Azure Data Studio is similar to SSMS. Right-click a database or server name and select **New query**.

1. For Azure SQL Database, because you're not getting a full "server," **USE [DatabaseName]** is not supported to change the database context. You must either change the connection to specifically connect to the database on which you want to run a query or use the dropdown. Change to the context of your `AdventureWorks` database by selecting the dropdown next to `master` and run `SELECT @@VERSION`.  

    :::image type="content" source="../media/4-new-query-azure-data-studio.png" alt-text="Screenshot of querying in Azure Data Studio.":::

    Later in this exercise, you'll dive in to why that result is different from what you see in SQL Server.

## Set up easy file access with Azure Data Studio  

Now that you're connected, you might want an easy way to access scripts and Jupyter notebooks. A Jupyter notebook is a way of integrating runnable code with text. If you aren't familiar with Jupyter notebooks, you will be soon.

1. In Azure Data Studio, select **File** > **Open Folder**.  

    :::image type="content" source="../media/4-open-folder.png" alt-text="Screenshot of opening a folder in Azure Data Studio.":::  

1. Browse to where you extracted the zip file of the resources for this exercise. If you followed the prerequisites, the path should be similar to `C:\Users\<machine-username>\mslearn-azure-sql-fundamentals`. When you're there, select **Select Folder**. If prompted, select **Yes, I trust the authors**.

1. Next, select the **Explorer** icon from the left taskbar to browse through the files in the module. Note that this folder contains all of the necessary resources for the learning path about Azure SQL fundamentals, so you only need to download and configure this once!

    Throughout the module and learning path exercises, you'll be instructed at various points to open a notebook (file ending in `.ipynb`). You can access the notebook from here directly. Alternatively, you can access it from the **Notebook** icon tab.  

## Verify deployment

After you've deployed an instance of SQL, you typically run queries to verify your deployment. In Azure SQL, some of these queries vary from SQL Server. In this step, you'll see what and how things change from SQL Server, and what's new.  

There are two options for completing this exercise:

- T-SQL in SSMS
- SQL Notebooks in Azure Data Studio

Both exercises contain the same commands and content, so you can choose the option that you prefer.

### Option 1: T-SQL in SSMS

In this option, you'll walk through some common queries against system functions, dynamic management views (DMVs), and catalog views that you can use after deployment in SSMS. You'll see which ones work the same as SQL Server, which ones don't, and which ones are new to Azure SQL.

1. Connect to your Azure SQL Database logical server in SSMS if you haven't already.
1. Right-click the `AdventureWorks` database, and select **New Query**.
1. Check the version that you deployed by executing the well-known system function ``@@VERSION``.

    ```sql
    SELECT @@VERSION
    ```

    :::image type="content" source="../media/4-version.png" alt-text="Screenshot of the result of the SELECT @@VERSION function.":::  

    The result looks a bit different from SQL Server. You can tell that this is Azure SQL, which doesn't have versions. Azure SQL Database includes the most up-to-date changes in line with the latest release of SQL Server. However, using the system function `@@VERSION` is a common method to verify that you can "query" SQL Server.

1. Determine the specific type of Azure SQL deployment, based on the number returned:

    1 = Personal or Desktop Engine  
    2 = Standard  
    3 = Enterprise  
    4 = Express  
    5 = SQL Database  
    6 = SQL Data Warehouse  
    8 = SQL Managed Instance  

    Run the following T-SQL command to see if you get the expected result.

    ```sql
    SELECT SERVERPROPERTY('EngineEdition');
    ```

    :::image type="content" source="../media/4-engine-edition.png" alt-text="Screenshot of the results for the Azure SQL deployment.":::  

    The result is 5, which makes sense because you deployed Azure SQL Database, not SQL Managed Instance or SQL Server Enterprise. Note that there's no special number for SQL Server in Azure Virtual Machines. The number would correspond to the edition that you installed in the virtual machine. Personal or Desktop Engine is an earlier edition that's no longer used with SQL Server.

1. Let's examine the catalog views `sys.databases` and `sys.objects`. Typically, you look at these to verify the installation and the status of system databases and to check system objects in your database.

    ```sql
    SELECT * FROM sys.databases;
    SELECT * FROM sys.objects;
    ```

    :::image type="content" source="../media/4-sys-databases-objects.png" alt-text="Screenshot of the results for sys.databases and sys.objects.":::  

    In the first result set, the system databases `msdb`, `tempdb`, and `model` aren't listed. Only master and your user database are listed. This is because the master database for a database server for Azure SQL Database is not the same as the physical master database installed with SQL Server. In Azure SQL Managed Instance, you'll see the normal set of system databases, as with any SQL Server instance.

    However, `sys.objects` looks similar to a normal SQL Server instance. That's true for system tables, internal tables, and user objects for the sample `AdventureWorksLT` database.

1. Verify that all schedulers are online and you're detecting the expected available CPUs, considering that you deployed with a two-vCore model.

    ```sql
    SELECT * FROM sys.dm_os_schedulers where STATUS = 'VISIBLE ONLINE';
    ```

    :::image type="content" source="../media/4-schedulers.png" alt-text="Screenshot of the results for sys.dm_os_schedulers.":::  

    Two `VISIBLE ONLINE` schedulers are what you would expect when two vCores are available for the SQL Server instance where your SQL database is deployed.

1. For a SQL Server deployment, you might normally look at DMVs like `sys.dm_process_memory` to see limits for CPU, memory, and workers. This DMV is not supported with Azure SQL Database, because the user doesn't expose or control the details of the host that supports the database. You can use the DMV `sys.dm_user_db_resource_governance` to review capacities and limits for your deployed SQL database. You can also use `sys.dm_instance_resource_governance` in Azure SQL Managed Instance.

    Run and review the following query results. Compare this to your pricing tier and the limits documented for your deployed tier. The `slo_name` is the Service Level Objective (SLO) which states the deployment option, service tier, hardware, and compute amount.  In addition, because Azure SQL Database uses Windows Job Objects for additional resource limits (such as memory), you can use the `sys.dm_os_job_object` DMV to see what resources are available for the deployment.

    ```sql
    SELECT * FROM sys.dm_user_db_resource_governance;
    ```

    :::image type="content" source="../media/4-resource-governance.png" alt-text="Screenshot of the results showing resource governance limits.":::

1. A common technique to look at a SQL Server deployment is to examine a list of active requests. Just like SQL Server, you can use `sys.dm_exec_requests` to view currently running SQL requests.

    ```sql
    SELECT * FROM sys.dm_exec_requests;
    ```

    :::image type="content" source="../media/4-dm-exec-requests.png" alt-text="Screenshot of the results showing dm_exec_requests.":::

    Using `sys.dm_exec_requests` for Azure SQL Database is different from using it for SQL Server or SQL Managed Instance. This DMV shows only active requests related to your database, including background tasks (or background tasks that don't have a database context that shows up as "master"). This is because of the nature of an Azure SQL Database deployment where each database is deployed on its own SQL Server instance.

### Option 2: SQL Notebooks in Azure Data Studio

For this option, you'll use the notebook **VerifyDeployment.ipynb**. It's under `02-DeployAndConfigure\verifydeployment\VerifyDeployment.ipynb` in the GitHub repository or the zip file you downloaded earlier. Browse to that file in Azure Data Studio to complete this part of the exercise, then return here. In the same folder, you'll also find extra notebooks that contain the results of the same queries on Azure SQL Managed Instance and SQL Server 2019.  

If you can't complete the exercise for any reason, you can review the results in the [corresponding notebook file on GitHub](https://github.com/MicrosoftDocs/mslearn-azure-sql-fundamentals/blob/master/02-DeployAndConfigure/verifydeployment/VerifyDeployment.ipynb?azure-portal=true).
