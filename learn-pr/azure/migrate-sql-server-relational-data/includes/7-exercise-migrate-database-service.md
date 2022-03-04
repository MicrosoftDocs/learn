In this exercise, you migrate the data in your database by using Azure Database Migration Service. This is a two-step process. First, you create a new instance of Database Migration Service. Within that instance, you then create a new migration project.

## Create the Database Migration Service instance

1. Open the [Azure portal](https://portal.azure.com?azure-portal=true), and under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, enter *Azure Database Migration Service*, and press <kbd>Enter</kbd>. The **Azure Database Migration Service** pane appears.

1. Select **Create**. The **Create Migration Service** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription | Select your subscription |
    | Resource group | From the dropdown list, select **admsdemorg** |
    | **Instance details** |
    | Migration service name | Enter *admsdemodms* |
    | Location    | Select the same region where your resources are located |
    | Pricing tier | Standard 1 vCores |
    |||

1. Select **Next : Networking**.

1. On the **Networking** tab, select the **admsdemo-vnet/default** virtual network.

1. Select **Review + create**.

1. To create the Database Migration Service instance, select **Create**.

1. Wait for the deployment to finish. It might take 15 minutes. Then, select **Go to resource**. The **Azure Database Migration Service** Overview pane appears.

    ![The overview pane for Database Migration Service.](../media/7-migration-service-overview.png)

## Create a migration project

After the service instance is created, you create a project to migrate the database.

1. In the top menu bar, select **New Migration Project**. The **New migration project** pane appears.

1. Enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Migration project name** |
    | Project name | SocialDatabaseMigration |
    | **Choose your source and target server type.** |
    | Source server type | SQL Server |
    | Target server type | Azure SQL Database |
    | **Choose your migration activity type.**  |
    | Migration activity type | Data migration |
    |||

    ![Selections for project, servers, and activity type.](../media/7-07-new-project.png)

1. Select **Create and run activity**. The **SQL Server to Azure SQL Database Migration Wizard** pane appears.

1. On the **Select source** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | Source SQL Server instance name | admsdemovm |
    | Authentication type | Windows Authentication |
    | User Name | admsdemovm\windowsadmin |
    | Password     | Enter the password for the windowsadmin account |
    | **Connection properties** |
    | Encrypt connection | Check |
    | Trust server certificate | Check |
    | | |

    ![Source details.](../media/7-08-source-details.png)

1. Select **Next : Select databases**.

1. Select **Next : Select target**.

1. On the **Select target** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | Target server name | Enter the DNS name of your Azure SQL server (for example, admsdemosqlmfe4eev3ubxlo.database.windows.net). |
    | Authentication type | SQL Authentication |
    | User Name | azuresqladmin |
    | Password     | Enter the password for the azuresqladmin account |
    | **Connection properties** |
    | Encrypt connection | Check |
    | | |

    ![Target details.](../media/7-09-target-details.png)

1. Select **Next : Map to target databases**.

1. On the **Map to target databases** tab, for the **Social** database, select **Set Source DB Read-Only**.

    Make sure you're not logged in to the database elsewhere, such as from SQL Server Management Studio in the virtual machine. If you are, the migration will fail.

    ![Selections for mapping to a target database.](../media/7-10-map-database.png)

1. Select **Next : Configure migration settings**.

1. On the **Configure migration settings** tab, to expand the list of tables, next to **Social 1 of 1**, select the arrow. Make sure the `dbo.Twitters` table is selected.

    ![List of tables.](../media/7-11-select-tables.png)

1. Select **Next : Summary**.

1. On the **Summary** tab, in the **Activity name** box, enter *MigrateSocialDatabase*.

    ![Migration summary.](../media/7-12-run-migration.png)

1. To start the migration, select **Start migration**. A new pane appears with the status of the migration.

1. To update the status until it shows that the process is finished, on the top menu bar, select **Refresh**.

    ![Refresh button.](../media/7-13-completed.png)

## View data in the new database

You can now go to the Azure SQL database and view your migrated data.

1. Go back to your **admsdemorg** resource group, and select the **Social (admsdemosqlv2v2s22x.../Social)** SQL database.

    ![Overview pane.](../media/7-sql-database.png)

1. Select **Set server firewall**.

1. On the **Firewall settings** pane, in the top menu bar, select **Add client IP**, and then select **Save**.

    ![Firewall pane.](../media/7-sql-firewall.png)

1. To return to the overview for your database, close the **Firewall settings** pane.

1. Select **Query editor (preview)**.

1. Log in with the **azuresqladmin** username and password.

1. Enter the following query, and select **Run**.

    ```sql
    SELECT * FROM [dbo].[Twitters];
    ```

    ![Select pane.](../media/7-sql-select.png)

    You should see data from your database, which indicates a successful migration.