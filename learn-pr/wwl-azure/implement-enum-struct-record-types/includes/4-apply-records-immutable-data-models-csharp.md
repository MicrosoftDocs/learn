Imagine you're working on a project where you need to model data that shouldn't change after creation, such as a person's name or a product's details. Records in C# provide a way to create immutable data models with value-based equality, making them ideal for such scenarios.

## Define records for immutable data models

To define an immutable data model, use the `record` keyword. Records automatically generate properties, constructors, and methods like `ToString`, `Equals`, and `GetHashCode`.

```csharp
public record Person(string FirstName, string LastName);
```

*Code sample demonstrates how to define a record with immutable properties.*

In this example:

- `FirstName` and `LastName` are positional parameters that define immutable properties.
- The compiler generates a primary constructor and init-only properties.

Records are useful for scenarios like modeling API responses, configuration settings, or logging events where immutability and simplicity are critical.

## Compare records with classes and structs

Records differ from classes and structs in several ways:

- **Immutability**: Records are immutable by default, while classes and structs require more effort to enforce immutability.
- **Equality**: Records use value-based equality, whereas classes use reference equality, and structs rely on value equality but without compiler-synthesized methods.
- **Inheritance**: Record classes support inheritance, but record structs don't.

| Feature            | Record Class       | Record Struct      | Class             | Struct            |
|--------------------|--------------------|--------------------|-------------------|-------------------|
| Immutability       | Default            | Optional           | Optional          | Optional          |
| Equality           | Value-based        | Value-based        | Reference-based   | Value-based       |
| Inheritance        | Supported          | Not supported      | Supported         | Not supported     |

*Table summarizes key differences between records, classes, and structs.*

> [!TIP]
> Use records when you need immutable data models with value-based equality. For mutable or behavior-focused types, consider using classes instead.

## Implement equality checks using records

Records provide built-in value-based equality. Two record instances are considered equal if their types and property values match.

```csharp
var person1 = new Person("Chris", "Kuo");
var person2 = new Person("Chris", "Kuo");
Console.WriteLine(person1 == person2); // Output: True
```

*Code sample demonstrates how records use value-based equality to compare instances.*

You can also customize equality behavior by overriding the `Equals` or `GetHashCode` methods. For example:

```csharp
public record Product(string Name, decimal Price)
{
    public override int GetHashCode() => HashCode.Combine(Name.ToLower(), Price);
}
```

*Code sample demonstrates how to customize equality behavior in a record.*

## Use positional syntax to define records

Positional syntax allows you to define records concisely. The compiler generates properties, a primary constructor, and a deconstructor.

```csharp
public record Point(int X, int Y);

var point = new Point(3, 4);
Console.WriteLine(point); // Output: Point { X = 3, Y = 4 }
```

*Code sample demonstrates how to use positional syntax to define a record.*

This approach simplifies the creation of immutable data models by reducing boilerplate code.

## Apply inheritance with records

Record classes support inheritance, enabling you to create hierarchies while maintaining immutability and value-based equality.

```csharp
public record Animal(string Name);
public record Dog(string Name, string Breed) : Animal(Name);

var dog = new Dog("Buddy", "Golden Retriever");
Console.WriteLine(dog); // Output: Dog { Name = Buddy, Breed = Golden Retriever }
```

*Code sample demonstrates how to use inheritance with record classes.*

Inheritance is useful for creating hierarchies of related data models, such as animals, vehicles, or user roles.

> [!NOTE]
> A record can't inherit from a class, and a class can't inherit from a record.

## Practical example: Using records to represent products in an inventory system

Records are ideal for representing immutable data. For example, you can use a record to represent a product in an inventory system and compare two products:

```csharp
public record Product(string Name, decimal Price);

var product1 = new Product("Laptop", 1200m);
var product2 = new Product("Laptop", 1200m);
var product3 = new Product("Tablet", 600m);

Console.WriteLine($"Are product1 and product2 equal? {product1 == product2}");
Console.WriteLine($"Are product1 and product3 equal? {product1 == product3}");
```

This example demonstrates how to define a record for a product, create instances of the record, and compare them using value-based equality.

Combining immutability, value-based equality, and concise syntax, records provide a powerful way to model data in C#. These features make records ideal for scenarios where data integrity and simplicity are critical.
