A derived class that replaces or overrides a base class method or property can still access the method or property on the base class by using the `base` keyword. This enables you to call base class constructors, methods, and properties from overridden members of a derived class. By using the `base` keyword, you can ensure that the derived class properly reuses and extends the functionality provided by the base class.

The `base` keyword is used to accomplish the following tasks:

- To call a base class method from an overridden method of the derived class.
- To implement a base-class constructor from within the constructor of the derived class.

The `base` keyword has the following restrictions:

- The `base` keyword can only be used in a constructor, an instance method, or an instance property accessor.
- The `base` keyword can't be used in a static method. Attempting to use the `base` keyword in a static method will generate an error.

When you implement the `base` keyword in a derived class, your code uses the base class specified in the class declaration. For example, if you specify class `ClassC : ClassB` in the class declaration, the `base` keyword enables your code to access the members of `ClassB` from `ClassC`. It doesn't matter whether class `ClassB` inherits from class `ClassA`.

## Access base class properties and methods from a derived class

Accessing the properties and methods of a base class from a derived class is a common requirement when implementing inheritance. The following code demonstrates the syntax for implementing the `base` keyword:

```csharp
base.MemberName
```

Notice that the `base` keyword and the name of the base class member are separated by a period (`.`). The `MemberName` can be a property, method, or field of the base class.

The following code demonstrates how to access base class properties and methods from a derived class:

```csharp

// create an instance of the derived classes
DerivedClass1 derivedClass1 = new DerivedClass1();

// demonstrate the overridden methods of the derived class
Console.WriteLine("Calling the methods of DerivedClass1...\n");
Console.WriteLine($"Method1 in the derived class appends derived class information to the return value: {derivedClass1.Method1()}");

derivedClass1.Method2();

/*Output:
Calling the methods of DerivedClass1...

Method1 in the derived class calls base.Method1. base.Method1 returns: base.Method1 results
Method1 in the derived class appends derived class information to the return value: base.Method1 results - plus information specific to DerivedClass1

Method2 in the derived class calls base.Method2 (reuses the base class implementation)
Method2 in the base class implements common behavior and returns true/false
Method2 in the derived class accesses base class Property2: Base - Property2

Method2 in the derived class uses base class members to modify and extend functionality
*/

public abstract class BaseClass
{
    public abstract string Property1 { get; set; }
    public virtual string Property2 { get; set; } = "Base - Property2";

    public virtual string Method1()
    {
        return "base.Method1 results";
    }

    public virtual bool Method2()
    {
        Console.WriteLine("Method2 in the base class implements common behavior and returns true/false");
        return true;
    }
}

public class DerivedClass1 : BaseClass
{
    public override string Property1 { get; set; } = "Derived - Property1";
    public new string Property2 { get; set; } = "Derived - Property2";

    public override string Method1()
    {
        // Method1 of the base class is abstract and can't be called
        Console.WriteLine($"Method1 in the derived class calls base.Method1. base.Method1 returns: {base.Method1()}");
        
        // Return the base.Method1 response additional information specific to DerivedClass1
        return $"{base.Method1()} - plus information specific to DerivedClass1";
    }

    public override bool Method2()
    {
        // Call base class method to implement common behavior
        Console.WriteLine($"\nMethod2 in the derived class calls base.Method2 (reuses the base class implementation)");
        bool baseMethod1Success = base.Method2();

        // Access base class Property2
        string baseProperty2Value = base.Property2;
        Console.WriteLine($"Method2 in the derived class accesses base class Property2: {baseProperty2Value}");

        // implement derived class logic that involves base class information
        if (baseMethod1Success && baseProperty2Value == "Base - Property2")
        {
            Console.WriteLine("\nMethod2 in the derived class uses base class members to modify and extend functionality");
            return true;
        }
        else
        {
            Console.WriteLine("Method2 in the derived class can implement alternate behavior");
        }

        return false;
    }
}

```

In this code sample, the `DerivedClass1` class inherits from the `BaseClass` and overrides its methods to extend their functionality. The code implements the following steps:

1. An instance of `DerivedClass1` is created using the statement `DerivedClass1 derivedClass1 = new DerivedClass1();`. This derived class instance is used to call and demonstrate the overridden methods of the derived class.

1. The code calls `Method1` of the derived class from within a `Console.WriteLine` statement. The overridden `Method1` uses `base.Method1()` to call the base class's `Method1`, appends additional information specific to `DerivedClass1`, and returns the combined result. A `Console.WriteLine` statement is used to display the value returned by overridden `Method1`. This step demonstrates how to include information specific to the derived class when extending a base class method of type `string`.

1. The code calls `Method2` of the derived class. The overridden `Method2` uses `base.Method2` to reuse the base class's `Method2` implementation. The method accesses the base class's `Property2` and prints its value. The overridden method then uses the Boolean value returned by the base class's `Method2` and the value of `Property2`, to either extend the `Method2` functionality or implements alternate behavior. This step demonstrates how the derived class can build upon and modify the behavior of the base class method.

> [!NOTE]
> It's best practice for virtual members use `base` to call the base class implementation of that member in their own implementation. Letting the base class behavior occur enables the derived class to concentrate on implementing behavior specific to the derived class. If the base class implementation isn't called, it's up to the derived class to make their behavior compatible with the behavior of the base class.

