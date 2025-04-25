Often, you need to retrieve data based on conditions that are themselves derived from the data in your database. Subqueries allow you to do this by letting you use the result of one SELECT statement as part of another. This is useful for tasks like finding all customers who placed orders exceeding a certain average or identifying products supplied by a specific set of suppliers. 

Subqueries can be used in the following contexts: 

     Within clauses of SELECT statements (FROM, WHERE, HAVING clause) 

     Within data manipulation statements (INSERT, UPDATE, DELETE statement) 

## Key points to emphasize: 

A subquery is always a SELECT statement. 

The subquery is enclosed in parentheses (). 

The subquery's result is used by the outer query.    

## Subquery examples

```sql
SELECT product_name, price 
FROM sales.products 
WHERE price > ( 
	SELECT AVG(price) 
	FROM sales.products 
); 
```

This query retrieves the names and prices of products from the `sales.products` table where the product's price is greater than the average price of all products in the same table. It uses a subquery within the `WHERE` clause to calculate the average price by selecting the `AVG(price)` from the `sales.products` table. The result of this subquery is then compared against the `price` column in the outer query to filter and display only those products whose prices exceed this calculated average. 

```sql
SELECT customer_id, customer_name 
FROM sales.customers 
WHERE customer_id IN ( 
	SELECT DISTINCT customer_id 
	FROM sales.orders 
); 
```

This query retrieves the IDs and names of customers from the `sales.customers` table who have placed at least one order. It achieves this by using a subquery within the `WHERE` clause. The subquery selects distinct `customer_id` values from the `sales.orders` table, representing customers who have made any orders. The outer query then uses these IDs to filter and display customer information, ensuring that only those customers who are associated with orders are included in the result. 

```sql
SELECT supplier_id, AVG (price) AS avg_price 
FROM ( SELECT supplier_id, price FROM sales.products) AS product_prices 
GROUP BY supplier_id; 
```

This query calculates the average product price for each supplier. It uses a subquery in the FROM clause to select the supplier_id and price from the sales.products table. The outer query then groups the result by supplier_id and calculates the average price for each group. This approach can be helpful when you want to perform aggregation on a filtered or preprocessed set of data. 

```sql
UPDATE sales.products 
SET price = price * 1.1 
WHERE category_id = (SELECT category_id FROM sales.products GROUP BY category_id                   
ORDER BY AVG(price) DESC LIMIT 1); 
```

This query increases the prices of products in the category with the highest average price by 10%. The `UPDATE` statement modifies the `price` column in the `sales.products` table, multiplying it by 1.1 for rows matching the condition in the `WHERE` clause.  

The subquery inside the `WHERE` clause determines the `category_id` of the category with the highest average price by grouping the products by their `category_id`, calculating the average `price` for each group, and ordering them in descending order of average price. The `LIMIT 1` ensures that only the top result, i.e., the category with the highest average price, is selected and used to filter the rows for the update. 