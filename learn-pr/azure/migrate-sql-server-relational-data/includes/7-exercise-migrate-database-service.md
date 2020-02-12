In this exercise, you will migrate the data in your database using the Azure Data Migration Service. This is a two-step process. First, you'll need to create a new instance of a Database Migration Service. Once it has been created, within it you will create a new migration project.

## Create The Database Migration Service

1. Open the [Azure Portal](https://portal.azure.com?azure-portal=true) in a new tab, then select **+ Create a resource**.

1. In the **Search the Marketplace** box search for **Azure Database Migration Service** and select **Create**.

    ![Create an Azure Database Migration Service Project](../media/7-01-create-adms.png)

1. In the basics tab, select your subscription.

1. Next, select **admsdemorg** for the resource group.

1. Under Instance details, use **admsdemodms** for the service name.

1. Change the location to the same region your resources were deployed to.

1. Accept the rest of the defaults, then select **Next:Networking**.

    ![Basics Tab](../media/7-02-basics.png)

1. Select **admsdemo-vnet/default**, then select **Review + create**.

    ![Networking Tab](../media/7-03-networking.png)

    Select **Create** to create the new Database Migration Service.

   ![Create Service](../media/7-04-create-service.png)

1. Wait for the deployment to complete. Once done, select **Go to resource**. 

   ![Deploy Complete](../media/7-05-deploy-complete.png)

## Create a Migration Project

Now that the service has been created, you will create a project in the service to migrate the database.

1. In the migration project, select **New Migration Project**.

    ![Deploy Complete](../media/7-06-new-migration-project.png)

1. Enter **AdmsDemoDMS** for the Project Name.

1. Take the defaults for the Source and Target server types.

1. For the type of activity you will be doing the default, **Offline data migration**.

1. Select **Create and run activity**.

    ![Deploy Complete](../media/7-07-new-project.png)

1. Next, you will fill out the information on the source, in this case the virtual machine. For the Source SQL Server instance name, enter **admsdemovm**.

1. You can use Windows Authentication to connect to the virtual machine.

1. For the user name, use **admsdemovm\windowsadmin**.

1. Enter the password for the **windowsadmin** account.

1. Ensure the **Encrypt connection** box is checked, as well as the **Trust server certificate**.

1. Select **Save**.

    ![Source Details](../media/7-08-source-details.png)

1. Next, you need to supply information to the target, the Azure SQL Database. If you didn't write it down earlier, you can look it up by going to the resource group page. As an example, it will look something like **admsdemosqlvsm4cdzuubghw.database.windows.net**. The string between _admsdemosql_ and _.database.windows.net_ will vary, as it is dynamically generated when the environment setup is executed.

1. For the authentication type, use **SQL Authentication**.

1. Enter **azuresqladmin** for the user name and enter the password for this account.

1. Ensure the **Encrypt connection** is checked, then select **Save**.

    ![Target Details](../media/7-09-target-details.png)

1. Select **Set Source DB Read-Only**. As a reminder, make sure you are not logged into the database elsewhere, such as from SQL Server Management Studio in the virtual machine, or the migration will fail.

1. Select **Save** to proceed to configure the migration settings.

    ![Map Database](../media/7-10-map-database.png)

1. Select the down arrow next to **Social 1 of 1** to see the list of tables.

1. Make sure the `dbo.Twitters` table is checked, then select **Save**.

    ![Select Tables](../media/7-11-select-tables.png)

1. In the **Activity name** box, enter **MigrateSocialDatabase**.

1. Select **Validation Options**, then select **Do not validate my database(s)**, then select **Save**.

1. Select **Run migration** to start the migration.

    ![Run Migration](../media/7-12-run-migration.png)

1. A new pane will appear showing the status of the migration. Select the **Refresh** button at the top to update the status until it shows the process is complete.

    ![Run Migration](..//media/7-13-completed.png)
