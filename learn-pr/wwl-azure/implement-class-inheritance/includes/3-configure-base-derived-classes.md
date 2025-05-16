The terms *base class* and *derived class* are used to describe the relationship between classes in an inheritance hierarchy. A base class is used to define a common set of attributes and behaviors that other classes inherit. A derived class is used to define a specialized set of attributes and behaviors that extend or modify the base class.

## Examine the transitive nature of inheritance

In C#, a class can inherit from only one base class. This restriction is known as single inheritance. Single inheritance allows a derived class to access the properties and methods of a single base class, promoting a clear and simple hierarchy. The concept of multiple inheritance isn't supported in C#. This restriction avoids the complexities and ambiguities that can arise when inheriting from multiple base classes. Instead, C# uses interfaces to achieve similar functionality.

Although a class can inherit from only one base class, inheritance is transitive. This means that if a class C inherits from class B, and class B inherits from class A, then class C inherits the members declared in both class B and class A. This property allows for deeper hierarchies and further code reuse.

For example, consider a vehicle management system where you have a base class `Vehicle`, a derived class `Car` that inherits from `Vehicle`, and another derived class `ElectricCar` that inherits from `Car`. In this hierarchy, `ElectricCar` inherits members from both `Car` and `Vehicle`, demonstrating the transitive nature of inheritance.

```csharp
public class Vehicle
{
    public string Make { get; set; }
    public string Model { get; set; }

    public void StartEngine()
    {
        Console.WriteLine("Engine started.");
    }

    public void StopEngine()
    {
        Console.WriteLine("Engine stopped.");
    }
}

public class Car : Vehicle
{
    public int NumberOfDoors { get; set; }

    public void OpenTrunk()
    {
        Console.WriteLine("Trunk opened.");
    }

    public void HonkHorn()
    {
        Console.WriteLine("Horn honked.");
    }

    public void LockDoors()
    {
        Console.WriteLine("Doors locked.");
    }
}

public class ElectricCar : Car
{
    public int BatteryCapacity { get; set; }

    public void ChargeBattery()
    {
        Console.WriteLine("Battery charging.");
    }

    public void DisplayBatteryStatus()
    {
        Console.WriteLine("Battery status displayed.");
    }
}

public class CombustionEngineCar : Car
{
    public int FuelCapacity { get; set; }

    public void Refuel()
    {
        Console.WriteLine("Car refueled.");
    }

    public void CheckOilLevel()
    {
        Console.WriteLine("Oil level checked.");
    }
}
```

This example demonstrates a simple vehicle management system with the following classes:

- `Vehicle` class: The base class `Vehicle` contains common properties and methods for all vehicles, such as Make, Model, StartEngine, and StopEngine.

- `Car` class: The `Car` class inherits from `Vehicle` and adds specific properties and methods for cars, such as `NumberOfDoors`, `OpenTrunk`, `HonkHorn`, and `LockDoors`.

- `ElectricCar` class: The `ElectricCar` class inherits from `Car` and adds properties and methods specific to electric cars, such as `BatteryCapacity`, `ChargeBattery`, and `DisplayBatteryStatus`.

- `CombustionEngineCar` class: The `CombustionEngineCar` class also inherits from `Car` and adds properties and methods specific to combustion engine cars, such as `FuelCapacity`, `Refuel`, and `CheckOilLevel`.

In this example, the `Car` class inherits members from the `Vehicle` class, and the `ElectricCar` and `CombustionEngineCar` inherit members from the `Car` class. This hierarchy demonstrates the transitive nature of inheritance, where `ElectricCar` and `CombustionEngineCar` inherit members from both `Car` and `Vehicle`.

## Examine member inheritance and visibility

When a class inherits from a base class, the following rules apply:

- Static and instance constructors aren't inherited.
- All other members of the base class are inherited, but access modifiers affect their visibility in the derived class. Access modifiers include: `public`, `protected`, `internal`, and `private`.

### Public members

Public members are accessible from any code that has access to the class. Derived classes inherit public members and they're accessible from outside the class hierarchy.

```csharp

public class BaseClass
{
    public int publicField;
    public void PublicMethod() { }
}

public class DerivedClass : BaseClass
{
    public void AccessPublicMember()
    {
        publicField = 10;
        PublicMethod();
    }
}

```

In this example, the `DerivedClass` inherits the `publicField` and `PublicMethod` members from the `BaseClass`. The `AccessPublicMember` method in the `DerivedClass` can access these members. Public members are also accessible from code that's outside the class hierarchy.

