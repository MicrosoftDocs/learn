Before you can write queries and explore the sales data, you need to connect to a database that holds this data.

To complete the exercises in this module, you need one of the following accounts:

- A Microsoft account or a Microsoft Entra user identity to create a free cluster. You don't require an Azure subscription or a credit card.
- An Azure account. If you don't already have an Azure account, [create a free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Connect to the data

In this exercise, you use the Azure Data Explorer web interface to connect to the data. However, you can also use the Kusto Query Language itself in Azure Monitor Logs, Azure Sentinel, and other services. You only need to connect once. Then, continue to use this data connection for all queries throughout this module.

1. Use your Azure account to sign in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/).
1. In the left pane, select the  **+ Add** dropdown, and then select **Connection**.
1. Under **Connection URI**, enter **help**, and then select **Add**.

    :::image type="content" source="../media/3-add-cluster.png" alt-text="Screenshot that shows how to add the 'help' cluster, which contains sample data, on the Azure Data Explorer web UI.":::

Now you're connected to the help cluster.

### Select the database

Queries always run in the context of a database, so you need to connect to a specific database.

1. On the left pane, expand the **help** cluster.
1. Select the **ContosoSales** database to give your queries the correct context.

    :::image type="content" source="../media/3-help-cluster.png" alt-text="Screenshot that shows the 'help' cluster organization.":::

1. If you expand the **ContosoSales** database, you see a list of tables below the database. You're going to use the *Customers*, *Products*, and *SalesFact* tables.

Now you're ready to run queries on these tables, and in the exercises in the following units, you do just that.
