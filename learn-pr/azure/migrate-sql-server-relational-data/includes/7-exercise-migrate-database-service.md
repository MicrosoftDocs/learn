In this exercise, you will migrate the data in your database using the Azure Data Migration Service. This is a two-step process. First, you'll need to create a new instance of a Database Migration Service. Once it has been created, within it you will create a new migration project.

## Create The Database Migration Service

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true) in a new tab, then select **+ Create a resource**.

1. In the **Search the Marketplace** box search for **Azure Database Migration Service** and select **Create**.

1. In the basics tab, configure the following values:

    |  |  |
    |---------|---------|
    | **Subscription** | Select your subscription |
    | **Resource group** | admsdemorg |
    | **Migration service name** | admsdemodms |
    | **Location**     | Select the same region your resources are located |
    | **Pricing tier** | Standard 1 vCores |
    |||

1. Select **Next:Networking**.

1. Select the **admsdemo-vnet/default** virtual network, then select **Review + create**.

1. Select **Create** to create the new Database Migration Service.

1. Wait for the deployment to complete. Once done, select **Go to resource**.

    ![The overview pane for the database migration service.](../media/7-migration-service-overview.png)

## Create a Migration Project

Once the service has been created, you will create a project to migrate the database.

1. In the migration project, select **New Migration Project**.

1. In the **New migration project** pane, configure the following values:

    |  |  |
    |---------|---------|
    | **Project name** | SocialDatabaseMigration |
    | **Source server type** | SQL Server |
    | **Target server type** | Azure SQL Database |
    | **Choose type of activity**     | Offline data migration |
    |||

    ![Deploy Complete](../media/7-07-new-project.png)

1. Select **Create and run activity**.

1. Next, you will fill out the information on the source database. Complete the **New migration project** pane with the following values:

    |  |  |
    |---------|---------|
    | **Source SQL Server instance name** | admsdemovm |
    | **Authentication type** | Windows authentication |
    | **User Name** | admsdemovm\windowsadmin |
    | **Password**     | Enter the password for the windowsadmin account |
    | **Encrypt connection** | Selected |
    | **Trust server certificate** | Selected |
    | | |

    ![Source Details](../media/7-08-source-details.png)

1. Select **Save**.

1. Next, you need to supply information for the target Azure SQL Database. Complete the **Migration target details** pane with the following values:

    |  |  |
    |---------|---------|
    | **Target server name** | Enter the DNS name of your Azure SQL server. |
    | **Authentication type** | SQL Authentication |
    | **User Name** | azuresqladmin |
    | **Password**     | Enter the password for the azuresqladmin account |
    | **Encrypt connection** | Selected |
    | | |

    ![Target Details](../media/7-09-target-details.png)

1. Select **Save**.

1. Select **Set Source DB Read-Only** for the **Social** database. As a reminder, make sure you are not logged into the database elsewhere, such as from SQL Server Management Studio in the virtual machine, or the migration will fail.

    ![Map Database](../media/7-10-map-database.png)

1. Select **Save** to proceed to configure the migration settings.

1. Select the down arrow next to **Social 1 of 1** to see the list of tables.

    ![Select Tables](../media/7-11-select-tables.png)

1. Make sure the `dbo.Twitters` table is checked, then select **Save**.

1. In the **Activity name** box, enter **MigrateSocialDatabase**.

1. Select **Validation Options**, then select **Do not validate my database(s)**, then select **Save**.

    ![Run Migration](../media/7-12-run-migration.png)

1. Select **Run migration** to start the migration.

1. A new pane will appear showing the status of the migration. Select the **Refresh** button at the top to update the status until it shows the process is complete.

    ![Run Migration](../media/7-13-completed.png)

## View data in the new database

You can now go to the Azure SQL database and view your migrated data.

1. Navigate back to your **admsdemorg** resource group and select the **Social (admsdemosqlv2v2s22x.../Social)** database.

    ![Firewall pane](../media/7-sql-database.png)

1. Select **Set server firewall**.

1. In the **Firewall settings** pane, select **+ Add client IP**, then select **Save**.

    ![Firewall pane](../media/7-sql-firewall.png)

1. Close the **Firewall settings** pane to return to the overview for your database.

1. Select **Query editor (preview)**.

1. Log in with the **azuresqladmin** username and password.

1. Enter the following query and select **Run**.

    ```sql
    SELECT * FROM [dbo].[Twitters];
    ```

    ![Firewall pane](../media/7-sql-query.png)

    You should see data from your database, indicating a successful migration.