Let's create a sample data warehouse in Azure Synapse Analytics with sample data. You need an Azure account to do this exercise.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, read the instructions to understand how to create a new Azure SQL data warehouse.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-port=true).

1. In the upper-left corner, select **+ Create a resource**.

Select **Databases** > **Azure Synapse Analytics (formerly SQL DW)** to start the creation process.

    ![Creating a data warehouse in Azure Synapse Analytics](../media/2-create-sql-dw.png)

1. From the **SQL Data Warehouse** blade, create an Azure Synapse Analytics  with the following settings:

    - Subscription: the name of the subscription you are using in this lab

    - In **Additional setting** tab, under data source, click **Sample**. Clivk on the **Basics** tab

    - Resource group name: **mslearn-demodw**.

    - Database warehouse name: **sampleDataWH**.

    - Server: Create a new server by clicking **Create new** with the following settings and click on **OK**:
        - Server name: **sampledatawhxx**, where **xx** are your initials
        - Server admin login: **dwdbadmin**.
        - Password: **Pa55w.rd**
        - Confirm Password: **Pa55w.rd**
        - Location: choose a **location** near to you.
        - Select the checkbox to Allow Azure services to access server

    ![Creating the Azure Synapse Analytics server](../media/2-select-asdw-server.png)

1. Select **OK** to continue.

1. Select the **Select Performance level** hyperlink to open the **Configure performance** view. The default performance level is **DW1000c**, under **Gen 2**. Move the slider to the left end. The performance level of the server is downgraded to **DW100c**. This level reduces the cost per hour. Click **Apply**.

    ![Selecting performance level](../media/2-select-performance-level.png)

1. Select **Review + Create** at the top of the screen.

1. Select **Create** to start the deployment process.

Deployment takes a few minutes while Azure:

- Provisions a server in a data center.
- Creates a new database.
- Loads the AdventureWorks data into the database.

Select the **Notification** icon on the toolbar to see the progress of the creation. After it deploys, you get a popup notification. Use it to go to the new resource or pin the resource to your dashboard.

![Notification pane](../media/2-click-notification.png)

Select **Go to resource** to open the **Overview** page for your new database.

## View the new database details

Explore the database details on the **Overview** page. To get to this page, use the global search feature or your Azure dashboard.

Here, you can see the traffic that's processing. You also can access various features and configuration options and do common tasks, such as backup or restore on the database.

As an example, the **Server name** and **Connection strings** are two useful items of information you can access on this view.

![Showing the SQL database](../media/2-explore-sql-db.png)

