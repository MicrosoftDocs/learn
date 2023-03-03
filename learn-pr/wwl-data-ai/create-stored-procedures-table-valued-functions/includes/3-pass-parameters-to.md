One of the advantages of using stored procedures is that you can pass parameters to them at runtime. Input parameters can be used filter the query results, such as in the predicate of a **WHERE** clause, or the value in a **TOP** operator. Procedure parameters can also return values to the calling program if the parameter is marked as an OUTPUT parameter. You can also assign a default value to a parameter.

## Input parameters

Stored procedures declare their input parameters by name and data type in the header of the **CREATE PROCEDURE** statement. The parameter is then used as a local variable within the body of the procedure. You can declare and use more than one parameter in a stored procedure. Input parameters are the default type of parameter.

Parameter names must be prefixed by the @ character, and be unique in the scope of the procedure.

To pass a parameter to a stored procedure, use the following syntax:

```sql
 EXEC <schema_name>.<procedure_name> @<parameter_name> = 'VALUE'
```

For example, a stored procedure called **ProductsBySupplier** in the Products schema, would be executed with a parameter named **supplierid** using the following code:

```sql
EXEC Products.ProductsBySupplier @supplierid = 5
```

It is best practice to pass parameter values as name-value pairs. Multiple parameters are separated with commas. For example, if the parameter is called **customerid** and the value to pass is **5**, use the following code:

```sql
EXEC customers.customerid @customerid=5
```

You can also pass parameters by position, omitting the parameter name. However, parameters must be passed either by name or by position - you cannot mix the way parameters are passed to the procedure. If parameters are passed by order, they must be in the identical order as they are listed in the CREATE PROCEDURE statement.

You can pass values as a constant, or as a variable, such as:

```sql
EXEC customers.customerid @CustomerID
```

You can't, however, use a function to pass a parameter. For example, the following code would raise an error:

```sql
EXEC customers.customerid GETDATE()
```

Check that parameters are of the correct data type. For example, if a procedure accepts an NVARCHAR, pass in the Unicode character string format: **N'string'**.

You can view parameter names and data types in Azure Data Studio or SQL Server Management Studio (SSMS). Expand the list of database objects until you see the **Stored Procedures** folder, beneath the **Programmability** folder.

:::image type="content" source ="../media/parameter.png" alt-text ="Expand the Programming folder to view stored procedures and parameter data types":::

Stored procedures two-part names are displayed, together with a Parameters folder that contains for each parameter:

* Parameter name.
* Data type.
* An **in** arrow indicating an input parameter.
* An **out** arrow indicating an output parameter.

You can query a system catalog view such as **sys.parameters** to retrieve parameter definitions together with the object ID.

## Default values

If a parameter was declared with a default value, you don't have to pass value when the stored procedure is run. If a value is passed it will be used, but if no value is passed, then the default is used.

When the stored procedure is created, parameters are given default values using the = operator, such as:

```sql
CREATE PROCEDURE Sales.SalesYTD  
    -- Set NULL as the default value
    @SalesPerson nvarchar(50) = NULL 
    AS ...
```

## Output parameters

You've seen how to pass a value into a stored procedure, known as an input parameter.

However, you can also return a value to the calling program. This is known as an OUTPUT parameter. Use the OUTPUT or OUT keyword to specify an output parameter in the CREATE PROCEDURE statement.  The procedure returns the current value of the output parameter to the calling program when the procedure exits.

The calling program must also use the OUTPUT keyword when executing the procedure to save the parameter's value in a variable that can be used in the calling program.

In the following T-SQL code fragment, two parameters are defined as OUTPUT parameters, @ComparePrice and @ListPrice.

```sql
CREATE PROCEDURE Production.uspGetList @Product varchar(40)
    , @MaxPrice money   
    , @ComparePrice money OUTPUT  
    , @ListPrice money OUT  
AS 
```

Values are then assigned to the OUTPUT parameters in the body of the stored procedure, for example, `SET @ComparePrice = @MaxPrice;`.