### Protected members

Protected members are accessible within the class in which they're declared and within derived classes. They aren't accessible from outside the class hierarchy.

```csharp

public class BaseClass
{
    protected int protectedField;
    protected void ProtectedMethod() { }
}

public class DerivedClass : BaseClass

{
    public void AccessProtectedMember()
    {
        protectedField = 10;
        ProtectedMethod();
    }
}

```

In this example, the `DerivedClass` inherits the `protectedField` and `ProtectedMethod` members from the `BaseClass`. The `AccessProtectedMember` method in the `DerivedClass` can access these members. However, if you try to access protected members from outside the class hierarchy, a compile-time error is generated.

### Internal members

Internal members are accessible within the same assembly. They aren't accessible from outside the assembly, even if the class is inherited.

```csharp

public class BaseClass
{
    internal int internalField;
    internal void InternalMethod() { }
}

public class DerivedClass : BaseClass
{
    public void AccessInternalMember()
    {
        internalField = 10;
        InternalMethod();
    }
}

```

In this example, the `DerivedClass` inherits the `internalField` and `InternalMethod` members from the `BaseClass`. The `AccessInternalMember` method in the `DerivedClass` can access these members because they're in the same assembly. However, if you try to access internal members from outside the assembly, a compile-time error is generated.

### Private members

Private members are accessible only within the class in which they're declared. Derived classes don't inherit private members, so they're not directly accessible in the derived class.

```csharp

public class BaseClass
{
    private int privateField;
    private void PrivateMethod() { }
}

public class DerivedClass : BaseClass
{
    public void AccessPrivateMember()
    {
        // Can't access privateField or PrivateMethod
    }
}

```

In this example, the `DerivedClass` inherits from the `BaseClass`, but it can't access the `privateField` or `PrivateMethod` members because they're private.

## Examine the use of abstract, virtual, and sealed keywords in the base class

Base and derived classes use the `abstract`, `virtual`, and `sealed` keywords to control the behavior of members that are inherited. These keywords allow you to define the level of control that derived classes have over the members of the base class.

### Examine the use of the `abstract` keyword

The `abstract` keyword in C# is used to define classes and class members that are incomplete and must be implemented in derived classes. An abstract class can't be instantiated directly and is intended to be a base class for other classes. Abstract methods and properties are declared without any implementation and must be overridden in nonabstract derived classes.

For example:

```csharp
public abstract class Shape
{
    public abstract int GetArea();
}

public class Square : Shape
{
    private int _side;

    public Square(int side)
    {
        _side = side;
    }

    public override int GetArea()
    {
        return _side * _side;
    }
}

class Program
{
    static void Main()
    {
        Square square = new Square(5);
        Console.WriteLine($"Area of the square = {square.GetArea()}");
    }
}
```

In this example, the `Shape` class is abstract and contains an abstract method `GetArea`. The `Square` class inherits from `Shape` and provides an implementation for the `GetArea` method. The `Square` class can be instantiated, and the `GetArea` method returns the area of the square.

The following rules describe how the `abstract` keyword affects inheritance:

- Abstract classes: An abstract class can't be instantiated directly. The abstract class is a base class for derived classes and the derived classes must provide implementations for all abstract members of the abstract class.
- Abstract methods: Abstract methods are declared without any implementation in the abstract class. Derived classes must override these methods and provide the implementation.
- Abstract properties: Similar to abstract methods, abstract properties are declared without implementation and must be overridden in derived classes.

The `abstract` keyword in C# is a powerful tool for defining incomplete classes and members that must be implemented in derived classes. It enforces a contract that derived classes must follow, ensuring that certain methods and properties are implemented. Appropriate use of the `abstract` keyword promotes a clear delineation of responsibilities between base and derived classes.

### Examine the use of the `virtual` keyword

The `virtual` keyword in C# is used to define methods and properties that can be overridden in derived classes. A virtual method or property has an implementation in the base class, but it can be extended or modified in derived classes. Derived classes can override virtual members to provide their own implementations.

For example:

```csharp

public class Animal
{
    public virtual void MakeSound()
    {
        Console.WriteLine("Animal makes a sound");
    }
}

public class Dog : Animal
{
    public override void MakeSound()
    {
        Console.WriteLine("Dog barks");
    }
}

class Program
{
    static void Main()
    {
        Animal animal = new Dog();
        animal.MakeSound();
    }
}

```

