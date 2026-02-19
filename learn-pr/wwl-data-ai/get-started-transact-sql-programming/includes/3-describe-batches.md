T-SQL batches are collections of one or more T-SQL statements that are submitted to SQL Server by a client as a single unit. SQL Server operates on all the statements in a batch at the same time when parsing, optimizing, and executing the code.

If you're a report writer who typically writes queries using `SELECT` statements and not procedures, it's still important to understand batch boundaries. These boundaries affect your work with variables and parameters in stored procedures and other routines. For example, a variable must be declared in the same batch in which it's referenced. It's important, therefore, to recognize what is contained in a batch.

Batches are delimited by the client application. How you mark the end of a batch depends on the settings of your client. For Microsoft clients including SQL Server Management Studio (SSMS) and SQLCMD the keyword is `GO`.

In this example, there are two distinct batches each terminated with a `GO` statement:

```sql
CREATE NEW <view_name>
AS ...
GO
CREATE PROCEDURE <procedure_name>
AS ...
GO
```

The batch terminator **GO** isn't a T-SQL keyword, but is one recognized by SSMS to indicate the end of a batch.

Keep two important considerations in mind when you work with T-SQL batches:

- Batches are boundaries for variable scope, which means a variable defined in one batch can only be referenced by other code in the same batch
- Some statements, typically data definition statements such as `CREATE VIEW`, `CREATE FUNCTION`, and `CREATE PROCEDURE` can't be combined with others in the same batch.

## Working with batches

A batch is a collection of T-SQL statements submitted to SQL Server for parsing and execution. Understanding how batches are parsed is useful in identifying error messages and behavior. When a batch is submitted by a client, such as when you press the Execute button in SSMS, the batch is parsed for syntax errors by the SQL Server engine. Any errors found cause the entire batch to be rejected; there is no partial execution of statements within the batch.

If the batch passes the syntax check, then SQL Server runs other steps, resolving object names, checking permissions, and optimizing the code for execution. Once this process completes and execution begins, statements succeed or fail individually. This is an important contrast to syntax checking. When a runtime error occurs on one line, the next line can still execute, unless you add error handling to the code.

For example, the following batch contains a syntax error:

```sql
INSERT INTO dbo.t1 VALUE(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
GO
```

It gives this error message:

```text
Msg 102, Level 15, State 1, Line 1
Incorrect syntax near 'VALUE'.
```

The error occurred in line 1, but the entire batch is rejected, and execution doesn't continue with line 2. Even if each of the `INSERT` statements were reversed and the syntax error occurred in the second line, the frontline wouldn't be executed because the entire batch would be rejected.

In contrast, this corrected batch doesn't contain an error:

```sql
INSERT INTO dbo.t1 VALUES(1,2,N'abc');
INSERT INTO dbo.t1 VALUES(2,3,N'def');
GO
```

The previous samples use `INSERT` statements rather than `SELECT` because modification statements are more commonly grouped in batches.
