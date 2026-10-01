The Contoso catalog API takes its filter values from the request: a category from the route, a price range from the query string, a sort order from a header. Building the query as a string and pasting in those values works on the first try and creates two problems that surface later. In this unit, you write parameterized queries, project results into the shape your application consumes, apply built-in functions, and run all of it through the SDK.

## Parameterize every value that comes from outside

A parameterized query separates the query text from its values. The text stays constant, and the values travel alongside it.

```sql
SELECT p.name, p.price
FROM product p
WHERE p.categoryId = @category AND p.price <= @max
```

That separation closes the injection path that string concatenation opens: a value can never be interpreted as query syntax, whatever arrives in the request.

::: zone pivot="csharp"

```csharp
QueryDefinition query = new QueryDefinition(
        "SELECT p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max")
    .WithParameter("@category", categoryId)
    .WithParameter("@max", maxPrice);
```

`WithParameter` is fluent, so parameters chain. The value keeps its type: passing a `decimal` produces a numeric comparison, and passing a string produces a string comparison.

::: zone-end

::: zone pivot="python"

```python
query = "SELECT p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max"

parameters = [
    {"name": "@category", "value": category_id},
    {"name": "@max", "value": max_price},
]
```

Each parameter is a dictionary with `name` and `value` keys. The value keeps its Python type, so an `int` or `float` produces a numeric comparison and a `str` produces a string comparison.

::: zone-end

Parameters replace values, not identifiers. You can't parameterize a property name, an alias, or a sort direction. When a client chooses the sort column, map the incoming value against a fixed allow list of column names and build the text from that name, rather than substituting the raw input.

## Project the shape your application needs

The catalog's product cards need three fields: a name, a category label, and a price nested under a `scannerData` object. Rather than returning whole items and reshaping them in application code, shape them in the query.

Aliasing renames a property with `AS`:

```sql
SELECT
    p.name,
    p.categoryName AS category,
    { "price": p.price } AS scannerData
FROM product p
WHERE p.categoryId = @category
```

The object literal creates a nested object in the output, so the result arrives ready to deserialize:

```json
{
    "name": "Classic Vest, L",
    "category": "Clothing, Vests",
    "scannerData": { "price": 63.5 }
}
```

When a query returns exactly one property, `VALUE` flattens the results into an array of scalars instead of an array of single-property objects. Pair it with `DISTINCT` to build the catalog's category filter list:

```sql
SELECT DISTINCT VALUE p.categoryName FROM product p
```

```json
["Clothing, Vests", "Components, Pedals", "Bikes, Touring Bikes"]
```

Without `VALUE`, that same query returns objects, and your code needs a wrapper type whose only job is to hold one string.

Projection reduces the response payload and can lower the request unit (RU) charge. Replacing `SELECT *` with the properties a screen displays doesn't necessarily reduce the work of loading documents or reading the index. Measure the charge instead of assuming that every request costs less.

## Apply built-in functions

Built-in functions and pattern-matching operators transform and compare values inside the query. A few that earn their place in a catalog API:

| Expression | Use |
|:---|:---|
| `CONCAT(p.name, ', ', p.categoryName)` | Build a display string server side |
| `LOWER(p.sku)` | Normalize inconsistent casing before comparison |
| `STARTSWITH(p.name, @prefix, true)` | Prefix match, with an optional case-insensitive flag |
| `CONTAINS(p.name, @term, true)` | Substring match |
| `p.name LIKE @pattern` | Wildcard match, using `%` for any sequence of characters and `_` for a single character |
| `GetCurrentDateTime()` | Compare against the current Coordinated Universal Time (UTC) |
| `ARRAY_LENGTH(p.tags)` | Count elements in an array property |

Where a function appears changes what it costs. In a `SELECT` clause, a function transforms values the engine already retrieved, so index usage is unaffected. In a `WHERE` clause, a function can prevent the engine from using the index and force it to evaluate every candidate item instead. `STARTSWITH` and a range comparison can both use the index; wrapping a property in `LOWER` and comparing the result can't, because the index stores the original value. The case-insensitive flag sits between those two cases: the query still uses the index, but it scans a wider set of index entries than the case-sensitive form does.

```sql
SELECT p.id, p.name
FROM product p
WHERE p.categoryId = @category AND STARTSWITH(p.name, @prefix, true)
```

When a case-insensitive comparison sits on a hot path, storing a normalized copy of the value at write time, such as a `nameLower` property, converts function evaluation into an ordinary indexed comparison.

## Execute the query

::: zone pivot="csharp"

```csharp
QueryDefinition query = new QueryDefinition(
        "SELECT p.id, p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max")
    .WithParameter("@category", categoryId)
    .WithParameter("@max", maxPrice);

QueryRequestOptions options = new()
{
    PartitionKey = new PartitionKey(categoryId)
};

using FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(query, requestOptions: options);

while (iterator.HasMoreResults)
{
    FeedResponse<Product> response = await iterator.ReadNextAsync();

    Console.WriteLine($"Page charge: {response.RequestCharge} RU");

    foreach (Product product in response)
    {
        Console.WriteLine($"{product.name}: {product.price:C}");
    }
}
```

`GetItemQueryIterator<T>` returns a `FeedIterator<T>` that fetches results in pages. Draining it with the `HasMoreResults` and `ReadNextAsync` pair exposes `RequestCharge` on every `FeedResponse<T>`, which a helper that collects all pages into one list discards.

::: zone-end

::: zone pivot="python"

```python
query = "SELECT p.id, p.name, p.price FROM product p WHERE p.categoryId = @category AND p.price <= @max"

results = container.query_items(
    query=query,
    parameters=[
        {"name": "@category", "value": category_id},
        {"name": "@max", "value": max_price},
    ],
    partition_key=category_id,
)

for product in results:
    print(f"{product['name']}: {product['price']}")

charge = container.client_connection.last_response_headers["x-ms-request-charge"]
print(f"Last page charge: {charge} RU")
```

`query_items` returns a paged iterable, and iterating it fetches each page as needed. Reading `last_response_headers` after the iteration reports the charge for the last page alone, not the query total. To accumulate the charge across a multi-page result, pass a `response_hook` callable, which the SDK invokes once per page.

::: zone-end

Setting the partition key on the request scopes the query to one logical partition. An equality filter on the partition key, such as `p.categoryId = @category`, also lets the service route the query to the relevant physical partition. Omitting the SDK option doesn't force that query to fan out. A query with no partition-key restriction checks every physical partition, including those with no matching items. The extra RU cost grows with the number of physical partitions. In the Contoso catalog, a category browse always knows its `categoryId`, so it sets the request option explicitly.

---

> **Try it yourself:** Filter on `categoryName`, not the partition-key property `categoryId`, and compare three queries: `SELECT *` without a partition-key request option, `SELECT *` scoped to that category's `categoryId`, and a projection of the properties your user interface needs with the same scope. For the first Python query, set `enable_cross_partition_query=True`. Print the total RU charge for each query and check the container's physical partition count. This comparison separates the effect of partition routing from the effect of projection; neither change guarantees a particular saving.
