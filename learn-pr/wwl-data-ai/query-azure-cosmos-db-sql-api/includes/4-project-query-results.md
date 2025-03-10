When you develop middle-tier and API applications, there's a tendency to build highly complex solutions to translate database results to something that the business application can understand and use. This workaround often occurs because the database platform is inflexible and must store the data in some fixed schema that can never be changed.

One of the great things about JSON is that it’s compatible with various developer platforms making it highly flexible. Azure Cosmos DB for NoSQL extends the SQL query language by adding functionality to manipulate the JSON results of your query so you can change the query result to map to the schema and shape that your developer team needs.

Let’s look at an example.

In the previous unit, you ran this query:

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

And here's an example result:

```json
{
    "name": "LL Bottom Bracket",
    "categoryName": "Components, Bottom Brackets",
    "price": 53.99
}
```

::: zone pivot="csharp"

While this result is acceptable, your dev team needs this result mapped to this C# object and doesn't want to write extra code to accomplish this task.

```csharp
public class ProductAdvertisement
{
    public string Name { get; set; }
    
    public string Category { get; set; }

    public class ScannerData
    {
        public decimal Price { get; set; }
    }
}
```

> [!NOTE]
> For the purposes of this exercise, you can ignore casing. The JSON parser properly handles converting between camel and pascal casing.

::: zone-end

::: zone pivot="python"

While this result is acceptable, your Python team needs this result mapped to this Python class and doesn't want to write extra code to accomplish this task.

```python
class ProductAdvertisement:
    def __init__(self, name, category, scanner_data):
        self.name = name
        self.category = category
        self.scanner_data = scanner_data

class ScannerData:
    def __init__(self, price):
        self.price = price
```

::: zone-end

::: zone pivot="node"

While this result is acceptable, your JavaScript team needs this result mapped to this JavaScript object and doesn't want to write extra code to accomplish this task.

```javascript
class ProductAdvertisement {
    constructor(name, category, scannerData) {
        this.name = name;
        this.category = category;
        this.scannerData = scannerData;
    }
}

class ScannerData {
    constructor(price) {
        this.price = price;
    }
}
```

::: zone-end

The first change that could be made is to use a SQL alias to change the **categoryName** property to **category**. This change is accomplished by adding an ``AS`` keyword to the existing query:

```sql
SELECT
    p.name, 
    p.categoryName AS category,
    p.price
FROM 
    products p
WHERE
    p.price >= 50 AND
    p.price <= 100
```

This new query results in this JSON output:

```json
{
    "name": "LL Bottom Bracket",
    "category": "Components, Bottom Brackets",
    "price": 53.99
}
```

The following change requires us to think about how we want to change the structure of our JSON output. Before changing the query, we need to think about how our JSON object should change. We, essentially, need to create a child JSON object. In this example, we have a child ``scannerData`` object with a property for ``price``:

```json
{
    "name": "LL Bottom Bracket",
    "category": "Components, Bottom Brackets",
    "scannerData": {
        "price": 53.99
    }
}
```

How does this child affect the query? We need to create a field that defines a JSON object with a single property named **price** that references the **p.price** property and an alias of **scannerData**. This expression would look like this:

```sql
{ "price": p.price } AS scannerData
```

Altogether, the entire query looks like this:

```sql
SELECT
    p.name, 
    p.categoryName AS category,
    { "price": p.price } AS scannerData
FROM 
    products p
WHERE
    p.price >= 50 AND
    p.price <= 100
```

## Reviewing specific properties in query results

Sometimes you want to shape your query results to drill down to specific properties. Two keywords are useful in these scenarios.

First, consider a scenario where you would like to find all of the category names in your container. You could use this query to get all of the container names for every item:

```sql
SELECT
    p.categoryName
FROM
    products p
```

This query returns a JSON result set

Unfortunately, there would be repeated values within the result set:

```json
[
    {
        "categoryName": "Components, Road Frames"
    },
    {
        "categoryName": "Components, Touring Frames"
    },
    {
        "categoryName": "Bikes, Touring Bikes"
    },
    {
        "categoryName": "Clothing, Vests"
    },
    {
        "categoryName": "Accessories, Locks"
    },
    {
        "categoryName": "Components, Pedals"
    },
    {
        "categoryName": "Components, Touring Frames"
    },
...
```

Instead, you can use the ``DISTINCT`` keyword only to return unique values in the result set.

```sql
SELECT DISTINCT
    p.categoryName
FROM
    products p
```

::: zone pivot="csharp"

Let’s consider another scenario. If your .NET developers wanted to consume this list of category names, they would need to create a C# wrapper class to consume this list:

```csharp
public class CategoryReader
{
    public string CategoryName { get; set; }
}

// Developers read this as List<CategoryReader>
```

::: zone-end

::: zone pivot="python"

Let’s consider another scenario. If your Python developers wanted to consume this list of category names, they would need to create a Python wrapper class to consume this list:

```python
class CategoryReader:
    def __init__(self, category_name):
        self.category_name = category_name

# Developers read this as List[CategoryReader]
```

::: zone-end

::: zone pivot="node"

Let’s consider another scenario. If your JavaScript developers wanted to consume this list of category names, they would need to create a JavaScript wrapper class to consume this list:

```javascript
class CategoryReader {
    constructor(categoryName) {
        this.categoryName = categoryName;
    }
}

// Developers read this as List<CategoryReader>
```

::: zone-end

This extra step is both needless and unnecessary. It can quickly become cumbersome as you need to do this multiple times for multiple types in your container[s]. But, if you have a query that returns an object with only a single property, you can use the ``VALUE`` keyword to flatten the result set to an array of a simple type.

```sql
SELECT DISTINCT VALUE
    p.categoryName
FROM
    products p
```

```json
[
    "Components, Road Frames",
    "Components, Touring Frames",
    "Bikes, Touring Bikes",
    "Clothing, Vests",
    "Accessories, Locks",
    "Components, Pedals",
...
```

::: zone pivot="csharp"

```csharp
// Developers read this as List<string>
```

::: zone-end

::: zone pivot="python"

```python
# Developers read this as List[str]
```

::: zone-end

::: zone pivot="node"

```javascript
// Developers read this as List<string>
```

::: zone-end

The ``VALUE`` keyword can even be used on its own without the ``DISTINCT`` keyword:

```sql
SELECT VALUE
    p.name
FROM
    products p
```

```json
[
    "LL Road Frame - Red, 60",
    "LL Touring Frame - Blue, 58",
    "Touring-1000 Yellow, 54",
    "Classic Vest, L",
    "Cable Lock",
    "ML Road Pedal",
    "LL Touring Frame - Yellow, 62",
...
```
