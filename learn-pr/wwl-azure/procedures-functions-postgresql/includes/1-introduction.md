PostgreSQL stored procedures and functions extend the functionality of your Azure Database for PostgreSQL and can make queries more efficient. In this module you will learn how to create and call a SQL stored procedure. You will also learn how to create and use a function. 

After completing this module, you will be able to:

- Create a stored procedure in Azure Database for PostgreSQL.
- Call a stored procedure in Azure Database for PostgreSQL.
- Create and use a function in Azure Database for PostgreSQL.

Stored procedures and functions are similar in that they are code written for a specific reason and can be used wherever you need them. There are differences between them, however, which means there are times when you will use one or the other:

- Functions always return a single value. This can be a scalar value, or a table. Stored procedures may return nothing, a single value, or multiple values.
- Functions cannot include DML statements such as UPDATE and INSERT. Stored procedures can include any DML statement.
- Functions cannot include transactions, whereas stored procedures can. This means that functions cannot include COMMIT or ROLLBACK statements.
- Functions can be used within stored procedures. A function cannot call a stored procedure.

Stored procedures are a relatively new addition to PostgreSQL, whereas functions have been available for some time.
