Ordinarily, there are two ways to add a method to an existing type:

- Modify the source code for that type. Modifying the source creates a breaking change if you also add any private data fields to support the method.
- Define the new method in a derived class. A method can't be added in this way using inheritance for other types, such as structures and enumerations. Nor can it be used to "add" a method to a sealed class.

Extension methods let you "add" a method to an existing type without modifying the type itself or implementing the new method in an inherited type. The extension method also doesn't have to reside in the same assembly as the type it extends. You call an extension method as if it were a defined member of a type.

## Extension methods

Extension methods enable you to "add" methods to existing types without creating a new derived type, recompiling, or otherwise modifying the original type. Extension methods are static methods, but they're called as if they were instance methods on the extended type. For client code written in C#, F# and Visual Basic, there's no apparent difference between calling an extension method and the methods defined in a type.

### Binding extension methods at compile time

You can use extension methods to extend a class or interface, but not to override them. An extension method with the same name and signature as a class method is never called. At compile time, extension methods always have lower priority than instance methods defined in the type itself. In other words, if a type has a method named `Process(int i)`, and you have an extension method with the same signature, the compiler always binds to the instance method. When the compiler encounters a method invocation, it looks for a match in the type's instance methods. If no matching instance method is found, the compiler searches for any extension methods defined for the type. The compiler binds to the first extension method that it finds.

The following example demonstrates the rules that the C# compiler follows in determining whether to bind a method call to an instance method on the type, or to an extension method.

```csharp

namespace ExtensionMethodDemo.PersonNamespace
{
    // Define a simple class with properties and methods
    public class Person
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Age { get; set; }

        public void Introduce()
        {
            Console.WriteLine($"Hi, I'm {FirstName} {LastName}, and I'm {Age} years old.");
        }
    }
}

namespace ExtensionMethodDemo.PersonExtensionsNamespace
{
    using ExtensionMethodDemo.PersonNamespace;

    // Define an extension method for the Person class
    public static class PersonExtensions
    {
        public static void DisplayFullName(this Person person)
        {
            Console.WriteLine($"Full Name: {person.FirstName} {person.LastName}");
        }

        public static bool IsAdult(this Person person)
        {
            return person.Age >= 18;
        }

        public static void Introduce()
        {
            Console.WriteLine($"Extension - Hi, it's nice to meet you.");
        }

        // Extension method attempting to override Introduce
        public static void Introduce(this Person person, string greeting)
        {
            Console.WriteLine($"{greeting}, I'm {person.FirstName} {person.LastName}, and I'm {person.Age} years old.");
        }
    }
}

namespace ExtensionMethodDemo
{
    using ExtensionMethodDemo.PersonNamespace;
    using ExtensionMethodDemo.PersonExtensionsNamespace;

    class Program
    {
        static void Main(string[] args)
        {
            // Create instances of the Person class
            Person person1 = new Person { FirstName = "FName1", LastName = "LName1", Age = 25 };
            Person person2 = new Person { FirstName = "FName2", LastName = "LName2", Age = 16 };

            // Use the methods of the Person class
            person1.Introduce();
            person2.Introduce();

            // Use the extension methods
            person1.DisplayFullName();
            Console.WriteLine($"Is {person1.FirstName} an adult? {person1.IsAdult()}");

            person2.DisplayFullName();
            Console.WriteLine($"Is {person2.FirstName} an adult? {person2.IsAdult()}");

            // Use the extension method that attempts to override Introduce
            person1.Introduce("Hello");
            person2.Introduce("Greetings");
        }
    }
}
// Output:
//     Hi, I'm FName1 LName1, and I'm 25 years old.
//     Hi, I'm FName2 LName2, and I'm 16 years old.
//     Full Name: FName1 LName1
//     Is FName1 an adult? True
//     Full Name: FName2 LName2
//     Is FName2 an adult? False
//     Hello, I'm FName1 LName1, and I'm 25 years old.
//     Greetings, I'm FName2 LName2, and I'm 16 years old.

```

In this example, the `Person` class has three properties: `FirstName`, `LastName`, and `Age`. The `Person` class also has an instance method `Introduce` that writes a message to the console.

The `PersonExtensions` class defines extension methods for the `Person` class. The `PersonExtensions` class contains the following extension methods:

- `DisplayFullName`: Writes the full name of the person to the console.
- `IsAdult`: Returns a Boolean value indicating whether the person is an adult.
- `Introduce`: Writes a message to the console. This method has two overloads: one without parameters and one with a string parameter.
- `Introduce(this Person person, string greeting)`: Writes a message to the console with a custom greeting.
- `Introduce()`: Writes a default message to the console.

The `Main` method creates two instances of the `Person` class and calls the `Introduce` method on each instance. The `Introduce` method defined in the `Person` class is executed. The `Introduce` method without parameters in the `PersonExtensions` class isn't called because the `Person` class already has an instance method `Introduce` with the same signature. The compiler follows the rules for binding extension methods at compile time and gives priority to the instance method defined in the type itself. The `Main` method also calls the extension methods `DisplayFullName`, `IsAdult`, and the overloaded `Introduce` method with a custom greeting. The extension methods are executed as expected.

## General guidelines

Extension methods are an important option for creating reusable functionality throughout the .NET ecosystem. However, modifying an object's code or deriving a new type whenever it's reasonable and possible to do so, is still considered preferable. Extension methods are an excellent choice when the original source isn't under your control, when a derived object is inappropriate or impossible, or when the functionality shouldn't be exposed beyond its applicable scope.

When using extension methods to extend a type whose source code you aren't in control of, you run the risk that a change in the implementation of the type will cause your extension method to break. If you do implement extension methods for a given type, remember the following points:

- An extension method isn't called if it has the same signature as a method defined in the type.
- Extension methods are brought into scope at the namespace level. For example, if you have multiple static classes that contain extension methods in a single namespace named `Extensions`, they'll all be brought into scope by the `using Extensions;` directive.

For a class library that you implemented, you shouldn't use extension methods to avoid incrementing the version number of an assembly. If you want to add significant functionality to a library for which you own the source code, follow the .NET guidelines for assembly versioning.
