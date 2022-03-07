A basic SQL query in Azure Cosmos DB SQL API would be similar to the same query in any other database platform; it would be composed of a few essential components:

- The ``SELECT`` keyword
- Either an asterisk to indicate all possible fields or an inclusive list of fields
- The ``FROM`` keyword followed by the data source (container)

Here is a basic query that returns all fields from a container:

```sql
SELECT * FROM products
```

Here is another query that returns only a few fields from a container:

```sql
SELECT 
    products.id, 
    products.name, 
    products.price, 
    products.categoryName 
FROM 
    products
```

One interesting caveat here is that it doesn’t matter what name is used here for the source, as this will reference the source moving forward. You can think of this as a variable. It’s not uncommon to use a single letter from the container name:

```sql
SELECT
    p.name, 
    p.price
FROM 
    p
```

You can use any word or phrase like you would in developer code:

```sql
SELECT
    supercalifragilisticexpialidocious.id,
    supercalifragilisticexpialidocious.categoryId
FROM 
    supercalifragilisticexpialidocious
```

Alternatively, you can alias the data source and use the alias if that’s your preference:

```sql
SELECT 
    alternativealias.id, 
    alternativealias.name 
FROM 
    reallyinterestingdatasource alternativealias
```

We can also filter our queries using the ``WHERE`` keyword. In this example, we filter the list of products to those that have a price that is between $50 and $100:

```sql
SELECT
    p.name, 
    p.categoryName,
    p.price
FROM 
    products p
WHERE
    p.price >= 50 AND
    p.price <= 100
```
