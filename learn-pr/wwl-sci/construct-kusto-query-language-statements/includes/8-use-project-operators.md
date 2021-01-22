The project operators control what columns to include, add, remove, or rename in the result set of a statement.

There are multiple types of project operators.  The following table is a list of the variations.

| Operator| Description|
| :--- | :--- |
| project| Select the columns to include, rename or drop, and insert new computed columns.|
| project-away| Select what columns from the input to exclude from the output.|
| project-keep| Select what columns from the input to keep in the output.|
| project-rename| Select the columns to rename in the resulting output.|
| project-reorder| Set the column order in the resulting output.|

## project operator

Select the columns to include, rename or drop, and insert new computed columns.

> [!TIP]
> The project operator will limit the size of the result set, which will increase performance
```kusto
SecurityEvent

| project Computer, Account

```

## project-away operator

Select what columns from the input to exclude from the output.

This example builds from our previous extend and order by operators.  The goal of the statement was to set the AlertSeverity in a more meaningful order.  If the order were only on the AlertSeverity column, the order would have been in alpha order.  Creating the new column severityOrder and setting a numeric value would allow the sorting to provide a meaningful severity order.  The severityOrder number is meaningless after the order by operator.  The project-away will remove the unnecessary column from the result set.

```kusto
SecurityAlert

| where TimeGenerated > ago(7d)

| extend severityOrder = case (

    AlertSeverity == "High", 3,

    AlertSeverity == "Medium", 2, 

    AlertSeverity == "Low", 1,

    AlertSeverity == "Informational", 0,

    -1)

| order by severityOrder

| project-away severityOrder

```

