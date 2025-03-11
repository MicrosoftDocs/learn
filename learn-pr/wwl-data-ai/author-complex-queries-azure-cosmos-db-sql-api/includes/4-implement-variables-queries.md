We can implement many common cross-product queries on the SDK side and may want to add filters to prevent the queries from exploding in result size and complexity. Using the available classes and methods within the SDK, we can add query parameters to quickly adjust the values in a ``WHERE`` filter for a SQL query.

Let’s look at an example SQL query that uses a ``JOIN`` and a ``WHERE`` filter:

```sql
SELECT 
    p.name,
    t.name AS tag
FROM 
    products p
JOIN
    t IN p.tags
WHERE
    p.price > 500
```

::: zone pivot="csharp"

In C#, we would typically create a query definition using the following syntax with the value of **500** hard-coded in a string value:

```csharp
string sql = "SELECT p.name, t.name AS tag FROM products p JOIN t IN p.tags WHERE p.price > 500"
QueryDefinition query = new (sql);
```

However, using the **.WithParameter(string, string)** fluent method, you can add parameters to the query making it easier to configure parameters in the query:

```csharp
string sql = "SELECT p.name, t.name AS tag FROM products p JOIN t IN p.tags WHERE p.price > @lower"
QueryDefinition query = new (sql)
    .WithParameter("@lower", 500);
```

You can even use multiple parameters in more complex queries:

```csharp
string sql = "SELECT p.name, t.name AS tag FROM products p JOIN t IN p.tags WHERE p.price >= @lower AND p.price <= @upper"
QueryDefinition query = new (sql)
    .WithParameter("@lower", 500)
    .WithParameter("@upper", 1000);
```

::: zone-end

::: zone pivot="python"

In Python, we would typically create a query definition using the following syntax with the value of **500** hard-coded in a string value:

```python
query_text = "SELECT p.name, t AS tag FROM products p JOIN t IN p.tags WHERE p.price > 500"
query = {"query": query_text}
```

However, using parameters to the query dynamically, we can adjust the `WHERE` filter values at runtime. Here's how to add a parameter using the Python SDK:

```python
query_text = "SELECT p.name, t AS tag FROM products p JOIN t IN p.tags WHERE p.price > @lower"

query = {
    "query": query_text,
    "parameters": [
        {"name": "@lower", "value": 500}
    ]
}
```

You can even use multiple parameters in more complex queries:

```python
query_text = (
    "SELECT p.name, t AS tag "
    "FROM products p JOIN t IN p.tags "
    "WHERE p.price >= @lower AND p.price <= @upper"
)

query = {
    "query": query_text,
    "parameters": [
        {"name": "@lower", "value": 500},
        {"name": "@upper", "value": 1000}
    ]
}
```

::: zone-end

::: zone pivot="node"

In JavaScript, we would typically create a query definition using the following syntax with the value of **500** hard-coded in a string value:

```javascript
const sql = "SELECT p.name, t.name AS tag FROM products p JOIN t IN p.tags WHERE p.price > 500";
```

However, using parameters to the query dynamically, we can adjust the `WHERE` filter values at runtime. Here's how to add a parameter using the JavaScript SDK:

```javascript
const sql = "SELECT p.name, t.name AS tag FROM products p JOIN t IN p.tags WHERE p.price > @lower";

const querySpec = {
    query: sql,
    parameters: [
        { name: "@lower", value: 500 }
    ]
};
```

You can even use multiple parameters in more complex queries:

```javascript
const sql = "SELECT p.name, t.name AS tag FROM products p JOIN t IN p.tags WHERE p.price >= @lower AND p.price <= @upper";

const querySpec = {
    query: sql,
    parameters: [
        { name: "@lower", value: 500 },
        { name: "@upper", value: 1000 }
    ]
};
```

::: zone-end

## Benefits of Parameterized Queries

- **Improved Security**: Helps prevent SQL injection attacks.
- **Flexibility**: Allows you to modify query filters dynamically without changing the SQL query structure.
- **Code Reusability**: Makes it easier to reuse query definitions across multiple queries with different parameter values.
