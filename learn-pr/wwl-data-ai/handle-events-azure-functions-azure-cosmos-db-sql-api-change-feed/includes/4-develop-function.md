The code to use various bindings in a function is primarily focused on the parameters of the function’s method. Once the parameters are configured, the data associated with each binding can be used and modified in the method much like any other C# variable.

## Trigger function on changes in the change feed

The code for a change feed trigger includes a method parameter of type **IReadOnlyList\<Document\>** that has an enumerated list of the current batch of changes. The name of the method parameter must match the value provided in the binding configuration for the name property. In this example method signature, the **name** in the binding is set to **changes**. Within the function code, your logic can use a foreach loop to iterate over all changes in the current batch.

```csharp
public static void Run(IReadOnlyList<Document> changes)
{
    foreach(Document doc in changes ?? Enumerable.Empty<Document>())
    {
        //Do something with each item
    }
}
```

> [!TIP]
> This sample code uses a null coalescing operator to ensure that the function doesn't throw an exception if the list of changes is null.

## Bind the function's input parameter to an item or query

An input binding for a function can include either a single item or multiple items. Input bindings also support the ability to bind to a C# type.

> [!NOTE]
> The remaining examples for input/output bindings will assume that the function is triggered using a HTTP request.

### Point read input binding

For a point read, the input binding’s parameter should be set to a simple type. In this first example, the binding is named **item** and is set to an object of type **Document**. The Document class is a special class that can represent an item in Azure Cosmos DB SQL API if you don't want to define your own type.

```csharp
public static void Run(HttpRequest request, Document item)
{
    //Do something with this item
}
```

As an alternative, you can define a type in C# to represent the data in your Azure Cosmos DB SQL API container.

```csharp
public class Product
{
    public string id { get; set; }

    public string categoryId { get; set; }

    public string name { get; set; }
}
```

This type, once defined, can be used with the method parameter. The Azure Functions runtime will automatically bind the input item to the specified type.

```csharp
public static void Run(HttpRequest request, Product item)
{
    //Do something with this item
}
```

### SQL query input binding

Input bindings with a SQL query require a method parameter of type **IEnumerable\<\>**. The type used as a generic parameter can be **Document** or a type you created in C#.

In this first example, the input binding is named **items** and is bound to a collection of type **Document**.

```csharp
public static async Task Run(HttpRequest request, IEnumerable<Document> items)
{
    //Do something with these items
}
```

The second example illustrates the ability to use your own custom C# types instead of the **Document** type.

```csharp
public static async Task Run(HttpRequest request, IEnumerable<Product> items)
{
    //Do something with these items
}
```

## Output items from the function

Whether an output binding will update one or multiple items is made by setting the input parameter to one of two types.

First, to write only a single item to the container, the output binding’s corresponding parameter should be configured as an **out** parameter and can be any C# type.

In this example, the output binding is named **output**, and the out parameter is of type **Product**. This example also illustrates

```csharp
public static void Run(HttpRequest request, out Product output)
{    
    var product = new Product()
    {
        id = "FDEF01CB-5067-414F-B0A3-07FF8A4B80DD",
        categoryId = "14A1AD5D-59EA-4B63-A189-67B077783B0E",
        name = "Sport-100 Helmet, Red"
    };
    output = product;
}
```

This following example illustrates writing multiple items to a container. The primary changes here include:

- The method is now configured for async calls
- The input parameter is of type **IAsyncCollector\<\>** using our C\# type as a generic parameter
- The items are added to the container asynchronously using the **AddAsync** method

```csharp
public static async Task Run(HttpRequest request, IAsyncCollector<Product> output)
{    
    var firstProduct = new Product()
    {
        id = "7236DDB5-CFE0-4D3D-8FE5-799B398396B1",
        categoryId = "AE48F0AA-4F65-4734-A4CF-D48B8F82267F",
        name = "Road-650 Black, 48"
    };

    var secondProduct = new Product()
    {
        id = "878C50F0-7E29-4D0D-A52E-6D8B063673E3",
        categoryId = "AE48F0AA-4F65-4734-A4CF-D48B8F82267F",
        name = "Road-250 Red, 58"
    };

    await output.AddAsync(firstProduct); 
    await output.AddAsync(secondProduct);
}
```
