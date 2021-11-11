Before you can write queries and explore the meteorological data, you need to connect to a database that holds this data.

To complete the exercises in this module, you need an Azure account.  If you don't have an Azure account, create a [free account](https://azure.microsoft.com/free/?azure-portal=true) before you begin.

## Connect to the data

In this example, we'll use the Azure Data Explorer web interface. However, the Kusto Query Language itself can also be used in Log Analytics, Azure Sentinel, and other services. You'll only need to connect once, and we'll continue to use this data connection for all queries in the following units.

1. Use your Azure account to sign in to the [Azure Data Explorer Web UI](https://dataexplorer.azure.com/).
1. In the left pane, select **Add Cluster**.
1. In the dialog box, under **Connection URI**, enter *help*.
1. Select **Add**.

:::image type="content" source="../media/3-add-cluster.png" alt-text="Screenshot of add help cluster in Azure Data Explorer Web UI.":::

### Select the database

Now you're connected to the help cluster. Queries always run in the context of a database, so you need to connect to a specific database.

1. Expand the help cluster in the left pane.
1. Select the **Samples** database to complete the connection to the correct destination. You may notice the list of tables below the database; we'll be using the *StormEvents* table.

:::image type="content" source="../media/3-help-cluster.png" alt-text="Screenshot of help cluster organization.":::
