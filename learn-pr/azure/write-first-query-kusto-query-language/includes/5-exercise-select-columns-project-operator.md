Kusto queries can be used to filter data and return specific information.
Recall that we've looked at random rows of data to get a sense of its structure. In this unit, you will learn how to choose specific data columns relating to storm types, locations, and their damaging effects.

## Use the `project` operator

If you remember, the meteorological data example has quite a few columns. Not all of these columns are meaningful for our exploration. We'll choose just a few columns to view. We'll use the `project` operator to define which columns we want to see in the output. Multiple column names are separated by commas.

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

You can also use `project` to rename columns and define new ones. We don't really care about the distinction between *InjuriesDirect* and *InjuriesIndirect*. It would be more useful to just know the total number of injuries. Let's make a new column that shows this sum. We'll do the same for the two types of damage columns by adding together damages to crops and damages to property.

If you hover on a column name in the query editor, you can see the type of data contained in this column. 

   :::image type="content" source="../media/4-data-type.png" alt-text="Screenshot of datatype in query editor.":::

Since these columns are of type `int` (integer), we can use a numerical operator to add the values. We'll also rename the *State* column.

To rename or perform numerical operations on arguments, we'll use the following syntax in our query:

`project ColumnName=Expression`

> [!NOTE]
> The `extend` operator can also be used to create calculated columns. `extend` creates new calculated columns, appends these calculated columns to the results set, and overrides existing columns with the same names.

1. Run the following query:
    
    ```kusto
    StormEvents
    | project US_State=State, EventType, Injuries=InjuriesDirect+InjuriesIndirect, Damage=DamageCrops+DamageProperty
    | take 10
    ```
    
1.  You should get results that look like the following image:

    :::image type="content" source="../media/4-project-rename.png" alt-text="Screenshot of project operator used to rename columns.":::

1. Notice that the *State* column has been renamed to *US_State*. The *Injuries* column is new, and has been calculated as the sum of *InjuriesDirect* and *InjuriesIndirect*. The *Damage* column is also new, and has been calculated as the sum of *DamageCrops* and *DamageProperty*.

## Use the `project-away` operator

What if you wanted to just remove a few select columns? For our exploration, we don't have any use for the IDs assigned to each episode and event. You can remove specific columns using the `project-away` operator, which indicates which columns to *remove*, while leaving all remaining columns. You can also use a wildcard, such as: `|project-away *ID` to remove all columns ending in `ID`.

1. Run the following query:

    ```kusto
    StormEvents
    | project-away EpisodeId, EventId
    | take 10
    ```

1. Check your results. Recall that the *EpisodeID* and *EventID* columns were between the *EndTime* and *State* columns. Which of these columns do you see in the output?
