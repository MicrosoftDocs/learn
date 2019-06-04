Azure SQL Database runs as a cloud service. The simplest way to create a database is to use the Azure portal. You can import data to a database in many different ways, but if you want to insert a large number of rows quickly, use the bulk copy command, **bcp**. Once you have the data in your tables, you can run some queries. The Azure portal provides the Query Editor for defining queries graphically, or you can use the **sqlcmd** utility from the Cloud Shell if you're familiar with SQL.

The educational institute currently stores their data in a series of comma-delimited files. You need to migrate this data to Azure SQL Database.

In this exercise, you'll create an instance of the Azure SQL Database service and a database. Next, you'll create tables and import data into the database. Finally, you'll query the data using the Query Editor and the **sqlcmd** utility.

## Create an Azure SQL Database instance and database

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using your MSLearn account.

1. In the left-hand pane, click **+ Create a resource**, select **Databases**, and then click **SQL Database**.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    ![Screenshot of the New page in the Azure portal showing the Databases options available in the Azure Marketplace](../media/2-new-database-annotated.png)

1. On the **Create SQL Database** page, specify the values in the following table for the properties of the database.

    > [!NOTE]
    > The database must have a unique name. We suggest using something like **coursedatabase*nnn*** where *nnn* is a random number. Use this name wherever you see *\<your-database-name\>* in this exercise.

    | Property  | Value  |
    |---|---|
    | Subscription | Concierge Subscription  |
    | Resource Group | Use the existing resource group |
    | Database name | *\<your-database-name\>* |
    | Server | Click **Create new**, and enter the details shown in the table below |
    | Want to use SQL elastic pool? | No |
    | Compute + storage | Standard S0 |

    For the server, specify the following details in the **New server** pane, and then click **Select**:

    | Property  | Value  |
    |---|---|
    | Server name | courseserver*nnn*  (use the same number that you selected for the database) |
    | Server admin login | azuresql |
    | Password | Pa55w.rd |
    | Confirm password | Pa55w.rd |
    | Location | Accept the default location |
    | Allow Azure services to access server | Selected |

1. Click **Review + create**.

1. Click **Create**, and wait for the server and database to be created before continuing.

## Create the tables

## Import the data

## Query the data
