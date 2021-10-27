Kusto queries can be used to filter data and return specific information.
Recall that the `take` operator returned a specified number of random rows. Here, you will use the `project` operator to return specified columns.

## Use the `project` operator

If you remember, the meterological data example has quite a few columns. Not all of these columns are meaningful for our exploration, or you might be using these results in a situation with limited space. We'll choose just a few columns to view. To do this, we'll use the `project` operator, which essentially is like saying "show me the following columns".

Run the following query:

```kusto
StormEvents
| project EventType, State, DamageProperty, DamageCrops
| take 10
```

> [!NOTE]
> You may notice that as you type these terms, a list of suggestions appears with possible operators or arguments. This function is called IntelliSense, and will help you write queries faster as well as access supporting documentation for each operator.

:::image type="content" source="../media/4-project-operator.png" alt-text="Screenshot of project operator results.":::

## Use the `project away` operator

What if you wanted to just remove a few select columns? Use the `project-away` operator, which indicates which columns to *remove*.

Run the following query:

```kusto
StormEvents
| project-away StartTime, EndTime
| take 10
```

:::image type="content" source="../media/4-project-away-operator.png" alt-text="Screenshot of project away operator":::

In this example, we've removed just the first two columns; *StartTime* and *EndTime*. This leaves the remaining 20 columns.

## Check your work

To check your results, try scrolling to the far right of the resulting table. Do you see the *StormSummary* column?

