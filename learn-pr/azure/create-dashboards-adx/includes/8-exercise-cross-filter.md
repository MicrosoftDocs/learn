## Use cross-filters as dashboard parameters

Cross-filters allow you to select a value in one visual, and this value is used to filter other dashboard visuals. Instead of selecting a parameter in the list above, you select the parameter by selecting a field on a tile.

You only need to add a cross-filter on the tile you'll be selecting. All other tiles that use this parameter in their query will then be filtered accordingly. You can create more than one cross-filters on the same tile, or different cross-filters on different tiles. 

## Define cross-filters

1. Select **Viewing** and toggle the mode to **Editing**.

    :::image type="content" source="../media/8-editing mode.png":::

1. Select the **edit** icon on the visual where you want to add cross-filters. In this example, edit the tile for **Event counts by state**.
1. In the right pane, select **Interactions**.
1. Fill out the fields as follows:

    :::image type="content" source="../media/8-cross-filter.png" alt-text="Screenshot of cross-filter fields to fill in.":::

    | Field | Description | Suggested entry|
    |---|---|---|
    | Cross-filter |  Enables the cross-filter  | Toggle to **On**
    | Interaction | Whether you point or drag to select the parameter value   | Point
    | Column | The column from this visual that will be used to provide the parameter value  | State
    | Parameter | The name of the predefined parameter that will be selected using the cross-filter   | State

1. Select **Apply changes**
1. Save the dashboard using the **Save** icon.

## Use a cross-filter

To use the cross-filter, go to the **Events count by state** and click on the bar for the state you want to select. For example, see if you can select **Ohio**. 

Now look at the **Events by date** visual. Do you notice how it's changed to just show data for the state of Ohio? You should see tiles like the following image:

:::image type="content" source="../media/8-cross-filter-selection.png" alt-text="Screenshot of cross-filter in use.":::


