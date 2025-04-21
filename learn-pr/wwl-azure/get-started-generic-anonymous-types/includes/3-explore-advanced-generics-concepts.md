Imagine you have a warehouse with boxes that can hold different types of items. Some items, like fragile goods or oversized packages, need special handling. To manage the special case, you create rules to ensure everything is packed and processed efficiently.

Advanced generics in C# work similarly. Features like generic interfaces, covariance and contravariance, and generic math let you define flexible rules, ensure compatibility, and perform operations across data types, making your code reusable and efficient.

## Purpose and value of advanced generics

Advanced use of generics builds on the foundation of generics by introducing features that handle complex scenarios while maintaining type safety and efficiency.

- **Generic Interfaces**: Define type-safe contracts for implementing classes.

- **Covariance and Contravariance**: Enable flexible type assignments in method signatures and delegates.

- **Generic Math**: Perform mathematical operations generically across numeric types.

> [!TIP]  
> Use advanced generics to simplify complex scenarios while keeping your code reusable and type-safe.

## Generic interfaces

Generic interfaces are a key feature of advanced generics, allowing you to define type-safe contracts for implementing classes. They're especially useful when you want to enforce consistent behavior across different types while maintaining flexibility.

For example, the `IComparable<T>` interface allows objects to be compared by type:

```csharp
public class Product : IComparable<Product>
{
    public string Name { get; set; }
    public decimal Price { get; set; }

    public int CompareTo(Product other)
    {
        return Price.CompareTo(other.Price);
    }
}
```

In this example:

- The `Product` class implements the `IComparable<Product>` interface.
- The `CompareTo` method ensures that products can be compared based on their price.

Some commonly used generic interfaces in .NET include:

- **`IEnumerable<T>`**: Represents a collection of objects that can be enumerated.

- **`IComparer<T>`**: Defines a custom comparison for sorting objects.

- **`IEqualityComparer<T>`**: Defines custom equality logic for comparing objects.

Here’s an example of using `IComparer<T>` to sort a list of products:

```csharp
public class ProductComparer : IComparer<Product>
{
    public int Compare(Product x, Product y)
    {
        return x.Price.CompareTo(y.Price);
    }
}

var products = new List<Product>
{
    new Product { Name = "Laptop", Price = 1200 },
    new Product { Name = "Tablet", Price = 600 }
};

products.Sort(new ProductComparer());
```

- The `ProductComparer` class implements `IComparer<Product>` to sort products by price.
- The `Sort` method uses the comparer to order the products.

> [!TIP]  
> Use generic interfaces to enforce type-safe behavior across different types while keeping your code flexible and reusable.

By using generic interfaces, you can enforce consistent behavior across different types while keeping your code flexible and reusable.

## Covariance and Contravariance

Covariance and contravariance allow flexibility when working with generic types, especially when assigning one type to another. They help ensure compatibility between related types in certain scenarios.

- **Covariance**: Allows you to assign a more specific type (derived type) to a more general type (base type).  
  Think of it like storing a collection of apples (`IEnumerable<Apple>`) in a basket that can hold any fruit (`IEnumerable<Fruit>`).

- **Contravariance**: Allows you to assign a more general type (base type) to a more specific type (derived type).  
  Think of it like using a handler for any fruit (`Action<Fruit>`) to process only apples (`Action<Apple>`).

Covariance allows you to assign a more specific type to a more general type. For example:

```csharp
IEnumerable<string> strings = new List<string>();
IEnumerable<object> objects = strings; // Covariance: string is a more specific type than object
```

Contravariance allows you to assign a more general type to a more specific type. For example:

```csharp
Action<object> handleObject = obj => Console.WriteLine(obj);
Action<string> handleString = handleObject; // Contravariance: object is a more general type than string
```

> [!TIP]  
> Covariance is useful when reading data, such as, iterating through a collection. Contravariance is useful when writing or processing data, such as passing parameters to a method.

## Generic math and methods

.NET 7 introduces generic math interfaces, enabling mathematical operations across numeric types.

The following example demonstrates a generic addition method:

```csharp
static T Add<T>(T left, T right) where T : INumber<T>
{
    return left + right;
}

int result = Add(5, 10); // Works with integers
double resultDouble = Add(5.5, 10.2); // Works with doubles
```

- Generic math reduces redundant overloads and supports a wide range of numeric types.
- It simplifies mathematical operations by allowing you to write reusable methods for numeric types.

> [!TIP]  
> Use generic math to write reusable methods for numeric operations, reducing the need for multiple overloads.

Advanced generics in C# build on the foundation of generics to handle more complex scenarios. Features like generic interfaces, covariance and contravariance, and generic math allow you to write flexible, reusable, and type-safe code. By learning these tools, you can simplify complex logic and create more adaptable applications.
