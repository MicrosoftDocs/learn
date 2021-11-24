One of Azure Cosmos DB SQL API’s advantages as a data store is its flexibility to store data with varying structures and shapes. As the developer crafting queries for this data, the responsibility for type checking will often fall on your queries. The SQL query language for the SQL API includes a suite of built-in functions to make it possible for you to check the types of properties or expressions on the fly when they are variable or unknown.

Up until now, we have had a sample data structure that is well known and understood. But let’s consider some possible exceptions.

Each **product** item in the container has a property named **tags**. The tags property is an array of objects with **id** and **name** properties. The assumption, until now, is that the tags array always exists for every product in the container. But if we remove that baseline assumption, we could have a situation where a new product item is inserted into the container without a tag property such as this example:

```json
{
    "id": "6374995F-9A78-43CD-AE0D-5F6041078140",
    "categoryid": "3E4CEACD-D007-46EB-82D7-31F6141752B2",
    "sku": "FR-R38R-60",
    "name": "LL Road Frame - Red, 60",
    "price": 337.22
}
```

First, we can use the ``IS_DEFINED`` built-in function to check if the **tags** property exists at all in this item:

```sql
SELECT
    IS_DEFINED(p.tags) AS tags_exist
FROM
    products p
```

```json
[
    {
        "tags_exist": false
    }
]
```

Let’s say that the tags property does exist, but it’s not an array; it’s another type of property:

```json
{
    "id": "6374995F-9A78-43CD-AE0D-5F6041078140",
    "categoryid": "3E4CEACD-D007-46EB-82D7-31F6141752B2",
    "sku": "FR-R38R-60",
    "name": "LL Road Frame - Red, 60",
    "price": 337.22,
    "tags": "fun, sporty, rad"
}
```

We can use the ``IS_ARRAY`` built-in function to check if the tags property is an array:

```sql
SELECT
    IS_ARRAY(p.tags) AS tags_is_array
FROM
    products p
```

We can also check if the tags property is *null* or not using the ``IS_NULL`` built-in function:

```sql
SELECT
    IS_NULL(p.tags) AS tags_is_null
FROM
    products p
```

There are even more built-in functions for different scenarios involving other data types.

For example, consider a situation where different data stores persist pricing information inconsistently. Some persist pricing information using string data, while others may store pricing information using numbers. The built-in ``IS_NUMBER`` function could be used in a WHERE expression of our queries:

```sql
SELECT
    p.id,
    p.price, 
    (p.price * 1.25) AS priceWithTax
FROM
    products p
WHERE
    IS_NUMBER(p.price)
```

We could also use the built-in ``IS_STRING`` function to see if our price is a string and not apply any formatting:

```sql
SELECT
    p.id,
    p.price
FROM
    products p
WHERE
    IS_STRING(p.price)
```

There are other built-in type checking functions including ``IS_OBJECT`` and ``IS_BOOLEAN``.
