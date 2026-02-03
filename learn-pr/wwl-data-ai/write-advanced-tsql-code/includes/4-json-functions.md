Consider a scenario where your e-commerce application stores customer preferences and order metadata as JSON documents. A mobile app sends shopping cart data in JSON format, and your reporting system needs to export product catalogs as JSON for a web API. Working directly with JSON in your database eliminates the need for application-layer transformations and keeps your data processing efficient.

SQL Server, Azure SQL, and SQL databases in Fabric provide built-in JSON support that lets you parse, query, create, and transform JSON data directly in T-SQL. In this unit, you'll learn how to use JSON functions to extract values, construct JSON output, aggregate data into JSON arrays, and validate JSON content.

## Extract values with JSON_VALUE and JSON_QUERY

When working with JSON stored in your database, you need to extract specific values for filtering, joining, or displaying. SQL Server provides two functions for this purpose:

**`JSON_VALUE()`** extracts a scalar value (string, number, boolean) from a JSON string:

```sql
DECLARE @json NVARCHAR(MAX) = N'{
    "customer": {
        "id": 12345,
        "name": "Contoso Ltd",
        "active": true
    },
    "orderTotal": 1599.99
}';

SELECT 
    JSON_VALUE(@json, '$.customer.id') AS CustomerID,
    JSON_VALUE(@json, '$.customer.name') AS CustomerName,
    JSON_VALUE(@json, '$.orderTotal') AS OrderTotal;
```

The result set will be:

```
CustomerID   CustomerName   OrderTotal
----------   ------------   ----------
12345        Contoso Ltd    1599.99
```

The function navigates the JSON structure using the path expression and returns the value as an `NVARCHAR(4000)` string. You can cast the result to other data types as needed for calculations or comparisons.

**`JSON_QUERY()`** extracts a JSON object or array (nonscalar values):

```sql
DECLARE @json NVARCHAR(MAX) = N'{
    "customer": {
        "id": 12345,
        "name": "Contoso Ltd"
    },
    "items": [
        {"product": "Widget", "qty": 5},
        {"product": "Gadget", "qty": 3}
    ]
}';

SELECT 
    JSON_QUERY(@json, '$.customer') AS CustomerObject,
    JSON_QUERY(@json, '$.items') AS ItemsArray;
```

The result set will be:

```
CustomerObject                          ItemsArray
--------------------------------------  ------------------------------------------------
{"id": 12345,"name": "Contoso Ltd"}     [{"product": "Widget", "qty": 5},{"product": "Gadget", "qty": 3}]
```

Unlike `JSON_VALUE()`, `JSON_QUERY()` preserves the JSON structure, returning objects and arrays as valid JSON strings that you can store, pass to other functions, or return to applications.

The path expression uses `$` to represent the root element, with dot notation for nested properties and bracket notation for array elements, like in the following example:

```sql
-- Access array elements by index (0-based)
SELECT JSON_VALUE(@json, '$.items[0].product') AS FirstProduct;
```

The result will be:

```
FirstProduct
------------
Widget
```

Array indices start at 0, so `$.items[0]` refers to the first element. Use this syntax to extract specific items when you know the position, or combine with `OPENJSON` when you need to process all array elements.

> [!TIP]
> Use `JSON_VALUE()` when you need a scalar value for comparisons or calculations. Use `JSON_QUERY()` when you need to preserve the JSON structure of nested objects or arrays.

## Parse JSON arrays with `OPENJSON`

`OPENJSON` is a table-valued function that transforms JSON data into a relational rowset. Use this function to join JSON data with relational tables or process array elements individually.

The following query parses a JSON array into rows with default schema:

```sql
DECLARE @json NVARCHAR(MAX) = N'[
    {"id": 1, "name": "Widget", "price": 29.99},
    {"id": 2, "name": "Gadget", "price": 49.99},
    {"id": 3, "name": "Gizmo", "price": 19.99}
]';

SELECT * FROM OPENJSON(@json);
```

The result set will be:

```
key   value                                          type
---   --------------------------------------------   ----
0     {"id": 1, "name": "Widget", "price": 29.99}   5
1     {"id": 2, "name": "Gadget", "price": 49.99}   5
2     {"id": 3, "name": "Gizmo", "price": 19.99}    5
```

Without a schema, `OPENJSON` returns three columns: `key` (the array index or property name), `value` (the JSON content), and `type` (a number indicating the JSON data type: 0=null, 1=string, 2=number, 3=boolean, 4=array, 5=object).

The following query defines an explicit schema to extract specific columns with proper data types:

