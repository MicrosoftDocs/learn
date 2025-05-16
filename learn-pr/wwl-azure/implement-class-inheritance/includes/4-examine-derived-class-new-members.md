A derived class is used to extend or modify the base class that it inherits from.

When you create a derived class, you have several options for how to extend the base class:

- You can define new properties and methods in the derived class that don't exist in the base class. This option allows you to extend the behavior of the base class by providing more functionality in the derived class.
- You can define properties and methods in the derived class that have the same name as properties and methods in the base class. In such cases, you can use the `new` keyword to hide the base class members.
- You can define properties and methods in the derived class that override properties and methods in the base class. In such cases, you can use the `override` keyword to extend or modify the behavior of the base class members.

Using the `new` keyword can also be used to avoid accidental overriding of base class members. Using the `new` keyword ensures that the derived class member is treated as a separate entity.

## Add new members to a derived class that don't exist in the base class

When you create a derived class, you can add new properties and methods that extend the behavior and functionality of the base class. However, you need to either manage or avoid naming conflicts between the base class and the derived class.

Consider the following example:

```csharp

// create instances of the base class and the derived classes
BaseClass baseClass = new BaseClass();
DerivedClass derivedClass = new DerivedClass();
BaseClass baseClassReferencingDerivedClass = new DerivedClass();

// access properties and methods of the base class
Console.WriteLine($"\n{baseClass.Property1}");
baseClass.Method1();

// access properties and methods of the derived class
Console.WriteLine($"\n{derivedClass.Property1}");
derivedClass.Method1();
Console.WriteLine($"{derivedClass.Property2}");
derivedClass.Method2();

// access properties and methods of the base class that references the derived class
Console.WriteLine($"\n{baseClassReferencingDerivedClass.Property1}");
baseClassReferencingDerivedClass.Method1();
//baseClassReferencingDerivedClass.Method2(); //Generates error: 'BaseClass' doesn't contain a definition for 'Method2' ...

/*Output:
Base - Property1
Base - Method1

Base - Property1
Base - Method1
Derived - Property2
Derived - Method2

Base - Property1
Base - Method1
*/

public class BaseClass
{
    public string Property1 { get; set; } = "Base - Property1";

    public void Method1()
    {
        Console.WriteLine("Base - Method1");
    }
}

public class DerivedClass : BaseClass
{
    public string Property2 { get; set; } = "Derived - Property2";

    public void Method2()
    {
        Console.WriteLine("Derived - Method2");
    }
}

```

This code sample includes top level statements and two classes: `BaseClass` and `DerivedClass`. The `BaseClass` class defines a property named `Property1` and a method named `Method1`. The derived class `DerivedClass` extends the base class with a new property named `Property2` and a new method named `Method2`. There's no naming conflicts between the base and derived classes, so you can access the new and inherited members from an instance of the derived class.

The code creates an instance of `BaseClass` named `baseClass` and an instance of `DerivedClass` named `derivedClass`. The code also creates an instance of `BaseClass` named `baseClassReferencingDerivedClass` that references an instance of `DerivedClass`. The code then completes the following steps:

- It uses `baseClass` to display the value of `Property1` and call `Method1`.
- It uses `derivedClass` to display the value of `Property1`, call `Method1`, display the value of `Property2`, and call `Method2`.
- It uses `baseClassReferencingDerivedClass` to call `Method1` and display the value of `Property1`.

Notice that the variable `baseClassReferencingDerivedClass` is declared as type `BaseClass`, but assigned an instance of type `DerivedClass`. Using this declaration syntax means that even though the `baseClassReferencingDerivedClass` object contains a reference the derived class, it's still treated like an instance of the base class. An attempt to call `Method2` would result in a compile-time error because the base class doesn't have a method named `Method2`. When an app instantiates an object as a base class type and then assigns the object a derived class instance, it's prepared to implement polymorphism. Although class inheritance is often used to support polymorphism, inheritance and polymorphism are distinct topics. Polymorphism is explored in a separate module.

When you run the code, you see the following output:

```plaintext

Base - Method1

Base - Property1

Base - Method1

Base - Property1

Derived - Method2

Derived - Property2

Base - Method1

Base - Property1

```

The base class objects, `baseClass` and `baseClassReferencingDerivedClass`, can only access the properties and methods defined in the base class. The derived class object, `derivedClass`, can access properties and methods in both the base class and the derived class.

## Add new members to a derived class that exist in the base class

When you add new members to a derived class, you need to be aware of naming conflicts between the base class and the derived class. A naming conflict occurs when a derived class defines a member with the same name as a member in the base class.

Consider the following code sample that includes a naming conflicts between the base class and the derived class:

