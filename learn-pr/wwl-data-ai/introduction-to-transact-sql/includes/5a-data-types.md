Columns and variables used in Transact-SQL each have a *data type*. The behavior of values in expressions depends on the data type of the column or variable being referenced. For example, as you saw previously, you can use the **+** operator to concatenate two string values, or to add two numeric values.

The following table shows common data types supported in a SQL Server database.

:::row:::
  :::column:::
    Exact Numeric
  :::column-end:::
  :::column:::
    Approximate Numeric
  :::column-end:::
  :::column:::
    Character
  :::column-end:::
  :::column:::
    Date/Time
  :::column-end:::
  :::column:::
    Binary
  :::column-end:::
  :::column:::
    Other
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    tinyint
  :::column-end:::
  :::column:::
    float
  :::column-end:::
  :::column:::
    char
  :::column-end:::
  :::column:::
    date
  :::column-end:::
  :::column:::
    binary
  :::column-end:::
  :::column:::
    cursor
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    smallint
  :::column-end:::
  :::column:::
    real
  :::column-end:::
  :::column:::
    varchar
  :::column-end:::
  :::column:::
    time
  :::column-end:::
  :::column:::
    varbinary
  :::column-end:::
  :::column:::
    hierarchyid
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    int
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    text
  :::column-end:::
  :::column:::
    datetime
  :::column-end:::
  :::column:::
    image
  :::column-end:::
  :::column:::
    sql\_variant
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    bigint
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    nchar
  :::column-end:::
  :::column:::
    datetime2
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    table
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    bit
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    nvarchar
  :::column-end:::
  :::column:::
    smalldatetime
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    timestamp
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    decimal/numeric
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    ntext
  :::column-end:::
  :::column:::
    datetimeoffset
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    uniqueidentifier
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    numeric
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    xml
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    money
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    geography
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    smallmoney
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    geometry
  :::column-end:::
:::row-end:::

## Data type conversion

Values of compatible data types can be implicitly converted as required. For example, suppose you can use the **+** operator to add an *integer* number to a *decimal* number, or to concatenate a fixed-length *char* value and a variable length *varchar* value. However, in some cases you may need to explicitly convert values from one data type to another - for example, trying to use **+** to concatenate a *varchar* value and a *decimal* value will result in an error unless you first convert the numeric value to a compatible string data type.

> [!NOTE]
> For the full list of data type conversions, see the [Transact-SQL reference documentation](/sql/t-sql/data-types/data-type-conversion-database-engine).

T-SQL includes functions to help you convert between data types:

### CAST and TRY_CAST

The CAST function converts a value to a specified data type if the value is compatible with the target data type. If it is not compatible, an error is returned.

For example, the following query uses CAST to convert the *integer* values in the **ProductID** column to *varchar* values (with a maximum of 4 characters) in order to concatenate them with another character-based value:

```sql
SELECT CAST(ProductID AS varchar(4)) + ': ' + Name AS ProductName
FROM Production.Product;
```

Possible result from this query might look something like this:

:::row:::
  :::column:::
    ProductName
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680: HL Road Frame - Black, 58
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706: HL Road Frame - Red, 58
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707: Sport-100 Helmet, Red
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    708: Sport-100 Helmet, Black
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

However, let's suppose the **Size** column in the **Production.Product** table is a *nvarchar* (variable length, Unicode text data) column that contains some numeric sizes (like 58) and some text-based sizes (like "S", "M", or "L"). The following query tries to convert values from this column to an *integer* data type:

```sql
SELECT CAST(Size AS integer) As NumericSize
FROM Production.Product;
```

This query results in the following error message:

> Error: Conversion failed when converting the nvarchar value 'M' to data type int.

Given that at least *some* of the values in the column are numeric, you might want to convert those values and ignore the others. You can use the TRY_CAST function to convert data types.

```sql
SELECT TRY_CAST(Size AS integer) As NumericSize
FROM Production.Product;
```

The results this time look might like this:

:::row:::
  :::column:::
    NumericSize
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    58
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    58
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

