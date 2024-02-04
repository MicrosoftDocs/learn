Before you can write queries and explore the meteorological data, you need to connect to a database that holds this data.

To complete the exercises in this module, you need an Azure account. If you don't have an Azure account, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Connect to the data

You'll use the Azure Data Explorer web interface to connect to the data. However, you can also use the Kusto Query Language itself in Log Analytics, Azure Sentinel, and other services. You'll only need to connect once, and you'll continue to use this data connection for all queries in the following units.

1. Use your Azure account to sign in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/).
1. In the left pane, select **Query**.
1. Select the **Add** button at the top of the tab, then select **Connection**.
1. In the dialog box, under **Connection URI**, enter *help*.
1. Select **Add**.

   :::image type="content" source="../media/3-add-cluster.png" alt-text="Screenshot of add help cluster in Azure Data Explorer web U I.":::

Now you're connected to the help cluster.

### Select the database

Queries always run in the context of a database, so you need to connect to a specific database.

1. Expand the **help** cluster in the left pane.
1. Select the **Samples** database to give your queries the correct context.

    :::image type="content" source="../media/3-help-cluster.png" alt-text="Screenshot of help cluster organization.":::

1. If you expand the **Samples** database, **Tables**, and the **Storm_Events** folder, you'll see a list of tables below the database; we'll be using the *StormEvents* table.

Now, you're ready to run queries on the *StormEvents* table. You'll do that in the following exercise.
