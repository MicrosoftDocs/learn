The union operator takes two or more tables and returns the rows of all of them.  Understanding how results are passed and impacted with the pipe character is essential.

Based on the time window set in the Query window:

- Query 1 will return all rows of SecurityEvent and all rows of SecurityAlert

- Query 2 will return one row and column, which is the count of all rows of SecurityEvent and all rows of SecurityAlert

- Query 3 will return all rows of SecurityEvent and one row for SecurityAlert.  The row for SecurityAlert will have the count of the SecurityAlert rows.

Run each Query separately to see the results.

```kusto
// Query 1

SecurityEvent 
| union SecurityAlert  

// Query 2

SecurityEvent 
| union SecurityAlert  
| summarize count() 
| project count_

// Query 3

SecurityEvent 
| union (SecurityAlert  | summarize count()) 
| project count_

```

The union operator supports wildcards to union multiple tables.  The following KQL will create a count for the rows in all tables with names that start with Security.

```kusto
union Security* 
| summarize count() by Type

```

