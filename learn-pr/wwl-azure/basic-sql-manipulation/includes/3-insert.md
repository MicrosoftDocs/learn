## INSERT command

# INSERT data into specific column/columns

```sql
INSERT INTO Sales.Products (productname,price)
VALUES ('keyboard', 25.99);
```
This query adds a new row to the `Sales.Products` table with `keyboard` as the product name and 25.99 as the price. Other columns will be left as NULL 

# INSERT error due to missing NOT NULL value

This section shows the result of attempting to insert data without providing a value for a column defined as NOT NULL. 

Before we proceed, we want to check which columns in the Sales.Products table are defined as NOT NULL. The following query lists all columns along with their data, type, nullability, and default value. At this point, the price column is still nullable. 

```sql
SELECT column_name,data_type, is_nullable, column_default
FROM information_schema.columns 
WHERE table_schema = ' sales ' 
AND table_name = ' products '; 
```

In the next step, we modify the price column to make it mandatory by setting it to NOT NULL. This ensures that every new product must have a price value. 

```sql
ALTER TABLE Sales.Products 
ALTER COLUMN price SET NOT NULL;
```
 Next, we try inserting a product without specifying the price. Because the price column is set to NOT NULL, the database will return an error indicating that this field cannot be left empty. 

 ```sql
 INSERT INTO Sales.Products (productname)
 VALUES ('Gaming chair');
 ```

 To fix this error, we need to include a value for the price column in our INSERT statement. 

 This query inserts a new product called `Gaming Chair` into the `Sales.Products` table with a price of 149.99. 

 ```sql
INSERT INTO Sales.Products (productname,price) 
VALUES ('Gaming Chair', 149.99); 
```

# INSERT data into all columns

 We do not need to manually insert values for columns like productid (auto-increment) 
 The `productid` column is not included in the SQL query because it is set as auto-increment.  
 This means that the database automatically generates a unique value for productid each time a new product is added.
 The database handles assigning the next available value, ensuring that each product has a unique identifier, so there is no need to manually provide a value for productid 

 ```sql
INSERT INTO Sales.Products (productname, supplierid, categoryid, unit, price)  
VALUES ('Wireless Mouse', 1, 2, '1 per box', 19.99); 
```

# INSERT multiple rows at once

 Instead of running separate INSERT statements, you can insert multiple rows in a single query:

 Since we only provided the `productname`, this query will create three rows in the `Sales.Products` table with the specified names (`Onion`, `Milk`, `Skateboard`).

 The productid column will be automatically assigned (auto-increment), while all other columns will be filled with NULL values. 

 ```sql
INSERT INTO Sales.Products (productname)  
VALUES ('Onion'), ('Milk'), ('Skateboard'); 
```

# Or with additional column values:

This query inserts three rows into the `Sales.Products` table with the specified productname and price values. 
The `productid` will be automatically assigned (auto-increment), while all other unspecified columns will be filled with NULL values. 

```sql
INSERT INTO Sales.Products (productname, price) VALUES ('USB Hub', 14.50), ('HDMI Cable', 8.75), ('External SSD', 120.00); 
```

# INSERT data from another table

This query inserts new rows into `Sales.OrderDetails` table  by selecting `orderid` from orders placed after January 1, 1996, `productid` from products in `Category 1`, and setting the `quantity` to 1 for each inserted row 

```sql
INSERT INTO Sales.OrderDetails (orderid, productid, quantity) 
SELECT o.orderid, p.productid, 1 
FROM Sales.Orders o 
JOIN Sales.Products p ON p.categoryid = 1  
WHERE o.orderdate > '1996-01-01'; 
```

# Another example

This query inserts new orders for customers from Germany into the `Sales.Orders` table, assigning today's date as the `orderdate`, `employeeid` as 1, and `shipperid` as 2, while the DISTINCT keyword ensures that only unique customer records are selected, preventing duplicates. 

```sql
INSERT INTO Sales.Orders (customerid, employeeid, orderdate, shipperid)   
SELECT DISTINCT c.customerid, 1, CURRENT_DATE, 2   
FROM Sales.Customers c   
JOIN Sales.Orders o ON c.customerid = o.customerid  
WHERE c.country = 'Germany'; 
```