Before you can write queries and explore the meteorological data, you need to connect to a database that holds this data.

To complete the exercises in this module, you need an Azure account.  If you don't have an Azure account, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Connect to the data

In this example, you'll use the Azure Data Explorer web interface as a query editor. However, Kusto Query Language can also be used in Azure Monitor Logs, Azure Sentinel, and other services. You need to connect only once, and you'll continue to use this data connection for all queries in the following units.

1. Use your Azure account to sign in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/).
1. On the left pane, select **Add Cluster**.
1. In the dialog, under **Connection URI**, enter **help**.
1. Select **Add**.

   :::image type="content" source="../media/3-add-cluster.png" alt-text="Screenshot of selections for adding a help cluster in the Azure Data Explorer web user interface.":::

Now you're connected to the help cluster. 

### Select the database

Queries always run in the context of a database, so you need to connect to a specific database.

1. Expand the help cluster on the left pane.
1. Select the **Samples** database to give your queries the correct context.

    :::image type="content" source="../media/3-help-cluster.png" alt-text="Screenshot that shows the organization of the help cluster.":::

1. Expand the **Samples** database, the **Tables** folder, and the **Storm_Events** folder. A list of tables appears. You'll be using the **StormEvents** table.

Now you're ready to run queries on the **StormEvents** table. You'll learn how to do that in the following exercise.
