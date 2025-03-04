In C#, you can use the `override` keyword to extend or modify the behavior of the base class in the derived class. The `override` keyword enables you to override properties and methods that are inherited from the base class, and provide custom implementations in the derived class. This allows you to reuse code defined in the base class and extend or modify the behavior of the base class in the derived class.

To override a property or method in a derived class, you must follow these steps:

1. Declare the members in the base class as either `abstract` or `virtual`.
1. Override the members in the derived class.
1. Optionally, use the `base` keyword to access the base class implementation from the overridden member in the derived class.

## Declare abstract and virtual members of the base class

Before you can override the members in a derived class, you must declare the members in the base class as either `abstract` or `virtual`.

- Abstract: The `abstract` keyword indicates that the member has no implementation and must be overridden in a derived class.
- Virtual: The `virtual` keyword indicates that the member has an implementation but can be overridden or extended in a derived class.

The following example demonstrates how to declare abstract and virtual members in a base class:

```csharp

public class BaseClass
{
    public string Property1 { get; set; } = "Base - Property1";
    public string Property2 { get; set; } = "Base - Property2";

    public virtual void Method1()
    {
        Console.WriteLine("Base - Method1");
    }

    public void Method2()
    {
        Console.WriteLine("Base - Method2");
    }
}

```

## Override members in the derived class

After you declare the members in the base class as either `abstract` or `virtual`, you can override the members in the derived class using the `override` keyword. The `override` keyword indicates that the member in the derived class overrides the member in the base class.

Consider the following example:

```csharp

// Step 1: Create instances of the base class and the derived classes
BaseClass baseClass = new BaseClass();
DerivedClass derivedClass = new DerivedClass();
BaseClass baseClassReferencingDerivedClass = new DerivedClass();

// Step 2: Access properties and methods of the base class
Console.WriteLine($"\n{baseClass.Property1}");
Console.WriteLine($"{baseClass.Property2}");
baseClass.Method1();
baseClass.Method2();

// Step 3: Access properties and methods of the derived class
Console.WriteLine($"\n{derivedClass.Property1}");
Console.WriteLine($"{derivedClass.Property2}");
derivedClass.Method1();
derivedClass.Method2();

// Step 4: Access properties and methods of the base class that references the derived class
Console.WriteLine($"\n{baseClassReferencingDerivedClass.Property1}");
Console.WriteLine($"{baseClassReferencingDerivedClass.Property2}");
baseClassReferencingDerivedClass.Method1();
baseClassReferencingDerivedClass.Method2();

/*Output:
Base - Property1
Base - Property2
Base - Method1
Base - Method2

Derived - Property1
Derived - Property2
Derived - Method1
Derived - Method2

Derived - Property1
Base - Property2
Derived - Method1
Base - Method2
*/

public class BaseClass
{
    public virtual string Property1 { get; set; } = "Base - Property1";
    public virtual string Property2 { get; set; } = "Base - Property2";

    public virtual void Method1()
    {
        Console.WriteLine("Base - Method1");
    }

    public void Method2()
    {
        Console.WriteLine("Base - Method2");
    }
}

public class DerivedClass : BaseClass
{
    public override string Property1 { get; set; } = "Derived - Property1";
    public new string Property2 { get; set; } = "Derived - Property2";

    public override void Method1()
    {
        Console.WriteLine("Derived - Method1");
    }

    public new void Method2()
    {
        Console.WriteLine("Derived - Method2");
    }
}

```

This code demonstrates how to modify and hide properties and methods in a derived class using the `override` and `new` keywords. The code defines a base class (BaseClass) and a derived class (DerivedClass) that inherits from the base class. The base class has two properties (Property1 and Property2) and two methods (Method1 and Method2). The derived class overrides Property1 and Method1, and hides Property2 and Method2 using the `new` keyword.

Here is a breakdown of the code:

1. In step 1, the code creates an instance of the base class (`baseClass`), an instance of the derived class (`derivedClass`), and an instance of the derived class referenced by a base class variable (`baseClassReferencingDerivedClass`). The `baseClassReferencingDerivedClass` instance demonstrates polymorphism, where a base class reference points to a derived class object.

