You have had a chance to look at the raw data and structure of an unfamiliar meterological dataset in Azure Data Explorer. 
Here, you'll use queries to find trends in the data. In particular, you'll use visualizations to see how the data is distributed.

## Timechart

In the last unit, you saw that some of the data columns were of type **datetime**, and represented start and end times for storm events. In order to see if this dataset is complete and doesn't have any gaps, you can plot a count of entries vs. time. Note that the previous unit used a subset of 50 data rows, where this unit will use the full dataset. The following query creates a timechart of the number of storm events per 8-hour bin as a function of time.

1. Run the following query:

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAx2MMQrDMBRD95xCYwKFrF06hZzAvUDiKtiDv+n3dyGlh6+dSfCkp3mGI2GBOJTvSvEn8oFiWRP4oVjBfsJi4uA6XC82/FBqSpvGL7HkKoYHfM9x6vs9CkZnm9qzmTfcw9QUpbyo15kPrfsD4B0ckX4AAAA=" target="_blank">Click to run query</a>
    
    
    ```kusto
    StormEvents
    | summarize Count = count() by bin (StartTime, 8h)
    | render timechart
    ```
    You should get results that look like the following image:
    
    :::image type="content" source="../media/6-timechart.png" alt-text="Screenshot of time chart results.":::

1. Take a look at the resulting graph. Do you see any obvious gaps or anomalies?

## Events by state

Another way to look at data distribution is to group by event location, in this case state, to see what kind of trends can be understood from the distribution.

1. Run the following query. 

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAyWMsQ3DMBADe0/B0qk8gUtPoAleyhsOEOmBFxUggYe3rBQsjjhyWRBUwaPHKG+UlqM6bId+tLAiflEp1CnQPG+jnE7UlrP466d/DyuStcL5cQ/CGHTJnDcPpbNrefbzKJ4OcV63IslrfQAAAA==" target="_blank">Click to run query</a>
    
    
    ```kusto
    StormEvents
    | summarize event = count() by State
    | sort by event
    | render barchart 
    ```
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/6-damage-chart.png" alt-text="Screenshot of bar chart showing damage by state.":::

1. Take a look at the resulting graph. There are 67 different kinds of states in the list- including those which are not official states in the US, such as "American Samoa" and "Hawaii waters". Does this type of geographical storm distribution make sense? 
1. You can look at the underlying data by selecting the **Table** icon above the chart. Do the actual numbers help you understand the data distribution better?
    
    :::image type="content" source="../media/6-underlying-data.png" alt-text="Screenshot of data table for damage chart.":::

## Events by geographic location

You've seen how the number of events vary based on time and state. Recall that the schema mapping showed that each storm event entry contains latitudinal and longitudinal information. Let's take a look at how the data clusters on a map.

1. The following query groups events by geographic cell, and counts the number of events in each cell. These results are displayed on a map, where the circle size corresponds to the number of events in that cell. Run the following query.

    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA2WPsQ7CMAxEd77C6tRInRjYuiCxsfEBVQhWE2jtKnEpID4el4CoxGbd+fnOB+HY765IklZPGCKf0QlssQ20Z6o+kxU1J48RISRiobHryq9lwNLpT2cyyqSx720MDwTHI0lp4HgHb5OHGlrkZuBA0gg3ae1wwf6Cq41ZFJuZvDpDTmtH2+Ur5XzWVDmoUQZvglosP6d5xdsp1ImqY4QhoPM2CkxBPJSXoNs19HYwL2cZuBIWAQAA" target="_blank">Click to run query</a>
    
    ```kusto
    StormEvents
    | project BeginLon, BeginLat
    | where isnotnull(BeginLat) and isnotnull(BeginLon)
    | summarize count() by hash = geo_point_to_s2cell(BeginLon, BeginLat,6)
    | project geo_s2cell_to_central_point(hash), count_
    | extend Events = "count"
    | render piechart with (kind = map)
    ```
    
    You should get results that look like the following image:
    
    :::image type="content" source="../media/6-event-map.png" alt-text="Screenshot of map chart result with circles showing number of events in a given area.":::

1. Try zooming in by pressing **Ctrl +**.  Now that you've seen the types of storms represented, does it make sense that there are more of these types of storms in the northeastern area of the US and the gulf of Mexico?