The values that can be converted to a numeric data type are returned as *decimal* values, and the incompatible values are returned as *NULL*, which is used to indicate that a value is *unknown*.

> [!NOTE]
> We'll explore considerations for handling *NULL* values later in this unit.

### CONVERT and TRY_CONVERT

CAST is the ANSI standard SQL function for converting between data types, and is used in many database systems. In Transact-SQL, you can also use the CONVERT function, as shown here:

```sql
SELECT CONVERT(varchar(4), ProductID) + ': ' + Name AS ProductName
FROM Production.Product;
```

Once again, this query returns the value converted to the specified data type, like this:

:::row:::
  :::column:::
    ProductName
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680: HL Road Frame - Black, 58
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706: HL Road Frame - Red, 58
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707: Sport-100 Helmet, Red
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    708: Sport-100 Helmet, Black
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    ...
  :::column-end:::
:::row-end:::

Like CAST, CONVERT has a TRY_CONVERT variant that returns *NULL* for incompatible values.

Another benefit of using CONVERT over CAST, is that CONVERT also includes a parameter that enables you specify a format style when converting numeric and date values to strings. For example, consider the following query:

```sql
SELECT SellStartDate,
       CONVERT(varchar(20), SellStartDate) AS StartDate,
       CONVERT(varchar(10), SellStartDate, 101) AS FormattedStartDate 
FROM SalesLT.Product;
```

The results from this query might look something like this:

:::row:::
  :::column:::
    SellStartDate
  :::column-end:::
  :::column:::
    StartDate
  :::column-end:::
  :::column:::
    FormattedStartDate
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2002-06-01T00:00:00.0000000
  :::column-end:::
  :::column:::
    Jun 1 2002 12:00AM
  :::column-end:::
  :::column:::
    6/1/2002
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2002-06-01T00:00:00.0000000
  :::column-end:::
  :::column:::
    Jun 1 2002 12:00AM
  :::column-end:::
  :::column:::
    6/1/2002
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2005-07-01T00:00:00.0000000
  :::column-end:::
  :::column:::
    Jul 1 2005 12:00AM
  :::column-end:::
  :::column:::
    7/1/2005
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2005-07-01T00:00:00.0000000
  :::column-end:::
  :::column:::
    Jul 1 2005 12:00AM
  :::column-end:::
  :::column:::
    7/1/2005
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


> [!NOTE]
> To find out more about *style formatting* codes you can use with CONVERT, see the [Transact-SQL reference documentation](/sql/t-sql/functions/cast-and-convert-transact-sql).

### PARSE and TRY_PARSE

The PARSE function is designed to convert formatted strings that represent numeric or date/time values. For example, consider the following query (which uses literal values rather than values from columns in a table):

```sql
SELECT PARSE('01/01/2021' AS date) AS DateValue,
   PARSE('$199.99' AS money) AS MoneyValue;
```

The results of this query look like this:

:::row:::
  :::column:::
    DateValue
  :::column-end:::
  :::column:::
    MoneyValue
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2021-01-01T00:00:00.0000000
  :::column-end:::
  :::column:::
    199.99
  :::column-end:::
:::row-end:::

Similarly to CAST and CONVERT, PARSE has a TRY_PARSE variant that returns incompatible values as *NULL*.

> [!NOTE]
> When working with decimal or numeric data types, you may need to round to a whole number or set the decimal point, which can be achieved through precision and scale.  To better understand this concept of precision and scale, see the [Transact-SQL reference documentation](/sql/t-sql/data-types/decimal-and-numeric-transact-sql).

### STR

The STR function converts a numeric value to a *varchar*.

For example:

```sql
SELECT ProductID,  '$' + STR(ListPrice) AS Price
FROM Production.Product;
```

The results would look something like this:

:::row:::
  :::column:::
    ProductID
  :::column-end:::
  :::column:::
    Price
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    680
  :::column-end:::
  :::column:::
    $1432.00
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    706
  :::column-end:::
  :::column:::
    $1432.00
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    707
  :::column-end:::
  :::column:::
    $35.00
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


