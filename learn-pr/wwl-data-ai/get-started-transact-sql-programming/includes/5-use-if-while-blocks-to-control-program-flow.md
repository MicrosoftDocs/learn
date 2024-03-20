
All programming languages include elements that help you to determine the flow of the program, or the order in which statements are executed. While not as fully featured as languages like C#, T-SQL provides a set of control-of-flow keywords you can use to perform logic tests and create loops containing your T-SQL data manipulation statements. In this lesson, you'll learn how to use the T-SQL IF and WHILE keywords.

## Understand the T-SQL control of flow language

SQL Server provides language elements that control the flow of program execution within T-SQL batches, stored procedures, and multistatement user-defined functions. These control-of-flow elements mean you can programmatically determine whether to execute statements and programmatically determine the order of those statements that should be executed.

These elements include, but aren't limited to:

- IF...ELSE, which executes code based on a Boolean expression.
- WHILE, which creates a loop that executes providing a condition is true.
- BEGIN…END, which defines a series of T-SQL statements that should be executed together.
- Other keywords, for example, BREAK, CONTINUE, WAITFOR, and RETURN, which are used to support T-SQL control-of-flow operations.

Here is an example of the IF statement:

```sql
IF OBJECT_ID('dbo.tl') IS NOT NULL
    DROP TABLE dbo.tl
GO
```

## Use conditional logic in your programs using IF...ELSE

The IF...ELSE structure is used in T-SQL to conditionally execute a block of code based on a predicate. The IF statement determines whether or not the following statement or block (if BEGIN...END is used) executes. If the predicate evaluates to TRUE, the code in the block is executed. When the predicate evaluates to FALSE or UNKNOWN, the block is not executed, unless the optional ELSE keyword is used to identify another block of code.

In the following IF statement, we are asking the database if the OBJECT_ID IS NULL, and if so, return the PRINT statement. In this example, the object is *NOT* null and therefore FALSE, which means the BEGIN/END code won't be executed. The PRINT statement will only be executed if the object does not exist in the database.

```sql
USE TSQL;
GO
IF OBJECT_ID('HR.Employees') IS NULL --this object does exist in the sample database
BEGIN
    PRINT 'The specified object does not exist';
END;
```

Due to the limitations with the code above with only an IF statement, this can be confusing. Combining IF and ELSE gives you more flexibility with the logic in your code, and you can use multiple ELSE statements. With the use of ELSE, you have another execution option when the IF predicate evaluates to FALSE or UNKNOWN, as in the following example:

```sql
IF OBJECT_ID('HR.Employees') IS NULL --this object does exist in the sample database
BEGIN
    PRINT 'The specified object does not exist';
END
ELSE
BEGIN
    PRINT 'The specified object exists';
END;
```

Within data manipulation operations, using IF with the EXISTS keyword can be a useful tool for efficient existence checks, as in the following example:

```sql
IF EXISTS (SELECT * FROM Sales.EmpOrders WHERE empid =5)
BEGIN
    PRINT 'Employee has associated orders';
END;
```

## Understand looping using WHILE statements

The WHILE statement is used to execute code in a loop based on a predicate. Like the IF statement, the WHILE statement determines whether the following statement or block (if BEGIN...END is used) executes. The loop continues to execute as long as the condition evaluates to TRUE. Typically, you control the loop with a variable tested by the predicate and manipulated in the body of the loop itself.

The following example uses the @empid variable in the predicate and changes its value in the BEGIN...END block:

```sql
DECLARE @empid AS INT = 1, @lname AS NVARCHAR(20);
WHILE @empid <=5
   BEGIN
	SELECT @lname = lastname FROM HR.Employees
		WHERE empid = @empid;
	PRINT @lname;
	SET @empid += 1;
   END;
```


For extra options within a WHILE loop, you can use the CONTINUE and BREAK keywords to control the flow.
