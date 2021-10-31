Kusto queries can be used to filter data and return specific information.
Recall that the we've returned a specified number of random rows. Here, you will use the `project` operator to return specified columns.

## Use the `project` operator

If you remember, the meteorological data example has quite a few columns. Not all of these columns are meaningful for our exploration, or you want to view these results in a window with limited space. We'll choose just a few columns to view. To do this, we'll use the `project` operator to define which columns we want to see in the output. Multiple column names are separated by commas.

Run the following query:

```kusto
StormEvents
| project EventType, State, DamageProperty, DamageCrops, InjuriesDirect, InjuriesIndirect
| take 10
```

> [!NOTE]
> You may notice that as you type these terms, a list of suggestions appears with possible operators or arguments. This function is called IntelliSense, and will help you write queries faster as well as access supporting documentation for each operator.

:::image type="content" source="../media/4-project-operator.png" alt-text="Screenshot of project operator results.":::

## Rename and define new columns with `project`

You can also use project to rename columns and define new ones. Let's clean up the *InjuriesDirect* and *InjuriesIndirect* columns, and similarly the damage columns. Since these columns are of type int (integer), we can use a numerical operator add the values. We'll also rename the *State* column to specify that these are US states.

To rename or perform numerical operations on operators, we'll use the following syntax in our query:

`project ColumnName=Expression`

```kusto
StormEvents
| project US_State=State, EventType, Injuries=InjuriesDirect+InjuriesIndirect, Damage=DamageCrops+DamageProperty
| take 10
```

:::image type="content" source="../media/4-project-rename.png" alt-text="Screenshot of project operator used to rename columns.":::

## Use the `project away` operator

What if you wanted to just remove a few select columns? For our exploration, we don't have any use for the IDs assigned to each episode and event. Let's remove them using the `project-away` operator, which indicates which columns to *remove*.

Run the following query:

```kusto
StormEvents
| project-away EpisodeId, EventId
| take 10
```

:::image type="content" source="../media/4-project-away-operator.png" alt-text="Screenshot of project away operator":::

In this example, we've removed two columns; *EpisodeId* and *EventId*. This leaves the remaining 20 columns.

## Check your work

To check your results, try scrolling to the far right of the resulting table. Do you see the *StormSummary* column?

