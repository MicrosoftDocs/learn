A Kusto query can be used to explore datasets and gain insights. Recall that you have an unfamiliar meteorological dataset and want to explore what you can learn from this data. 

Here, you'll look at the structure of the data to understand what kinds of questions you can ask about these storm events.

## Write your first query

Let's take a look at a sample of the data so you can get to know the columns and types of data in the table. You don't need to see all rows, just a few examples.

The `take` operator is perfect for this task, because it returns a specific number of arbitrary rows. 

1. Copy this query to your clipboard:

    ```kusto
    StormEvents
    | take 5
    ```
    
1. Paste in the query editor that you set up earlier.
1. Notice that the query begins with a reference to the data table, **StormEvents**. This data is piped into the first and only operator, which then selects five arbitrary rows.

1. Run the query by either selecting the **Run** button above the query window or selecting **Shift**+**Enter** on the keyboard.

1. Check that your results are similar to the following example. The actual data in the rows might differ because it's selected arbitrarily.

    :::image type="content" source="../media/3-take-5.png" alt-text="Screenshot of query output.":::

## Explore the results

What do you notice about the results? Scroll all the way to the right of the dataset and take a look. Here are a few takeaways: 

* Each event has a start and end time, from the year 2007.
* The **EventType** column shows different kinds of storms.
* The state (in the **State** column) where each storm occurred is written in all capital letters.
* The damages associated with each storm are found in two separate columns: **DamageProperty** and **DamageCrops**.

