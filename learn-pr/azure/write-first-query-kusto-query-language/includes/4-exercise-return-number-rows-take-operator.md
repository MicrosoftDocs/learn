A Kusto query can be used to explore datasets and gain insights. Recall that we have an unfamiliar meteorological dataset and want to explore what we can learn from this data. 
Here, we'll look at the structure of this data to understand what kinds of questions we can ask about these storm events.

## Write your first query

Let's take a look at a sample of the data to get to know the columns and types of data in the table. We don't need to see all rows, just a few examples.

The `take` operator is perfect for this task, as it returns a specific number of arbitrary rows. 

1. Copy this query to your clipboard and paste in the query editor of your sample environment. 

    ```kusto
    StormEvents
    | take 5
    ```
    
1. Notice that the query begins with a reference to the data table, *StormEvents*. This data is piped into the first and only operator, which then selects five arbitrary rows.

1. Run the query by either selecting the **Run** button above the query window or by pressing **Shift+Enter**.

1. Check that your results are similar to the following example, though the actual data in the rows may differ because they are selected arbitrarily.

    :::image type="content" source="../media/3-take-5.png" alt-text="Screenshot of take five outputs.":::

## Explore the results

What do you notice about the results? Scroll all the way to the right of the dataset and take a look. Here are a few takeaways: 

* Each event has a start and end time, from the year 2007.
* The **EventType** column shows different kinds of storms.
* The **State** in which each storm occurred is written in all capital letters.
* The damages associated with each storm are found in two separate columns: **DamageProperty** and **DamageCrops**.

