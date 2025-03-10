Instance constructors are used to specify the code that's executed when you create a new instance of a class with the `new` operator. When instance constructors use the `public` access modifier, the resulting object is accessible from any other code in your application. This type of access to an object and its members is often desirable, but there are times when you want to restrict access to a class or to the members of a class.

When you need to hide or reduce the exposure of a class, you can use access modifiers to control the visibility of the class and its members.

## Access modifiers

All types and type members have an accessibility level that controls whether they are accessible from other code in your compiled application (or other assemblies).

Classes declared directly within a namespace can have `public`, `internal` or `file` access. Classes are assigned `internal` access by default when no access modifier is specified.

Use the following access modifiers to specify the accessibility of a type or member when you declare it:

- `public`: Code in any assembly can access this type or member. The accessibility level of the containing type controls the accessibility level of public members of the type.
- `private`: Only code declared in the same `class` or `struct` can access this member.
- `protected`: Only code in the same `class` or in a derived `class` can access this type or member.
- `internal`: Only code in the same assembly can access this type or member.
- `protected internal`: Only code in the same assembly or in a derived class in another assembly can access this type or member.
- `private protected`: Only code in the same assembly and in the same class or a derived class can access the type or member.
- `file`: Only code in the same file can access the type or member.

The `record` modifier on a type causes the compiler to synthesize extra members. The `record` modifier doesn't affect the default accessibility for either a `record class` or a `record struct`.

## Private class constructors

A private constructor is a special instance constructor. Private constructors are often used in classes that contain only static members. If a class has one or more private constructors and no public constructors, other classes (except nested classes) can't create instances of the class. For example:

```csharp

class NLog
{
    // Private Constructor:
    private NLog() { }

    public static double e = Math.E;  //2.71828...
}

```

The declaration of the empty constructor prevents the automatic generation of a parameterless constructor. If you don't specify an access modifier for a constructor, it defaults to `private`. However, the `private` modifier should be used to clarify that the class can't be instantiated.

Private constructors are used to prevent creating instances of a class when there are no instance fields or methods, such as the `Math` class in the .NET library, or when a method is called to obtain an instance of a class. If all the methods in the class are static, consider making the complete class static.

The following example shows a class using a private constructor.

```csharp

public class Counter
{
    private Counter() { }

    public static int currentCount;

    public static int IncrementCount()
    {
        return ++currentCount;
    }
}

class TestCounter
{
    static void Main()
    {
        // If you uncomment the following statement, it generates
        // an error because the constructor is inaccessible:
        // Counter aCounter = new Counter();   // Error

        Counter.currentCount = 100;
        Counter.IncrementCount();
        Console.WriteLine("New count: {0}", Counter.currentCount);

        // Keep the console window open in debug mode.
        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}
// Output: New count: 101

```

If you uncomment the following statement from the example, the compiler generates a build error. The compiler understands that a private constructor is inaccessible.

```csharp

// Counter aCounter = new Counter();   // Error

```

## Static classes

A static class is basically the same as a nonstatic class, with one important difference: a static class can't be instantiated. In other words, you can't use the `new` operator to create a variable from a static class. Although you can't create an instance of the class, you can access the members of a static class by referencing the class name. For example, if you have a static class named `UtilityClass` that has a public static method named `MethodA`, you can call the method using a combination of the class and method names. This syntax is shown in the following example:

```csharp

UtilityClass.MethodA();

```

A static class can be used as a container for methods that operate on input parameters and don't have to `get` or `set` any internal instance fields.

For example, in the .NET Class Library, the static `System.Math` class contains methods that perform mathematical operations. These methods operate without any requirement to store or retrieve data that's unique to a particular instance of the `Math` class. You call the members of the class by specifying the class name and the method name, as shown in the following example:

```csharp

double dub = -3.14;
Console.WriteLine(Math.Abs(dub));
Console.WriteLine(Math.Floor(dub));
Console.WriteLine(Math.Round(Math.Abs(dub)));

// Output:
// 3.14
// -4
// 3

```

As is the case with all class types, the .NET runtime loads the type information for a static class when the program that references the class is loaded. The program can't specify exactly when the class is loaded. However, it's guaranteed to load and have its fields initialized and its static constructor called before the class is referenced for the first time in your program. A static constructor is only called one time, and a static class remains in memory for the lifetime of the application domain in which your program resides.

The following list provides the main features of a static class:

- Contains only static members.
- Can't be instantiated.
- Is sealed.
- Can't contain Instance Constructors.

Creating a static class is therefore basically the same as creating a class that contains only static members and a private constructor. A private constructor prevents the class from being instantiated. The advantage of using a static class is that the compiler can check to make sure that no instance members are accidentally added. The compiler guarantees that instances of this class can't be created.

Static classes are sealed and therefore can't be inherited. They can't inherit from any class or interface except `Object`. Static classes can't contain an instance constructor. However, they can contain a `static` constructor. Nonstatic classes should also define a `static` constructor if the class contains `static` members that require non-trivial initialization.

Here's an example of a static class that contains two methods that convert temperature from Celsius to Fahrenheit and from Fahrenheit to Celsius:

