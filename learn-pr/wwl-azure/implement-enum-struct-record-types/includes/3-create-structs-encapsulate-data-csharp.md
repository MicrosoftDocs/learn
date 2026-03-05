In working on the project to track order details, you need a way to keep related information like the customer's name, shipping address, and order total together. Structs in C# let you create a basic encapsulated container for this data, making it easier to work with and pass around as a single unit.

## Understand structs

Structs are **value types** in C#, meaning they directly store their data rather than referencing it. You use the `struct` keyword to define a struct. Structs are typically used for small, data-centric types that provide minimal behavior.

- Structs have value semantics, meaning their values are copied during assignment or method calls.
- Common use cases include representing numbers, Boolean values, characters, and time instances.
- Structs are commonly used for representing lightweight data like geometric shapes (for example, `Rectangle`, `Circle`), coordinates, or configuration settings.

Structs are best suited for small, immutable, and performance-critical data. For larger, more complex objects or when behavior is a focus, consider using classes instead. Unlike classes, structs can't inherit from other structs or classes, but they can implement interfaces.

> [!TIP]
> If your type focuses on behavior rather than data, classes are often a better choice due to their reference semantics.

## Define and implement a struct

```csharp
public struct Point
{
    public int X;
    public int Y;

    public Point(int x, int y)
    {
        X = x;
        Y = y;
    }
}
```

*Code sample demonstrates how to define a struct with fields and a constructor in C#.*

Structs can also implement interfaces but can't inherit from other classes or structs.

## Encapsulate data with structs

Encapsulation allows you to control access to the data within a struct. Use access modifiers like `private`, `public`, or `internal` to specify accessibility.

- Fields and properties can be made private to restrict direct access.
- Methods can provide controlled ways to interact with the data.

For example:

```csharp
public struct Rectangle
{
    private int width;
    private int height;

    public Rectangle(int width, int height)
    {
        this.width = width;
        this.height = height;
    }

    public int Area => width * height;
}
```

*Code sample demonstrates a struct in C# with encapsulated fields and a computed property for area.*

## Apply readonly modifier to structs for immutability

Immutability ensures that once a struct is created, its data can't be changed. A struct is useful when working with data that should remain constant throughout its lifetime, such as coordinates, or configuration values. When you apply the `readonly` modifier to a struct, you can enforce immutability, making your code more predictable and less prone to errors caused by unintended modifications.

```csharp
public readonly struct ImmutablePoint
{
    public int X { get; init; }
    public int Y { get; init; }

    public ImmutablePoint(int x, int y)
    {
        X = x;
        Y = y;
    }
}
```

*Code sample demonstrates the use of the `readonly` modifier to create an immutable struct in C#.*

> [!NOTE]
> While the struct itself is immutable, mutable reference types within it can still change their state.

## Use object initializers with structs

When working with structs, you often need to initialize multiple properties. Object initializers provide a simple and readable way to create and initialize struct instances in a single step. This approach reduces repetitive code and makes your intent clear.

The following code sample defines a struct with properties that group related data together and make it easier to initialize and work with instances of the struct.

```csharp
public struct Point
{
    public int X { get; set; }
    public int Y { get; set; }
}
```

Using an object initializer, you can create and initialize a `Point`:

```csharp
var point = new Point { X = 10, Y = 20 };
```

*Code sample demonstrates how to use an object initializer to set property values when creating a struct instance.*

> [!TIP]
> Object initializers make your code more concise and easier to read when working with structs that have multiple properties.

## Practical example: Using structs to represent points in 2D space

Structs are often used to represent small, immutable data structures. For example, you can use a struct to represent a point in 2D space and calculate the distance between two points:

```csharp
public struct Point
{
    public int X { get; }
    public int Y { get; }

    public Point(int x, int y)
    {
        X = x;
        Y = y;
    }

    public double DistanceTo(Point other)
    {
        int dx = X - other.X;
        int dy = Y - other.Y;
        return Math.Sqrt(dx * dx + dy * dy);
    }
}

var point1 = new Point(3, 4);
var point2 = new Point(7, 1);
Console.WriteLine($"Distance between points: {point1.DistanceTo(point2)}");
```

This example demonstrates how to define a struct for a point, calculate the distance between two points, and use the struct in a simple program.

Combining encapsulation, immutability, and object initializers enable you to create structs that are efficient, and predictable. These features help you manage related data in a clean and organized way.
