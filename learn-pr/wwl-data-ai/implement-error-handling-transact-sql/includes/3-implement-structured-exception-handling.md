Now that you have an understanding of the nature of errors and basic error handling in T-SQL, it's time to look at a more advanced form of error handling. Structured exception handling was introduced in SQL Server 2005.

Here, you'll see how to use it and evaluate its benefits and limitations, including the TRY CATCH block, the role of error handling functions, and understanding the difference between catchable and noncatchable errors. Finally, you'll see how errors can be managed and surfaced when necessary.

## What is TRY/CATCH block programming

Structured exception handling is more powerful than error handling based on the @@ERROR system variable. It allows you to prevent code from being littered with error handling code and to centralize that error handling code. Centralization of error handling code also means you can focus more on the purpose of the code rather than the error handling it contains.

### TRY block and CATCH block

When using structured exception handling, code that might raise an error is placed within a TRY block. TRY blocks are enclosed by **BEGIN TRY** and **END TRY** statements.

Should a catchable error occur - most errors can be caught, execution control moves to the CATCH block. The CATCH block is a series of T-SQL statements enclosed by **BEGIN CATCH** and **END CATCH** statements.

> [!NOTE]
> While BEGIN CATCH and END TRY are separate statements, the BEGIN CATCH must immediately follow the END TRY.

### Current limitations

High-level languages often offer a try/catch/finally construct, and are often used to release resources implicitly. There's no equivalent FINALLY block in T-SQL.

## Understand the difference between catchable and noncatchable errors

It's important to realize that, while TRY/CATCH blocks allow you to catch a much wider range of errors than you could with @@ERROR, you can't catch every type.

### Catchable vs. noncatchable errors

Not all errors can be caught by TRY/CATCH blocks within the same scope where the TRY/CATCH block exists. Often, errors that cannot be caught in the same scope can be caught in a surrounding scope. For example, you might not be able to catch an error within the stored procedure that contains the TRY/CATCH block. However, you're likely to catch that error in a TRY/CATCH block in the code that called the stored procedure where the error occurred.

### Common noncatchable errors

Common examples of noncatchable errors are:

- Compile errors, such as syntax errors, that prevent a batch from compiling.
- Statement level recompilation issues that usually relate to deferred name resolution. For example, you could create a stored procedure that refers to an unknown table. An error is only thrown when the procedure tries to resolve the name of the table to an *objectid*.

## How to rethrow errors using THROW

If the THROW statement is used in a CATCH block without any parameters, it will rethrow the error that caused the code to enter the CATCH block. You can use this technique to implement error logging in the database by catching errors and logging their details, and then throwing the original error to the client application, so that it can be handled there.

Here is an example of how to rethrow an error.

```sql
BEGIN TRY
    -- code to be executed
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
    THROW
END CATCH
```

In some earlier versions of SQL Server, there was no method to throw a system error. While THROW can't specify a system error to raise, when THROW is used without parameters in a CATCH block, it will reraise both system and user errors.

## What are error handling functions

CATCH blocks make the error-related information available throughout the duration of the CATCH block. This includes subscopes, such as stored procedures, run from within the CATCH block.

### Error handling functions

You should recall that, when programming with @@ERROR, the value held by the @@ERROR system variable was reset as soon as the next statement was executed.

Another key advantage of structured exception handling in T-SQL is that a series of error handling functions has been provided and these keep their values throughout the CATCH block. Separate functions provide each property of an error that has been raised.

This means you can write generic error handling stored procedures that can still access the error-related information.

- CATCH blocks make the error-related information available throughout the duration of the CATCH block.
- @@Error is reset when the next statement is run.

## Manage errors in code

SQL CLR integration allows for the execution of managed code within SQL Server. High-level .NET languages, such as C# and VB, have detailed exception handling available to them. Errors can be caught using standard .NET try/catch/finally blocks.

### Errors in managed code

In general, you might wish to catch errors within managed code as much as possible. It's important to realize, though, that any errors not handled in the managed code are passed back to the calling T-SQL code. Whenever any error that occurs in managed code is returned to SQL Server, it will appear to be a 6522 error. Errors can be nested and that particular error will be wrapping the real cause of the error.

Another rare but possible cause of errors in managed code would be that the code could execute a RAISERROR T-SQL statement via a SqlCommand object.
