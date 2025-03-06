Inheritance is one of the primary characteristics of object-oriented programming. It allows you to create a hierarchy of classes by defining relationships between classes. In C#, you can create a base class that defines common behavior and characteristics, and then create derived classes that inherit and extend that behavior.

For example, a base class named `Person` might define `Name` and `Age` properties. A derived class named `Employee` might inherit these properties and define other properties such as `EmployeeNumber` and `Salary`.

This example could be represented using the following C# code:

```csharp
public class Person
{
    public string? Name { get; set; }
    public int Age { get; set; }
}

public class Employee : Person
{
    public int EmployeeNumber { get; set; }
    public decimal Salary { get; set; }
}
```

This code sample defines the `Person` class and then the `Employee` class. Notice the colon (`:`) character in the `Employee` class declaration. The colon (`:`) between `Employee` and `Person` indicates that the `Employee` class inherits from the `Person` class. In this case the `Employee` class inherits the `Name` and `Age` properties and defines two more properties: `EmployeeNumber` and `Salary`. When an `Employee` object is created, it has access to the `Name` and `Age` properties defined in the `Person` class, as well as the `EmployeeNumber` and `Salary` properties defined in the `Employee` class. When a `Person` object is created, it only has access to the `Name` and `Age` properties.

Inheritance allows you to create a hierarchy of classes that share common behavior and characteristics. It enables you to reuse code and define relationships between classes. By using inheritance, you can create more maintainable and extensible code.

## Benefits of inheritance

Inheritance provides several benefits, including:

- **Code reuse**: Inheritance allows you to reuse code defined in a base class in a derived class. This reduces duplication and promotes code reuse.
- **Extensibility**: Inheritance enables you to extend the behavior of a base class by adding new members to a derived class. You can define new properties, methods, and events in a derived class.
- **Encapsulation**: Inheritance promotes encapsulation by allowing you to hide the implementation details of a base class from a derived class. Inheritance and encapsulation enable you to define a clear interface for interacting with objects of a derived class.
- **Consistency**: Inheritance promotes consistency by allowing you to define common behavior in a base class. Inheriting from a base class ensures that the derived classes share the same base behaviors.
- **Polymorphism**: Inheritance enables polymorphism, which allows you to treat objects of a derived class as objects of their base class. Polymorphism enables you to write code that works with objects of different types without knowing their specific type at compile time.

## Compare class inheritance with interface implementation

C# provides two mechanisms for defining relationships between classes: class inheritance and interface implementation. Class inheritance allows a class to inherit members from a base class, while interface implementation allows a class to implement members defined in an interface. Both mechanisms enable code reuse and promote polymorphism, but they have different characteristics:

Class inheritance has the following characteristics:

- A class can inherit from only one base class.
- A derived class can reuse, extend, and modify the behavior defined in the base class.
- Inheritance creates an "is-a" relationship between classes.

Interface implementation has the following characteristics:

- A class can implement multiple interfaces.
- A class can define its own behavior and implement the members defined in an interface.
- Interface implementation creates a "can-do" relationship between classes.

The difference between "is-a" and "can-do" relationships is important when designing object-oriented systems. In general, you should use class inheritance when a derived class is a specialized version of a base class. You should use interface implementation when a class can perform a specific set of actions.

An example of when to use class inheritance is when you have a base class named `Dog` and derived classes named `German Shepherd` and `Golden Retriever`. The `German Shepherd` and `Golden Retriever` are specialized versions of a `Dog`. In this case, you can use class inheritance to define a common set of properties and methods in the `Dog` class and then extend and modify that behavior in the `German Shepherd` and `Golden Retriever` classes.

An example of when to use interface implementation is when you have an interface named `IDrawable` that defines a `Draw` method. You can implement the `IDrawable` interface in classes that can be drawn, such as `Circle` and `Rectangle`. In this case, you can use interface implementation to define a common set of actions that're shared by different classes.

## Compare class inheritance with polymorphism

Class inheritance and polymorphism are closely related concepts in object-oriented programming. Inheritance allows you to define a hierarchy of classes that share common behaviors, while polymorphism allows you to treat objects of a derived class as objects of their base class.

For example, consider a base class named `HousePet` and derived classes named `Dog` and `Cat`. The `HousePet` class defines a `Speak` method that returns a string representing the sound the pet makes. The `Dog` class overrides the `Speak` method to return "Woof", and the `Cat` class overrides the `Speak` method to return "Meow". You can create a `HousePet` object named `myPet` of type `Dog` or `Cat` and call the `Speak` method to get the appropriate response.

In this example, the `HousePet` class defines a common `Speak` behavior that the `Dog` and `Cat` classes share. The `Dog` and `Cat` classes override the `Speak` method to customize the behavior. When you call the `Speak` method on a `HousePet` object that references one of the derived classes, you get the appropriate response based on the type of the object. Here's the code sample that demonstrates this concept:

```csharp
HousePet myPet1 = new Dog();    // Create a HousePet object named myPet1 that's of type Dog
HousePet myPet2 = new Cat();    // Create a HousePet object named myPet2 that's of type Cat

Console.WriteLine(myPet1.Speak());    // Call the Speak method on myPet1
Console.WriteLine(myPet2.Speak());    // Call the Speak method on myPet2

// Output: Woof
//         Meow

public class HousePet
{
    public virtual string Speak()
    {
        return "Hello";
    }
}

public class Dog : HousePet
{
    public override string Speak()
    {
        return "Woof";
    }
}

public class Cat : HousePet
{
    public override string Speak()
    {
        return "Meow";
    }
}
```

Polymorphism allows you to write code that works with objects of different types without knowing their specific type at compile time. In this example, polymorphism is achieved by creating instances of the `HousePet` class that are of type `Dog` or `Cat`. The `Speak` method is called on the `HousePet` objects, and the appropriate response is returned based on the type of the object, either "Woof" or "Meow". In C#, polymorphism can be achieved by using either class inheritance or interface implementation.

## Summary

Inheritance is a fundamental concept in object-oriented programming that allows you to create a hierarchy of classes by defining relationships between classes. In C#, you can use class inheritance to create a base class that defines common behavior and characteristics, and then create derived classes that inherit and extend that behavior. Inheritance provides several benefits, including code reuse, extensibility, encapsulation, consistency, and polymorphism. By using inheritance, you can create more maintainable and extensible code.