## Access base class constructors from a derived class

Class constructors in the base class can be accessed from constructors of the derived class by using the `base` keyword.

The following code demonstrates how to access base class constructors from a derived class:

```csharp

// create an instance of the derived classes
DerivedClass1 derivedClass1 = new DerivedClass1("Derived1 - Property1", "Derived1 - Property2");

// demonstrate the overridden methods of the derived class
Console.WriteLine("Calling the methods of DerivedClass1...\n");
Console.WriteLine($"Method1 in the derived class appends derived class information to the return value: {derivedClass1.Method1()}");

derivedClass1.Method2();

/*Output:
Calling the methods of DerivedClass1...

Method1 in the derived class calls base.Method1. base.Method1 returns: base.Method1 results
Method1 in the derived class appends derived class information to the return value: base.Method1 results - plus information specific to DerivedClass1

Method2 in the derived class calls base.Method2 (reuses the base class implementation)
Method2 in the base class implements common behavior and returns true/false
Method2 in the derived class accesses base class Property2: Base - Property2

Method2 in the derived class uses base class members to modify and extend functionality
*/

public abstract class BaseClass
{
    public abstract string Property1 { get; set; }
    public virtual string Property2 { get; set; }

    public BaseClass(string property1, string property2)
    {
        Property1 = property1;
        Property2 = property2;
    }

    public virtual string Method1()
    {
        return "base.Method1 results";
    }

    public virtual bool Method2()
    {
        Console.WriteLine("Method2 in the base class implements common behavior and returns true/false");
        return true;
    }
}

public class DerivedClass1 : BaseClass
{
    public override string Property1 { get; set; }
    public new string Property2 { get; set; }

    public DerivedClass1(string property1, string property2) : base(property1, "Base - Property2")
    {
        Property1 = property1;
        Property2 = property2;
    }

    public override string Method1()
    {
        // Method1 of the base class is abstract and can't be called
        Console.WriteLine($"Method1 in the derived class calls base.Method1. base.Method1 returns: {base.Method1()}");
        
        // Return the base.Method1 response additional information specific to DerivedClass1
        return $"{base.Method1()} - plus information specific to DerivedClass1";
    }

    public override bool Method2()
    {
        // Call base class method to implement common behavior
        Console.WriteLine($"\nMethod2 in the derived class calls base.Method2 (reuses the base class implementation)");
        bool baseMethod1Success = base.Method2();

        // Access base class Property2
        string baseProperty2Value = base.Property2;
        Console.WriteLine($"Method2 in the derived class accesses base class Property2: {baseProperty2Value}");

        // implement derived class logic that involves base class information
        if (baseMethod1Success && baseProperty2Value == "Base - Property2")
        {
            Console.WriteLine("\nMethod2 in the derived class uses base class members to modify and extend functionality");
            return true;
        }
        else
        {
            Console.WriteLine("Method2 in the derived class can implement alternate behavior");
        }

        return false;
    }
}

```

Calling the base class constructor from the derived class constructor is important. For example, when the base class constructor initializes common properties that are used by the derived class. By calling the base class constructor from the derived class constructor, you ensure that the common properties are initialized before the derived class constructor executes.

Consider the following code:

```csharp

public abstract class Vehicle
{
    public virtual int Speed { get; set; }
    public virtual int Fuel { get; set; }

    public Vehicle(int speed, int fuel)
    {
        Speed = speed;
        Fuel = fuel;
    }

    public virtual void Drive()
    {
        Console.WriteLine("Vehicle is driving");
    }
}

public class Car : Vehicle
{
    public int NumberOfDoors { get; set; }
    public int TrunkCapacity { get; set; }

    public Car(int speed, int fuel, int numberOfDoors) : base(speed, fuel)
    {
        NumberOfDoors = numberOfDoors;
        // Initialize TrunkCapacity based on the Speed and Fuel properties of the base class
        TrunkCapacity = CalculateTrunkCapacity(Speed, Fuel);
    }

    private int CalculateTrunkCapacity(int speed, int fuel)
    {
        // Example logic to calculate trunk capacity based on speed and fuel
        return (speed + fuel) / 2;
    }

    public override void Drive()
    {
        base.Drive();
        Console.WriteLine("Car is driving with additional features");
    }
}

class Program
{
    static void Main()
    {
        Car car = new Car(100, 50, 4);
        Console.WriteLine($"Speed: {car.Speed}, Fuel: {car.Fuel}, NumberOfDoors: {car.NumberOfDoors}, TrunkCapacity: {car.TrunkCapacity}");
        car.Drive();
    }
}

```

Notice that the `Car` class constructor calls the base class constructor using the `base` keyword. Calling the base class constructor first ensures that the `Speed` and `Fuel` properties of the `Vehicle` base class are initialized correctly before the `Car` class constructor executes. This sequence of events is important because the `TrunkCapacity` property of the `Car` class is initialized using the `Speed` and `Fuel` properties of the `Vehicle` base class.

## Summary

Consider the following guidelines when accessing base class members from a derived class:

- Use the `base` keyword to access base class members from a derived class.
- Use the `base` keyword to call base class constructors from derived class constructors.
- Use the `base` keyword to access base class fields, properties, and methods from overridden methods in a derived class.
