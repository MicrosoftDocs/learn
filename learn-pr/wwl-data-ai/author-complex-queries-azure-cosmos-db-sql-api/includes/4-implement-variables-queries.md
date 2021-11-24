We can implement many common cross-product queries on the SDK side and may want to add filters to prevent the queries from exploding in result size and complexity. Using the QueryDefinition class and the fluent SDK, we can add query parameters to quickly adjust the values in a ``WHERE`` filter for a SQL query.

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