```sql
SELECT 
    ProductID,
    ProductName,
    Price
FROM OPENJSON(@json)
WITH (
    ProductID INT '$.id',
    ProductName NVARCHAR(100) '$.name',
    Price DECIMAL(10,2) '$.price'
);
```

The result set will be:

```
ProductID   ProductName   Price
---------   -----------   ------
1           Widget        29.99
2           Gadget        49.99
3           Gizmo         19.99
```

The `WITH` clause maps JSON properties to typed columns. This approach gives you proper data types for calculations and comparisons, and lets you select only the properties you need.

Combine `OPENJSON` with table data using `CROSS APPLY`:

```sql
-- Assuming Orders table has a JSON column called OrderDetails
SELECT 
    o.OrderID,
    o.CustomerID,
    items.ProductName,
    items.Quantity,
    items.UnitPrice
FROM Orders AS o
CROSS APPLY OPENJSON(o.OrderDetails)
WITH (
    ProductName NVARCHAR(100) '$.product',
    Quantity INT '$.qty',
    UnitPrice DECIMAL(10,2) '$.price'
) AS items;
```

> [!NOTE]
> When using `OPENJSON` with `CROSS APPLY`, rows from the main table that have `NULL` or empty JSON values don't appear in the results. Use `OUTER APPLY` if you need to include rows with no JSON data.

## Construct JSON with `JSON_OBJECT` and `JSON_ARRAY`

SQL Server 2022 introduced `JSON_OBJECT` and `JSON_ARRAY` functions for intuitive JSON construction:

**`JSON_OBJECT()`** creates a JSON object from key-value pairs, the following example shows how to build a JSON object for a product:

```sql
SELECT JSON_OBJECT(
    'id': ProductID,
    'name': Name,
    'price': ListPrice,
    'available': CASE WHEN SellEndDate IS NULL THEN 'true' ELSE 'false' END
) AS ProductJson
FROM SalesLT.Product
WHERE ProductID = 680;
```

The result will be:

```
ProductJson
---------------------------------------------------------------------------
{"id":680,"name":"HL Road Frame - Black, 58","price":1431.50,"available":"true"}
```

The function automatically handles data type conversion and proper JSON escaping for special characters in string values.

**`JSON_ARRAY()`** creates a JSON array from values, the following example builds a JSON array:

```sql
SELECT JSON_ARRAY(
    'SQL Server',
    'Azure SQL Database',
    'SQL Database in Fabric'
) AS Platforms;
```

The result will be:

```
Platforms
---------------------------------------------------------
["SQL Server","Azure SQL Database","SQL Database in Fabric"]
```

You can pass column values, variables, or literal values to `JSON_ARRAY()`. The function creates a properly formatted JSON array regardless of the input types.

Then, combine these functions to build nested JSON structures. The following example constructs a complete order JSON object with customer and totals information:

```sql
SELECT JSON_OBJECT(
    'orderId': soh.SalesOrderID,
    'orderDate': soh.OrderDate,
    'customer': JSON_OBJECT(
        'id': c.CustomerID,
        'name': c.CompanyName
    ),
    'totals': JSON_OBJECT(
        'subtotal': soh.SubTotal,
        'tax': soh.TaxAmt,
        'total': soh.TotalDue
    )
) AS OrderJson
FROM SalesLT.SalesOrderHeader AS soh
INNER JOIN SalesLT.Customer AS c
    ON soh.CustomerID = c.CustomerID
WHERE soh.SalesOrderID = 71774;
```

The result will be:

```
OrderJson
--------------------------------------------------------------------------------
{"orderId":71774,"orderDate":"2008-06-01","customer":{"id":29825,"name":"Contoso"},"totals":{"subtotal":880.35,"tax":70.43,"total":972.79}}
```

Nesting `JSON_OBJECT` calls creates hierarchical structures that match your application's expected format. This approach is cleaner than string concatenation and ensures valid JSON output.

## Aggregate data with `JSON_ARRAYAGG`

`JSON_ARRAYAGG` aggregates values from multiple rows into a single JSON array. This function is useful for creating denormalized JSON output from normalized relational data:

```sql
SELECT 
    c.CustomerID,
    c.CompanyName,
    JSON_ARRAYAGG(soh.SalesOrderID) AS OrderIds
FROM SalesLT.Customer AS c
INNER JOIN SalesLT.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, c.CompanyName;
```

The result will be:

```
CustomerID   CompanyName           OrderIds
----------   -------------------   ------------------
29825        Contoso Retail        [71774,71776,71780]
29847        Adventure Works       [71782,71784]
```