In this example, the `Animal` class defines a virtual method `MakeSound` that prints a generic message. The `Dog` class inherits from `Animal` and overrides the `MakeSound` method to print a specific message. When you create a `Dog` object and call the `MakeSound` method, the overridden implementation in the `Dog` class is executed.

The following rules describe how the `virtual` keyword affects inheritance:

- Virtual methods: A virtual method has an implementation in the base class, but it can be overridden in derived classes.
- Virtual properties: Similar to virtual methods, virtual properties have an implementation in the base class and can be overridden in derived classes.

### Examine the use of the `sealed` keyword

The `sealed` keyword in C# is used to prevent a class or class member from being inherited or overridden. When a class is marked as `sealed`, it can't be used as a base class for other classes. When a method is marked as `sealed`, it can't be overridden in derived classes.

For example:

```csharp

public class BaseClass
{
    public virtual void Method1()
    {
        Console.WriteLine("Method1 in BaseClass");
    }

    public virtual void Method2()
    {
        Console.WriteLine("Method2 in BaseClass");
    }
}

public class DerivedClass : BaseClass
{
    public sealed override void Method1()
    {
        Console.WriteLine("Method1 in DerivedClass");
    }

    public override void Method2()
    {
        Console.WriteLine("Method2 in DerivedClass");
    }
}

public class FinalClass : DerivedClass
{
    // This class can't override Method1 because it's sealed in DerivedClass
    public override void Method2()
    {
        Console.WriteLine("Method2 in FinalClass");
    }
}

```

In this example, the `DerivedClass` inherits from the `BaseClass` and overrides the `Method1` method, marking it as `sealed`. The `Method2` method is also overridden in the `DerivedClass` but isn't sealed. The `FinalClass` inherits from `DerivedClass` and tries to override the `Method2` method. However, it can't override the `Method1` method because it is sealed in the `DerivedClass`.

The following rules describe how the `sealed` keyword affects inheritance:

- Sealed classes: A sealed class can't be used as a base class for other classes. It prevents inheritance from the sealed class.
- Sealed methods: A sealed method can't be overridden in derived classes. It prevents further modification of the method in derived classes.
- Sealed properties: Similar to sealed methods, sealed properties can't be overridden in derived classes.

Sealed classes and methods are useful when you want to prevent further extension or modification of a class or method. They provide a way to restrict inheritance and ensure that certain members remain unchanged.

## Examine implicit inheritance from Object

In C#, all classes implicitly inherit from the `Object` class. The `Object` class defines several methods that are available to all classes, such as `ToString`, `Equals`, and `GetHashCode`. If a class doesn't explicitly inherit from another class, it still inherits from `Object` by default.

- `ToString`: The `ToString` method returns a string that represents the current object. By default, it returns the fully qualified name of the class.
- `Equals`: The `Equals` method compares two objects for equality. By default, it compares the references of the objects.
- `GetHashCode`: The `GetHashCode` method returns a hash code for the current object. By default, it returns the hash code of the object's reference.

Consider the following code sample that creates three `Person` objects and demonstrates the inherited `ToString`, `Equals`, and `GetHashCode` methods:

```csharp
Person person1 = new Person { Name = "Alice", Age = 30 };
Person person2 = new Person { Name = "Alice", Age = 30 };
Person person3 = person1;

Console.WriteLine(person1.ToString());
Console.WriteLine(person1.Equals(person2));
Console.WriteLine(person1.GetHashCode());
Console.WriteLine(person1.Equals(person3));

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

// Output: Person
//         False
//         32854180
//         True
```

In this code sample, the `ToString` method returns the fully qualified name of the `Person` class, which includes the defined namespace. The first `Equals` method compares the references of the `person1` and `person2` objects and returns `False`. The `GetHashCode` method returns the hash code of the `person1` object's reference. And then the `Equals` method compares the references of the `person1` and `person3` objects and returns `True`.

## Summary

Inheritance enables derived classes to inherit base class members that define a common set of attributes and behaviors. Derived classes can extend or modify the behavior of the base class by adding new members or overriding existing members. The `abstract`, `virtual`, and `sealed` keywords are used to control how base class members are inherited or overridden. The visibility of inherited members is affected by access modifiers, such as `public`, `protected`, `internal`, and `private`. All classes in C# implicitly inherit from the `Object` class, which provides several methods, such as `ToString`, `Equals`, and `GetHashCode`, that are available to all classes.