1. In step 2, the code accesses and prints the properties and methods of the base class instance. Since `baseClass` is an instance of `BaseClass`, it uses the properties and methods defined in `BaseClass`. The output shows the values and behaviors as defined in the base class.

1. In step 3, the code accesses and prints the properties and methods of the derived class instance. Since `derivedClass` is an instance of `DerivedClass`, it uses the overridden properties and methods defined in `DerivedClass`. The output reflects the values and behaviors as defined in the derived class.

- In step 4, the code accesses and prints the properties and methods of the derived class instance referenced by a base class variable. For properties and methods that are overridden (`Property1` and `Method1`), the derived class implementation is used. However, for properties and methods that are hidden (`Property2` and `Method2`), the base class implementation is used. This demonstrates the difference between method overriding (using `override`) and method hiding (using `new`).

## Defining an abstract base class

When you define a base class as `abstract`, you indicate that the class is incomplete and must be implemented by derived classes. Abstract classes can contain abstract properties and methods that must be implemented by derived classes. Abstract base classes can't be instantiated directly, so they're used as a template for derived classes to implement the abstract members.

Consider the following example:

```csharp

// create instances of the base class and the derived classes
// Note: We can't create an instance of an abstract class
// BaseClass baseClass = new BaseClass(); // This line would cause a compile-time error
DerivedClass derivedClass = new DerivedClass();
BaseClass baseClassReferencingDerivedClass = new DerivedClass();

// access properties and methods of the derived class
Console.WriteLine($"\n{derivedClass.Property1}");
Console.WriteLine($"{derivedClass.Property2}");
derivedClass.Method1();
derivedClass.Method2();

// access properties and methods of the base class that references the derived class
Console.WriteLine($"\n{baseClassReferencingDerivedClass.Property1}");
Console.WriteLine($"{baseClassReferencingDerivedClass.Property2}");
baseClassReferencingDerivedClass.Method1();
baseClassReferencingDerivedClass.Method2();

/*Output:
Derived - Property1
Derived - Property2
Derived - Method1
Derived - Method2

Derived - Property1
Base - Property2
Derived - Method1
Base - Method2
*/

public abstract class BaseClass
{
    public abstract string Property1 { get; set; }
    public virtual string Property2 { get; set; } = "Base - Property2";

    public abstract void Method1();

    public void Method2()
    {
        Console.WriteLine("Base - Method2");
    }
}

public class DerivedClass : BaseClass
{
    public override string Property1 { get; set; } = "Derived - Property1";
    public new string Property2 { get; set; } = "Derived - Property2";

    public override void Method1()
    {
        Console.WriteLine("Derived - Method1");
    }

    public new void Method2()
    {
        Console.WriteLine("Derived - Method2");
    }
}

```

Notice that when the base class is declared using the `abstract` keyword, the base class can't be instantiated directly. Instead, you must create instances of the derived classes that implement the abstract members. The derived class must provide implementations for the abstract members defined in the base class. Members that aren't abstract can be overridden or hidden in the derived class.

## Override implicitly inherited members of the Object class

All classes in C# implicitly inherit from the `Object` class. The `Object` class defines several members that are inherited by all classes, such as `ToString`, `Equals`, and `GetHashCode`. You can override these members in your classes to provide custom implementations.

Consider the following example:

```csharp

// create instances of the derived classes
DerivedClass1 derivedClass1 = new DerivedClass1();
DerivedClass2 derivedClass2a = new DerivedClass2 { Property1 = "Value1", Property2 = "Value2" };
DerivedClass2 derivedClass2b = new DerivedClass2 { Property1 = "Value1", Property2 = "Value2" };
DerivedClass2 derivedClass2c = new DerivedClass2 { Property1 = "Value3", Property2 = "Value4" };

// demonstrate Object class methods for DerivedClass1
Console.WriteLine("\nDemonstrating Object class methods for DerivedClass1:");
Console.WriteLine($"ToString: {derivedClass1.ToString()}");
Console.WriteLine($"Equals: {derivedClass1.Equals(new DerivedClass1())}");
Console.WriteLine($"GetHashCode: {derivedClass1.GetHashCode()}");

// demonstrate overridden Object class methods for DerivedClass2
Console.WriteLine("\nDemonstrating overridden Object class methods for DerivedClass2:");
Console.WriteLine($"ToString: {derivedClass2a.ToString()}");
Console.WriteLine($"Equals (derivedClass2a vs derivedClass2b): {derivedClass2a.Equals(derivedClass2b)}"); // should return true
Console.WriteLine($"Equals (derivedClass2a vs derivedClass2c): {derivedClass2a.Equals(derivedClass2c)}"); // should return false
Console.WriteLine($"GetHashCode (derivedClass2a): {derivedClass2a.GetHashCode()}");
Console.WriteLine($"GetHashCode (derivedClass2b): {derivedClass2b.GetHashCode()}");
Console.WriteLine($"GetHashCode (derivedClass2c): {derivedClass2c.GetHashCode()}");

/*Output:
Demonstrating Object class methods for DerivedClass1:
ToString: DerivedClass1
Equals: False
GetHashCode: [HashCode]

Demonstrating overridden Object class methods for DerivedClass2:
ToString: DerivedClass2: Property1 = Value1, Property2 = Value2
Equals (derivedClass2a vs derivedClass2b): True
Equals (derivedClass2a vs derivedClass2c): False
GetHashCode (derivedClass2a): [HashCode]
GetHashCode (derivedClass2b): [HashCode]
GetHashCode (derivedClass2c): [HashCode]
*/

public abstract class BaseClass
{
    public abstract string Property1 { get; set; }
    public virtual string Property2 { get; set; } = "Base - Property2";

    public abstract void Method1();

    public void Method2()
    {
        Console.WriteLine("Base - Method2");
    }
}

public class DerivedClass1 : BaseClass
{
    public override string Property1 { get; set; } = "Derived1 - Property1";
    public new string Property2 { get; set; } = "Derived1 - Property2";

    public override void Method1()
    {
        Console.WriteLine("Derived1 - Method1");
    }

    public new void Method2()
    {
        Console.WriteLine("Derived1 - Method2");
    }
}

public class DerivedClass2 : BaseClass
{
    public override string Property1 { get; set; } = "Derived2 - Property1";
    public new string Property2 { get; set; } = "Derived2 - Property2";

    public override void Method1()
    {
        Console.WriteLine("Derived2 - Method1");
    }

    public new void Method2()
    {
        Console.WriteLine("Derived2 - Method2");
    }

    // Override ToString method
    public override string ToString()
    {
        return $"DerivedClass2: Property1 = {Property1}, Property2 = {Property2}";
    }

    // Override Equals method
    public override bool Equals(object obj)
    {
        if (obj is DerivedClass2 other)
        {
            return Property1 == other.Property1 && Property2 == other.Property2;
        }
        return false;
    }

    // Override GetHashCode method
    public override int GetHashCode()
    {
        return HashCode.Combine(Property1, Property2);
    }
}

```

In this example, the `DerivedClass1` and `DerivedClass2` classes inherit from the `BaseClass` class. The `DerivedClass2` class overrides the `ToString`, `Equals`, and `GetHashCode` methods inherited from the `Object` class. The `ToString` method returns a string representation of the object, the `Equals` method compares two objects for equality, and the `GetHashCode` method returns a hash code for the object. The `DerivedClass2` class provides custom implementations for these methods to display the properties of the object and compare objects based on their properties.

## Summary

Overriding properties and methods in a derived class allows you to extend or modify the behavior of the base class. By using the `override` keyword, you can provide custom implementations for properties and methods that are inherited from the base class. This enables you to reuse code defined in the base class and extend or modify the behavior of the base class in the derived class. You can also use the `new` keyword to hide properties and methods in the base class and provide new implementations in the derived class.
