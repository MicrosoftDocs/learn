Before you can write queries and explore the sales data, you need to connect to a database that holds this data.

To complete the exercises in this module, you need one of the following:

- A Microsoft account or an Azure Active Directory user identity to create a free cluster. You don't require an Azure subscription or a credit card.
- An Azure account. If you don't have an Azure account, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Connect to the data

You'll use the Azure Data Explorer web interface to connect to the data. However, the Kusto Query Language itself can also be used in Azure Monitor Logs, Azure Sentinel, and other services. You'll only need to connect once, and you'll continue to use this data connection for all queries in the following units.

1. Use your Azure account to sign in to the [Azure Data Explorer Web UI](https://dataexplorer.azure.com/).
1. In the left pane, select **Add Cluster**.
1. In the dialog box, under **Connection URI**, enter *help*.
1. Select **Add**.

    :::image type="content" source="../media/3-add-cluster.png" alt-text="Screenshot of add help cluster in Azure Data Explorer Web UI.":::

Now you're connected to the help cluster.

### Select the database

Queries always run in the context of a database, so you need to connect to a specific database.

1. Expand the *help* cluster in the left pane.
1. Select the **ContosoSales** database to give your queries the correct context.

    :::image type="content" source="../media/3-help-cluster.png" alt-text="Screenshot of help cluster organization.":::

1. If you expand the **ContosoSales** database, you'll see a list of tables below the database; we'll be using the *Customers*, *Products*, and *SalesFact* tables.

Now you're ready to run queries on these tables. You'll do that in the following exercises.
