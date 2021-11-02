A Kusto query can be used to explore datasets and gain insights. Recall that we have an unfamiliar meteorological dataset, and want to explore what we can learn from this data. 
Here, we'll look at the structure of this data to understand what kinds of questions we can ask about these storm events.

## Write your first query

Let's take a look at a sample of the data to get to know the columns and types of data in the table. We don't need to see all rows, just a few examples.

The `take` operator is perfect, as it returns a specified number of random rows. 

1. Copy this query to your clipboard and run in your sample environment. 

    ```kusto
    StormEvents
    | take 5
    ```
    
1. Notice that the query begins with a reference to the data table, *StormEvents*. This data is piped into the first and only operator, which then selects five rows at random.

1. To run the query, either select the **Run** button above the query window, or press **Shift+Enter**.

1. You should get results that look like the following image. However, since the rows are selected at random, you will probably see different data than is displayed below.

    :::image type="content" source="../media/3-take-5.png" alt-text="Screenshot of take five outputs.":::

## Explore the results

What do you notice about the results? Scroll all the way to the right of the dataset and take a look. Here are a few takeaways: 

* Each event has a start and end time, from the year 2007.
* The **EventType** column shows different kinds of storms.
* The **State** in which each storm occurred is written in all capital letters.
* The damages associated with each storm are found in two separate columns: **DamageProperty** and **DamageCrops**.

