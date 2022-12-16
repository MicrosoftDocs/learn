The project operators control what columns to include, add, remove, or rename in the result set of a statement.

There are multiple types of project operators.  The following table is a list of the variations.

| Operator| Description|
| :--- | :--- |
| project| Select the columns to include, rename or drop, and insert new computed columns.|
| project-away| Select what columns from the input to exclude from the output.|
| project-keep| Select what columns from the input to keep in the output.|
| project-rename| Select the columns to rename in the resulting output.|
| project-reorder| Set the column order in the resulting output.|

## Project operator

Select the columns to include, rename or drop, and insert new computed columns.

> [!TIP]
> The project operator will limit the size of the result set, which will increase performance

Run each Query separately to see the results.

```kusto
SecurityEvent
| project Computer, Account


SecurityEvent
| where ProcessName != "" and Process != ""
| extend StartDir =  substring(ProcessName,0, string_size(ProcessName)-string_size(Process))
| order by StartDir desc, Process asc
| project Process, StartDir

```

## Project-away operator

Select what columns from the input to exclude from the output.

This example builds from our previous extend and order by operators. The project-away will remove the unnecessary column from the result set.  In this example, we'll remove the ProcessName column.

```kusto
SecurityEvent
| where ProcessName != "" and Process != ""
| extend StartDir =  substring(ProcessName,0, string_size(ProcessName)-string_size(Process))
| order by StartDir desc, Process asc
| project-away ProcessName

```

