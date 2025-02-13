As a developer tasked with creating your project's interfaces, you start the process by designing an interface with **properties**. Then, you develop a class that implements these properties.

An interface in C# is like a blueprint. It outlines the features (properties or methods) that classes need to have if they want to use this interface. For this project, you define an interface that defines properties only (without methods).

- Use the `interface` keyword to create an interface.
- Define properties in the interface without a body.
- Interfaces can optionally provide default implementations for members, including properties, but it happens infrequently.

The following code creates an `IVehicle` interface with `Speed` and `Color` properties:

```csharp
public interface IVehicle
{
    int Speed { get; set; }
    string Color { get; set; }
}
```

Interface properties typically don't have any code inside them, they just specify the type of data (like `int` or `string`) and whether you can read from them, write to them, or do both. When you implement these properties in a class, you'll write the actual code for getting (reading) and setting (writing) the values. For example, if an interface has a `Speed` property, you will decide how to store and retrieve the speed value in your class.

## Develop a class that implements the interface

When a class, like `Car`, decides to implement an interface, such as `IVehicle`, it's like saying "I'm going to build a vehicle." The `Car` must include all the features (properties or methods) outlined in the `IVehicle` blueprint.

- The `Car : IVehicle` syntax is used to indicate that `Car` is implementing the `IVehicle` interface. You use the familiar syntax, the same as used for inheritance.
- The `Car` must provide public, non-static implementations for all the features listed in the `IVehicle` blueprint.
- If `Car` decides to implement multiple blueprints (interfaces) that have similar features, it needs to be clear about which feature comes from which blueprint.

Here's how `Car` implements the `IVehicle` interface in code:

```csharp
public class Car : IVehicle
{
    private int _speed;
    private string _color;

    public int Speed
    {
        get { return _speed; }
        set { _speed = value; }
    }

    public string Color
    {
        get { return _color; }
        set { _color = value; }
    }
}
```

> [!NOTE]
> The `:` symbol is used to indicate that `Car` implements `IVehicle`, similar to how `:` is used to indicate inheritance.

In this example, `Car` is a class that implements the `IVehicle` interface and provides its own versions of `Speed` and `Color`. It's like building a vehicle based on the `IVehicle` blueprint but adding its own unique touches to the speed and color.