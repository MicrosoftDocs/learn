# JSON and String Aggregation in SQL Server 2025

SQL Server 2025 introduces new aggregation functions for building JSON arrays, JSON objects, and delimited strings. These additions make it easier to generate structured output such as API responses, reports, or log exports directly from T-SQL queries. The new functions let you move data formatting into the database layer, reducing the need for complex client-side transformation.

## Overview of JSON and String Aggregation Functions

Let's look at the three new aggregation functions:

### JSON_ARRAYAGG  
Creates a JSON array from the values of an expression. Each row’s value becomes an element in the resulting JSON array. It simplifies generating arrays of values such as lists of IDs or names.

### JSON_OBJECTAGG  
Creates a JSON object from key-value pairs. The first argument defines the key, and the second defines the value. This value-pairing makes it easy to build JSON documents directly from query results.

### STRING_CONCAT_WS  
Concatenates strings with a specified separator while skipping NULL values. The function’s name stands for *String CONCAT With Separator*. It provides an efficient way to join values like names, tags, or comma-delimited lists.

### String concatenation operator ||

SQL Server 2025 introduces the ANSI-standard `||` operator as an alternative to `+` for string concatenation. It provides more portable syntax and is often preferred when combining multiple columns into a single text output.

### UNISTR function

`UNISTR()` returns a Unicode string based on escape sequences, enabling you to insert characters by code point or escape notation. It’s useful when authoring scripts that include nonprintable or multilingual characters.

## Example 1: Build JSON Arrays and Objects from Query Results

Imagine your database stores customer order data in two tables, `Sales.Customer` and `Sales.SalesOrderHeader`. The analytics team needs a JSON report summarizing each customer and their order IDs for integration with a web dashboard.

### Query: Use JSON_ARRAYAGG and JSON_OBJECTAGG

The following query retrieves each customer along with a JSON array of their order IDs, wrapped in a JSON object.

```sql
SELECT
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    JSON_OBJECTAGG(
        'Customer' : C.CustomerID,
        'Orders'   : JSON_ARRAYAGG(SOH.SalesOrderID)
    ) AS CustomerSummary
FROM Sales.Customer AS C
JOIN Sales.SalesOrderHeader AS SOH
    ON C.CustomerID = SOH.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName;
```

### Results

| CustomerID | CustomerName | CustomerSummary |
|-------------|--------------|-----------------|
| 11001 | Jordan Patterson | {"Customer":11001,"Orders":[43722,43723,43724]} |
| 11002 | Alicia Tran | {"Customer":11002,"Orders":[43725,43726]} |
| 11003 | Marco Diaz | {"Customer":11003,"Orders":[43727]} |

In this example, `JSON_ARRAYAGG` collects all order IDs for each customer into a JSON array, and `JSON_OBJECTAGG` wraps the result into a JSON object with clear key-value pairs. The entire structure is produced in one T-SQL query.

## Example 2: Format Text Output Using STRING_CONCAT_WS

The marketing team needs a list of each customer’s purchased product names separated by commas for an email campaign. The `STRING_CONCAT_WS` function can generate these results cleanly, omitting any NULL values.

### Query: Join Product Names with a Separator

The following query retrieves each customer along with a comma-separated list of products they purchased.

```sql
SELECT
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    STRING_CONCAT_WS(', ',
        P.Name
    ) AS ProductsPurchased
FROM Sales.Customer AS C
JOIN Sales.SalesOrderHeader AS SOH
    ON C.CustomerID = SOH.CustomerID
JOIN Sales.SalesOrderDetail AS SOD
    ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN Production.Product AS P
    ON SOD.ProductID = P.ProductID
GROUP BY C.CustomerID, C.FirstName, C.LastName;
```

### Results

| CustomerID | CustomerName | ProductsPurchased |
|-------------|--------------|-------------------|
| 11001 | Jordan Patterson | Touring-2000 Blue, 50, Mountain-100 Black, 44 |
| 11002 | Alicia Tran | Road-250 Yellow, 44, Mountain-200 Red, 48 |
| 11003 | Marco Diaz | Touring-3000 Blue, 62 |

Here, `STRING_CONCAT_WS` joins product names with commas and ignores NULL entries automatically, avoiding manual `COALESCE`, or `ISNULL` logic.

## Example 3: Combine JSON and Delimited Text for API Output

You can also use these functions together to prepare structured data for an API response. The following query creates a JSON array of objects where each object contains a customer’s name and comma-delimited product list.

```sql
SELECT
    JSON_ARRAYAGG(
        JSON_OBJECTAGG(
            'Customer' : C.FirstName + ' ' + C.LastName,
            'Products' : STRING_CONCAT_WS(', ', P.Name)
        )
    ) AS ApiOutput
FROM Sales.Customer AS C
JOIN Sales.SalesOrderHeader AS SOH
    ON C.CustomerID = SOH.CustomerID
JOIN Sales.SalesOrderDetail AS SOD
    ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN Production.Product AS P
    ON SOD.ProductID = P.ProductID
GROUP BY C.CustomerID, C.FirstName, C.LastName;
```

### Result Sample

```json
[
  {"Customer":"Jordan Patterson","Products":"Touring-2000 Blue, 50, Mountain-100 Black, 44"},
  {"Customer":"Alicia Tran","Products":"Road-250 Yellow, 44, Mountain-200 Red, 48"},
  {"Customer":"Marco Diaz","Products":"Touring-3000 Blue, 62"}
]
```

An application directly consumes this structure or exports it as a JSON document through tools like SQL Server Management Studio (SSMS) or Azure Data Studio.

## Summary

SQL Server 2025 adds `JSON_ARRAYAGG`, `JSON_OBJECTAGG`, and `STRING_CONCAT_WS` to simplify building structured text and JSON output within T-SQL. These functions let you generate application-ready data from queries without external code. Whether you’re preparing JSON payloads, constructing reports, or formatting API responses, these aggregation features make SQL Server 2025 a more versatile platform for modern data applications.
