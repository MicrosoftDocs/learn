The render operator generates a visualization of the query results.

The supported visualizations are:

* `<Areachart>`
* `<Bacchant>`
* `<Columnchart>`
* `<Timechart>`
* `<Scatterchart>`
* `<Timechart>`

```kusto
SecurityEvent 
| summarize count() by Account
| render barchart

```

## Use the summarize operator to create time series

The bin() function rounds values down to an integer multiple of the given bin size.  Used frequently in combination with summarize by .... If you have a scattered set of values, the values are grouped into a smaller set of specific values.  Combining the generated time series and pipe to a render operator with a type of <timechart> provides a time-series visualization.

```kusto
SecurityEvent 
| summarize count() by bin(TimeGenerated, 1d) 
| render timechart

```

