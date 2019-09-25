Although the default Azure SQL Database configuration includes automated backups, most organizations will modify the default setup to tailor it to their needs.

Now that you have planned a comprehensive backup strategy for Azure SQL Database and your company's ERP system, it's time to implement it.

Here, you will create a database in Azure and then configure backups. You'll set the retention to 28 days, to ensure you have 4 weeks of backups retained, per your policy. You will also add some content to the database.

## Create a server and database

Let's use the Azure CLI to create an Azure SQL Server and database instance.

1. Run these commands in the Azure Cloud Shell to set up some variables for the SQL Server creation. This will create a server name with a random number at the end to ensure it's globally unique. We'll refer to the server name as `ERPServer-NNNN` through the exercises, but replace this with the name of your server that is generated here. This also sets the location for your server to the location of the resource group. Finally, it sets the credentials you will use to access the database server. When prompted, enter a complex password of your choice. 

    ```powershell
    $serverName = "ERPServer-$(Get-Random)"
    $location = $(Get-AzResourceGroup -ResourceGroupName <rgn>[sandbox resource group name]</rgn>).location
    $sqlAdmin = Get-Credential -credential dbadmin

    ```

1. Run the `New-AzSqlServer` command to create an Azure SQL server to store the database.

    ```powershell
    New-AzSqlServer `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
        -Location $location `
        -ServerName $serverName `
        -SqlAdministratorCredentials $sqlAdmin
    ```

1. Run the `New-AzSqlDatabase` command to create a database.

    ```powershell
    New-AzSqlDatabase `
        -ResourceGroupName <rgn>[sandbox resource group name]</rgn> `
        -ServerName $serverName `
        -DatabaseName sql-erp-db
    ```

## Configure the database retention policy

In the portal, you can examine the default retention policy and adapt it to your needs.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), select **All resources** and then select the **ERPServer-NNNN** database server that you created.

1. On the left in the **Settings** section, select **Manage Backups**.

1. On the **Configure policies** tab, select the **sql-erp-db** database, and then select **Configure retention**.

1. In the **Point In Time Restore Configuration** drop-down list, select **28**.

    ![Screenshot of the Azure portal showing the database restore options for point in time restore](../media/3-configure-backup-pitr-retention.png)

1. Select **Apply**, and then select **Yes**.

## Allow network access to the database server

By default, Azure SQL Database blocks network access to the server. Let's enable both your IP address and Azure services to access the server so that we can run queries from Cloud Shell and the Azure portal. By adding your IP address, you could also connect directly from your local device.

1. On the left in the **Security** section, select **Firewalls and virtual networks**.

1. At the top of the page, select **Add client IP**.

1. Under **Allow access to Azure services**, select **ON**.

    ![Add a client IP address rule](../media/3-add-client-ip.png)

1. Select **Save**. When the rule has been saved, select **OK**.

## Add data to the database

Now let's add a table and a sample record to the database. It is helpful to have some data in the database to to validate that our backups and restores work later in the module.

1. In the **Settings** section, select **SQL databases**, then select the **sql-erp-database**.

1. Select **Query editor**, and then sign in with the credentials **dbadmin** and the password you created previously.

1. To create a table, in the **Query 1** window, type this SQL command, and then select **Run**.

    ```sql
    CREATE TABLE Person
    (
        PersonId INT IDENTITY PRIMARY KEY,
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        DateOfBirth DATE NOT NULL
    )
    ```

    ![Create a new table in the sql-erp-db database](../media/3-create-table.png)

1. To add a record, select **+ New Query** and then, in the **Query 2** window, type this SQL command, and then select **Run**.

    ```sql
    INSERT INTO PERSON (FirstName, LastName, DateOfBirth)
    VALUES ('Lucas', 'Ball', '1987-11-03');
    ```

    ![Insert a record into the sql-erp-db database](../media/3-insert-record.png)

1. To query the database, select **+ New Query** and then, in the **Query 3** window, type this SQL command, and then select **Run**.

    ```sql
    SELECT * FROM dbo.Person
    ```

    The **Results** window displays the record for Lucas Ball.

    ![Query the person table in the sql-erp-db database](../media/3-query-person-table.png)

You now have an Azure SQL Database that is populated with data, and you've set up retention policy to ensure you have four weeks of backups immediately available for restore.