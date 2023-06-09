Before you can create dashboards from the sample meteorological data, you need to connect to the data itself. This data is stored in a table within a publically available database. You don't need an Azure account, but you will need an email that's connected to a Microsoft account.

## Connect to the data

You'll use the Azure Data Explorer web interface to connect to the data. You only need to connect once, and you'll continue to use this data connection for all exercises in the following units.

1. Use your Microsoft account to sign in to the [Azure Data Explorer web UI](https://dataexplorer.azure.com/).
1. In the home page, select **Query** from the left menu.

    :::image type="content" source="../media/3-home-page.png" alt-text="Screenshot of ADX homepage.":::

    The query window opens with a connection to the *help* cluster. The query window contains a tutorial, which starts with green commented-out explanations. For this module, you won't be using the built-in tutorial.

    If you are not automatically connected to the *help* cluster, use the following steps:

     1. Select **+Add cluster**
     1. In the **Connection URI**, enter *help*.
     1. Select the blue **Add** button.
     
1. Expand the database by selecting the **>** arrow to the next of the **Samples** database.

    :::image type="content" source="../media/3-query.png" alt-text="Screenshot of query window in ADX.":::

1. You can further expand the **Tables**, and the **Storm_Events** folder to see a list of tables below the database; we'll be using the *StormEvents* table.

    :::image type="content" source="../media/3-tables.png" alt-text="Screenshot of stormevents table.":::

Now you're ready to use data in the *StormEvents* table. You'll do that in the following exercise.