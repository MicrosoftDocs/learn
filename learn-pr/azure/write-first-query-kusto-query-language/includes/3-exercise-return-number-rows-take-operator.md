A Kusto query can be used to explore datasets and gain insights. 

Recall that we have a meterological dataset of which we are unfamiliar, and want to explore what we can learn from this data.

Here, we'll look at the structure of this data table using the `take` operator.

## Connect to the data

In this example, we'll use the Azure Data Explorer web interface. However, Kusto Query Language can also be used in Log Analytics, Azure Sentinel, and other workspaces.

1. Sign in to the [Azure Data Explorer Web UI](https://dataexplorer.azure.com/)
1. In the left pane, select **Add Cluster**
1. In the dialog box, under **Connection URI**, enter *help*.
1. Select **Add**.

:::image type="content" source="../media/3-add-cluster.png" alt-text="Screenshot of add help cluster in Azure Data Explorer Web UI.":::

### Select the database

Now you're connected to the help cluster. If you expand the help cluster in the left pane, you will see the **Samples** database. Under this database is a list of several tables. We're going to use the **StormEvents** table.

:::image type="content" source="../media/3-help-cluster.png" alt-text="Screenshot of help cluster organization.":::

1. Select the **Samples** database to complete the connection to the correct destination. Now you're ready to start exploring data.

## Write your first query

Let's take a look at a sample of the data in order to get to know the columns and types of data in the table. We don't need to see all rows for this, just a few examples.

The `take` operator is perfect, as it returns a specified number of random rows. You can copy this query to your clipboard and run in your sample environment. Since the rows are selected at random, you will probably see different data than is displayed below.

```kusto
StormEvents
| take 5
```

Notice that the query begins with a reference to the data table, *StormEvents*. This data is piped into the first (and only) operator, which then selects five rows at random. 

To run the query, either select the **Run** button above the query window, or press **Shift+Enter**.

:::image type="content" source="../media/3-take-5.png" alt-text="Screenshot of take 5 output.":::

## Explore the results

What do you notice about the results? Scroll all the way to the right of the dataset and take a look. Here are a few takeaways: 

* Each event has a start and end time, from the year 2007.
* The **EventType** column shows different kinds of storms.
* The **State** in which each storm occurred is written in all capital letters.
* The damages associated with each storm are found in two separate columns: **DamageProperty** and **DamageCrops**.

