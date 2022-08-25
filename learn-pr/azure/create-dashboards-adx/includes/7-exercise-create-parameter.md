You've created a dashboard to visualize data insights. In this unit, you'll create a parameter to filter these visualizations. 

## Create a parameter

First, you need to switch from viewing mode to editing mode.

1. Select **Viewing** and toggle the mode to **Editing**.

    :::image type="content" source="../media/8-editing mode.png" alt-text="Screenshot of switching to editing mode.":::

1. In the top menu bar, select **[@] Parameters**. The **Parameters** pane opens to the right. 
1. Select **+ New parameter**
1. Fill out the parameter options as follows:

    :::image type="content" source="../media/9-parameter-options.png" alt-text="Screenshot of parameter options.":::

    |Field  |Description | Suggested value |
    |---------|---------| ---|
    |**Label**|The name of the parameter shown on the dashboard or the edit card.| State
    |**Parameter type**|**Single selection**: Only one value can be selected in the filter as input for the parameter.<br>**Multiple selection**: One or more values can be selected in the filter as input(s) for the parameter.<br>**Time range**: Filter the queries and dashboards based on time.<br>**Free text**: The user can type a value or copy/paste a value to the text field. | Multiple selection
    |**Variable name**|The name of the parameter to be used in the query.| state
    |**Data type**|The data type of the parameter values.| string
    |**Show on pages**|Select the pages where this parameter will be displayed. | Select all
    |**Source**|**Fixed values**: Manually introduced static filter values. <br>**Query**: Dynamically introduced values using a KQL query.| [Query](#edit-query)
    |**Default value**|The default value of the filter. | Select all
    |**Add a "Select all" value**|For single selection and multiple selection types. Used to retrieve data for all the parameter values. This value affects how the query is written. | Checked|

### Edit parameter source query

You need to create a list of possible values for this parameter. The parameter you are creating is called "State", and will be used to filter the results based on the state in which the event occurred. You could manually enter a list of all possible states, however, it's simpler to use a query that will return this list dynamically.

1. In **Data source**, select the *Samples* database.
1. Select **Add query**.
    
    :::image type="content" source="../media/9-add-query.png" alt-text="Screenshot of source to add query.":::

1. Copy/paste the following query into the editor:
    
    ```kusto
    StormEvents
    | distinct (State)
    ```

    This query returns a list of all the different values in the column *State*.

    :::image type="content" source="../media/9-edit-query.png" alt-text="Screenshot of editing query for parameter.":::

1. Select **Done**

## Edit the tile query to include a parameter

You've now created a parameter, but nothing has changed on your dashboard. You need to use the parameter in the query that generates one of your visuals.

1. In the **Events by date** tile, select the pencil icon.

    :::image type="content" source="../media/9-edit-tile-query.png" alt-text="Screenshot of editing the query in the tile.":::

1. You're going to use the **variable name** defined in the parameter options as a filter in the query. In this case, the variable name is *state*. Edit the query to include the following line:

    ```kusto
    | where State has_any (state)
    ```  

    Your query should look like the following image: 

    :::image type="content" source="../media/9-add-parameter-to-query.png" alt-text="Screenshot of editing the query to add parameter.":::
1. Select **Apply changes**.

## Use the parameter

Select the **State** parameter, and then select one of the options on the dropdown menu, for example **TEXAS**. Notice how the visualization changes to display only data associated with the selected state.

:::image type="content" source="../media/9-use-parameter.gif" alt-text="Animated gif showing how to use the parameter picker.":::
