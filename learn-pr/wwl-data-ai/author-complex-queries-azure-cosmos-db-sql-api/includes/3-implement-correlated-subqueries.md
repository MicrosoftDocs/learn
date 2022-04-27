We can optimize JOIN expressions further by writing subqueries to filter the number of array items we want to include in the cross-product set.

Let’s examine the example JSON object again:

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

In this example, we include tags that are in both classes **trade-in** and **group**. What if we want to filter out the **group** tags?

We can rewrite our JOIN expression by writing a subquery to filter out the group tags using a subquery:

```sql
SELECT VALUE t FROM t IN p.tags WHERE t.class = 'trade-in'
```

If we add this subquery to the entire all-up query, it will total up to this:

```sql
SELECT 
    p.id,
    p.name,
    t.name AS tag
FROM 
    products p
JOIN
    (SELECT VALUE t FROM t IN p.tags WHERE t.class = 'trade-in') AS t
```

Our final JSON result array would then be this with one less result in the set:

```json
[
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
