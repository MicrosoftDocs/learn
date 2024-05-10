PostgreSQL stored procedures and functions extend the functionality of your Azure Database for PostgreSQL and can make queries more efficient. In this module, you learn how to create and call a SQL stored procedure. You also learn how to create and use a function. 

After completing this module, you'll be able to:

- Create a stored procedure in Azure Database for PostgreSQL.
- Call a stored procedure in Azure Database for PostgreSQL.
- Create and use a function in Azure Database for PostgreSQL.

Stored procedures and functions are similar in that they're code-written for a specific reason and can be used wherever you need them. There are differences between them, however, which means there are times when you use one or the other:

- Functions always return a single value, a scalar value, or a table. Stored procedures might return nothing, a single value, or multiple values.
- Functions can't include DML (Data Manipulation Language) statements such as UPDATE and INSERT. Stored procedures can include any DML statement.
- Functions can't include transactions, whereas stored procedures can. This restriction means that functions can't include COMMIT or ROLLBACK statements.
- Functions can be used within stored procedures. A function can't call a stored procedure.

Stored procedures are a relatively new addition to PostgreSQL, whereas functions are available for some time.
