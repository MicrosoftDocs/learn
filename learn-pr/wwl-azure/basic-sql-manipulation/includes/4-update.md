## UPDATE command

# UPDATE single column (Simple UPDATE)

This query updates the price of the `Wireless Mouse` in the `Sales.Products` table to 100.99. 

```sql
UPDATE Sales.Products SET price = 100.99 WHERE productname = 'Wireless Mouse'; 
```

# UPDATE multiple columns

This query updates both the price and unit for the product `Wireless Mouse` in the `Sales.Products` table.

```sql
UPDATE Sales.Products SET price = 25.00, unit = '20 boxes' WHERE productname = 'Wireless Mouse'; 
```

# UPDATE all rows

This query updates the price for all rows in the `Sales.Products` table to 42.99.

```sql
UPDATE Sales.Products SET price = 42.99; 
```

# UPDATE with subquery

Subquery - a query inside another query. 
It retrieves data that the main query uses for filtering, calculations, or updates. Subqueries are often used in WHERE, SELECT, or FROM clauses to make queries more dynamic and efficient. 

This query increases the price of products that have been ordered at least once by 10%, based on matching productid between `Sales.Products` and `Sales.OrderDetails` (for products that exist in the `Sales.OrderDetails` table). 

```sql
UPDATE Sales.Products SET price = price * 1.1  
WHERE productid IN (SELECT productid FROM Sales.OrderDetails); 
```

# UPDATE with RETURNING

RETURNING – allows retrieving specific columns or values from rows affected by an UPDATE, INSERT, or DELETE operation. It returns the modified data immediately, eliminating the need for a separate SELECT query.

This query updates the price for all products with supplierid = 1, increases their price by 20%, and returns the productname, supplierid, and updated price. 

```sql
UPDATE Sales.Products SET price = price * 1.20 
WHERE supplierid = 1 RETURNING productname, supplierid, price; 
```

# UPDATE using CASE

CASE -  a conditional statement in SQL that works like WHEN-THEN-ELSE. It evaluates conditions and returns different values based on the result, making it useful for dynamic updates and transformations in queries.  

This query updates the price of products based on their current value. If the price is less than 50, it multiplies it by 3, otherwise, it multiplies it by 1.1. It then returns the updated price, rounded to two decimal places. 

```sql
UPDATE Sales.Products  
SET price = CASE  
    WHEN price < 50 THEN price * 3.0  
    ELSE price * 1.10  
END 
RETURNING ROUND(price,2); 
```

