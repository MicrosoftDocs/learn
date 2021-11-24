A JOIN in Azure Cosmos DB SQL API is different from a JOIN in a relational database as its only scope is a single item. A JOIN creates a cross-product between different sections of a single item.

Let’s take this example JSON object, which has a **name** property and an array with two objects that each have their own **group** property:

```json
{
    "id": "E08E4507-9666-411B-AAC4-519C00596B0A",
    "name": "Men's Bib-Shorts",
    "groups": [
        {
            "group": "accessories"
        },
        {
            "group": "new"
        },
        {
            "group": "sale"
        }
    ]
}

```

If you create a cross-product of the **name** and **group** properties, you will create a JSON array with permutations of possible combinations of names and groups, making it easier for your applications to iterate over items in the array:

```json
[
    {
        "name": "Men's Bib-Shorts",
        "group": "accessories"
    },
    {
        "name": "Men's Bib-Shorts",
        "group": "new"
    },
    {
        "name": "Men's Bib-Shorts",
        "group": "sale"
    }
]
```

So, how can you create this type of cross-product in a SQL query? The ``JOIN`` keyword in Azure Cosmos DB SQL API returns all possible combinations of values within two sets. Let’s use a different example JSON object with a more complex group of tags:

```json
{
    "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
    "categoryId": "629A8F3C-CFB0-4347-8DCC-505A4789876B",
    "categoryName": "Clothing, Vests",
    "sku": "VE-C304-L",
    "name": "Classic Vest, L",
    "description": "A worn brown classic vest that was a trade-in apparel item",
    "price": 32.4,
    "tags": [
        {
            "id": "2CE9DADE-DCAC-436C-9D69-B7C886A01B77",
            "name": "apparel",
            "class": "group"
        },
        {
            "id": "CA170AAD-A5F6-42FF-B115-146FADD87298",
            "name": "worn",
            "class": "trade-in"
        },
        {
            "id": "CA170AAD-A5F6-42FF-B115-146FADD87298",
            "name": "no-damaged",
            "class": "trade-in"
        }
    ]
}
```

The corresponding query for this is structured like most ``SELECT FROM`` query, but also includes the ``JOIN`` keyword, which references the **tags** property and aliases it with the letter **t**. Then, we add the **t.name** to the list of projected fields in the query results:

```sql
SELECT 
    p.id,
    p.name,
    t.name AS tag
FROM 
    products p
JOIN
    t IN p.tags
```

The result of this query is a JSON array that includes three objects for the single JSON item in the container:

```json
[
    {
        "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
        "name": "Classic Vest, L",
        "tag": "apparel"
    },
    {
        "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
        "name": "Classic Vest, L",
        "tag": "worn"
    },
    {
        "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
        "name": "Classic Vest, L",
        "tag": "no-damaged"
    }
]
```