The function collects all matching values from the grouped rows and combines them into a single JSON array. This is useful for creating denormalized API responses from normalized database tables.

You can combine `JSON_ARRAYAGG` with `JSON_OBJECT` to create arrays of complex objects:

```sql
SELECT 
    pc.Name AS Category,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'id': p.ProductID,
            'name': p.Name,
            'price': p.ListPrice
        )
    ) AS Products
FROM SalesLT.ProductCategory AS pc
INNER JOIN SalesLT.Product AS p
    ON pc.ProductCategoryID = p.ProductCategoryID
GROUP BY pc.ProductCategoryID, pc.Name;
```

The following result will be:

```
Category        Products
--------------  --------------------------------------------------------------------------
Road Bikes      [{"id":749,"name":"Road-150 Red, 62","price":3578.27},{"id":750,"name":"Road-150 Red, 44","price":3578.27}]
Mountain Bikes  [{"id":771,"name":"Mountain-100 Silver, 38","price":3399.99},{"id":772,"name":"Mountain-100 Black, 38","price":3374.99}]
```

> [!IMPORTANT]
> `JSON_ARRAYAGG` and `JSON_OBJECT`/`JSON_ARRAY` functions are available in SQL Server 2022 and later, Azure SQL Database, and SQL databases in Microsoft Fabric. For earlier versions, use `FOR JSON PATH` for similar functionality.

## Validate and check JSON with `JSON_CONTAINS`

JSON data from external sources can be malformed, missing expected properties, or contain unexpected values. Attempting to extract values from invalid JSON or missing paths can cause query failures or return misleading `NULL` results that mask data problems.

Robust JSON processing requires defensive coding: validate that the JSON is well-formed before parsing it, check that expected paths exist before extracting values, and verify that values match your expectations before using them in business logic. SQL Server provides several functions to help you validate JSON content at each stage of processing.

### Understand lax vs strict path modes

You can use JSON path expressions in two modes that control error handling:

```sql
DECLARE @json NVARCHAR(MAX) = N'{"name": "Widget", "price": 29.99}';

-- Lax mode (default): Returns NULL for missing paths
SELECT JSON_VALUE(@json, 'lax $.description') AS LaxResult;

-- Strict mode: Raises an error for missing paths
SELECT JSON_VALUE(@json, 'strict $.description') AS StrictResult;
```

The result will be:

```
LaxResult
---------
NULL

-- Strict mode raises: Property cannot be found on the specified JSON path.
```

Use `lax` mode (the default) when missing properties are expected and should return `NULL`. Use `strict` mode when missing properties indicate a data problem that should raise an error.

**`ISJSON`** validates whether a string contains valid JSON. The following example shows how to use `ISJSON`:

```sql
SELECT 
    ISJSON('{"name": "test"}') AS ValidJson,      -- Returns 1
    ISJSON('not valid json') AS InvalidJson,       -- Returns 0
    ISJSON(NULL) AS NullJson;                      -- Returns NULL
```

The result will be:

```
ValidJson   InvalidJson   NullJson
---------   -----------   --------
1           0             NULL
```

Use `ISJSON` in `WHERE` clauses to filter rows with valid JSON, or in `CASE` expressions to handle invalid data gracefully.

**`JSON_PATH_EXISTS`** checks whether a specific path exists in a JSON document, like the following example:

```sql
DECLARE @json NVARCHAR(MAX) = N'{"customer": {"name": "Contoso", "tier": "Gold"}}';

SELECT 
    JSON_PATH_EXISTS(@json, '$.customer.name') AS HasName,
    JSON_PATH_EXISTS(@json, '$.customer.email') AS HasEmail;
```

The result will be:

```
HasName   HasEmail
-------   --------
1         0
```

This function returns 1 if the path exists, 0 if it doesn't. Use it before calling `JSON_VALUE` in strict mode, or to conditionally process JSON with varying structures.

Use `JSON_CONTAINS` to check if a JSON document contains a specific value or object, like the following example:

```sql
DECLARE @json NVARCHAR(MAX) = N'{"tags": ["sql", "database", "azure"]}';

SELECT 
    JSON_CONTAINS(@json, '"sql"', '$.tags') AS HasSqlTag,
    JSON_CONTAINS(@json, '"python"', '$.tags') AS HasPythonTag;
```

The result will be:

```
HasSqlTag   HasPythonTag
---------   ------------
1           0
```

## Optimize JSON queries with computed columns

When you frequently query specific JSON properties, the database engine must parse the JSON document for every row on every query. For tables with thousands or millions of rows, this repeated parsing creates significant overhead. Computed columns let you extract JSON values once and store them in a queryable format that supports indexing.

