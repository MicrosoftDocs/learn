**Default implementations in interfaces** enable you to add new methods directly into an interface and provide a default implementation. A class that uses this interface, can either use the default method, or it can override and provide its own implementation.

## Default implementations

Default implementations in interfaces let you add new methods to an interface without causing problems.

- An interface can provide a body for its methods using default implementations.
- Classes using the interface don't need to write their own versions of these methods.
- This feature helps when you want to change the interface without breaking anything.

> [!NOTE]
> Even with default implementations, a class doesn't automatically get the interface's methods. To use a method from the interface, the variable must be of the interface type.

## Benefits

Default implementations in interfaces have several benefits:

- **Code reuse:** You can share common functions across different implementations without copying code.
- **Backward compatibility:** You can add new methods to interfaces without changing all classes using the interface to prevents breaking changes.
- **Flexibility:** Classes using the interface can change the default implementation if they need different behavior.

For example, let's say you're working with a customer management system and you add a new method to apply a loyalty discount in an existing interface. The default method calculates a basic discount. But if a "VIP customer" class needs a different calculation, it can modify this method.

## Define default implementations

The syntax for defining default implementations in interfaces extends the interface declaration to include method bodies. The following example defines a default implementation in an interface based on a customer management system scenario:

```csharp
interface ICustomer
{
    int CustomerId { get; set; } // No default implementation

    void ApplyLoyaltyDiscount() 
    { 
        // default implementation
        Console.WriteLine("Applying 10% loyalty discount."); 
    }
}
```

In this example, the `ApplyLoyaltyDiscount` method has a default implementation within the `ICustomer` interface. The `CustomerId` property is also defined in the interface but doesn't have a default implementation.

> [!NOTE]
> From C# 8.0 onwards, interfaces can include default method implementations. The change allows new methods to be added to interfaces without breaking existing code. Classes can use these defaults or provide their own implementations.

Next, implement a "VIPCustomer" class that needs a different discount calculation. This class can implement the `ICustomer` interface, provide its own implementation for the `CustomerId` property, and override the `ApplyLoyaltyDiscount` method like so:

```csharp
class VIPCustomer : ICustomer
{
    public int CustomerId { get; set; } // Implementing property from interface

    void ICustomer.ApplyLoyaltyDiscount()
    {
        // override default implementation for VIP customers
        Console.WriteLine($"Applying 20% loyalty discount for VIP customer with ID {CustomerId}.");
    }
}
```

In this case, the `VIPCustomer` class applies a 20% discount instead of the default 10%. The `CustomerId` is used in the message when applying the discount.

Default implementations in interfaces allow for the addition of new methods with the method implementation provided in the interface. The default implementations promote code reuse, backward compatibility, and flexibility. It's a practical tool in C# Object-Oriented Programming that enhances adaptability without disrupting existing code.
