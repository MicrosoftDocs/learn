In C#, interfaces establish a contract for classes. In this unit, you explore how methods accept interfaces as parameters, learn the syntax for defining these methods, and review a practical sample implementation.

## Methods that accept an interface

Your methods in C# can accept interfaces as parameters to ensure that the passed objects adhere to specific contracts. Using interfaces as parameters allows for more flexible and reusable code.

For instance, consider a method that accepts an `IAnimal` interface as a parameter:

```csharp
public interface IAnimal
{
    void MakeSound();
}

public void MakeAnimalSound(IAnimal animal)
{
    animal.MakeSound();
}
```

In this example, the `MakeAnimalSound` method accepts an `IAnimal` interface, ensuring that any object passed to it has a `MakeSound` method.

> [!NOTE]
> Using interfaces as method parameters promotes loose coupling and enhances testability.

## Example: interfaces as method parameters

In the following example, we have several files each containing a different class or interface. It's common to place items in separate files for better organization and readability.

### `IAnimal.cs`

The `IAnimal.cs` file defines the `IAnimal` interface, which includes a method `MakeSound`.

```csharp
public interface IAnimal
{
    void MakeSound();
}
```

### `Dog.cs` and `Cat.cs`

These files contain the `Dog` and `Cat` classes, which implement the `IAnimal` interface and provide the `MakeSound` method.

```csharp
public class Dog : IAnimal
{
    public void MakeSound()
    {
        Console.WriteLine("Woof!");
    }
}

public class Cat : IAnimal
{
    public void MakeSound()
    {
        Console.WriteLine("Meow!");
    }
}
```

### `AnimalSound.cs`

This file contains the `AnimalSound` class, which has a method `MakeAnimalSound` that accepts an `IAnimal` interface as a parameter and calls the `MakeSound` method.

```csharp
public class AnimalSound
{
    public void MakeAnimalSound(IAnimal animal)
    {
        animal.MakeSound();
    }
}
```

### `Program.cs`

This file contains the `Program` class with the `Main` method, which creates instances of `Dog` and `Cat`, and uses the `AnimalSound` class to make them produce sounds.

```csharp
public class Program
{
    public static void Main()
    {
        IAnimal dog = new Dog();
        IAnimal cat = new Cat();
        
        AnimalSound animalSound = new AnimalSound();
        animalSound.MakeAnimalSound(dog); // Output: Woof!
        animalSound.MakeAnimalSound(cat); // Output: Meow!
    }
}
```

This example demonstrates how interfaces can be used as method parameters, promoting loose coupling and enhancing testability. It's a simple yet effective way to understand the concept of interfaces in C#.
