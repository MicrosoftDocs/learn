A NULL value means *no value* or *unknown*. It does not mean zero or blank, or even an empty string. Those values are not unknown. A NULL value can be used for values that haven’t been supplied yet, for example, when a customer has not yet supplied an email address. As you've seen previously, a NULL value can also be returned by some conversion functions if a value is not compatible with the target data type.

You'll often need to take special steps to deal with NULL. NULL is really a non-value. It is unknown. It isn't equal to anything, and it’s not unequal to anything. NULL isn't greater or less than anything. We can’t say anything about what it is, but sometimes we need to work with NULL values. Thankfully, T-SQL provides functions for conversion or replacement of NULL values.

## ISNULL

The ISNULL function takes two arguments. The first is an expression we are testing. If the value of that first argument is NULL, the function returns the second argument. If the first expression is not null, it is returned unchanged.

For example, suppose the **Sales.Customer** table in a database includes a **MiddleName** column that allows NULL values. When querying this table, rather than returning NULL in the result, you may choose to return a specific value, such as "None".

```sql
SELECT FirstName,
      ISNULL(MiddleName, 'None') AS MiddleIfAny,
      LastName
FROM Sales.Customer;
```

The results from this query might look something like this:

:::row:::
  :::column:::
    FirstName
  :::column-end:::
  :::column:::
    MiddleIfAny
  :::column-end:::
  :::column:::
    LastName
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Orlando
  :::column-end:::
  :::column:::
    N.
  :::column-end:::
  :::column:::
    Gee
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Keith
  :::column-end:::
  :::column:::
    None
  :::column-end:::
  :::column:::
    Howard
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Donna
  :::column-end:::
  :::column:::
    F.
  :::column-end:::
  :::column:::
    Gonzales
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
> The value substituted for NULL must be the same datatype as the expression being evaluated. In the above example, **MiddleName** is a *varchar*, so the replacement value could not be numeric. In addition, you'll need to choose a value that will not appear in the data as a regular value. It can sometimes be difficult to find a value that will never appear in your data.

The previous example handled a NULL value in the source table, but you can use ISNULL with any expression that might return a NULL, including nesting a TRY\_CONVERT function within an ISNULL function.

## COALESCE

The ISNULL function is not ANSI standard, so you may wish to use the COALESCE function instead. COALESCE is a little more flexible in that it can take a variable number of arguments, each of which is an expression. It will return the first expression in the list that is not NULL.

If there are only two arguments, COALESCE behaves like ISNULL. However, with more than two arguments, COALESCE can be used as an alternative to a multipart CASE expression using ISNULL.

If all arguments are NULL, COALESCE returns NULL. All the expressions must return the same or compatible data types.

The syntax is as follows:

```sql
SELECT COALESCE ( expression1, expression2, [ ,...n ] )
```

The following example uses a fictitious table called **HR.Wages**, which includes three columns that contain information about the weekly earnings of the employees: the hourly rate, the weekly salary, and a commission per unit sold. However, an employee receives only one type of pay. For each employee, one of those three columns will have a value, the other two will be NULL. To determine the total amount paid to each employee, you can use COALESCE to return only the non-null value found in those three columns.

```sql
SELECT EmployeeID,
      COALESCE(HourlyRate * 40,
                WeeklySalary,
                Commission * SalesQty) AS WeeklyEarnings
FROM HR.Wages;
```

The results might look something like this:

:::row:::
  :::column:::
    EmployeeID
  :::column-end:::
  :::column:::
    WeeklyEarnings
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    1
  :::column-end:::
  :::column:::
    899.76
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    2
  :::column-end:::
  :::column:::
    1001.00
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    3
  :::column-end:::
  :::column:::
    1298.77
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


## NULLIF

The NULLIF function allows you to return NULL under certain conditions. This function has useful applications in areas such as data cleansing, when you wish to replace blank or placeholder characters with NULL.

NULLIF takes two arguments and returns NULL if they're equivalent. If they aren't equal, NULLIF returns the first argument.

In this example, NULLIF replaces a discount of 0 with a NULL. It returns the discount value if it is not 0:

```sql
SELECT SalesOrderID,
      ProductID,
      UnitPrice,
      NULLIF(UnitPriceDiscount, 0) AS Discount
FROM Sales.SalesOrderDetail;
```

The results might look something like this:

:::row:::
  :::column:::
    SalesOrderID
  :::column-end:::
  :::column:::
    ProductID
  :::column-end:::
  :::column:::
    UnitPrice
  :::column-end:::
  :::column:::
    Discount
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    71774
  :::column-end:::
  :::column:::
    836
  :::column-end:::
  :::column:::
    356.898
  :::column-end:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    71780
  :::column-end:::
  :::column:::
    988
  :::column-end:::
  :::column:::
    112.998
  :::column-end:::
  :::column:::
    0.4
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    71781
  :::column-end:::
  :::column:::
    748
  :::column-end:::
  :::column:::
    818.7
  :::column-end:::
  :::column:::
    NULL
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    71781
  :::column-end:::
  :::column:::
    985
  :::column-end:::
  :::column:::
    112.998
  :::column-end:::
  :::column:::
    0.4
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
:::row-end:::
