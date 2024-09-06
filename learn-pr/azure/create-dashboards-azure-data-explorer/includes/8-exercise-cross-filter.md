In the previous unit, you created dashboard parameters to filter dashboard tiles. In this unit, you create cross-filters to use as dashboard parameters.

## Define cross-filters

1. Select **Viewing** and toggle the mode to **Editing**.

    :::image type="content" source="../media/8-editing mode.png" alt-text="Screenshot of toggling to editing mode.":::

1. Select the **edit** icon on the visual where you want to add cross-filters. In this example, edit the tile for **Event count by state**.
1. In the right pane, select **Interactions**.
1. Fill out the fields as follows:

    :::image type="content" source="../media/8-cross-filter.png" alt-text="Screenshot of cross-filter fields to fill in.":::

    | Field | Description | Suggested entry|
    |---|---|---|
    | Cross-filter |  Enables the cross-filter.  | Toggle to **On**
    | Interaction | Indicates whether you point or drag to select the parameter value.  | Point
    | Column | The column from this visual that is used to provide the parameter value.  | State
    | Parameter | The name of the predefined parameter that is selected using the cross-filter.  | State

1. Select **Apply changes**
1. Save the dashboard using the **Save** icon.

## Use a cross-filter

1. To use the cross-filter, go to the **Event count by state** tile, and select the bar for the state you want to select. For example, see if you can select **MINNESOTA**.
1. Now look at the changes to the **Events by date** visual. Do you notice how the visual only shows data for the state of Minnesota? Your dashboard should look like the following image:

    :::image type="content" source="../media/8-cross-filter-selection.png" alt-text="Screenshot of cross-filter in use.":::
