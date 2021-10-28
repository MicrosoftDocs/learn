Kusto queries can be used to filter data and return specific information.
Recall that we've used the `project` operators to filter certain columns.
Here, you will use the `where` operator to filter on a condition.

## Use the `where` operator

Up to this point, all the operators we've used have returned selected columns. Now, let's take a look at specific rows of the data.

The `where` operator filters results that satisfy a certain condition. In this first example, we'll compare an integer column to a minimum value using the numerical operator *greater than* (>). Specifically, we only want to see storms that damaged crops. 

Run the following query:

```kusto
StormEvents
| where DamageCrops > 0
| project State, EventType, DamageCrops
| take 10
```

:::image type="content" source="../media/5-where-1.png" alt-text="Screenshot of where operator.":::

Notice that the all rows returned do, in fact, have DamageCrops values greater than zero. 

## Filter using string operators

It looks like there are quite a few types of damage-causing storms, occurring all over the US. Let's narrow that down to storms that happened in a certain location. 

- Filter based on a certain value in the column(s)
- Used together with other operators, for example string operators

- Filter to return certain kinds of storms (e.g. including the word "wind" or "flood")


> [!NOTE]
> Values can be defined as different data types, so you might need to cast them to a different data type in order to perform comparisons on the correct type.
>
> For example, the SecurityEvent Level column is of type String, so you must cast it to a numerical type, such as int or long, before you can use numerical operators on it, as shown here: SecurityEvent | where toint(Level) >= 10

