::: zone pivot="csharp"

The **Microsoft.Azure.Cosmos** library includes first-class support for generics in the C# language, making it vital for you, as a developer, to think about how you want to represent what you are interacting with within your container.

At the most foundational level, you can create a C# class that represents an item in your container that, at a minimum, contains two members:

- a string property named **id** with a public getter and setter
- a string property with the same name as your partition key path with a public getter and setter

```csharp
public class item
{
    public string id { get; set; }

    public string partitionKey { get; set; }
}
```

You can include a rich collection of other members of other types. You can even have other members of different complex types, such as other classes.

```csharp
public decimal money { get; set;}

public bool boolean { get; set; }

public string[] set { get; set; }

public double numbers { get; set; }

public int moreNumbers  { get; set; }

public ComplexClass sophisticated { get; set;}

public List<ComplexType> oneToMany  { get; set; }
```

Let's establish a fictional scenario for the remainder of this module. We have a **Product** class with five members for the unique **id**, the product's **name**, the unique **category** identifier, the **price**, and a collection of **tags**. The **category** identifier is the **partition key** path for the container.

```csharp
public class Product
{
    public string id { get; set; }
    
    public string name { get; set; }

    public string categoryId { get; set; }

    public double price { get; set; }

    public string[] tags { get; set; }
}
```

This implementation is an incredibly versatile C# class that any developer can pick and use immediately. Suppose, for any reason, you need to change the name of properties to fit your business needs. In that case, you can use property attributes to disassociate the name of the property you use in the C# code from the name of the property used in JSON and, in effect, in Azure Cosmos DB for NoSQL. In this example, you can use the name **InternalId** in C# code and still use the identifier **id** in JSON and Azure Cosmos DB for NoSQL.

```csharp
[JsonProperty(PropertyName = "id")]
public string InternalId { get; set; }
```

> [!TIP]
> If you have an existing application with C# member names that you can't change, property attributes are a way to reuse types without incurring the risk of changing your existing code in significant ways or incurring technical debt.

::: zone-end

::: zone pivot="python"

The **azure-cosmos** library provides robust support for modeling and interacting with items in an Azure Cosmos DB container. As a Python developer, it's important to structure your item definitions carefully to align with the requirements of the database and your application's use case.

At a minimum, each item in a container must include two attributes:

- A string attribute named **id**, which acts as the unique identifier for the item.
- A string attribute that corresponds to the **partition key** path of the container.

Here's an example of a Python class representing a minimal item structure:

```python
class Item:
    def __init__(self, id: str, partition_key: str):
        self.id = id
        self.partition_key = partition_key
```

You can enhance this class by adding more attributes of various types, including basic types like strings and numbers, or complex types like nested objects and lists.

```python
class Item:
    def __init__(
        self,
        id: str,
        partition_key: str,
        money: float,
        boolean: bool,
        tags: list[str],
        numbers: float,
        more_numbers: int,
        sophisticated: dict,
        one_to_many: list[dict]
    ):
        self.id = id
        self.partition_key = partition_key
        self.money = money
        self.boolean = boolean
        self.tags = tags
        self.numbers = numbers
        self.more_numbers = more_numbers
        self.sophisticated = sophisticated
        self.one_to_many = one_to_many
```

## Example Scenario: Modeling a Product

Let’s use a fictional scenario for the remainder of this module. You need to create a **Product** class to represent products in your inventory. Each product includes:

- A unique **id**.
- A **name** of the product.
- A **categoryId** as the **partition key**.
- A **price** of the product.
- A list of **tags** for categorization.

Here’s how the class might look in Python:

```python
class Product:
    def __init__(self, id: str, name: str, category_id: str, price: float, tags: list[str]):
        self.id = id
        self.name = name
        self.category_id = category_id  # Partition key
        self.price = price
        self.tags = tags
```

This implementation is flexible and easy to use for various operations in your application. If, for any reason, you need to adjust the names of the attributes to match your business requirements, you can use serialization techniques to map attribute names in Python to property names in JSON.

For example, suppose you want to use the name **internal_id** in your Python code while still using **id** as the JSON property name:

```python
class Product:
    def __init__(self, internal_id: str, name: str, category_id: str, price: float, tags: list[str]):
        self.internal_id = internal_id
        self.name = name
        self.category_id = category_id  # Partition key
        self.price = price
        self.tags = tags

    def to_dict(self):
        return {
            "id": self.internal_id,  # Map internal_id to id
            "name": self.name,
            "categoryId": self.category_id,
            "price": self.price,
            "tags": self.tags,
        }
```

> 💡 **Tip**: If you are working with existing Python classes that cannot be modified, consider using helper methods like `to_dict()` to convert objects into the format expected by Azure Cosmos DB for NoSQL. This allows you to reuse existing types while avoiding technical debt.

With these foundational modeling techniques, you can ensure that your Python application effectively interacts with Azure Cosmos DB for NoSQL.

::: zone-end

::: zone pivot="node"

The **@azure/cosmos** library provides robust support for modeling and interacting with items in an Azure Cosmos DB container. As a JavaScript developer, it's important to structure your item definitions carefully to align with the requirements of the database and your application's use case.

At a minimum, each item in a container must include two properties:

- A string property named **id**, which acts as the unique identifier for the item.
- A string property that corresponds to the **partition key** path of the container.

Here's an example of a JavaScript class representing a minimal item structure:

```javascript
class Item {
    constructor(id, partitionKey) {
        this.id = id;
        this.partitionKey = partitionKey;
    }
}
```

You can enhance this class by adding more properties of various types, including basic types like strings and numbers, or complex types like nested objects and arrays.

```javascript
class Item {
    constructor(id, partitionKey, money, boolean, tags, numbers, moreNumbers, sophisticated, oneToMany) {
        this.id = id;
        this.partitionKey = partitionKey;
        this.money = money;
        this.boolean = boolean;
        this.tags = tags;
        this.numbers = numbers;
        this.moreNumbers = moreNumbers;
        this.sophisticated = sophisticated;
        this.oneToMany = oneToMany;
    }
}
```

## Example Scenario: Modeling a Product

Let’s use a fictional scenario for the remainder of this module. You need to create a **Product** class to represent products in your inventory. Each product includes:

- A unique **id**.
- A **name** of the product.
- A **categoryId** as the **partition key**.
- A **price** of the product.
- An array of **tags** for categorization.

Here’s how the class might look in JavaScript:

```javascript
class Product {
    constructor(id, name, categoryId, price, tags) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId; // Partition key
        this.price = price;
        this.tags = tags;
    }
}
```

This implementation is flexible and easy to use for various operations in your application. If, for any reason, you need to adjust the names of the properties to match your business requirements, you can use serialization techniques to map property names in JavaScript to property names in JSON.

For example, suppose you want to use the name **internalId** in your JavaScript code while still using **id** as the JSON property name:

```javascript
class Product {
    constructor(internalId, name, categoryId, price, tags) {
        this.internalId = internalId;
        this.name = name;
        this.categoryId = categoryId; // Partition key
        this.price = price;
        this.tags = tags;
    }

    toJSON() {
        return {
            id: this.internalId, // Map internalId to id
            name: this.name,
            categoryId: this.categoryId,
            price: this.price,
            tags: this.tags,
        };
    }
}
```

> 💡 **Tip**: If you are working with existing JavaScript classes that cannot be modified, consider using a method like `toJSON()` to convert objects into the format expected by Azure Cosmos DB for NoSQL. This allows you to reuse existing types while avoiding technical debt.

With these foundational modeling techniques, you can ensure that your JavaScript application effectively interacts with Azure Cosmos DB for NoSQL.

::: zone-end
