Now that we've covered a lot of the design principles, let's see how easy it is to create a data warehouse in Azure. We'll use some sample data for exploration, but you can start building your own data warehouses using the same principles shown in this exercise.

Follow these steps to create a SQL data warehouse that contains the *AdventureWorksDW* sample data.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Create a resource** in the upper left-hand corner of the Azure portal.
1. Select **Databases** > **SQL Data Warehouse**.

    ![Screenshots of Creating Azure Data Warehouse](../media/6-create-azure-data-warehouse.png)

1. On the new SQL Data Warehouse page, use the following values for the fields.
    - Set the _Database name_ to "sampleDataWH"
    - Select the _Subscription_ you want to use
    - Create a new _Resource group_ named **mslearn-demodw**

1. Select **Sample** from the _Select source_ dropdown list.

1. Select **AdventureWorksDW** from the _Select sample_ dropdown list

1. Click **Server** to create and configure a new server for your new database. Fill out the **New server form** with the following information:
    - Use a unique name for the DB name, here we're using **sampledatawh** but you will need to select a globally unique name.
    - Fill in the admin credentials, we're using **dwdbadmin** for the admin name.
    - Select a _Location_ to physically host the server. Typically this would be a location close to the data consumer.

1. Click **Select** to set the server information and go back to the create blade.

    ![Screenshot of the New DB server blade](../media/6-create-sql-db.png)

1. Click **Create** to provision the database. Provisioning takes a few minutes.

You can monitor the deployment process through the notifications icon. Once it's deployed you will have successfully created an Azure SQL Data Warehouse!
