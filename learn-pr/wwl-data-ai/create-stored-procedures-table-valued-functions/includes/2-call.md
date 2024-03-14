Stored procedures may be called by an application, by a user, or when SQL Server starts.

## Execute a stored procedure by a user 

When an application or user executes a stored procedure, the EXECUTE command or its shortcut, EXEC is used, followed by the two-part name of the procedure. For example:

`EXEC dbo.uspGetEmployeeManagers`

System stored procedures are also called using the EXECUTE or EXEC keyword. The calling database collation is used when matching system procedure names. If the database collation is case-sensitive, you must execute the stored procedure with exact case of the procedure name.  

If the stored procedure is the first statement in the T-SQL batch, the procedure can be executed without the EXECUTE or EXEC keyword.

To check the exact system procedure names, use the catalog views:

`sys.system_objects`  

`sys.system_parameters`

System stored procedures are prefixed with **sp_**. System stored procedures are not created by users, but are part of all user-defined and system-defined databases. They do not require a fully qualified name to be executed, but it is best practice to include the **sys** schema name. For example:

`EXEC sys.sp_who;`

## Automatically execute a stored procedure

You can run a stored procedure every time SQL Server starts. You might want to carry out database maintenance operations, or run a procedure as a background process. Stored procedures that run automatically cannot contain input or output parameters.

Use the **sp_procoption** to run a stored procedure every time an instance of SQL Server is started. The syntax is:

```sql
sp_procoption [ @ProcName = ] 'procedure'     
    , [ @OptionName = ] 'option'     
    , [ @OptionValue = ] 'value'
```

For example:

```sql
EXEC sp_procoption @ProcName = myProcedure    
    , @OptionName = 'startup'   
    , @OptionValue = 'on';
```

To execute multiple procedures that don't need to execute them in parallel, make one procedure the startup procedure and call the other procedures from the startup procedure. This will use only one worker thread.

Startup procedures must be in the master database. 