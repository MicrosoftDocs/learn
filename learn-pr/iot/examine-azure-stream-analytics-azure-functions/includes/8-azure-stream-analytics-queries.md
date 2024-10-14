Queries in Azure Stream Analytics are expressed in a SQL-like query language.

Queries can be designed for simple pass-through logic that moves event data from one input stream into an output data store. An advanced query might use rich pattern matching and temporal analysis to calculate aggregates over various time windows. You can also use queries to join data from multiple inputs. For example, you could combine streaming events, or you could implement lookups against static reference data to enrich the event values. Queries are also used to write data to multiple outputs.

Queries are written using a combination of query syntax elements and functions. Queries process data from an input and use the data to produce a desired output.

## Query language elements

Azure Stream Analytics provides a variety of  elements for building queries. They are summarized below.

|Element|Summary|
|-------------|-------------|
|[APPLY](/stream-analytics-query/apply-azure-stream-analytics)|The APPLY operator allows you to invoke a table-valued function for each row returned by an outer table expression of a query. There are two forms of APPLY:<br /><br /> CROSS APPLY returns only rows from the outer table that produce a result set from the table-valued function.<br /><br /> OUTER APPLY returns both rows that produce a result set, and rows that do not, with NULL values in the columns produced by the table-valued function.|
|[CASE](/stream-analytics-query/case-azure-stream-analytics)|CASE evaluates a list of conditions and returns one of multiple possible result expressions|
|[COALESCE](/stream-analytics-query/coalesce-azure-stream-analytics)|COALESCE evaluates the arguments in order and returns the value of the first expression that initially does not evaluate to NULL.|
|[CREATE TABLE](/stream-analytics-query/create-table-stream-analytics)|CREATE TABLE is used to define the schema of the payload of the events coming into Azure Stream Analytics.|
|[FROM](/stream-analytics-query/from-azure-stream-analytics)|FROM specifies the input stream or a step name associated in a WITH clause. The FROM clause is **always** required for any SELECT statement.|
|[GROUP BY](/stream-analytics-query/group-by-azure-stream-analytics)|GROUP BY groups a selected set of rows into a set of summary rows grouped by the values of one or more columns or expressions.|
|[HAVING](/stream-analytics-query/having-azure-stream-analytics)|HAVING specifies a search condition for a group or an aggregate. HAVING can be used **only** with the SELECT expression.|
|[INTO](/stream-analytics-query/into-azure-stream-analytics)|INTO explicitly specifies an output stream, and is **always** associated with an SELECT expression.  If not specified, the default output stream is "output".|
|[JOIN](/stream-analytics-query/join-azure-stream-analytics) and<br /><br /> [Reference Data JOIN](/stream-analytics-query/reference-data-join-azure-stream-analytics)|JOIN is used to combine records from two or more input sources.  JOIN is temporal in nature, meaning that each JOIN must define how far the matching rows can be separated in time.<br /><br /> JOIN is also used to   correlate persisted historical data or a slow changing dataset (also known as reference data) with the real-time event stream to make smarter decisions about the system. For example, join an event stream to a static dataset which maps IP Addresses to locations. This is the **only** JOIN supported in Stream Analytics where a temporal bound is not necessary.|
|[MATCH_RECOGNIZE](/stream-analytics-query/match-recognize-stream-analytics)|MATCH_RECOGNIZE is used to search for a set of events over a data stream.|
|[NULLIF](/stream-analytics-query/nullif-azure-stream-analytics)|NULLIF evaluates two arguments and returns null if they are equal.|
|[OVER](/stream-analytics-query/over-azure-stream-analytics)|OVER defines the grouping of rows before an associated aggregate or analytic function is applied. |
|[SELECT](/stream-analytics-query/select-azure-stream-analytics)|SELECT is used to retrieve rows from input streams and enables the selection of one or many columns from one or many input streams in Azure Stream Analytics.|
|[UNION](/stream-analytics-query/union-azure-stream-analytics)|UNION combines two or more queries into a single result set that includes all the rows that belong to all queries in the union.|
|[WHERE](/stream-analytics-query/where-azure-stream-analytics)|WHERE specifies the search condition for the rows returned by the query.|
|[WITH](/stream-analytics-query/with-azure-stream-analytics)|WITH specifies a temporary named result set which can be referenced by a FROM clause in the query. This is defined within the execution scope of a single SELECT statement.|

## Built-in functions

Azure Stream Analytics provides some built-in functions. The categories of built-in functions are:

### Types of Functions

