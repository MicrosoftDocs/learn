It's possible to split the definition of a class or method over two or more source files. Each source file contains a section of the type or method definition, and all parts are combined when the application is compiled.

## Partial classes

There are several situations when splitting a class definition is desirable:

- Declaring a class over separate files enables multiple programmers to work on it at the same time.
- You can add code to the class without having to recreate the source file that includes automatically generated source. Visual Studio uses this approach when it creates Windows Forms, Web service wrapper code, and so on. You can create code that uses these classes without having to modify the file created by Visual Studio.
- Source generators can generate extra functionality in a class.

To split a class definition, use the partial keyword modifier. In practice, each partial class is typically defined in a separate file, making it easier to manage and expand the class over time.

The following `Employee` example demonstrates how the class might be divided across two files: `Employee_Part1.cs` and `Employee_Part2.cs`.

```csharp

// This is in Employee_Part1.cs
public partial class Employee
{
    public void DoWork()
    {
        Console.WriteLine("Employee is working.");
    }
}

```

```csharp

// This is in Employee_Part2.cs
public partial class Employee
{
    public void GoToLunch()
    {
        Console.WriteLine("Employee is at lunch.");
    }
}

```

```csharp

//Main program demonstrating the Employee class usage
public class Program
{
    public static void Main()
    {
        Employee emp = new Employee();
        emp.DoWork();
        emp.GoToLunch();
    }
}

// Expected Output:
// Employee is working.
// Employee is at lunch.

```

The `partial` keyword indicates that other parts of the class can be defined in the namespace. All the parts must use the `partial` keyword. All the parts must be available at compile time to form the final type. All the parts must have the same accessibility, such as `public`, `private`, and so on.

If any part is declared abstract, then the whole type is considered abstract. If any part is declared sealed, then the whole type is considered sealed. If any part declares a base type, then the whole type inherits that class.

All the parts that specify a base class must agree, but parts that omit a base class still inherit the base type. Parts can specify different base interfaces, and the final type implements all the interfaces listed by all the partial declarations. Any class, struct, or interface members declared in a partial definition are available to all the other parts. The final type is the combination of all the parts at compile time.

> [!NOTE]
> The `partial` modifier isn't available on delegate or enumeration declarations.

The following example shows that nested types can be partial, even if the type they're nested within isn't partial itself.

```csharp

class Container
{
    partial class Nested
    {
        void Test() { }
    }

    partial class Nested
    {
        void Test2() { }
    }
}

```

At compile time, attributes of partial-type definitions are merged. For example, consider the following declarations:

```csharp

[SerializableAttribute]
partial class Moon { }

[ObsoleteAttribute]
partial class Moon { }

```

They're equivalent to the following declarations:

```csharp

[SerializableAttribute]
[ObsoleteAttribute]
class Moon { }

```

The following are merged from all the partial-type definitions:

- XML comments. However, if both declarations of a partial member include comments, only the comments from the implementing member are included.
- interfaces
- generic-type parameter attributes
- class attributes
- members

For example, consider the following declarations:

```csharp

partial class Earth : Planet, IRotate { }
partial class Earth : IRevolve { }

```

They're equivalent to the following declarations:

```csharp

class Earth : Planet, IRotate, IRevolve { }

```

## Restrictions on partial class definitions

There are several rules to follow when you're working with partial class definitions:

- All partial-type definitions meant to be parts of the same type must be modified with partial. For example, the following class declarations generate an error:

    ```csharp
    
    public partial class A { }
    //public class A { }  // Error, must also be marked partial
    
    ```

- The partial modifier can only appear immediately before the keyword class, struct, or interface.

- Nested partial types are allowed in partial-type definitions as illustrated in the following example:

    ```csharp
    
    partial class ClassWithNestedClass
    {
        partial class NestedClass { }
    }
    
    partial class ClassWithNestedClass
    {
        partial class NestedClass { }
    }
    
    ```

- All partial-type definitions meant to be parts of the same type must be defined in the same assembly and the same module (.exe or .dll file). Partial definitions can't span multiple modules.

- The class name and generic-type parameters must match on all partial-type definitions. Generic types can be partial. Each partial declaration must use the same parameter names in the same order.

- The following keywords on a partial-type definition are optional, but if present on one partial-type definition, the same must be specified on other partial definition for the same type:

    - public
    - private
    - protected
    - internal
    - abstract
    - sealed
    - base class
    - new modifier (nested parts)
    - generic constraints

