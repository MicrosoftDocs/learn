Let's create a sample data warehouse in Azure Synapse Analytics with sample data. You need an Azure account to do this exercise.

> [!NOTE]
> This exercise is optional. If you don't have an Azure account, or prefer not to do the exercise in your account, read the instructions to understand how to create a new Azure SQL data warehouse.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-port=true).

1. Select **Create a resource**.

1. Select **Databases**, search for and select **Azure Synapse Analytics** to start the creation process.

    ![Creating a data warehouse in Azure Synapse Analytics](../media/2-create-sql-dw.png)

    The **Azure Synapse Analytics** pane appears.

1. Select **Create**. The **Create Synapse workspace** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project details** |
    | Subscription | Select a Subscription |
    | Resource group | Select or create a resource group |
    | Managed resource group | Enter *mslearn-demodw* |
    | **Workspace details** |
    | Workspace name | Enter *sampledatawhxx*  |
    | Region | Select a location close to you |
    | Select Data Lake Storage Gen2 | **From subscription** |
    | Account name | Enter *sampledatawhxx*, where **xx** are your initials |
    | File system name | Enter *demodwxx*, where **xx** are your initials |

1. Select **Next:Security**.

1. On the **Security** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **SQL administrator credentials** |
    | Admin username | sqladminuser |
    | Password | **Pa55w.rd** |
    | Confirm password | **Pa55w.rd** |
    
1. Select **Review + create**.

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
