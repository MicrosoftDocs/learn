Kusto queries can be used to filter data and return specific information.
Recall that we've used filter certain columns in or out of the displayed results.
Here, you will use the `where` operator to filter on a condition.

## Use the `where` operator

Up to this point, all the operators we've used have returned selected columns. Now, let's take a look at specific rows of the data.

The `where` operator filters results that satisfy a certain condition. In this first example, we'll compare an integer column to a minimum value using the numerical operator *greater than* (>). Specifically, we only want to see storms that damaged property, so we'll look at rows of data where the damage property is greater than zero.

Run the following query:

```kusto
StormEvents
| where DamageProperty > 0
| project State, EventType, DamageProperty
| take 10
```

:::image type="content" source="../media/5-where-1.png" alt-text="Screenshot of where operator.":::

Notice that the all rows returned do, in fact, have *DamageProperty* values greater than zero.

## Filter using string operators

It looks like there are quite a few types of damage-causing storms, occurring all over the US. Let's narrow that down to storms that happened in a certain location, like the state of Florida. 

Run the following query:

```kusto
StormEvents
| where DamageCrops > 0
| where State == "FLORIDA"
| project State, EventType, DamageCrops
```

:::image type="content" source="../media/5-where-2.png" alt-text="Screenshot of where operator example 2.":::

As you can see, there are 200 records returned from this query, all of them from Florida, and having property damage greater than zero.

## Filter on datetime values

Maybe we only care about damage done in the first half of the calendar year. In fact, we often want to limit our search to a specific time range. Some interfaces with KQL have a dropdown time picker, but others require you to incorporate the date into the query itself.

Run the following query:

```kusto
StormEvents
| where StartTime between (datetime(2007-01-01)..datetime(2007-06-01))
| where DamageProperty > 0
| where State == "FLORIDA"
| project StartTime, EventType, DamageProperty
| take 50
```

:::image type="content" source="../media/5-where-3.png" alt-text="Screenshot of where operator example 3.":::

> [!TIP]
> You might need to cast either your input conditions or your data values to a different data type in order to perform comparisons between values.
>
> For example, when we search on a datetime field, we have to input a datetime value as shown in the query above.
> 
>If you hover on a column name in the query editor, you can see the type of data contained in this column. 
>
> :::image type="content" source="../media/5-where-4.png" alt-text="Screenshot of datatype in query editor.":::


## Check your work

