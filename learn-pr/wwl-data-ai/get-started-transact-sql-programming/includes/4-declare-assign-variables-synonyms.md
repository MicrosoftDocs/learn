
In T-SQL, as with other programming languages, variables are objects that allow temporary storage of a value for later use. You have already encountered variables when you used them to pass parameter values to stored procedures and functions.

In T-SQL, variables must be declared before they can be used. They may be assigned a value, or initialized, when they are declared. Declaring a variable includes providing a name and a data type, as shown below.  To declare a variable, you must use the DECLARE statement.

```sql
--Declare and initialize the variables.
DECLARE @numrows INT = 3, @catid INT = 2;
--Use variables to pass the parameters to the procedure.
EXEC Production.ProdsByCategory @numrows = @numrows, @catid = @catid;
GO
```

Variables must be declared in the same batch in which they're referenced. In other words, all T-SQL variables are local in scope to the batch, both in visibility and lifetime. Only other statements in the same batch can see a variable declared in the batch. A variable is automatically destroyed when the batch ends.

## Working with variables

Once you've declared a variable, you must initialize it, or assign it a value. You can do that in three ways:

- In SQL Server 2008 or later, you may initialize a variable using the DECLARE statement.
- In any version of SQL Server, you may assign a single (scalar) value using the SET statement.
- In any version of SQL Server, you can assign a value to a variable using a SELECT statement. Be sure that the SELECT statement returns exactly one row. An empty result will leave the variable with its original value; more than one result will return the last result. 

The following example shows the three ways of declaring and assigning values to variables:

```sql
DECLARE @var1 AS INT = 99;
DECLARE @var2 AS NVARCHAR(255);
SET @var2 = N'string';
DECLARE @var3 AS NVARCHAR(20);
SELECT @var3 = lastname FROM HR.Employees WHERE empid=1;
SELECT @var1 AS var1, @var2 AS var2, @var3 AS var3;
GO
```

This generates the following results.

|var1 |var2 | var3|
|---- |------ |----|
|99  |string |Davis|

> [!TIP]
> For full guidance on local variables, refer to the [T-SQL reference documentation](/sql/t-sql/language-elements/variables-transact-sql).

## Working with synonyms

In SQL Server, synonyms provide a method for creating a link, or alias, to an object stored in the same database or even on another instance of SQL Server. Objects that might have synonyms defined for them include tables, views, stored procedures, and user-defined functions.

Synonyms can be used to make a remote object appear local or to provide an alternative name for a local object. For example, synonyms can be used to provide an abstraction layer between client code and the actual database objects used by the code. The code references objects by their aliases, regardless of the object’s actual name.

> [!NOTE]
> You can create a synonym which points to an object that does not yet exist. This is called deferred name resolution. The SQL Server engine will not check for the existence of the actual object until the synonym is used at runtime.

To manage synonyms, use the data definition language (DDL) commands CREATE SYNONYM, ALTER SYNONYM, and DROP SYNONYM, as in the following example:

```sql
CREATE SYNONYM dbo.ProdsByCategory FOR TSQL.Production.ProdsByCategory;
GO
EXEC dbo.ProdsByCategory @numrows = 3, @catid = 2;
```

To create a synonym, you must have 'CREATE SYNONYM' permission as well as permission to alter the schema in which the synonym will be stored.

> [!NOTE]
> To create a synonym, the user must have CREATE SYNONYM permission and either own or have ALTER SCHEMA permission in the destination schema.

A synonym is an "empty" object that is resolved to the source object when referenced at runtime.
