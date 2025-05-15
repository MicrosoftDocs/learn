
##  Querying data with calculated columns

```sql
SELECT employee_id, first_name, last_name, birth_date, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date) AS age  
FROM sales.employees; 
```

This query retrieves employee details such as `employee_id`, `first_name`, `last_name`, and `birth_date` from the `sales.employees` table. 
It also calculates the age of each employee by subtracting the year of birth (extracted from their `birth_date`) from the current year (extracted using `CURRENT_DATE`). 
The calculated age is given an alias `age`, which serves as a temporary, user-defined label for the resulting column. This alias simplifies reference to the column in the query results or subsequent operations, providing a clearer and more intuitive way to identify the calculated data. 

## Querying data with column concatenation

```sql
SELECT CONCAT(address, ' ', city, ' ', postal_code, ' ', country) AS billing_address 
FROM sales.customers; 
```

This SQL query combines multiple columns: `address`, `city`, `postal_code` and `country` from the `sales.customers` table into a single concatenated field labeled as `billing_address`. 
The `CONCAT` function is used to merge these values into one string, with spaces added between each column to ensure proper formatting. By doing so, the query simplifies the presentation of customer location information, making it easier to read or use in applications where a complete billing address is required in a unified format. 
The alias `billing_address` is applied to the resulting column for better identification and usability in subsequent operations or outputs. 