Scalar functions return a single value and usually work on a single row of data. The number of input values they take can be zero (for example, GETDATE), one (for example, UPPER), or multiple (for example, ROUND). Because scalar functions always return a single value, they can be used anywhere a single value (the result) is needed. They are most commonly used in SELECT clauses and WHERE clause predicates. They can also be used in the SET clause of an UPDATE statement.

Built-in scalar functions can be organized into many categories, such as string, conversion, logical, mathematical, and others. This module will look at a few common scalar functions.

Some considerations when using scalar functions include:

 *  **Determinism**: If the function returns the same value for the same input and database state each time it is called, we say it is *deterministic*. For example, ROUND(1.1, 0) always returns the value 1.0. Many built-in functions are *nondeterministic*. For example, GETDATE() returns the current date and time. Results from nondeterministic functions cannot be indexed, which affects the query processor's ability to come up with a good plan for executing the query.
 *  **Collation**: When using functions that manipulate character data, which collation will be used? Some functions use the collation (sort order) of the input value; others use the collation of the database if no input collation is supplied.

## Scalar function examples

At the time of writing, the SQL Server Technical Documentation listed more than 200 scalar functions that span multiple categories, including:

 *  Configuration functions
 *  Conversion functions
 *  Cursor functions
 *  Date and Time functions
 *  Mathematical functions
 *  Metadata functions
 *  Security functions
 *  String functions
 *  System functions
 *  System Statistical functions
 *  Text and Image functions

There isn't enough time in this course to describe each function, but the examples below show some commonly used functions.

The following hypothetical example uses several date and time functions:

```sql
SELECT  SalesOrderID,
    OrderDate,
        YEAR(OrderDate) AS OrderYear,
        DATENAME(mm, OrderDate) AS OrderMonth,
        DAY(OrderDate) AS OrderDay,
        DATENAME(dw, OrderDate) AS OrderWeekDay,
        DATEDIFF(yy,OrderDate, GETDATE()) AS YearsSinceOrder
FROM Sales.SalesOrderHeader;
```

Partial results are shown below:

:::row:::
  :::column:::
    SalesOrderID
  :::column-end:::
  :::column:::
    OrderDate
  :::column-end:::
  :::column:::
    OrderYear
  :::column-end:::
  :::column:::
    OrderMonth
  :::column-end:::
  :::column:::
    OrderDay
  :::column-end:::
  :::column:::
    OrderWeekDay
  :::column-end:::
  :::column:::
    YearsSinceOrder
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    71774
  :::column-end:::
  :::column:::
    2008-06-01T00:00:00
  :::column-end:::
  :::column:::
    2008
  :::column-end:::
  :::column:::
    June
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Sunday
  :::column-end:::
  :::column:::
    13
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

The next example includes some mathematical functions:

```sql
SELECT TaxAmt,
       ROUND(TaxAmt, 0) AS Rounded,
       FLOOR(TaxAmt) AS Floor,
       CEILING(TaxAmt) AS Ceiling,
       SQUARE(TaxAmt) AS Squared,
       SQRT(TaxAmt) AS Root,
       LOG(TaxAmt) AS Log,
       TaxAmt * RAND() AS Randomized
FROM Sales.SalesOrderHeader;
```

Partial results:

:::row:::
  :::column:::
    TaxAmt
  :::column-end:::
  :::column:::
    Rounded
  :::column-end:::
  :::column:::
    Floor
  :::column-end:::
  :::column:::
    Ceiling
  :::column-end:::
  :::column:::
    Squared
  :::column-end:::
  :::column:::
    Root
  :::column-end:::
  :::column:::
    Log
  :::column-end:::
  :::column:::
    Randomized
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    70.4279
  :::column-end:::
  :::column:::
    70.0000
  :::column-end:::
  :::column:::
    70.0000
  :::column-end:::
  :::column:::
    71.0000
  :::column-end:::
  :::column:::
    4960.089098
  :::column-end:::
  :::column:::
    8.392133221
  :::column-end:::
  :::column:::
    4.254589491
  :::column-end:::
  :::column:::
    28.64120429
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ..
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

