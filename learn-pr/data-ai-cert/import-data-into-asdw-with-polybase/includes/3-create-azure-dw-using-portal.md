First, let's create a blank database named **DemoDW** in Azure SQL Data Warehouse.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in creating a blank Azure SQL Data Warehouse.

1. Sign into the [Azure portal](https://portal.azure.com?azure-portal=true).
1. Select **Create a resource** in the upper left-hand corner of the Azure portal.
1. Select **Databases** > **SQL Data Warehouse**.

    ![Screenshots of Creating Azure Data Warehouse](../media/3-create-azure-data-warehouse.png)

1. On the new SQL Data Warehouse page, use the following values for the fields.
    - Set the _Database name_ to "DemoDW".
    - Select the _Subscription_ you want to use.
    - Create a new _Resource group_ named **mslearn-demodw**.
    - Select **Blank database** for the _Source_ - this will create an empty database.

1. Click **Server** to create and configure a new server for your new database. Fill out the **New server form** with the following information:
    - Use a unique name for the DB name - for example, **sampledatawh** with a random number suffix, or your initials.
    - Fill in the admin credentials, we're using **dwdbadmin** for the admin name.
    - Select a _Location_ to physically host the server. Typically this would be a location close to the data consumer.
    
1. Click **Select** to set the server information and go back to the create blade.
1. Select _Performance level_, select Gen2, and change the slider position to be its lowest value - it should be **Gen 2: DW100c**.
1. Click **Apply** to set the performance level. Your settings should look something like the following.

    ![Screenshot of Database settings for new Data Warehouse](../media/3-create-db.png)

1. Click **Create** to provision the database. Provisioning takes a few minutes.

You can monitor the deployment process through the notifications icon. Once it's deployed, you will have successfully created an Azure SQL Data Warehouse!
