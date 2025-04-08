## UPSERT operation

# UPSERT - insert or update multiple columns

EXCLUDED - a special table alias in PostgreSQL used within the ON CONFLICT clause. It refers to the row that was proposed for insertion but caused a conflict. You can use EXCLUDED to access the values from the conflicting INSERT and use them in the DO UPDATE statement.

Next query attempts to insert a new product with `productid` = 2. 
If a conflict occurs because a product with the same `productid` already exists, it updates the existing row by setting the `productname`, `unit`, and `price` to the values from the new row (using the EXCLUDED alias) 

```sql
INSERT INTO Sales.Products(productid,productname,unit,price) 
VALUES(2,’Laptop Stand’,’5 boxes’ 35.99) 
ON CONFLICT(productid) 
DO UPDATE SET productname = EXCLUDED.productname, unit = EXCLUDED.unit, price = EXCLUDED.price; 
```

# UPSERT - insert or do nothing if conflict

This query tries to insert a new product with `productid` = 2. 
If a conflict occurs because a product with the same `productid` already exists, the database does nothing and skips the insert. 

```sql
INSERT INTO Sales.Products (productid, productname, price) 
VALUES (2, 'Webcam', 59.99) 
ON CONFLICT (productid) 
DO NOTHING; 
```

# UPSERT - with RETURNING

This query inserts a new product with `productid` = 2. 
If a product with the same `productid` already exists, it updates the `productname` and `price` with the new values. 
The RETURNING clause returns the `productid`, `productname`, and `price` of the inserted or updated row. 

```sql
INSERT INTO Sales.Products (productid, productname, price) 
VALUES (2, 'Bluetooth Speaker', 89.99) 
ON CONFLICT (productid) 
DO UPDATE SET price = EXCLUDED.price, productname = EXCLUDED.productname 
RETURNING productid, productname, price; 
```

# UPSERT - with subquery values

This query inserts or updates products that have been used in orders, refreshing their name and price based on the existing data from the `Sales.Products` table.

```sql
INSERT INTO Sales.Products (productid, productname, price) 
SELECT DISTINCT p.productid, p.productname, p.price 
FROM Sales.Products p 
JOIN Sales.OrderDetails od ON p.productid = od.productid 
ON CONFLICT (productid) 
DO UPDATE SET  
    productname = EXCLUDED.productname, 
    price = EXCLUDED.price; 
```