The following example uses some string functions:

```sql
SELECT  CompanyName,
        UPPER(CompanyName) AS UpperCase,
        LOWER(CompanyName) AS LowerCase,
        LEN(CompanyName) AS Length,
        REVERSE(CompanyName) AS Reversed,
        CHARINDEX(' ', CompanyName) AS FirstSpace,
        LEFT(CompanyName, CHARINDEX(' ', CompanyName)) AS FirstWord,
        SUBSTRING(CompanyName, CHARINDEX(' ', CompanyName) + 1, LEN(CompanyName)) AS RestOfName
FROM Sales.Customer;
```

Partial results:

:::row:::
  :::column:::
    CompanyName
  :::column-end:::
  :::column:::
    UpperCase
  :::column-end:::
  :::column:::
    LowerCase
  :::column-end:::
  :::column:::
    Length
  :::column-end:::
  :::column:::
    Reversed
  :::column-end:::
  :::column:::
    FirstSpace
  :::column-end:::
  :::column:::
    FirstWord
  :::column-end:::
  :::column:::
    RestOfName
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    A Bike Store
  :::column-end:::
  :::column:::
    A BIKE STORE
  :::column-end:::
  :::column:::
    a bike store
  :::column-end:::
  :::column:::
    12
  :::column-end:::
  :::column:::
    erotS ekiB A
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    A
  :::column-end:::
  :::column:::
    Bike Store
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Progressive Sports
  :::column-end:::
  :::column:::
    PROGRESSIVE SPORTS
  :::column-end:::
  :::column:::
    progressive sports
  :::column-end:::
  :::column:::
    18
  :::column-end:::
  :::column:::
    stropS evissergorP
  :::column-end:::
  :::column:::
    12
  :::column-end:::
  :::column:::
    Progressive
  :::column-end:::
  :::column:::
    Sports
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Advanced Bike Components
  :::column-end:::
  :::column:::
    ADVANCED BIKE COMPONENTS
  :::column-end:::
  :::column:::
    advanced bike components
  :::column-end:::
  :::column:::
    24
  :::column-end:::
  :::column:::
    stnenopmoC ekiB decnavdA
  :::column-end:::
  :::column:::
    9
  :::column-end:::
  :::column:::
    Advanced
  :::column-end:::
  :::column:::
    Bike Components
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

## Logical functions

Another category of functions allows determine which of several values is to be returned. Logical functions evaluate an input expression, and return an appropriate value based on the result.

### IIF

The **IIF** function evaluates a Boolean input expression, and returns a specified value if the expression evaluates to **True**, and an alternative value if the expression evaluates to **False**.

For example, consider the following query, which evaluates the address type of a customer. If the value is "Main Office", the expression returns "Billing". For all other address type values, the expression returns "Mailing".

```sql
SELECT AddressType,
      IIF(AddressType = 'Main Office', 'Billing', 'Mailing') AS UseAddressFor
FROM Sales.CustomerAddress;
```

The partial results from this query might look like this:

:::row:::
  :::column:::
    AddressType
  :::column-end:::
  :::column:::
    UseAddressFor
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Main Office
  :::column-end:::
  :::column:::
    Billing
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Shipping
  :::column-end:::
  :::column:::
    Mailing
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

### CHOOSE

The **CHOOSE** function evaluates an integer expression, and returns the corresponding value from a list based on its (1-based) ordinal position.

```sql
SELECT SalesOrderID, Status,
CHOOSE(Status, 'Ordered', 'Shipped', 'Delivered') AS OrderStatus
FROM Sales.SalesOrderHeader;
```

The results from this query might look something like this:

:::row:::
  :::column:::
    SalesOrderID
  :::column-end:::
  :::column:::
    Status
  :::column-end:::
  :::column:::
    OrderStatus
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1234
  :::column-end:::
  :::column:::
    3
  :::column-end:::
  :::column:::
    Delivered
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1235
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    Shipped
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1236
  :::column-end:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    Shipped
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1237
  :::column-end:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    Ordered
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::


