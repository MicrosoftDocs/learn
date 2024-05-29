You've explored the raw data and range of an unfamiliar meteorological dataset. In this unit, you'll use visualizations to see how the data is distributed.

## Timechart

Recall that some of the data columns you saw in the last unit were of type **DateTime**, and represented start and end times for storm events. To see which dates have storm-data events, you can plot a count of entries versus time.

Note that the previous unit used a subset of 50 data rows, whereas this unit will use the full dataset.

The following query creates a timechart of the number of storm events per 8-hour bin as a function of time.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAx2MMQrDMBRD95xCYwKFrF06hZzAvUDiKtiDv+n3dyGlh6+dSfCkp3mGI2GBOJTvSvEn8oFiWRP4oVjBfsJi4uA6XC82/FBqSpvGL7HkKoYHfM9x6vs9CkZnm9qzmTfcw9QUpbyo15kPrfsD4B0ckX4AAAA=" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | summarize Count = count() by bin (StartTime, 8h)
    | render timechart
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/6-timechart.png" alt-text="Screenshot of time chart results.":::

1. Take a look at the resulting graph. Do you see any obvious gaps or anomalies?

## Events by state

Another way to look at data distribution is to group by event location (in this case, state) to see what kind of trends can be understood from the distribution.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAyWMsQ3DMBADe0/B0qk8gUtPoAleyhsOEOmBFxUggYe3rBQsjjhyWRBUwaPHKG+UlqM6bId+tLAiflEp1CnQPG+jnE7UlrP466d/DyuStcL5cQ/CGHTJnDcPpbNrefbzKJ4OcV63IslrfQAAAA==" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | summarize event = count() by State
    | sort by event
    | render barchart 
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/6-damage-chart.png" alt-text="Screenshot of bar chart showing damage by state.":::

1. Take a look at the resulting graph. There are 67 different states in the list, including those which aren't official states in the US, such as "American Samoa" and "Hawaii waters". Does this type of geographical storm distribution make sense?
1. You can look at the underlying data by selecting the **Table** tab above the chart. Do the actual numbers help you understand the data distribution better?

    :::image type="content" source="../media/6-underlying-data.png" alt-text="Screenshot of data table for damage chart.":::

## Events by geographic location

You've seen how the number of events vary based on time and state. Recall that the schema mapping showed that each storm event entry contains latitudinal and longitudinal information. Let's take a look at how the data clusters on a map.

1. The following query groups events by geographic cell, and counts the number of events in each cell. These results are displayed on a map, where the circle size corresponds to the number of events in that cell. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA2VPOw7CMAzdOYXF1EidGNi6ILGxcYAqBKsJNHGUuJQiDo/bgihis/2+PjIlv79h4Lx6Qkx0QcOww8aFA4XyPWkWsLeYEFwOxKFr2+IDKdDh/HenoESTO+91cg8EQ13get6HatoKBacBrM4WKmiQ6khOOEx13hhcOH1rlFu1qDlqZuooMvJE0u3sUoy2qvyNFSneGaXt/LHErifCWpAkd0wQHRqrE0Pv2EJxdcKuwOuoXlm6/gQrAQAA" target="_blank">Run the query</a>

    ```kusto
    StormEvents
    | project BeginLon, BeginLat
    | where isnotnull(BeginLat) and isnotnull(BeginLon)
    | summarize count_summary=count() by hash = geo_point_to_s2cell(BeginLon, BeginLat,6)
    | project geo_s2cell_to_central_point(hash), count_summary
    | extend Events = "count"
    | render piechart with (kind = map)
    ```

    You should get results that look like the following image:

    :::image type="content" source="../media/6-event-map.png" alt-text="Screenshot of map chart result with circles showing number of events in a given area.":::

1. Try zooming in by pressing **Ctrl +**.  Now that you've seen the types of storms represented, does it make sense that there are more of these types of storms in the northeastern area of the US and the gulf of Mexico?
