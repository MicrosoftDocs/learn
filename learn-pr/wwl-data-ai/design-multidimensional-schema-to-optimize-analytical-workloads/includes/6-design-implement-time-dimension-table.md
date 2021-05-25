A time dimension table is one of the most consistently used dimension tables. This type of table enables consistent granularity for temporal analysis and reporting and usually contains temporal hierarchies, such as `Year` > `Quarter` > `Month` > `Day`. In addition to consistency in time attributes, this design will also help query performance. It is more performant to filter on stored attributes in a small dimension table than always calculating the time attributes at query time.

Time dimension tables can contain business-specific attributes that are useful references for reporting and filters, such as fiscal periods and public holidays.

This is the schema of the time dimension table that you will create:

| Column | Data Type |
| --- | --- |
| DateKey | `int` |
| DateAltKey | `datetime` |
| CalendarYear | `int` |
| CalendarQuarter | `int` |
| MonthOfYear | `int` |
| MonthName | `nvarchar(15)` |
| DayOfMonth | `int` |
| DayOfWeek | `int` |
| DayName | `nvarchar(15)` |
| FiscalYear | `int` |
| FiscalQuarter | `int` |