|Function Category|Description|
|-----------------------|-----------------|
|[Aggregate Functions](/stream-analytics-query/aggregate-functions-azure-stream-analytics)|Operate on a collection of values but return a single, summarizing value.|
|[Analytic Functions](/stream-analytics-query/analytic-functions-azure-stream-analytics)|Return a value based on defined constraints.|
|[Array Functions](/stream-analytics-query/array-functions-stream-analytics)|Returns information from an array.|
|[GeoSpatial Functions](/stream-analytics-query/geospatial-functions)|Perform specialized GeoSpatial functions.|
|[Input Metadata Functions](/stream-analytics-query/input-metadata-functions)|Query the metadata of property in the data input.|
|[Record Functions](/stream-analytics-query/record-functions-azure-stream-analytics)|Returns record properties or values.|
|[Windowing Functions](/stream-analytics-query/windowing-azure-stream-analytics)|Perform operations on events within a time window.|
|[Scalar Functions](/stream-analytics-query/built-in-functions-azure-stream-analytics#BKMK_ScalarFunctions)|Operate on a single value and then return a single value. Scalar functions can be used wherever an expression is valid.|

### Scalar Functions

A scalar function operates on a single value and then return a single value. Scalar functions can be used wherever an expression is valid.

|Function Category|Description|
|-----------------------|-----------------|
|[Conversion Functions](/stream-analytics-query/conversion-functions-azure-stream-analytics)|These functions allow you to cast data into different formats.|
|[Date and Time Functions](/stream-analytics-query/date-and-time-functions-azure-stream-analytics)|These functions allow you to perform operations on DateTime formats.|
|[Mathematical Functions](/stream-analytics-query/mathematical-functions-azure-stream-analytics)|Represent the scalar functions that perform a calculation, usually based on input values that are provided as arguments, and return a numeric value.|
|[String Functions](/stream-analytics-query/string-functions-azure-stream-analytics)|These functions allow you to convert strings to upper or lower case.|

## Query syntax examples

The following queries are examples taken from the Stream Analytics query language reference. They were selected because they help to illustrate common query patterns and show basic syntax.

All query pattern examples included in the reference guide are based on the following toll booth scenario:

A vehicle tolling station is a common phenomenon – we encounter them in many expressways, bridges, and tunnels across the world. Each toll station has multiple toll booth lanes that a car can enter, which may be manual – meaning that you stop to pay the toll to an attendant, or automated – where a sensor placed on top of the booth scans an RFID card affixed to the windshield of your vehicle as you pass the toll booth. The passage of vehicles through the toll stations provides us with an event stream that we can visualize. We can use this event stream to perform some interesting operations.

### Pattern 1 - Convert data types

For this example, the input stream includes the make of the car, the time when the car passes through the booth, and the weight of the car. The goal is to calculate the sum of vehicle weight that passes through an individual booth during a defined time period. In this example, the car weight reported on the input stream is represented as a string data type. The weight values must be converted to INT before the SUM can be calculated.

#### Input

|Make|Time|Weight|
|----|----|------|
|Honda|2015-01-01T00:00:01.0000000Z|"1000"|
|Honda|2015-01-01T00:00:02.0000000Z|"2000"|

#### Query solution

```SQL
    SELECT
        Make,
        SUM(CAST(Weight AS BIGINT)) AS Weight
    FROM
        Input TIMESTAMP BY Time
    GROUP BY
        Make,
        TumblingWindow(second, 10)
```

#### Output

|Make|Weight|
|----|------|
|Honda|3000|

#### Explanation

We use a CAST statement in the `Weight` field to specify its data type.

### Pattern 2 - Send data to multiple outputs

#### Description

In this example, the input stream includes the make of a car and the time when that car passes through the booth. We have two goals. The first goal it to archive the input data to cold storage. The second goal is to support a downstream alerting system that sends alerts whenever the traffic rate for a particular make of vehicle exceeds a defined threshold value. To achieve both goals we need to process the data for multiple output targets. The first target output will receive all of the input data. For the second target output will receive a record indicating the make of the vehicle, the time for the event, and the associated number of vehicles passing through the booth.

#### Input

|Make|Time|
|----|----|
|Honda|2015-01-01T00:00:01.0000000Z|
|Honda|2015-01-01T00:00:02.0000000Z|
|Toyota|2015-01-01T00:00:01.0000000Z|
|Toyota|2015-01-01T00:00:02.0000000Z|
|Toyota|2015-01-01T00:00:03.0000000Z|

#### Query solution

```SQL
    SELECT
        *
    INTO
        ArchiveOutput
    FROM
        Input TIMESTAMP BY Time

    SELECT
        Make,
        System.TimeStamp() AS AsaTime,
        COUNT(*) AS [Count]
    INTO
        AlertOutput
    FROM
        Input TIMESTAMP BY Time
    GROUP BY
        Make,
        TumblingWindow(second, 10)
    HAVING
        [Count] >= 3
```

#### Output 1

|Make|Time|
|----|----|
|Honda|2015-01-01T00:00:01.0000000Z|
|Honda|2015-01-01T00:00:02.0000000Z|
|Toyota|2015-01-01T00:00:01.0000000Z|
|Toyota|2015-01-01T00:00:02.0000000Z|
|Toyota|2015-01-01T00:00:03.0000000Z|

#### Output 2

|Make|Time|Count|
|----|----|-----|
|Toyota|2015-01-01T00:00:10.0000000Z|3|

#### Explanation

The INTO clause tells Stream Analytics the outputs to write the data to from this statement. The first query is a pass-through of the data received to an output named `ArchiveOutput`. The second query does some simple aggregation and filtering, and it sends the results to a downstream alerting system, `AlertOutput`.

The full Stream Analytics query language reference guide can be found here: [Stream Analytics Query Language Reference](/stream-analytics-query/stream-analytics-query-language-reference).
