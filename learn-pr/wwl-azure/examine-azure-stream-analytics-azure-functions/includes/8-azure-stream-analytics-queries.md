Queries in Azure Stream Analytics are expressed in a SQL-like query language.

Queries can be designed for simple pass-through logic that moves event data from one input stream into an output data store. An advanced query might use rich pattern matching and temporal analysis to calculate aggregates over various time windows. You can also use queries to join data from multiple inputs. For example, you could combine streaming events, or you could implement lookups against static reference data to enrich the event values. Queries are also used to write data to multiple outputs.

Queries are written using a combination of query syntax elements and functions. Queries process data from an input and use the data to produce a desired output.

## Query language elements

The Azure Stream Analytics service provides various elements for building queries. The elements are summarized in the following table.

:::row:::
  :::column:::
    **Element**
  :::column-end:::
  :::column:::
    **Summary**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    APPLY
  :::column-end:::
  :::column:::
    The APPLY operator allows you to invoke a table-valued function for each row that is returned by an outer table expression within a query. There are two forms of APPLY:

CROSS APPLY returns only rows from the outer table that produce a result set from the table-valued function.

OUTER APPLY returns both rows that produce a result set in the columns produced by the table-valued function. For rows that do not produce a result, NULL values are returned.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CASE
  :::column-end:::
  :::column:::
    CASE evaluates a list of conditions and returns one of multiple possible result expressions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    COALESCE
  :::column-end:::
  :::column:::
    COALESCE evaluates the arguments in order and returns the value of the first expression that initially does not evaluate to NULL.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    CREATE TABLE
  :::column-end:::
  :::column:::
    CREATE TABLE is used to define the schema of the payload of the events coming into Azure Stream Analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    FROM
  :::column-end:::
  :::column:::
    FROM specifies the input stream or a step name associated in a WITH clause. The FROM clause is always required for any SELECT statement.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    GROUP BY
  :::column-end:::
  :::column:::
    GROUP BY is used to group a selected set of rows into a set of summary rows. The summary rows are grouped by the values of one or more columns or expressions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HAVING
  :::column-end:::
  :::column:::
    HAVING specifies a search condition for a group or an aggregate. HAVING can be used only with the SELECT expression.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    INTO
  :::column-end:::
  :::column:::
    INTO explicitly specifies an output stream, and is always associated with an SELECT expression. If not specified, the default output stream is "output".
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    JOIN and

Reference Data JOIN
  :::column-end:::
  :::column:::
    JOIN is used to combine records from two or more input sources. JOIN is temporal in nature, meaning that each JOIN must define how far the matching rows can be separated in time.

JOIN is also used to correlate persisted historical data or a slow-changing dataset (also known as Reference data) with the real-time event stream to make smarter decisions about the system. For example, join an event stream to a static dataset that maps IP Addresses to locations. This type of JOIN is the only one supported in Stream Analytics where a temporal bound is not necessary.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    MATCH\_RECOGNIZE
  :::column-end:::
  :::column:::
    MATCH\_RECOGNIZE is used to search for a set of events over a data stream.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    OVER
  :::column-end:::
  :::column:::
    OVER defines the grouping of rows before an associated aggregate or analytic function is applied.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SELECT
  :::column-end:::
  :::column:::
    SELECT is used to retrieve rows from input streams. SELECT enables the selection of columns from one or more input streams in Azure Stream Analytics.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    UNION
  :::column-end:::
  :::column:::
    UNION combines two or more queries into a single result set. The result set includes all the rows that belong to all queries in the union.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    WHERE
  :::column-end:::
  :::column:::
    WHERE specifies the search condition for the rows returned by the query.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    WITH
  :::column-end:::
  :::column:::
    WITH specifies a temporary named result set that can be referenced by a FROM clause in the query. This parameter is defined within the execution scope of a single SELECT statement.
  :::column-end:::
:::row-end:::


## Built-in functions

### Types of functions

:::row:::
  :::column:::
    **Function Category**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Aggregate Functions
  :::column-end:::
  :::column:::
    Operate on a collection of values but return a single, summarizing value.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Analytic Functions
  :::column-end:::
  :::column:::
    Return a value based on defined constraints.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Array Functions
  :::column-end:::
  :::column:::
    Returns information from an array.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    GeoSpatial Functions
  :::column-end:::
  :::column:::
    Perform specialized GeoSpatial functions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Input Metadata Functions
  :::column-end:::
  :::column:::
    Query the metadata of property in the data input.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Record Functions
  :::column-end:::
  :::column:::
    Returns record properties or values.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Windowing Functions
  :::column-end:::
  :::column:::
    Perform operations on events within a time window.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Scalar Functions
  :::column-end:::
  :::column:::
    Operate on a single value and then return a single value. Scalar functions can be used wherever an expression is valid.
  :::column-end:::
