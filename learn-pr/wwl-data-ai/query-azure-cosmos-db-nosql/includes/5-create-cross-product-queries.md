The Contoso merchandising team wants a different view of the same data: one row per product-and-tag pair, so a report can group products by tag. `EXISTS` can't produce that view, because it returns each product once. This unit covers `JOIN`, which expands a nested array into a cross-product and gives you one result per element.

## JOIN operates inside a single item

`JOIN` in Azure Cosmos DB for NoSQL isn't the relational operator of the same name. It never combines two containers, and it never combines two items. Its scope is one item, and it produces the cross-product of a value in that item with the elements of an array in that item. The product documentation calls the same operation a **self-join**, for exactly that reason.

Start with one catalog item. This product carries two tags:

```json
{
    "id": "80D3630F-B661-4FD6-A296-CD03BB7A4A0C",
    "name": "Classic Vest, L",
    "tags": [
        { "id": "2CE9DADE-DCAC-436C-9D69-B7C886A01B77", "name": "Tag-101" },
        { "id": "CA170AAD-A5F6-42FF-B115-146FADD87298", "name": "Tag-186" }
    ]
}
```

A cross-product of the product name and the tag names produces two flat results from that one item:

```json
[
    { "name": "Classic Vest, L", "tag": "Tag-101" },
    { "name": "Classic Vest, L", "tag": "Tag-186" }
]
```

The query that produces it puts `JOIN` between the container alias and the array, and binds an alias to each array element:

```sql
SELECT
    p.name,
    t.name AS tag
FROM product p
JOIN t IN p.tags
```

Against a product with five tags, that query returns five results for that single product. Multiply across a category and the result count grows to the total number of tag elements in the category, not the number of products.

An item whose `tags` array is empty, or that has no `tags` property at all, contributes nothing. The cross-product of a set with an empty set is empty, so the product disappears from the results entirely. That behavior is the most common surprise with `JOIN`, and this catalog makes it easy to hit: products such as **Road Tire Tube** and **Classic Vest, S** carry no tags at all, so a report built this way silently omits them.

:::image type="content" source="../media/join-cross-product-expansion.png" alt-text="Diagram showing three products expanding into JOIN result rows, where the product with an empty tags array produces no row at all." lightbox="../media/join-cross-product-expansion.png":::

## Filter what enters the cross-product

Filtering array elements before a cross-product can reduce intermediate work without changing the final results.

Indexed filters on the parent item can narrow the items before their arrays expand:

```sql
SELECT p.name, t.name AS tag
FROM product p
JOIN t IN p.tags
WHERE p.price > @min
```

Here, the range index can identify products that satisfy `p.price > @min` before the engine expands their tags. A filter on a tag property in the outer `WHERE` clause still filters the resulting tuples. With multiple array joins, those tuples can form a large intermediate cross-product.

A subquery filters before the cross-product is formed, using the same building block from the previous unit:

```sql
SELECT p.name, t.name AS tag
FROM product p
JOIN (SELECT VALUE t FROM t IN p.tags WHERE t.name = @tag) AS t
WHERE p.categoryId = @category
```

Only matching tags enter the expansion. A product with five tags and one matching tag contributes one row to the cross-product instead of five. This reduces intermediate work, especially when joining multiple arrays. Filter as early as the shape of your question allows: partition key and indexed properties in the outer `WHERE`, array conditions in the subquery, and only genuinely cross-cutting conditions after the expansion.

## Joining more than one array multiplies

Nothing stops you from joining more than one array. The catalog's `product` documents hold a single array, but the `salesOrder` documents in this dataset hold order lines, and other models in the same family carry several arrays per item. A catalog that tracked sizes alongside tags would look like the following query, which doesn't run against this dataset. The arithmetic is worth stating explicitly, because it's what makes multi-array joins dangerous:

```sql
SELECT c.name, t.name AS tag, s.description AS size
FROM catalogItem c
JOIN t IN c.tags
JOIN s IN c.sizes
```

An item with 5 tags and 4 sizes produces 20 results. An item with 50 tags and 40 sizes produces 2,000, from a single document. The request unit (RU) charge and the response size follow that multiplication, and a query that behaves well against test data with short arrays can be an outage against production data with long ones.

Before adding a second `JOIN`, check whether the question needs every combination. Reports that consume one array at a time usually do better with two queries, or with an `ARRAY` projection that returns each array intact. A hard ceiling backs up that advice: a single query allows 10 `JOIN` statements by default, and raising that limit takes a support request.

## Run it from the SDK

Cross-product queries execute like any other query, and the same parameterization applies.

::: zone pivot="csharp"

```csharp
QueryDefinition query = new QueryDefinition(@"
        SELECT p.name, t.name AS tag
        FROM product p
        JOIN (SELECT VALUE t FROM t IN p.tags WHERE t.name = @tag) AS t
        WHERE p.categoryId = @category")
    .WithParameter("@tag", tagName)
    .WithParameter("@category", categoryId);

QueryRequestOptions options = new()
{
    PartitionKey = new PartitionKey(categoryId)
};

using FeedIterator<TaggedProduct> iterator =
    container.GetItemQueryIterator<TaggedProduct>(query, requestOptions: options);

while (iterator.HasMoreResults)
{
    FeedResponse<TaggedProduct> response = await iterator.ReadNextAsync();
    Console.WriteLine($"{response.Count} rows for {response.RequestCharge} RU");
}
```

The result type is a flattened projection, not the item type. `TaggedProduct` here holds `name` and `tag`, because the query returns that shape.

::: zone-end

::: zone pivot="python"

```python
query = """
    SELECT p.name, t.name AS tag
    FROM product p
    JOIN (SELECT VALUE t FROM t IN p.tags WHERE t.name = @tag) AS t
    WHERE p.categoryId = @category
"""

rows = container.query_items(
    query=query,
    parameters=[
        {"name": "@tag", "value": tag_name},
        {"name": "@category", "value": category_id},
    ],
    partition_key=category_id,
)

pairs = list(rows)
charge = container.client_connection.last_response_headers["x-ms-request-charge"]
print(f"{len(pairs)} rows, last page charged {charge} RU")
```

Each result is a flat dictionary with `name` and `tag` keys, not a full product item. `list()` drains every page, but `last_response_headers` holds the final page alone, so totaling the charge across a multi-page result takes a `response_hook`.

::: zone-end

---

> **Synthesis prompt:** You need the products that carry a given tag. Two queries can return them: an `EXISTS` subquery, or a `JOIN` with a `DISTINCT` projection of the product fields. Decide which one you'd ship, and be specific about why. Consider what each returns for a product carrying that tag once versus a product carrying several tags, how the result count relates to the item count, which one an untagged product can silently disappear from, and the fact that a `DISTINCT` query supports continuation tokens only when it also has an `ORDER BY` clause.
