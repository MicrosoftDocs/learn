In this unit, you create a parameter to filter dashboard visualizations. 

## Create a parameter

First, you need to switch from viewing mode to editing mode.

1. Select **Viewing** and toggle the mode to **Editing**.

    :::image type="content" source="../media/8-editing mode.png" alt-text="Screenshot of switching to editing mode.":::

1. In the top menu bar, select **[@] Parameters**. The **Parameters** pane opens.
1. Select **+ New parameter**
1. Fill out the parameter options in the **Add parameter** pane as follows:

    :::image type="content" source="../media/9-parameter-options.png" alt-text="Screenshot of parameter options.":::

    |Field  |Description | Suggested value |
    |---------|---------| ---|
    |**Label**|The name of the parameter shown on the dashboard or the edit card.| State
    |**Parameter type**|**Single selection**: Only one value can be selected in the filter as input for the parameter.<br>**Multiple selection**: One or more values can be selected in the filter as input(s) for the parameter.<br>**Time range**: Filter the queries and dashboards based on time.<br>**Free text**: The user can type a value or copy/paste a value to the text field. | Multiple selection
    |**Variable name**|The name of the parameter to be used in the query.| _state
    |**Data type**|The data type of the parameter values.| string
    |**Show on pages**|Select the pages where this parameter is displayed. | Select all
    |**Source**|**Fixed values**: Manually introduced static filter values. <br>**Query**: Dynamically introduced values using a KQL query.| [Query](#edit-parameter-source-query)
    | Data source | The source of a query-based parameter. See [Edit query](#edit-parameter-source-query). |

### Edit parameter source query

You need to create a list of possible values for this parameter. The parameter you're creating is called *State*. You want to use it to filter the results based on the state in which the event occurred. You could manually enter a list of all possible states, however, it's simpler to use a query that returns this list dynamically.

1. In **Data source**, select the *Samples* database.
1. In the **Query results** field, select **Edit query**.
1. Copy/paste the following query into the editor:

    ```kusto
    StormEvents
    | distinct (State)
    ```

1. Select **Run**. This query returns a list of all the different values in the column *State*.

    :::image type="content" source="../media/9-edit-query.png" alt-text="Screenshot of editing query for parameter.":::

1. Select **Add** to return to the **Add Parameter** dialog.
1. Select the **Default value** dropdown and select one of the states (for example, *Minnesota*).

    :::image type="content" source="../media/9-add-query.png" alt-text="Screenshot of source to add query.":::

1. Select **Done**.

## Edit both tile queries to include a parameter

You created a parameter, but your dashboard looks the same. You need to use the parameter in the query that generates a visual.

### Events by date

1. In the **Events by date** tile, select the pencil icon.

    :::image type="content" source="../media/9-edit-tile-query.png" alt-text="Screenshot of editing the query in the tile.":::

1. Use the **variable name** defined in the parameter options as a filter in the query. In this case, the variable name is *state*. Edit the query to include the following line:

    ```kusto
    | where State has_any (_state)
    ```  

    Your query should look like the following image:

    :::image type="content" source="../media/9-add-parameter-to-query.png" alt-text="Screenshot of editing the query to add parameter.":::

1. Select **Apply changes**.

### Event count by state

1. In the **Event count by state** tile, select the pencil icon.
1. Edit the query to include the following line:

    ```kusto
    | where State has_any (_state)
    ```  

    Your query should look like the following image: 

    :::image type="content" source="../media/7-add-parameter-second-query.png" alt-text="Screenshot of query in dashboard visual including parameter.":::

1. Select **Apply changes**.

## Use the parameter

Select the **State** parameter, and then select one of the options on the dropdown menu, for example **TEXAS**. Be sure and uncheck the default value, so that only one state is selected. Notice how the visualizations change to display only data associated with the selected state.

:::image type="content" source="../media/9-use-parameter.gif" alt-text="Animated gif showing how to use the parameter picker.":::
