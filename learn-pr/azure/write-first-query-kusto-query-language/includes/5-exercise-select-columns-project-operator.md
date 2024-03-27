You can use Kusto queries to filter data and return specific information.

Recall that you've looked at arbitrary rows of data to get a sense of its structure. In this unit, you'll learn how to choose specific data columns that relate to storm types, locations, and damaging effects.

## Use the `project` operator

If you remember, the meteorological data example has quite a few columns. Not all of these columns are meaningful for this exploration. You'll choose just a few columns to view. You'll use the `project` operator to define which columns you want to see in the output. Column names are separated by commas.

1. Run the following query. This query names the columns to return and their order within the `project` operator.
    
    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKCjKz0pNLlEAC4RUFqTqKASXJJYAKZfE3MT01ICi/ILUopJKGN8ZyC/WUfDMyyotykwtdsksAupG8D3zUsAiQJNLErNTFQwNAObMrGFvAAAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | project EventType, State, DamageProperty, DamageCrops, InjuriesDirect, InjuriesIndirect
    | take 10
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/4-project-operator.png" alt-text="Screenshot of project operator results with six columns.":::

1. Notice that only the columns mentioned in the `project` operator appear in the output.

## Rename and define new columns by using `project`

To understand the impacts of storms in US states, you want to get the total number of injuries and the total amount of damage. With the `project` operator, you can sum integer values from different columns and return the results in a new column. You can also rename columns to make them more meaningful to your analysis.

For example, there are other countries/regions with states. It might be helpful to rename the state column so it's clear that the results are for US states. Let's see how to change your previous query so you get the total number of injuries and amount of damage for US states.

1. Update your previous query to make a new column that shows the sum of **InjuriesDirect** and **InjuriesIndirect**:

   `Injuries=InjuriesDirect+InjuriesIndirect`

1. Do the same for the two types of damage columns by adding together damage to crops and damage to property:

   `Damage=DamageCrops+DamageProperty`

1. Hover over the column name in the query editor to see the data type contained in the columns. You can use a numerical operator to add the values because these columns are of type `int` (integer).

    :::image type="content" source="../media/4-data-type.png" alt-text="Screenshot of the data type in a query editor.":::

1. Rename the **State** column to **US_State**:

   `US_State=State`

1. Review your updated query and run it. The full query includes calculations for injuries, calculations for damages, and renaming the **State** column.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKCjKz0pNLlEIDY4PLkksSbUFkzoKYAUhlQVApmdeVmlRZmqxLYzhklkE1KIN43rmpYAFdBRcEnMT01NtIZRzUX5BsTaEHQBkpxaVVAItLEnMTlUwNAAA4HKT7IYAAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | project US_State=State, EventType, Injuries=InjuriesDirect+InjuriesIndirect, Damage=DamageCrops+DamageProperty
    | take 10
    ```

1. You should get results that look like the following image:

    :::image type="content" source="../media/4-project-rename.png" alt-text="Screenshot of query results for a project operator that renames columns.":::

1. Notice that the **State** column has been renamed to **US_State**. The **Injuries** column is new, and has been calculated as the sum of **InjuriesDirect** and **InjuriesIndirect**. The **Damage** column is also new, and has been calculated as the sum of **DamageCrops** and **DamageProperty**.

## Use the `project-away` operator

What if you want to remove a few select columns? For this exploration, you don't have any use for the IDs assigned to each episode and event. You can remove specific columns by using the `project-away` operator, which indicates which columns to remove while leaving all remaining columns. You can also use a wildcard, such as `| project-away *Id`, to remove all columns that end in **Id**.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKCjKz0pNLtFNLE+sVHAtyCzOT0n1TNFRACvwTAGqKEnMTlUwNAAA891eCDcAAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | project-away EpisodeId, EventId
    | take 10
    ```

1. Check your results. Recall that the **EpisodeId** and **EventId** columns were between the **EndTime** and **State** columns. Which of these columns do you see in the output?
