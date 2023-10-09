---
ms.custom:
  - build-2023
---
The addition of three new functions and the improvement of ISJSON in SQL Server 2022 helps developers work with JSON objects more effectively and easily. These functions help meet the increasing need for better handling of popular data formats in applications and APIs.

## JSON_OBJECT

The JSON_OBJECT function constructs a JSON object by specifying key-value pairs. It simplifies the process of creating JSON objects from query results.

## ISJSON

The ISJSON function checks if the input string contains valid JSON, returning 1 if true and 0 if false. In SQL Server 2022, it was enhanced to support `json_type_constraint`, allowing you to check for the JSON types of `VALUE`, `ARRAY`, `OBJECT` or `SCALAR`.

## JSON_PATH_EXISTS

The JSON_PATH_EXISTS function checks if a specific JSON path exists in a JSON string, returning 1 if true and 0 if false. This function is useful for verifying the presence of properties in JSON data.

## JSON_ARRAY

The JSON_ARRAY function constructs a JSON array by specifying elements. It simplifies the process of converting data into JSON arrays, which is beneficial when working with APIs or apps that require JSON arrays.

## Simplify JSON processing with JSON_OBJECT and JSON_PATH_EXISTS

Imagine you're a DBA for a large financial institution.  Your IT department installed a monitoring software for the whole network.  The software created a database called *CollectionDB*. To monitor your SQL Servers' query statistics, this database has a table called *QueryRequestStats* with the columns *CollectionTime*, *ServerName*, *session_id* and *QueryStats*.  The *QueryStats* column needs to be in JSON format. You must create the collection script that populates this table with the query text, plan and general statistics every 5 minutes. To minimize the overhead, you decide to only collect nonsleeping and nonbackground. Additionally, your team asks for a query against this table, that would return the top 10 requests by CPU usage that have a query text populated for the collection date time of `2023-03-29 12:54:00.000`. Run the following queries in SQL Server Management Studio (SSMS) to save and retrieve this data.

```sql
-- Query to collect data, run it every 5 minutes
INSERT INTO CollectionDB.dbo.QueryRequestStats
SELECT  GETDATE() AS CollectionTime
    , @@ServerName AS ServerName
	, er.session_id
	, JSON_OBJECT ('session_id':er.session_id
			, 'status':er.status
			, 'command':er.command
			, 'performanceCounters':JSON_OBJECT(
					'cpu':er.cpu_time
					, 'duration':er.total_elapsed_time
					, 'reads':er.logical_reads
				)
			, 'sql_text':JSON_OBJECT (
					'text': est.text
					, 'starting_offset':er.statement_start_offset
					, 'ending_offset':er.statement_end_offset
				)
			, 'query_plan':eqp.query_plan
		) AS QueryStats
FROM sys.dm_exec_requests  er
	OUTER APPLY sys.dm_exec_sql_text(er.sql_handle) est
	OUTER APPLY sys.dm_exec_query_plan(er.plan_handle) eqp
WHERE er.status NOT IN  ('sleeping', 'background')
	AND session_id > 50
	AND session_id != @@SPID

-- Query to return the top 10 requests by CPU usage that have a query text for the collection time `2023-03-29 12:54:00.000`
SELECT  *
FROM CollectionDB.dbo.QueryRequestStats
WHERE JSON_PATH_EXISTS(QueryStats, '$.sql_text.text') = 1
	AND JSON_VALUE(QueryStats, '$.sql_text.text') IS NOT NULL
    AND CollectionTime = '2023-03-29 12:54:00.000'
ORDER BY CAST(JSON_VALUE(QueryStats, '$.performanceCounters.cpu') AS INT) DESC
```

To collect the data, notice how we collect the query statistics into the *QueryStats* column as JSON using the function `JSON_OBJECT` function.  Furthermore, we also create two more JSON properties inside the collection, *performanceCounters* and *sql_text* also using the `JSON_OBJECT` function.

To display the data, we use the function `JSON_PATH_EXISTS` and `JSON_VALUE` to ensure that if the property exists, that `sql_text.text` isn't empty.

Collecting performance data and converting it to JSON is just one of countless scenarios that can largely benefit from these functions. The addition and improvement of JSON functions in SQL Server 2022 make it easier for users to work with JSON objects, addressing the growing demand for better ways to handle popular data formats commonly used in today's applications and APIs.
