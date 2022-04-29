Stored procedures are created with the **CREATE PROCEDURE** keywords. To create a stored procedure, you'll need the following permissions:

* CREATE PROCEDURE permission in the database.
* ALTER permission on the schema in which the procedure is being created.

Write and test your SELECT statement first, and when you're happy that it's working correctly add the CREATE PROCEDURE keywords before the schema and procedure name.

As an example, the following code will create a stored procedure called **TopProducts** in the SalesLT schema.

```sql
CREATE PROCEDURE SalesLT.TopProducts AS
SELECT TOP(10) name, listprice
    FROM SalesLT.Product
    GROUP BY name, listprice
    ORDER BY listprice DESC;
```

To amend a stored procedure, use the **ALTER PROCEDURE** keywords. For example, the following code will amend the **TopProducts** stored procedure to return the top 100 products.

```sql
ALTER PROCEDURE SalesLT.TopProducts AS
    SELECT TOP(100) name, listprice
    FROM SalesLT.Product
    GROUP BY name, listprice
    ORDER BY listprice DESC;
```

When you amend a stored procedure using the ALTER PROCEDURE keywords, any security permissions that have been assigned to the stored procedure are retained. After initial development, this is normally preferable to dropping and recreating the stored procedure.

Alternatively, use DROP PROCEDURE 'procedure_name', as in the following code:

```sql
DROP PROCEDURE myProcedure; 
```
