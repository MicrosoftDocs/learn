You've connected to resources containing meterological data. In this unit, you'll create a dashboard from a query to visualize insights in this data. 

## Pin query to dashboard

Start with a query that you want to pin to the dashboard. In this case, you'll share a plot of events versus time from the publicly available help cluster.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAx2MMQrDMBRD95xCYwKFrF06hZzAvUDiKtiDv+n3dyGlh6+dSfCkp3mGI2GBOJTvSvEn8oFiWRP4oVjBfsJi4uA6XC82/FBqSpvGL7HkKoYHfM9x6vs9CkZnm9qzmTfcw9QUpbyo15kPrfsD4B0ckX4AAAA=" target="_blank">Click to run query</a>
    
    ```kusto
    StormEvents
    | summarize Count = count() by bin (StartTime, 8h)
    | render timechart
    ```

1.  At the top right corner of the query editor, select **Share** > **Pin to dashboard**.

    :::image type="content" source="../media/8-pin-query.png" alt-text="Screenshot of pin query to dashboard.":::

1. In the **Pin to dashboard** pane that opens, fill in the fields as follows:

    :::image type="content" source="../media/8-pin-to-dashboard.png" alt-text="Screenshot of pin to dashboard options.":::

    | Field | Description | Suggested value |
    |---|---|
    |Tile name | The title for this specific tile. In this example, give it a name that describes the contents of the graph. | Events by date
    | Data source name | The database on which the query is run. This field is auto-populated when pinning from query. | Samples
    | Use existing/Create new | In this example, you're creating a new dashboard.| Create new
    | Dashboard name | Think about all the tiles you want to add to this dashboard, and give the dashboard an appropriate name.| Share insights
    | View dashboard after creation | Switches to dashboard view from the query view | Checked 

1. Select **Pin** to create the pin and view the dashboard.

    :::image type="content" source="../media/8-dashboard-created.png" alt-text="Screenshot of new pin in dashboard.":::

