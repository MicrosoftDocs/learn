We already learned that PostgreSQL supports different languages. Functions can be categorized into four different types:

- Functions written in SQL.
- Procedural language functions, written in a supported procedural language such as PL.pgSQL.
- Internal functions.
- C-language functions.

In addition, the purpose of the function can also be categorized as **volatile**, **immutable**, or **stable**.

A **volatile** (the default) function can modify the database and might not necessarily return the same result with the same input parameters each time. So, every time this function is called, it must be reevaluated.

A **stable** function can't modify the database and returns the same result if passed the same arguments and run within the same statement. If this function is called multiple times, the query optimizer can use the results from the last time it was called.

An **immutable** function can't modify the database and returns the same results if passed the same arguments, regardless of the query that calls it.

The volatility of a function makes a large difference to the efficiency with which the query optimizer handles it.

## Create a function

A function returns a single value and can be used within a SELECT statement.

The syntax for creating a function is:

```sql
CREATE [OR REPLACE] FUNCTION
myfunction ([inputparam] type {default})
RETURNS returntype AS
$$
SQL body
$$
LANGUAGE 'language_name';
CREATE FUNCTION
```

As with stored procedures, the \$\$ symbol is used to start and end the string.

Functions take the following parameters:

- **name** - optionally include the schema name.
- **argmode** - the mode of the argument. Can be IN, OUT, INOUT, or VARIADIC. The default is IN. VARDIAC is an undefined number of input arguments of the same type, *and is followed by OUT arguments*. OUT and INOUT arguments can't be used together with the RETURNS TABLE notations.
- **argname** - argument name.
- **argtype** - the argument data type. Can be base, composite, or domain types, or reference a table column type. The column type is written as table_name.column_name%TYPE. This data type can help make a function independent of table definition changes.
- **t_expr** - A default value (of the same type) if the parameter isn't specified. Only IN and INOUT parameters have a default value. Input parameters following a parameter with a default value must also have default values.
- **rettype** - The return data type, which can be a base, composite, or domain type, or reference a table column type. If the function doesn't return a value, specify the return type as void. When there are OUT or INOUT parameters, the RETURNS clause can be omitted. If present, it must agree with the result type implied by the output parameters: RECORD if there are multiple output parameters, or the same type as the single output parameter. The SETOF modifier indicates that the function returns a set of items, rather than a single item. The type of a column is referenced by writing ***table_name***.
- **column_name** - The name of an output column in the RETURNS TABLE syntax. This parameter declares a named OUT parameter, except that RETURNS TABLE also implies RETURNS SETOF.
- **column_type** - The data type of an output column in the RETURNS TABLE syntax.
- **lang_name -** the language used to write the procedure. The default is sql if sql_body is specified. Can be sql, c, internal, or the name of a user-defined procedural language, for example, plpgsql.

Use the keywords IMMUTABLE, STABLE, or VOLATILE as a hint to the query optimizer about the function. VOLATILE is the default.

## Call a function

A function can be used in a query by passing any relevant parameters to it. For example:

```sql
SELECT myfunction(3), CatID, CatName
    FROM myCats
```

## In-built functions

PostgreSQL includes many in-built functions that you can use in your queries. Theses cover making comparisons, aggregating data, mathematical functions, etc. See the online documentation for a [full list of PostgreSQL functions](https://www.postgresql.org/docs/13/functions.html).

An example of an in-built string function is **substring**.

```sql
substring (*string* text [ FROM *start* integer ] [ FOR *count* integer ] ) → text
```

This function takes three input parameters:

- String (type text)
- FROM start (type integer)
- FOR count (type integer)

Substring returns part of the input text, starting at the **start** character, and stopping after **count** characters. For example:

```sql
substring('Thomas' from 2 for 3) → hom
substring('Thomas' from 3) → omas
substring('Thomas' for 2) → Th
```

This function is the same as substr:

```sql
substr ( *string* text, *start* integer [, *count* integer ] ) → text
substr('alphabet', 3) → phabet
substr('alphabet', 3, 2) → ph
```

> [!NOTE]
> If you are familiar with functions, you will have noticed that the first version uses key words rather than commas to separate arguments. PostgreSQL provides both versions of these functions.

