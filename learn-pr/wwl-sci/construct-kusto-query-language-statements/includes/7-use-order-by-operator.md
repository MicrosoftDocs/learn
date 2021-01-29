Sort the rows of the input table by one or more columns.

The order by operator can utilize any column or multiple columns by using a comma separator.  Each column can be descending or ascending.

```kusto
SecurityAlert

| where TimeGenerated > ago(7d)

| extend severityOrder = case (

    AlertSeverity == "High", 3,

    AlertSeverity == "Medium", 2, 

    AlertSeverity == "Low", 1,

    AlertSeverity == "Informational", 0,

    -1)

| order by severityOrder desc

```