```csharp

public static class TemperatureConverter
{
    public static double CelsiusToFahrenheit(string temperatureCelsius)
    {
        // Convert argument to double for calculations.
        double celsius = Double.Parse(temperatureCelsius);

        // Convert Celsius to Fahrenheit.
        double fahrenheit = (celsius * 9 / 5) + 32;

        return fahrenheit;
    }

    public static double FahrenheitToCelsius(string temperatureFahrenheit)
    {
        // Convert argument to double for calculations.
        double fahrenheit = Double.Parse(temperatureFahrenheit);

        // Convert Fahrenheit to Celsius.
        double celsius = (fahrenheit - 32) * 5 / 9;

        return celsius;
    }
}

class TestTemperatureConverter
{
    static void Main()
    {
        Console.WriteLine("Please select the convertor direction");
        Console.WriteLine("1. From Celsius to Fahrenheit.");
        Console.WriteLine("2. From Fahrenheit to Celsius.");
        Console.Write(":");

        string? selection = Console.ReadLine();
        double F, C = 0;

        switch (selection)
        {
            case "1":
                Console.Write("Please enter the Celsius temperature: ");
                F = TemperatureConverter.CelsiusToFahrenheit(Console.ReadLine() ?? "0");
                Console.WriteLine("Temperature in Fahrenheit: {0:F2}", F);
                break;

            case "2":
                Console.Write("Please enter the Fahrenheit temperature: ");
                C = TemperatureConverter.FahrenheitToCelsius(Console.ReadLine() ?? "0");
                Console.WriteLine("Temperature in Celsius: {0:F2}", C);
                break;

            default:
                Console.WriteLine("Please select a convertor.");
                break;
        }

        // Keep the console window open in debug mode.
        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}
/* Example Output:
    Please select the convertor direction
    1. From Celsius to Fahrenheit.
    2. From Fahrenheit to Celsius.
    :2
    Please enter the Fahrenheit temperature: 20
    Temperature in Celsius: -6.67
    Press any key to exit.
 */

```

## Static members

A nonstatic class can contain static methods, fields, properties, or events. The static member is callable on a class even when no instance of the class exists. The static member is always accessed by the class name, not the instance name. Only one copy of a static member exists, regardless of how many instances of the class are created. Static methods and properties can't access nonstatic fields and events in their containing type, and they can't access an instance variable of any object unless it's explicitly passed in a method parameter.

It's more typical to declare a nonstatic class with some static members, than to declare an entire class as static. Two common uses of static fields are to keep a count of the number of objects that are instantiated, or to store a value that must be shared among all instances.

Static methods can be overloaded but not overridden, because they belong to the class, and not to any instance of the class.

Although a field can't be declared as `static const`, a `const` field is essentially static in its behavior. It belongs to the type, not to instances of the type. Therefore, `const` fields can be accessed by using the same `ClassName.MemberName` notation used for static fields. No object instance is required.

C# doesn't support static local variables (that is, variables that are declared in method scope).

You declare static class members by using the `static` keyword before the return type of the member, as shown in the following example:

```csharp

public class Automobile
{
    public static int NumberOfWheels = 4;

    public static int SizeOfGasTank
    {
        get
        {
            return 15;
        }
    }

    public static void Drive() { }

    public static event EventType? RunOutOfGas;

    // Other nonstatic fields and properties...
}

```

Static members are initialized before the static member is accessed for the first time and before the static constructor, if there's one, is called. To access a static class member, use the name of the class instead of a variable name to specify the location of the member, as shown in the following example:

```csharp

Automobile.Drive();
int i = Automobile.NumberOfWheels;

```

If your class contains static fields, provide a static constructor that initializes them when the class is loaded.

A call to a static method generates a call instruction in common intermediate language (CIL), whereas a call to an instance method generates a `callvirt` instruction, which also checks for null object references. However, most of the time the performance difference between the two isn't significant.

## Nested classes

A `class` type defined within another class is called a nested class. For example:

```csharp

public class Container
{
    class Nested
    {
        Nested() { }
    }
}

```

The accessibility of a nested class defaults to `private`. This means that nested classes are only accessible from their containing class. In the previous example, the `Nested` class is inaccessible to external types.

You can specify an access modifier to define the accessibility of a nested type, as follows:

- Nested types of a class can be `public`, `protected`, `internal`, `protected internal`, `private` or `private protected`.

However, defining a `protected`, `protected internal` or `private protected` nested class inside a sealed class generates compiler warning CS0628, "new protected member declared in sealed class."

> [!CAUTION]
> Be aware that making a nested type externally visible violates the code quality rule CA1034 "Nested types shouldn't be visible".

The following example makes the `Nested` class public:

```csharp

public class Container
{
    public class Nested
    {
        Nested() { }
    }
}

```

The nested, or inner, class can access the containing, or outer, class. To access the containing class, pass it as an argument to the constructor of the nested class. For example:

```csharp

public class Container
{
    public class Nested
    {
        private Container? parent;

        public Nested()
        {
        }
        public Nested(Container parent)
        {
            this.parent = parent;
        }
    }
}

```

A nested class has access to all of the members that are accessible to its containing class. It can access private and protected members of the containing class, including any inherited protected members.

In the previous declaration, the full name of class `Nested` is `Container.Nested`. This is the name used to create a new instance of the nested class, as follows:

```csharp

Container.Nested nest = new Container.Nested();

```
