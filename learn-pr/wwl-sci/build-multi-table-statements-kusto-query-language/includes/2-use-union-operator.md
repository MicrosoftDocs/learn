The union operator takes two or more tables and returns the rows of all of them. Understanding how results are passed and impacted with the pipe character is essential.

Based on the time window set in the Query window:

- Query 1 returns all rows of SecurityEvent and all rows of SigninLogs

- Query 2 returns one row and column, which is the count of all rows of SecurityEvent and all rows of SigninLogs

- Query 3 returns all rows of SecurityEvent and one row for SigninLogs.  

Run each Query separately to see the results.

```kusto
// Query 1

SecurityEvent 
| union SigninLogs  

// Query 2

SecurityEvent 
| union SigninLogs  
| summarize count() 
| project count_

// Query 3

SecurityEvent 
| union (SigninLogs | summarize count()| project count_)

```

The union operator supports wildcards to union multiple tables. The following KQL creates a count for the rows in all tables with names that start with Security.

```kusto
union Security* 
| summarize count() by Type

```
