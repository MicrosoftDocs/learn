Kusto queries can be used to filter data and return specific information.
Recall that we've used filter certain columns in or out of the displayed results.
Here, you will use the `where` operator to filter on a condition.

## Use the `where` operator

Up to this point, all the operators we've used have returned selected columns. Now, let's take a look at specific rows of the data.

The `where` operator filters results that satisfy a certain condition. In this first example, we'll compare an integer column to a minimum value using the numerical operator *greater than* (>). Specifically, we only want to see storms that damaged property, so we'll look at rows of data where the damage property is greater than zero.

1. Run the following query:

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | project State, EventType, DamageProperty
    | take 10
    ```
    
    :::image type="content" source="../media/5-where-1.png" alt-text="Screenshot of where operator.":::
    
    Notice that the all rows returned do, in fact, have *DamageProperty* values greater than zero.
    
1. Similarly, you could filter where the time of an event occurred more than a number of days ago, for example in the following query:

    ```kusto
    StormEvents
    | where DamageProperty > 0
    | where StartTime > ago(365d)
    | project State, EventType, DamageProperty
    ```
    
    This query returns no results. Since the data is from 2007, there are no records from the past year. 
    
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

### Filter using the `has` operator

Looking at the results of the last query, we see that one of the Event Types is called "Thunderstorm Wind". Let's see if there are any other kinds of wind that caused property damage in Florida. We can do this by searching on a string match of "wind" using the `has` operator. The `has` operator is a case-insensitive search that matches on a full term.

Run the following query:

```kusto
StormEvents
| where DamageProperty > 0
| where State == "FLORIDA"
| where EventType has "wind"
| project StartTime, EventType, DamageProperty
```

:::image type="content" source="../media/5-where-has.png" alt-text="Screenshot of where and has operators.":::

Notice in the results that we no longer see events such as tornados, but we do see Thunderstorm Wind and Strong Wind event types.

## Filter on datetime values

Maybe we only care about damage done in the first half of the calendar year. In fact, we often want to limit our search to see events within a specific time range. Some interfaces with KQL have a dropdown time picker, but others require you to incorporate the date into the query itself.

> [!TIP]
> Ever heard the phrase, "you can't compare apples to oranges?" The same is true of data types. In order to compare or combine two different data types, you may need to change the data type of one of those input fields.
>
> For example, when we search on a datetime field, we have to input a datetime value for our boundary reference value. To do this, we use the `datetime()` function, which converts the date within the parentheses to a datetime value.

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

>[!TIP]
> Notice that all the dates are within the first half of the year, months 1-6. You may also see that even though we've selected events from the state of Florida, we don't see the state as an output column, since it was not specified in the `project` operator.