## Implement partial classes

In the following example, the fields and constructor of the `Coords` class are declared in one partial class definition (`Coords_Part1.cs`), and the `PrintCoords` method is declared in another partial class definition (`Coords_Part2.cs`). This separation demonstrates how partial classes can be divided across multiple files for easier maintainability.

```csharp

// This is in Coords_Part1.cs
 public partial class Coords
 {
     private int x;
     private int y;

     public Coords(int x, int y)
     {
         this.x = x;
         this.y = y;
     }
 }

 // This is in Coords_Part2.cs
 public partial class Coords
 {
     public void PrintCoords()
     {
         Console.WriteLine("Coords: {0},{1}", x, y);
     }
 }

// Main program demonstrating the Coords class usage
 class TestCoords
 {
     static void Main()
     {
         Coords myCoords = new Coords(10, 15);
         myCoords.PrintCoords();

         // Keep the console window open in debug mode.
         Console.WriteLine("Press any key to exit.");
         Console.ReadKey();
     }
 }
 // Output: Coords: 10,15

```

## Partial members

A partial class can contain a partial member. One part of the class contains the signature of the member. An implementation can be defined in the same part or another part.

An implementation isn't required for a partial method when the signature obeys the following rules:

- The declaration doesn't include any access modifiers. The method has private access by default.
- The return type is `void`.
- None of the parameters have the `out` modifier.
- The method declaration can't include any of the following modifiers:

    - virtual
    - override
    - sealed
    - new
    - extern

The method and all calls to the method are removed at compile time when there's no implementation.

Any method that doesn't conform to all those restrictions, including properties and indexers, must provide an implementation. That implementation might be supplied by a source generator. Partial properties can't be implemented using automatically implemented properties. The compiler can't distinguish between an automatically implemented property, and the declaring declaration of a partial property.

Beginning with C# 13, the implementing declaration for a partial property can use field backed properties to define the implementing declaration. A field backed property provides a concise syntax where the field keyword accesses the compiler synthesized backing field for the property. For example, you could write the following code:

```csharp

// in file1.cs
public partial class PropertyBag
{
    // Defining declaration
    public partial int MyProperty { get; set; }
}

// In file2.cs
public partial class PropertyBag
{
    // Defining declaration
    public partial int MyProperty { get => field; set; }
}

```

You can use `field` in either the `get` or `set` accessor, or both.

> [!IMPORTANT]
> The `field` keyword is a preview feature in C# 13. You must be using .NET 9 and set your `<LangVersion>` element to preview in your project file in order to use the `field` contextual keyword.
>
> You should be careful using the `field` keyword feature in a class that has a field named `field`. The new `field` keyword shadows a field named `field` in the scope of a property accessor. You can either change the name of the field variable, or use the `@` token to reference the field identifier as `@field`.

Partial methods enable the implementer of one part of a class to declare a member. The implementer of another part of the class can define that member. There are two scenarios where this separation is useful: templates that generate boilerplate code, and source generators.

- Template code: The template reserves a method name and signature so that generated code can call the method. These methods follow the restrictions that enable a developer to decide whether to implement the method. If the method isn't implemented, then the compiler removes the method signature and all calls to the method. The calls to the method, including any results that would occur from evaluation of arguments in the calls, have no effect at run time. Therefore, any code in the partial class can freely use a partial method, even if the implementation isn't supplied. No compile-time or run-time errors result if the method is called but not implemented.

- Source generators: Source generators provide an implementation for members. The human developer can add the member declaration (often with attributes read by the source generator). The developer can write code that calls these members. The source generator runs during compilation and provides the implementation. In this scenario, the restrictions for partial members that might not be implemented often aren't followed.

    ```csharp
    
    // Definition in file1.cs
    partial void OnNameChanged();
    
    // Implementation in file2.cs
    partial void OnNameChanged()
    {
      // method body
    }
    
    ```

- Partial member declarations must begin with the contextual keyword partial.

- Partial member signatures in both parts of the partial type must match.

- Partial member can have static and unsafe modifiers.

- Partial member can be generic. Constraints must be the same on the defining and implementing method declaration. Parameter and type parameter names don't have to be the same in the implementing declaration as in the defining one.

- You can make a delegate to a partial method defined and implemented, but not to a partial method that doesn't have an implementation.