```csharp

// create instances of the base class and the derived classes
BaseClass baseClass = new BaseClass();
DerivedClass derivedClass = new DerivedClass();
BaseClass baseClassReferencingDerivedClass = new DerivedClass();

// access properties and methods of the base class
Console.WriteLine($"\n{baseClass.Property1}");
Console.WriteLine($"{baseClass.Property2}");
baseClass.Method1();
baseClass.Method2();

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
Base - Property1
Base - Property2
Base - Method1
Base - Method2

Base - Property1
Derived - Property2
Base - Method1
Derived - Method2

Base - Property1
Base - Property2
Base - Method1
Base - Method2
*/

public class BaseClass
{
    public string Property1 { get; set; } = "Base - Property1";
    public string Property2 { get; set; } = "Base - Property2";

    public void Method1()
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
    public string Property2 { get; set; } = "Derived - Property2";

    public void Method2()
    {
        Console.WriteLine("Derived - Method2");
    }
}

```

Notice that `Property2` and `Method2` in the derived class have the same name as `Property2` and `Method2` in the base class. Duplicating members creates a naming conflict between the base and derived classes. Building the solution generates a warning stating that members of the derived class are hiding members inherited from the base class.

```plaintext

warning CS0108: 'DerivedClass.Property2' hides inherited member 'BaseClass.Property2'. Use the new keyword if hiding was intended.

warning CS0108: 'DerivedClass.Method2()' hides inherited member 'BaseClass.Method2()'. Use the new keyword if hiding was intended.

```

If you run the code, you see the following output:

```plaintext

Base - Property1
Base - Property2
Base - Method1
Base - Method2

Base - Property1
Derived - Property2
Base - Method1
Derived - Method2

Base - Property1
Base - Property2
Base - Method1
Base - Method2

```

The output shows that the `Property2` property and the `Method2` method of the derived class are called when using the object declared as the derived class. The `Property2` property and the `Method2` method of the base class are called when using the object declared as the base class.

When you have a naming conflict between the base class and the derived class, you can use the `new` keyword to hide the base class member intentionally. The `new` keyword allows you to define a new member in the derived class that has the same name as a member in the base class.

> [!NOTE]
> Using the `override` keyword is discussed in the next unit.

## Use the `new` keyword to avoid naming conflicts

When you have a naming conflict between the base class and the derived class, you can use the `new` keyword to hide the base class member intentionally. This syntax allows you to define a new member in the derived class that has the same name as a member in the base class. Using the `new` keyword in this way doesn't change the compiler's default behavior for resolving naming conflicts, but it does suppress the warning that occurs when you build the solution, and it makes the intention to hide the base class member explicit.

The following code uses the `new` keyword in the derived class to hide the `Property2` property and the `Method2` method defined in the base class:

```csharp

// create instances of the base class and the derived classes
BaseClass baseClass = new BaseClass();
DerivedClass derivedClass = new DerivedClass();
BaseClass baseClassReferencingDerivedClass = new DerivedClass();

// access properties and methods of the base class
Console.WriteLine($"\n{baseClass.Property1}");
Console.WriteLine($"{baseClass.Property2}");
baseClass.Method1();
baseClass.Method2();

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
Base - Property1
Base - Property2
Base - Method1
Base - Method2

Base - Property1
Derived - Property2
Base - Method1
Derived - Method2

Base - Property1
Base - Property2
Base - Method1
Base - Method2
*/

public class BaseClass
{
    public string Property1 { get; set; } = "Base - Property1";
    public string Property2 { get; set; } = "Base - Property2";

    public void Method1()
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
    public new string Property2 { get; set; } = "Derived - Property2";

    public new void Method2()
    {
        Console.WriteLine("Derived - Method2");
    }
}

```

When you run the code, the output will be the same as in the previous example. The `new` keyword is used in the derived class to hide the `Property2` property and the `Method2` method defined in the base class. The `Property2` property and the `Method2` method of the derived class are called when using the object declared as the derived class. The `Property2` property and the `Method2` method of the base class are called when using the object declared as the base class.

### General guidance on using the `new` keyword

The `new` keyword can be used to hide a member of the base class intentionally. This behavior is useful when the derived class needs to provide a different implementation or functionality that isn't compatible with the base class member. The `new` keyword can also be used to ensure that the intention to hide the base class member is clear. Without the `new` keyword, it might be unclear whether the derived class member is intended to override the base class member or hide it.

Use the following guidelines when applying the `new` keyword:

- Use the `new` keyword when you want to hide a member of the base class intentionally. Hiding the base class member ensures that the derived class member is treated as a separate entity.
- Use the `new` keyword when you want to avoid accidental overriding of base class members. Intentionally leaving off the `new` keyword can lead another developer believe the derived class member should be overridden.
- Avoid using the `new` keyword if you intend to extend or modify the behavior of a base class member. In such cases, consider using the `override` keyword instead.
- Avoid using the `new` keyword if it leads to confusion or ambiguity in the code. Ensure that the purpose of hiding the base class member is clear and justified.

## Summary

A derived class can extend the behavior of a base class by adding new properties and methods. You can use the `new` keyword to hide base class members intentionally, or to avoid accidental overriding of base class members. The `new` keyword allows you to define new members in a derived class that have the same name as members in the base class.