### Why JSON parsing impacts performance

Consider a table with 100,000 product records where each row contains a JSON document with product attributes. A query filtering by category must:

1. Read each row from the table
2. Parse the JSON document to find the category property
3. Extract and compare the value

Without optimization, even simple filters require full table scans with JSON parsing on every row.

### Create computed columns for JSON properties

A computed column automatically extracts a JSON property and makes it available as a regular column, like the following example:

```sql
-- Add a computed column that extracts a JSON property
ALTER TABLE Products
ADD ProductCategory AS JSON_VALUE(ProductData, '$.category');

-- The column is now available in queries
SELECT ProductID, ProductName, ProductCategory
FROM Products
WHERE ProductCategory = 'Electronics';
```

The result will be:

```
ProductID   ProductName           ProductCategory
---------   -------------------   ---------------
101         Wireless Mouse        Electronics
102         USB Keyboard          Electronics
103         HD Monitor            Electronics
```

By default, computed columns are virtual. The database calculates the value at query time but can optimize the JSON extraction. For even better performance, you can persist the computed column like in the following example:

```sql
-- Persisted computed column stores the extracted value physically
ALTER TABLE Products
ADD ProductCategory AS JSON_VALUE(ProductData, '$.category') PERSISTED;
```

Persisted columns store the extracted value on disk, so the JSON is parsed only during `INSERT` and `UPDATE` operations, not during `SELECT` queries.

### Add indexes for faster filtering

The real performance gain comes from indexing computed columns:

```sql
-- Create an index on the computed column
CREATE INDEX IX_Products_Category ON Products(ProductCategory);

-- Now this query uses an index seek instead of a table scan
SELECT ProductID, ProductName
FROM Products
WHERE ProductCategory = 'Electronics';
```

Without the index, the query scans all 100,000 rows. With the index, the query engine performs an index seek and retrieves only matching rows. This can reduce query time from seconds to milliseconds.

### Index multiple JSON properties

For queries that filter on multiple JSON properties, create computed columns and a composite index:

```sql
-- Extract multiple properties
ALTER TABLE Products
ADD ProductCategory AS JSON_VALUE(ProductData, '$.category') PERSISTED,
    ProductBrand AS JSON_VALUE(ProductData, '$.brand') PERSISTED,
    ProductPrice AS CAST(JSON_VALUE(ProductData, '$.price') AS DECIMAL(10,2)) PERSISTED;

-- Create a composite index for common query patterns
CREATE INDEX IX_Products_Category_Brand ON Products(ProductCategory, ProductBrand);

-- Create an index for price range queries
CREATE INDEX IX_Products_Price ON Products(ProductPrice);
```

Now queries filtering by category and brand, or sorting by price, can use these indexes efficiently.

> [!TIP]
> For frequently accessed JSON properties, computed columns with indexes can improve query performance compared to parsing JSON at query time. Monitor your query patterns and create computed columns for properties used in `WHERE`, `JOIN`, or `ORDER BY` clauses.

## Transform relational data to JSON with FOR JSON

For comprehensive JSON output from queries, use `FOR JSON PATH` or `FOR JSON AUTO`:

```sql
SELECT 
    p.ProductID,
    p.Name,
    p.ListPrice,
    pc.Name AS CategoryName
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ListPrice > 1000
FOR JSON PATH, ROOT('products');
```

The result will be:

```
{"products":[{"ProductID":749,"Name":"Road-150 Red, 62","ListPrice":3578.27,"CategoryName":"Road Bikes"},{"ProductID":750,"Name":"Road-150 Red, 44","ListPrice":3578.27,"CategoryName":"Road Bikes"}]}
```

`FOR JSON PATH` gives you control over the JSON structure through column aliases. Use dot notation in aliases to create nested objects:

```sql
SELECT 
    p.ProductID AS 'product.id',
    p.Name AS 'product.name',
    pc.Name AS 'product.category'
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory AS pc
    ON p.ProductCategoryID = pc.ProductCategoryID
WHERE p.ProductID = 680
FOR JSON PATH;
```

The result will be:

```
[{"product":{"id":680,"name":"HL Road Frame - Black, 58","category":"Road Frames"}}]
```

The column alias `'product.id'` creates a nested `product` object with an `id` property. This technique lets you shape the output to match your API's expected format without post-processing.

For more information about JSON functions in SQL Server, see [JSON data in SQL Server](/sql/relational-databases/json/json-data-sql-server?azure-portal=true) and [JSON Functions](/sql/t-sql/functions/json-functions-transact-sql?azure-portal=true).
