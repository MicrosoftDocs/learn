The SQL query language for the Azure Cosmos DB SQL API ships with built-in functions for common tasks in a query. In this unit, we will walk through a brief set of examples of those functions.

Let’s start with an example where the name and the category are concatenated in the query result. For this example, the CONCAT built-in string function is used to concatenate these two fields together with a single vertical bar in the middle:

```sql
SELECT VALUE
    CONCAT(p.name, ' | ', p.categoryName)
FROM
    products p
```

For the next example, the query returns a flattened array with a single field, sku. Unfortunately, the sku may, or may not, be in lowercase. To solve for this, the LOWER built-in function is used to manipulate the string to all lowercase characters.

```sql
SELECT VALUE 
    LOWER(p.sku) 
FROM 
    products p
```

For this last example, the query is intended to filter out products that shouldn’t be retired yet by using the GetCurrentDateTime built-in function in a WHERE expression:

```sql
SELECT 
    *
FROM
    products p
WHERE
    p.retirementDate >= GetCurrentDateTime()
```

> [!TIP]
> This is not a comprehensive list of built-in functions for the Azure Cosmos DB SQL API query language.
