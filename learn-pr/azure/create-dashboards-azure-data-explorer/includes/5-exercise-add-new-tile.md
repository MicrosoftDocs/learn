You created a dashboard directly from a query in the Azure Data Explorer web UI. In this unit, you add a new tile to an existing dashboard.

## Add a new tile

Now, let's add another tile to this dashboard. First, you need to switch from viewing mode to editing mode.

1. Select **Viewing** and toggle the mode to **Editing**.

    :::image type="content" source="../media/8-editing mode.png" alt-text="Screenshot of switching to editing mode.":::

1. Select **+Add** > **Add tile**.

    :::image type="content" source="../media/8-add-tile.png" alt-text="Screenshot to add tile to dashboard.":::

1. Copy the following query into the query editor:

    ```kusto
    StormEvents
    | summarize event = count() by State
    | sort by event
    ```

1. Run the query by selecting the **Run** button or by pressing **Shift**+**Enter**.

1. Select **+ Add visual**.

    :::image type="content" source="../media/8-add-visual.png" alt-text="Screenshot of results of query and adding visual to dashboard.":::

1. The **Visual formatting** pane opens. Select **Visual type** > **Bar chart** and change the **Tile name** to *Event count by state*.

    :::image type="content" source="../media/8-visual-formatting.png" alt-text="Screenshot of visual formatting options.":::

1. Select **Apply changes** to create a new tile and view the updated dashboard.

    :::image type="content" source="../media/8-dashboard-two-tiles.png" alt-text="Screenshot of dashboard with two tiles.":::

1. Save the entire dashboard by selecting the **Save** icon in the upper right corner.

Congratulations! You created a dashboard of insights.
