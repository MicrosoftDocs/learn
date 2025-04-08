## DELETE command

One possible error when using the DELETE command occurs due to foreign key constraints.

If a product exists in the `Sales.OrderDetails` table as a reference, attempting to delete it from the `Sales.Products` table will result in an error to prevent data inconsistency.

# DELETE a specific row

This query deletes the product `USB Hub` from the `Sales.Products` table.

```sql
DELETE FROM Sales.Products WHERE productsname = `USB Hub`;
```

# DELETE multipe rows based on condition

This query deletes all products from the `Sales.Products` table where the `price` is greater than 100.

```sql
DELETE FROM Sales.Products WHERE price > 100;
```

# DELETE all rows in a table

This query deletes all rows in the Sales.Products table.

```sql
DELETE FROM Sales.Products;
```

# DELETE rows using subquery

This query deletes products in the `Sales.Products` table that do not exist in the `Sales.OrderDetails` table.

```sql
DELETE FROM Sales.Products  
WHERE productid NOT IN (SELECT DISTINCT productid FROM Sales.OrderDetails); 
```

# DELETE specific number of rows with subquery

Subquery - Selects the productid from `Sales.Products`, where the `productid` is not in `Sales.OrderDetails`, orders the products by price in ascending order, and limits the result to the 5 cheapest products.

This query deletes the 5 cheapest products that are not referenced in the `Sales.OrderDetails` table.

```sql
DELETE FROM Sales.Products  

WHERE productid IN ( 
    SELECT productid FROM Sales.Products  
    WHERE productid NOT IN (SELECT DISTINCT productid FROM Sales.OrderDetails) 
    ORDER BY price ASC  
    LIMIT 5); 
```

# DELETE that causes an error due to foreign key constraint

This query attempts to delete a product that is still referenced in the `Sales.OrderDetails table`, which results in an error. 

```sql
DELETE FROM Sales.Products WHERE productid = 1;
```
# Handling the error - Solution 1 : DELETE related rows first

To resolve the issue, first delete the related rows from `Sales.OrderDetails` before deleting the product.

```sql
DELETE FROM Sales.OrderDetails WHERE productid = 1; 
DELETE FROM Sales.Products WHERE productid = 1; 
```

# Handling the error - Solution 2 : Use ON DELETE CASCADE

ON DELETE CASCADE - ensures that deleting a product from Sales.Products automatically deletes corresponding order details. 

This SQL statement alters the `Sales.OrderDetails` table. 
It drops the existing orderdetails_productid_fkey constraint, as direct modification of foreign key constraints is not supported.  
Then, it adds a new constraint with the same name, including `ON DELETE CASCADE`. 

```sql
ALTER TABLE Sales.OrderDetails 
DROP CONSTRAINT orderdetails_productid_fkey, 
ADD CONSTRAINT orderdetails_productid_fkey  
FOREIGN KEY (productid) REFERENCES Sales.Products (productid) 
ON DELETE CASCADE; 
```

With this modification in place, the following query will execute successfully :

```sql
DELETE FROM Sales.Products WHERE productid = 1; 
```


