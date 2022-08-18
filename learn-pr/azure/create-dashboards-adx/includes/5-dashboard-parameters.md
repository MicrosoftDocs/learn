You've created a dashboard to view insights into your storm events dataset. In this unit, you'll create parameters to use as filters on the dashboard tiles. 

## What are parameters?

Parameters make your dashboard interactive. They act like a filter on any tile that uses the parameter, so that choosing a value from that parameter will show you a filtered view of the connected visual.

For example, each dashboard comes with a built-in time range parameter.

:::image type="content" source="../media/9-dashboard-time-range.png" alt-text="Screenshot showing time range parameter.":::

Recall that each visual is created from a query. If you've included this time range within the visual query, then changing its value will show only results for, for example, the past hour.

## Create a parameter

First, you need to switch from viewing mode to editing mode.

1. Select **Viewing** and toggle the mode to **Editing**.

    :::image type="content" source="../media/8-editing mode.png" alt-text="Screenshot of switching to editing mode.":::

1. In the top menu bar, select **[@] Parameters**. The **Parameters** pane opens to the right. 
1. Select **+ New parameter**
1. Fill out the parameter options as follows:

    :::image type="content" source="../media/9-parameter-options.png" alt-text="Screenshot of parameter options.":::

    |Field  |Description | Suggested setting |
    |---------|---------| ---|
    |**Label**|The name of the parameter shown on the dashboard or the edit card.| State
    |**Parameter type**|**Single selection**: Only one value can be selected in the filter as input for the parameter.<br>**Multiple selection**: One or more values can be selected in the filter as input(s) for the parameter.<br>**Time range**: Filter the queries and dashboards based on time.<br>**Free text**: The user can type a value or copy/paste a value to the text field. | Multiple selection
    |**Variable name**|The name of the parameter to be used in the query.| state
    |**Data type**|The data type of the parameter values.| string
    |**Show on pages**|Select the pages where this parameter will be displayed. | Select all
    |**Source**|**Fixed values**: Manually introduced static filter values. <br>**Query**: Dynamically introduced values using a KQL query.| [Query](#edit-query)
    |**Default value**|The default value of the filter. | Select all
    |**Add a "Select all" value**|For single selection and multiple selection types. Used to retrieve data for all the parameter values. This value affects how the query is written. | Checked|

### Edit query

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

You've now created a parameter, but nothing has changed on your dashboard. That's because you need to use the parameter in the query that generates one of your visuals.

1. In the **Events by date** tile, click on the pencil icon.

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
