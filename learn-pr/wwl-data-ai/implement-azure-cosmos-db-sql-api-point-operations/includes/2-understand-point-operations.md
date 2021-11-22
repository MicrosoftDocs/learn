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

public int morenumbers { get; set; }

public ComplexClass sophisticated { get; set;}

public List<ComplexType> onetomany { get; set; }
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

This implementation is an incredibly versatile C# class that any developer can pick and use immediately. Suppose, for any reason; you need to change the name of properties to fit you business needs. In that case, you can use property attributes to disassociate the name of the property you use in the C# code from the name of the property used in JSON and, in effect, in Azure Cosmos DB SQL API. In this example, you can use the name **InternalId** in C# code and still use the identifier **id** in JSON and Azure Cosmos DB SQL API.

```csharp
[JsonProperty(PropertyName = "id")]
public string InternalId { get; set; }
```

> [!TIP]
> If you have an existing application with C# member names that you cannot change, property attributes is a way to reuse types without incurring the risk of changing your existing code in significant ways or incurring technical debt.
