Using the two documents you added to the database as the target of our queries, let's walk through some query basics. Azure Cosmos DB uses SQL queries, just like SQL Server, to perform query operations. All properties are automatically indexed by default, so all data in the database is instantly available to query.

## SQL query basics
Every SQL query consists of a `SELECT` clause and optional `FROM` and `WHERE` clauses. You can also add other clauses like `ORDER BY` and `JOIN` to get the information you need.

A SQL query has the following format:

```sql
SELECT <select_list>
    [FROM <optional_from_specification>]
    [WHERE <optional_filter_condition>]
    [ORDER BY <optional_sort_specification>]
    [JOIN <optional_join_specification>]
```

You can place all of the verbs onto the same line, or separate them with newlines to make them more readable.


## SELECT clause

The `SELECT` clause determines the type of values that will be produced when the query is executed. A value of `SELECT *` indicates that the entire JSON document is returned. For example, if you typed the following query:

```sql
SELECT *
  FROM Products p
  WHERE p.id ="1"
```

The returned results would be a JSON document that looks something like:

```json
[
    {
        "id": "1",
        "productId": "33218896",
        "category": "Women's Clothing",
        "manufacturer": "Contoso Sport",
        "description": "Quick dry crew neck t-shirt",
        "price": "14.99",
        "shipping": {
            "weight": 1,
            "dimensions": {
                "width": 6,
                "height": 8,
                "depth": 1
            }
        },
        "_rid": "iAEeANrzNAAJAAAAAAAAAA==",
        "_self": "dbs/iAEeAA==/colls/iAEeANrzNAA=/docs/iAEeANrzNAAJAAAAAAAAAA==/",
        "_etag": "\"00003a02-0000-0000-0000-5b9208440000\"",
        "_attachments": "attachments/",
        "_ts": 1536297028
    }
]
```

Or, you can limit the output to include only certain properties by including a list of properties in the `SELECT` clause. In the following query, only the ID, manufacturer, and product description are returned.

```sql
SELECT
     p.id,
     p.manufacturer,
     p.description
  FROM Products p
  WHERE p.id ="1"
```

The results would look something like:

```json
[
    {
        "id": "1",
        "manufacturer": "Contoso Sport",
        "description": "Quick dry crew neck t-shirt"
    }
]
```

## FROM clause

The `FROM` clause specifies the data source upon which the query operates. You can make the whole container the source of the query or you can specify a subset of the container instead. The FROM clause is optional unless the source is filtered or projected later in the query.

A query such as `SELECT * FROM Products` indicates that the entire Products container is the source over which to enumerate the query.

### Use aliases

A container can be _aliased_ with the `AS` keyword. This allows you to refer to the container using a shorter or more descriptive name.

```sql
SELECT p.id FROM Products AS p
```

Allows you to use `p` in place of `Products` - notice we can now use the shorter form `p.id`. You can also omit the `AS` keyword as shown in this equivalent statement:

```sql
SELECT p.id FROM Products p
```

Once aliased, the original source can't be bound. For example, `SELECT Products.id FROM Products p` is syntactically invalid because the identifier "Products" can't be resolved anymore.

All properties that need to be referenced must be fully qualified. In the absence of strict schema adherence, this is enforced to avoid any ambiguous bindings. Therefore, `SELECT id FROM Products p` is syntactically invalid because the property `id` is not bound.

### Subdocuments in a FROM clause
The source can also be reduced to a smaller subset. For instance, to enumerate only a subtree in each document, the subroot could then become the source, as shown in the following example:

```sql
SELECT *
  FROM Products.shipping
```

Would produce:

```json
[
    {
        "weight": 1,
        "dimensions": {
            "width": 6,
            "height": 8,
            "depth": 1
        }
    },
    {
        "weight": 2,
        "dimensions": {
            "width": 8,
            "height": 11,
            "depth": 3
        }
    }
]
```

Although the above example used an array as the source, an object could also be used as the source, which is what's shown in the following example. Any defined valid JSON value that can be found in the source is considered for inclusion in the result of the query. 

If some products don’t have a `shipping.weight` value, they're excluded in the query result. For example, consider the following query:

```sql
SELECT *
  FROM Products.shipping.weight
```

Which produces:

```json
[
    1,
    2
]
```

## WHERE clause

The `WHERE` clause specifies the conditions that the source JSON documents must satisfy to be included as part of the result. Any JSON document must evaluate the specified conditions to **true** to be considered for the result. The `WHERE` clause is optional.

The following query requests documents that contain an ID whose value is 1:

```sql
SELECT p.description
  FROM Products p
  WHERE p.id = "1"
```

Here's the produced JSON result:

```json
[
    {
        "description": "Quick dry crew neck t-shirt"
    }
]
```

## ORDER BY clause

The `ORDER BY` clause enables you to order the results in ascending or descending order.

The following `ORDER BY` query returns the price, description, and product ID for all products, ordered by price, in ascending order:

```sql
SELECT p.price, p.description, p.productId
  FROM Products p
  ORDER BY p.price ASC
```

Which produces:

```json
[
    {
        "price": "14.99",
        "description": "Quick dry crew neck t-shirt",
        "productId": "33218896"
    },
    {
        "price": "49.99",
        "description": "Black wool pea-coat",
        "productId": "33218897"
    }
]
```

## JOIN clause

The `JOIN` clause lets you perform _inner joins_ with the document and the document subroots. So in the product database, for example, you can join the documents with the shipping data.

In the following query, the product IDs are returned for each product that has a shipping method. If you added a third product that didn't have a shipping property, the result would be the same because the third item would be excluded for not having a shipping property.

```sql
SELECT p.productId
  FROM Products p
  JOIN p.shipping
```

```json
[
    {
        "productId": "33218896"
    },
    {
        "productId": "33218897"
    }
]
```

## Geospatial queries

Geospatial queries enable you to perform spatial queries using GeoJSON Points. Using the coordinates in the database, you can calculate the distance between two points and determine whether a Point, Polygon, or LineString is within another Point, Polygon, or LineString.

For product catalog data, this would enable your users to enter their location information and determine whether there were any stores within a 50-mile radius that have the item they're looking for.