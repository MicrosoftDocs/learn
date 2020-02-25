In this exercise, you create a migration project by using Data Migration Assistant and move your database into Azure SQL Database. For this exercise, we'll use the offline migration option, accepting downtime. This way, we won't incur the cost associated with the premium database, a requirement of online migrations.

## Create a new project

1. If you're not connected already, connect to the **admsdemovm** virtual machine through RDP.

1. Open Data Migration Assistant.

1. Select **+** on the left menu.

1. In the pane that appears, select **Migration** for **Project type**.

1. In **Project name**, enter **Social Database Migration**.

1. Leave **Source server type** set to **SQL Server**, and leave **Target server type** set to **Azure SQL Database**.

1. Change **Migration scope** to **Schema only** and select **Create**.

## Select the source database

1. In the **Connect to source server** area, enter **admsdemovm** for the source server. Leave the other settings at their default values and select **Connect**.

1. After you're connected, you'll see a list of databases. In the list, you can select only one database to migrate. In this case, you have only the **Social** database.

    ![Source server](../media/6-02-source-server.png)

1. Select **Next** to continue.

## Select the target database

1. Get the name of your SQL Server instance that was created earlier. Open the [Azure portal](https://portal.azure.com?azure-portal=true) if you don't already have it open.

1. Open the **admsdemorg** resource group, and locate the SQL Server instance. Select the server name to open the **Overview** pane.

    ![Items in the resource group, with the SQL Server instance selected](../media/06-azure-sql-server.png)

1. Move the mouse to the end of the **Server name** line and select **Copy to clipboard**.

    ![Selection for copying the server name](../media/06-azure-sql-server-copy.png)

1. Switch back to Data Migration Assistant on your virtual machine. Paste the name of your SQL Server instance into the **Server name** box.

1. For **Authentication type**, select **SQL Server Authentication**.

1. Enter **azuresqladmin** into the username field, and enter the password that you specified for this account.

1. Select **Connect**.

1. The screen is updated to show a list of databases on the target server. From here, you can select a database that will be the target of the migration.

1. You should see the **Social** database that you created during the setup exercise, and it should be selected by default. Select **Next** to proceed to the next step.

    ![Social database selected as a target](../media/6-03-select-target.png)

## Select objects to migrate and deploy the schema

In this step, you can select the database objects that you want to migrate and deselect the ones you don't. In this exercise, we only have one object, the table `dbo.Twitters`.

1. Select the **dbo.Twitters** line, and you'll see there are no issues found for this object. This is in part because we fixed any issues during the assessment phase of the migration.

    ![Selected object with no issues](../media/6-04-select-objects.png)

1. Select **Generate SQL script** to proceed. This step generates a T-SQL script that will re-create the selected database objects on the target server. Note the warning provided about SQL logins that might have been selected as part of the migration.

    ![Generated script for a schema](../media/6-05-deploy-schema.png)

1. Select **Deploy Schema** to deploy the schema to the target server.

    After the target database is updated, it displays the results on the right.

    ![Deployment results](../media/6-06-deploy-results.png)

You have now completed the schema migration and can close Data Migration Assistant.
