Let's create a sample data warehouse in Azure with sample data. You will need an Azure account to go through this exercise.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, you can read through the instructions to understand the steps involved in creating a new Azure SQL Data Warehouse.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-port=true).

1. Select **Create a resource** from the left sidebar.
1. Select **Databases** > **SQL Data Warehouse** to start the creation process.

    ![Screenshot of Creating a SQL Data Warehouse](../media/2-create-sql-dw.png)

1. Give the database a name, for example **demodW**. 

1. Select a Subscription to own the database - ideally select one with available Azure credit to avoid any cost to your account.

1. Create a new resource group named **mslearn-demodw** so you can cleanup everything at the end of this module.

1. Expand the _Select source_ drop-down list and choose **Sample**. 
1. Next, expand the _Select sample_ drop-down list and select **AdventureWorksDW**. 

    > These two options will create the Azure service to deploy the traditional *AdventureWorksDW* sample database to our ASDW server.

1. Select the _Server_ field to expand the server configuration blade. We will create a new server here, but in a production system you might select an existing database server to share the physical resources.
1. Click the **Create a new server** button to open the **New server** blade if it's not visible already.
    1. Provide a valid _Server name_. Use **demo-dw-server**. This will make the full name of the server `demo-dw-server.database.windows.net`.

1. Enter a valid username and password for the Server admin login.

1. Choose a _Location_ from the drop-down list to decide the data center where the hardware will be located. You will often want this to be close to the primary users of the database.

1. Make sure the "Allow Azure services to access server" checkbox is selected.

    ![Screenshot of Choosing ASDW Server](../media/2-select-asdw-server.png)

1. Click the **Select** button to continue.

1. Click the _Performance level_ entry to expand the **Configure performance** blade. The default performance level is DW1000c, Under Gen 2. Draw the slider to the left end. Then the performance level of the server will be downgraded to **DW100c**; this will reduce the cost per hour. 

    ![Screenshot of Selecting Performance Level](../media/2-select-performance-level.png)

1. Click **Apply** to continue.

1. Click the **Create** button to start the deployment process.

This deployment will take a few minutes. Azure is doing several things:

1. Provisioning a server in a data center
1. Creating a new database
1. Loading the AdventureWorks data into the database

You can click the **Notification icon** on the toolbar to observe the progress of the creation. Once it's deployed, you will get a popup notification allowing you to navigate to the new resource or pin the resource to your dashboard.

![Screenshot of the notification panel](../media/2-click-notification.png)

Click **Go to the resource** to open the **Overview** page for your new database.

## View the new database details

You can explore the database details on the **Overview** page. In the future, you can get to this through the global search feature or your Azure dashboard.

Here, you can get a view of the traffic being processed, access various features and configuration options, and perform common tasks such as backup/restore on the DB.

As an example, the "Server name" and "Connection strings" are two useful bits of information you can access on this view.

![Screenshot of Showing SQL Database](../media/2-explore-sql-db.png)