:::row-end:::


### Scalar functions

A scalar function operates on a single value and then returns a single value. Scalar functions can be used wherever an expression is valid.

:::row:::
  :::column:::
    **Function Category**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Conversion Functions
  :::column-end:::
  :::column:::
    These functions allow you to cast data into different formats.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Date and Time Functions
  :::column-end:::
  :::column:::
    These functions allow you to perform operations on DateTime formats.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Mathematical Functions
  :::column-end:::
  :::column:::
    These functions represent the scalar functions that perform a calculation. These functions are usually based on input values that are provided as arguments, and return a numeric value.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    String Functions
  :::column-end:::
  :::column:::
    These functions allow you to convert strings to upper or lower case.
  :::column-end:::
:::row-end:::


## Query syntax examples

The following queries are examples taken from the Stream Analytics query language reference. They were selected because the help to illustrate common query patterns and show basic syntax.

All query pattern examples included in the reference guide are based on the following toll booth scenario:

A vehicle tolling station is a common phenomenon – we encounter them in many expressways, bridges, and tunnels across the world. Each toll station has multiple toll booth lanes that a car can enter, which may be manual – meaning that you stop to pay the toll to an attendant, or automated – where a sensor placed on top of the booth scans an RFID card affixed to the windshield of your vehicle as you pass the toll booth. The passage of vehicles through the toll stations provides us with an event stream that we can visualize. We can use this event stream to perform some interesting operations.

### Pattern 1 - Convert data types

For this example, the input stream includes the make of the car, the time when the car passes through the booth, and the weight of the car. The goal is to calculate the sum of vehicle weight that passes through an individual booth during a defined time period. In this example, the car weight reported on the input stream is represented as a string data type. The weight values must be converted to INT before the SUM can be calculated.

#### Input

:::row:::
  :::column:::
    **Make**
  :::column-end:::
  :::column:::
    **Time**
  :::column-end:::
  :::column:::
    **Weight**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    2015-01-01T00:00:01.0000000Z
  :::column-end:::
  :::column:::
    "1000"
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    2015-01-01T00:00:02.0000000Z
  :::column-end:::
  :::column:::
    "2000"
  :::column-end:::
:::row-end:::


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

:::row:::
  :::column:::
    **Make**
  :::column-end:::
  :::column:::
    **Weight**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    3000
  :::column-end:::
:::row-end:::


#### Explanation

We use a CAST statement in the Weight field to specify its data type.

### Pattern 2 - Send data to multiple outputs

#### Description

In this example, the input stream includes the make of a car and the time when that car passes through the booth. We have two goals. The first goal it to archive the input data to cold storage. The second goal is to support a downstream alerting system that sends alerts whenever the traffic rate for a particular make of vehicle exceeds a defined threshold value. To achieve both goals we need to process the data for multiple output targets. The first target output will receive all of the input data. For the second target output will receive a record indicating the make of the vehicle, the time for the event, and the associated number of vehicles passing through the booth.

#### Input

:::row:::
  :::column:::
    **Make**
  :::column-end:::
  :::column:::
    **Time**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    2015-01-01T00:00:01.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    2015-01-01T00:00:02.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:01.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:02.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:03.0000000Z
  :::column-end:::
:::row-end:::


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

:::row:::
  :::column:::
    **Make**
  :::column-end:::
  :::column:::
    **Time**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    2015-01-01T00:00:01.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Honda
  :::column-end:::
  :::column:::
    2015-01-01T00:00:02.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:01.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:02.0000000Z
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:03.0000000Z
  :::column-end:::
:::row-end:::


#### Output 2

:::row:::
  :::column:::
    **Make**
  :::column-end:::
  :::column:::
    **Time**
  :::column-end:::
  :::column:::
    **Count**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Toyota
  :::column-end:::
  :::column:::
    2015-01-01T00:00:10.0000000Z
  :::column-end:::
  :::column:::
    3
  :::column-end:::
:::row-end:::


#### Explanation

The INTO clause tells Stream Analytics the outputs to write the data to from this statement. The first query is a pass-through of the data received to an output named ArchiveOutput. The second query does some simple aggregation and filtering, and it sends the results to a downstream alerting system, AlertOutput.

The full Stream Analytics query language reference guide can be found here: [https://docs.microsoft.com/stream-analytics-query/stream-analytics-query-language-reference](/stream-analytics-query/stream-analytics-query-language-reference).
