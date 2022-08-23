You've created a dashboard from a query in the Azure Data Explorer web UI. In this unit, you'll add a new tile to an existing dashboard.

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

1. Notice that the query for the dashboard is different from the one you ran in the query editor. When adding a new tile in a dashboard, you need to add the visual aspect separately. Select **+ Add visual**.

    :::image type="content" source="../media/8-add-visual.png" alt-text="Screenshot of results of query and adding visual to dashboard.":::

1. The **Visual formatting** pane opens. Select **Visual type** > **Bar chart**.

    :::image type="content" source="../media/8-visual-formatting.png" alt-text="Screenshot of visual formatting options.":::

1. Select **Apply changes** to create a new tile and view the updated dashboard.

    :::image type="content" source="../media/8-dashboard-two-tiles.png" alt-text="Screenshot of dashboard with two tiles.":::

1. Save the entire dashboard by selecting the **Save** icon in the upper right corner.

Congratulations! You have created a dashboard of insights.

