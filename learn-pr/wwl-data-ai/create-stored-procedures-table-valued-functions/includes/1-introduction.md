Stored procedures are named groups of Transact-SQL (T-SQL) statements that can be used and reused whenever they're needed. Stored procedures can return results, manipulate data, and perform administrative actions on the server. You may need to execute stored procedures that someone else has created or create your own.

Stored procedure can contain both data definition commands and data manipulation commands, providing a clean interface between a database and an application.

There are advantages to using stored procedures, including:

* **Re-use of code**. Stored procedure can be written, tested, and then reused as needed. This helps to eliminate errors and reduce development time.
* **Security**. Stored procedures allow users and programs to perform certain operations on database objects, without giving permissions to the underlying tables. This allows you to control which processes and activities are allowed, thereby improving security.
* **Improve quality**. You can also include appropriate error handling code and make sure that each stored procedure is properly tested before being used in a production environment.
* **Improve performance**. When stored procedures are first executed, an execution plan is created. That execution plan can be reused when the stored procedure is executed again. This is typically quicker than creating an execution plan every time the code is executed.
* **Lower maintenance**. Stored procedures provide an interface to the data tier. When changes to the underlying database objects change, only the procedures are updated providing a clean separation between the data and application tiers.

There are three types of stored procedures:

* User-defined stored procedures.
* Temporary stored procedures.
* System stored procedures.

This module will show you how to call a stored procedure, pass a parameter to a stored procedure, and create and amend stored procedures. You'll also learn how to construct dynamic SQL and write inline table-valued functions.

After completing this module, you’ll be able to:

* Return results by executing stored procedures.
* Pass parameters to procedures.
* Create simple stored procedures that encapsulate a SELECT statement.
* Construct and execute dynamic SQL with EXEC and sp_executesql.
* Create simple user-defined functions and write queries against them.
