Now that you've seen how Azure SQL appears in SQL Server Management Studio (SSMS), you can verify the deployment.


## Verify deployment

After you deploy an instance of SQL, you typically run queries to verify your deployment. In Azure SQL, some of these queries vary from SQL Server. In this step, you see what things change SQL Server, how they change, and what's new.  

In this exercise, you walk through some common queries against system functions, dynamic management views (DMVs), and catalog views that you can use after deployment in SSMS. You see which ones work the same as SQL Server, which ones don't, and which ones are new to Azure SQL.

1. Connect to your Azure SQL Database logical server in SSMS if you haven't already.
1. Right-click the `AdventureWorks` database and select **New Query**.
1. Check the version that you deployed by executing the well-known system function ``@@VERSION``.

    ```sql
    SELECT @@VERSION
    ```

    :::image type="content" source="../media/4-version.png" alt-text="Screenshot of the result of the SELECT @@VERSION function.":::  

    The result looks a bit different from SQL Server. You can tell that this server is Azure SQL, which doesn't have versions. Azure SQL Database includes the most up-to-date changes in line with the latest release of SQL Server. However, using the system function `@@VERSION` is a common method to verify that you can "query" SQL Server.

1. Determine the specific type of Azure SQL deployment, based on the number returned:

    - **1**: Personal or Desktop Engine  
    - **2**: Standard  
    - **3**: Enterprise  
    - **4**: Express  
    - **5**: SQL Database  
    - **6**: SQL Data Warehouse  
    - **8**: SQL Managed Instance  

    Run the following T-SQL command to see if you get the expected result.

    ```sql
    SELECT SERVERPROPERTY('EngineEdition');
    ```

    :::image type="content" source="../media/4-engine-edition.png" alt-text="Screenshot of the results for the Azure SQL deployment.":::  

    The result is **5**, which makes sense because you deployed Azure SQL Database, not SQL Managed Instance or SQL Server Enterprise. There's no special number for SQL Server in Azure Virtual Machines. The number corresponds to the edition that you installed in the virtual machine. Personal or Desktop Engine is an earlier edition that's no longer used with SQL Server.

1. Examine the catalog views `sys.databases` and `sys.objects`. Typically, you look at these views to verify the installation and the status of system databases and to check system objects in your database.

    ```sql
    SELECT * FROM sys.databases;
    SELECT * FROM sys.objects;
    ```

    :::image type="content" source="../media/4-sys-databases-objects.png" alt-text="Screenshot of the results for sys.databases and sys.objects.":::  

    In the first result set, the system databases `msdb`, `tempdb`, and `model` aren't listed. Only `master` and your user database are listed. The `master` database in a logical server isn't the same as the physical `master` database installed with SQL Server. In Azure SQL Managed Instance, you see the normal set of system databases, as with any SQL Server instance.

    However, `sys.objects` looks similar to a normal SQL Server instance. That fact is true for system tables, internal tables, and user objects for the sample `AdventureWorksLT` database.

1. Verify that all schedulers are online and that you're detecting the expected available CPUs, considering that you deployed with a two-vCore model.

    ```sql
    SELECT * FROM sys.dm_os_schedulers where STATUS = 'VISIBLE ONLINE';
    ```

    :::image type="content" source="../media/4-schedulers.png" alt-text="Screenshot of the results for sys.dm_os_schedulers.":::  

    Two `VISIBLE ONLINE` schedulers are what you'd expect when two vCores are available for the SQL Server instance where your SQL database is deployed.

1. For a SQL Server deployment, you might normally look at DMVs like `sys.dm_process_memory` to see limits for CPU, memory, and workers. This DMV isn't supported with Azure SQL Database, because the user doesn't expose or control the details of the host that supports the database. You can use the DMV `sys.dm_user_db_resource_governance` to review capacities and limits for your deployed SQL database. You can also use `sys.dm_instance_resource_governance` in Azure SQL Managed Instance.

    Run and review the following query results. Compare the results to your pricing tier and the limits documented for your deployed tier. The `slo_name` is the Service Level Objective (SLO) which states the deployment option, service tier, hardware, and compute amount. In addition, because Azure SQL Database uses Windows Job Objects for other resource limits, such as memory, you can use the `sys.dm_os_job_object` DMV to see what resources are available for the deployment.

    ```sql
    SELECT * FROM sys.dm_user_db_resource_governance;
    ```

    :::image type="content" source="../media/4-resource-governance.png" alt-text="Screenshot of the results showing resource governance limits.":::

1. A common technique to look at a SQL Server deployment is to examine a list of active requests. Just like SQL Server, you can use `sys.dm_exec_requests` to view currently running SQL requests.

    ```sql
    SELECT * FROM sys.dm_exec_requests;
    ```

    :::image type="content" source="../media/4-dm-exec-requests.png" alt-text="Screenshot of the results showing dm_exec_requests.":::

    Using `sys.dm_exec_requests` for Azure SQL Database is different from using it for SQL Server or SQL Managed Instance. This DMV shows only active requests related to your database, including background tasks or background tasks that don't have a database context that shows up as `master`. This behavior is because of the nature of an Azure SQL Database deployment.


