Kusto queries can be used to filter data and return specific information.
Recall that the we've returned a specified number of random rows to see what kind information you have for each storm event. In this unit, you want to see specific columns relating to storm events, locations, and their damaging effects.

## Use the `project` operator

If you remember, the meteorological data example has quite a few columns. Not all of these columns are meaningful for our exploration, or you want to view these results in a window with limited space. We'll choose just a few columns to view. To do this, we'll use the `project` operator to define which columns we want to see in the output. Multiple column names are separated by commas.

1. Run the following query:
    
    ```kusto
    StormEvents
    | project EventType, State, DamageProperty, DamageCrops, InjuriesDirect, InjuriesIndirect
    | take 10
    ```

1. You should get results that look like the following image: 

    :::image type="content" source="../media/4-project-operator.png" alt-text="Screenshot of project operator results.":::

1. Notice that only the columns mentioned in the `project` operator appear in the output.

## Rename and define new columns with `project`

You can also use project to rename columns and define new ones. We don't really care about the distinction between *InjuriesDirect* and *InjuriesIndirect*. It would be more useful to just know the total number of injuries. Let's make a new column that shows this sum. We'll do the same for the two types of damage columns by adding together damages to crops and damages to property.

Since these columns are of type int (integer), we can use a numerical operator add the values. We'll also rename the *State* column to specify that these are US states.

If you hover on a column name in the query editor, you can see the type of data contained in this column. 

:::image type="content" source="../media/4-data-type.png" alt-text="Screenshot of datatype in query editor.":::

To rename or perform numerical operations on operators, we'll use the following syntax in our query:

`project ColumnName=Expression`

> [!NOTE]
> You can also use the equivalent `extend` operator to create calculated columns.

1. Run the following query:
    
    ```kusto
    StormEvents
    | project US_State=State, EventType, Injuries=InjuriesDirect+InjuriesIndirect, Damage=DamageCrops+DamageProperty
    | take 10
    ```
    
1.  You should get results that look like the following image:

    :::image type="content" source="../media/4-project-rename.png" alt-text="Screenshot of project operator used to rename columns.":::

1. Notice that the *State* column has been renamed to *US_State*. The *Damage* column is new, and has been calculated as the sum of *DamageCrops* and *DamageProperty*.

## Use the `project-away` operator

What if you wanted to just remove a few select columns? For our exploration, we don't have any use for the IDs assigned to each episode and event. You can remove specific columns using the `project-away` operator, which indicates which columns to *remove*, while leaving all remaining columns.

1. Run the following query: 

    ```kusto
    StormEvents
    | project-away EpisodeId, EventId
    | take 10
    ```

1. To check your results, try scrolling to the far right of the resulting table. Do you see the *StormSummary* column?
