[Scalar functions](/sql/relational-databases/user-defined-functions/user-defined-functions?azure-portal=true) are essential tools in SQL Server that allow you to encapsulate reusable logic and return a single value. You can use them directly in `SELECT` statements, `WHERE` clauses, and other [T-SQL](/sql/t-sql/language-reference?azure-portal=true) expressions, making your queries more maintainable and your code more modular.

## Understand scalar function fundamentals

A scalar function accepts zero or more parameters and returns a single value of a specified data type. Unlike stored procedures, scalar functions can be embedded directly in SQL expressions wherever you would use a column or variable.

The key characteristics of scalar functions include their ability to accept input parameters, perform calculations or transformations, and return exactly one value. You define the return data type explicitly in the function definition, which SQL Server validates at creation time.

When you create a scalar function, you're creating a reusable piece of logic that other developers can call throughout the database. This promotes code reuse and helps maintain consistency across your applications.

## Define scalar function syntax

To create a scalar function, you use the [`CREATE FUNCTION`](/sql/t-sql/statements/create-function-transact-sql?azure-portal=true) statement with specific syntax components. The basic structure includes the function name, parameters, return type, and function body.

Here's the fundamental syntax pattern:

```sql
CREATE FUNCTION schema_name.function_name 
(
    @parameter1 datatype,
    @parameter2 datatype
)
RETURNS return_datatype
AS
BEGIN
    -- Function logic here
    RETURN @result
END
```

The `RETURNS` clause specifies the data type of the single value the function returns. Within the `BEGIN...END` block, you write your T-SQL logic and use a `RETURN` statement to send back the result.

For example, you can create a simple function that calculates sales tax:

```sql
CREATE FUNCTION dbo.CalculateSalesTax
(
    @Amount DECIMAL(10,2),
    @TaxRate DECIMAL(5,4)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TaxAmount DECIMAL(10,2)
    SET @TaxAmount = @Amount * @TaxRate
    RETURN @TaxAmount
END
```

This function accepts two parameters and returns the calculated tax amount. You can use this function in any `SELECT` statement.

## Implement scalar functions with business logic

Scalar functions excel at encapsulating business rules and calculations that you need to apply consistently across your database. With scalar functions, you centralize logic that might otherwise be duplicated in multiple queries or application code.

Consider a scenario where you need to calculate employee tenure in years. You create a scalar function that accepts a hire date and returns the number of complete years:

```sql
CREATE FUNCTION dbo.GetEmployeeTenure
(
    @HireDate DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Tenure INT
    SET @Tenure = DATEDIFF(YEAR, @HireDate, GETDATE())
    RETURN @Tenure
END
```

You can use this function in queries to display tenure information:

```sql
SELECT 
    EmployeeName,
    HireDate,
    dbo.GetEmployeeTenure(HireDate) AS YearsOfService
FROM Employees
WHERE dbo.GetEmployeeTenure(HireDate) >= 5
```

This approach ensures consistent tenure calculation throughout your database. If the business rules change, you modify the function once rather than updating multiple queries.

> [!NOTE]
> This function uses `GETDATE()`, which makes it non-deterministic. Non-deterministic functions can't be used in indexed views or indexes on computed columns. For scenarios requiring determinism, pass the current date as a parameter instead.

## Apply best practices for scalar functions

When you create scalar functions, several best practices help ensure optimal performance and maintainability. Understanding these practices helps you avoid common pitfalls and create efficient, reliable functions.

First, keep your scalar functions deterministic whenever possible. A deterministic function always returns the same result given the same input parameters. Functions that reference system date/time functions or tables are non-deterministic and may prevent certain query optimizations.

Also, avoid side effects in your functions. Scalar functions shouldn't modify database state or have dependencies on external resources. This restriction exists because SQL Server may execute functions multiple times or in different orders than you expect.

Lastly, be mindful of performance implications. When you use a scalar function in a `WHERE` clause or `SELECT` list with large tables, SQL Server may execute the function for every row. This can significantly impact query performance. For such scenarios, consider inline table-valued functions as an alternative.

Here's an example of a well-designed scalar function that follows these practices:

```sql
CREATE FUNCTION dbo.FormatPhoneNumber
(
    @PhoneNumber VARCHAR(10)
)
RETURNS VARCHAR(14)
AS
BEGIN
    DECLARE @FormattedNumber VARCHAR(14)
    
    IF LEN(@PhoneNumber) = 10
        SET @FormattedNumber = '(' + SUBSTRING(@PhoneNumber, 1, 3) + ') ' +
                               SUBSTRING(@PhoneNumber, 4, 3) + '-' +
                               SUBSTRING(@PhoneNumber, 7, 4)
    ELSE
        SET @FormattedNumber = @PhoneNumber
    
    RETURN @FormattedNumber
END
```

This function is deterministic, has no side effects, and performs a straightforward transformation. It handles invalid input gracefully by returning the original value when the phone number doesn't match the expected format.

## Modify and manage scalar functions

After you create a scalar function, you can modify its definition using the `ALTER FUNCTION` statement. The `ALTER FUNCTION` syntax mirrors `CREATE FUNCTION` but allows you to change the function without dropping and recreating it, which preserves permissions and dependencies.

```sql
ALTER FUNCTION dbo.CalculateSalesTax
(
    @Amount DECIMAL(10,2),
    @TaxRate DECIMAL(5,4)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TaxAmount DECIMAL(10,2)
    -- Updated logic with rounding
    SET @TaxAmount = ROUND(@Amount * @TaxRate, 2)
    RETURN @TaxAmount
END
```

To remove a scalar function, you use the `DROP FUNCTION` statement:

```sql
DROP FUNCTION IF EXISTS dbo.CalculateSalesTax
```

The `IF EXISTS` clause prevents errors if the function doesn't exist, which is useful in deployment scripts. Before dropping a function, verify that no other database objects depend on it by checking system views like `sys.sql_expression_dependencies`.
