As a developer tasked with creating your project's interfaces, you start adding interface **methods** in addition to the interfaces with only **properties**. To test the interface, you develop a class that implements these methods.

An interface is a set of related functions that a class must implement. It can include methods, properties, events, and indexers.

For example, consider an interface named `IVehicle` that includes a `Drive` method and properties for `Speed` and `Color`:

```csharp
public interface IVehicle
{
    int Speed { get; set; }
    string Color { get; set; }
    void Drive();
}
```

> [!NOTE]
> How the `Drive` method is declared without a body in the interface. When adding methods to an interface, include the method's signature in the interface declaration, but not its body. The class implementing the interface provides the method's body.

## Construct a class that implements the interface

Implementing an interface in a class is the same for classes with properties, methods or both. When creating a class that implements an interface, adhere to these guidelines:

- Provide implementations for all the interface's members. 
- Declare the interface as part of the class definition and supply the required method bodies.

> [!NOTE]
> A class can implement multiple interfaces, allowing it to include behavior from multiple sources. However, a class can only inherit from a single class. If a base class implements an interface, any class derived from the base class inherits that implementation.

Examine the following `Car` class example, which implements the `IVehicle` interface:

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

    public void Drive()
    {
        // Implementation of the Drive method
        Console.WriteLine("The car is driving.");
    }
}
```

In this example, the `Drive` method is implemented to display a message when called. This is just a simple implementation for demonstration purposes. In a real-world application, the `Drive` method could contain more complex code that controls how the car drives.

Interfaces define a contract of method signatures and properties that a class is required to implement. When a class implements an interface, it provides the actual code for these methods, effectively turning the method signatures into functional routines. This process allows a class to adopt diverse behaviors by implementing multiple interfaces. As you continue to develop and define methods within interfaces, you'll find that using interfaces effectively can lead to cleaner, more efficient, and manageable code.
