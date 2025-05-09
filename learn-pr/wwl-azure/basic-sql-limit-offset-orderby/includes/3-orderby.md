The `ORDER BY` clause is used in SQL to sort the result set of a `SELECT` statement. This means it arranges the rows of the output based on the values of one or more columns. This is essential for organizing data in a way that makes it easier to interpret and use. You can specify one or more columns to sort by, and you have control over the sort order: ascending (from smallest to largest or A to Z) or descending (from largest to smallest or Z to A). Without `ORDER BY`, the order of the returned rows is unpredictable. 

## Sorting in ascending order (default)

```sql
SELECT * FROM sales.products 
ORDER BY price;
```

This query retrieves products sorted by price in ascending order, which is the default behavior of `ORDER BY`. 
Although redundant, you could explicitly add `ASC` at the end of the query, which could improve readability. 

To change the order, you need to indicate that explicitly, as demonstrated in the following example. 

## Sorting in descending order

```sql
SELECT * FROM sales.products 
ORDER BY price DESC;
```

This query retrieves products sorted by price in descending order.

## Sorting by multiple columns

```sql
SELECT * FROM sales.customers 
ORDER BY country, city;
```

This query retrieves all columns `(*)` from the `sales.customers` table and then sorts the resulting rows.
The sorting is done in two levels:
    1. First, the results are sorted alphabetically by the country column. This means all customers from "Argentina" will be grouped together, followed by customers from "Austria," and so on. 
    2. Within each group of customers from the same country, the results are further sorted alphabetically by the city column. So, if you have multiple customers from "Germany," they'll be ordered by their city names (for example, "Aachen" before "Berlin"). 

In essence, this query provides a customer list that is organized primarily by `country` and then, within each `country`, organized by `city`. This makes it easy to find customers from a specific region. 
Additionally, combining this approach with `ASC` or `DESC` modifiers allows full control over the sorting direction for each column.  

```sql
SELECT * FROM sales.customers 
ORDER BY country ASC, city DESC;
```

This query would sort countries in ascending order while organizing cities within each country in descending order. 