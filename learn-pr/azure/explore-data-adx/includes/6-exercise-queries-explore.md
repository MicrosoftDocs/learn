You have had a chance to look at the raw data of an unfamiliar meterological dataset, and explore some of its properties in the results grid of Azure Data Explorer. 

Here, you'll use queries to further characterize the size and variability of the data.

## Count the records

The most basic query you'll be using counts the number of rows in the table.

Run the following query.

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAA9PXd84vzStRKMlIVcgrzU1KLVLIT1NIzSspykwt5gouyS/KdS0Dcou5ahSSQSoBCrLn1DEAAAA=" target="_blank">Click to run query</a>

```kusto
StormEvents
| count 
```

You should get results that look like the following image:

:::image type="content" source="../media/5-count.png" alt-text="Screenshot of results of count operator.":::

## Find minimum and maximum values

It will be useful to know what ranges of values exist in the dataset. For example, you saw in the last unit that there are timestamps for each event. Run the following query to see the minimum and maximum values of the start time column:

<a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRKC7NzU0syqxKVcjNzNMILkksKgnJzE3V1FHITaxA4gMAZ2iu0TYAAAA=" target="_blank">Click to run query</a>

```
StormEvents
| summarize min(StartTime), max(StartTime)
```

You should get results that look like the following image:

:::image type="content" source="../media/5-min-max.png" alt-text="Screenshot of maximum and minimum results.":::

## Get table schema

Recall in the last unit that you looked at several rows of data to infer the data types. You can use a query to find out the actual schema of the data table. The schema is a mapping of column name to data type. 

1. Run the following query.
    
    <a href="https://dataexplorer.azure.com/clusters/help/databases/Samples?query=H4sIAAAAAAAAAwsuyS/KdS1LzSsp5qpRSE8tKU7OSM1NBADhHoKkFwAAAA==" target="_blank">Click to run query</a>
    
    ```kusto
    StormEvents
    | getschema 
    ```
    
    You should get results that look like the following image: 
    
    :::image type="content" source="../media/5-metadata.png" alt-text="Screenshot of results grid showing metadata.":::
    
1. Look at each column. The first, **ColumnName** shows the columns you explored in the last unit. The **ColumnOrdinal** numbers the columns in order of how they appear in the table. The **DataType** isn't needed for this characterization. **ColumnType** displays the datatype for each column. Notice that the last column, **StormSummary**, is a dynamic object. A dynamic object can contain property bags or arrays.

## Unpack a dynamic field

The dynamic field is essentially hiding extra data within a large field. In order to fully characterize all the available data, you can expand the cell to view all information inside the dynamic field.

1. Select the **Expand view** icon on the top right of the results grid.
1. Select **Right** to view the expanded results in the right pane.
1. Scroll to the rightmost column of the table, **StormSummary**.
1. Double-click on one of the fields in this column. The field will expand to show the contents in an easier to read format:

    :::image type="content" source="../media/5-unpack-bag.gif" alt-text="Screen capture of expanding of storm summary dynamic field.":::
