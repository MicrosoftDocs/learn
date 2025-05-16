Class properties provide a flexible mechanism to read, write, or compute the value of a data field. They appear as public data members, but they're implemented as special methods called *accessors*. This feature enables callers to access data easily and still helps promote data safety and flexibility.

## Using properties

Properties combine aspects of both fields and methods. To the user of an object, a property appears to be a field. Accessing the property requires the same syntax as accessing a field. To the implementer of a class, a property is one or two code blocks, representing a `get` accessor and/or a `set` or `init` accessor. The code block for the `get` accessor is executed when the property is read. The code block for the `set` or `init` accessor is executed when the property is assigned a value. A property without a `set` accessor is considered read-only. A property without a `get` accessor is considered write-only. A property that has both accessors is read-write. You can use an `init` accessor instead of a `set` accessor to enable the property to be set as part of object initialization but otherwise make it read-only.

Unlike fields, properties aren't classified as variables. Therefore, you can't pass a property as a `ref` or `out` parameter.

Properties are often used to support the following scenarios:

- They can validate data before allowing a change.
- They can transparently expose data on a class where that data is retrieved from some other source, such as a database.
- They can take an action when data is changed, such as raising an event, or changing the value of other fields.

Properties are declared in the code block of a class definition. Properties are declared by specifying the access level of the field, followed by the type of the property, followed by the name of the property, followed by a code block that declares a `get` accessor and/or a `set` accessor.

### The `get` accessor

The body of the `get` accessor resembles that of a method. It must return a value of the property type. The C# compiler and Just-in-time (JIT) compiler detect common patterns for implementing the `get` accessor, and optimize for those patterns.

For example, a `get` accessor that returns a field without performing any computation is likely optimized to a memory read of that field. Automatically implemented properties, examined in the next unit of this module, follow this pattern and benefit from these optimizations. However, a virtual `get` accessor method can't be inlined because the compiler doesn't know at compile time which method might actually be called at run time.

The following example shows a `get` accessor that returns the value of a private field `_name`:

```csharp

public class Employee
{
    private string _name = "unknown";  // the name field
    public string Name
    {
        get { return _name; }  // the Name property
    }
}

```

In this example, the `Employee` class includes a private field and a public property. Here's an explanation of the `Employee` class definition:

- The `Employee` class is defined with the public access modifier, meaning it's accessible from any other code in the same assembly or another assembly that references it.
- The private field `_name` is declared with the `string` type and is assigned a default value, `"unknown"`.
- The public property `Name` is declared with the `string` type. The property includes a `get` accessor that returns the value of the `_name` field.

> [!NOTE]
> The fields that provide the values for property accessors are often called *backing fields*.

Take a minute to consider the code that instantiates an `Employee` object and reads the value of the `Name` property:

```csharp
Employee employee = new Employee();  // create an instance of the Employee class

Console.Write(employee.Name);  // use the get accessor to read the value of the Name property

```

This code sample instantiates a new `Employee` object named `employee`. When your code references the `employee.Name` property, except as the target of an assignment, the `get` accessor is invoked to read the value of the property. In this case, the `get` accessor returns the value of the `_name` field, which is assigned the value `"unknown"`.

The code block for a `get` accessor can also be used to return a calculated value. This can be useful when you want to ensure that a property always returns a non-null value. For example:

```csharp

public class Manager
{
    private string? _name;
    public string Name
    {
        get
        {
            return _name != null ? _name : "NA";
        }
    }
}

```

### The `set` accessor

The `set` accessor resembles a method whose return type is void. It uses an implicit parameter called `value`, whose type is the type of the property. The compiler and JIT compiler also recognize common patterns for a `set` or `init` accessor. Those common patterns are optimized, directly writing the memory for the backing field. In the following example, a `set` accessor is added to the `Name` property:

```csharp

class Student
{
    private string? _name;  // the name field
    public string Name    // the Name property
    {
        get
        {
            return _name != null ? _name : "NA";
        }
        set
        {
            _name = value;
        }
    }
}

```

Take a minute to consider the code that creates an instance of the `Student` class. When you assign a value to the `Name` property, the `set` accessor is invoked by using an argument that provides the new value. For example:

```csharp

var student = new Student();
student.Name = "StudentName";  // the set accessor is invoked here

Console.Write(student.Name);  // the get accessor is invoked here

```

### The `init` accessor

The code to create an `init` accessor is the same as the code to create a `set` accessor except that you use the `init` keyword instead of `set`. The difference is that the `init` accessor can only be used in the constructor or by using an *object-initializer*.

## Declare and use read-write properties

Properties provide the convenience of public data members without the risks that come with unprotected, uncontrolled, and unverified access to an object's data. Properties declare accessors: special methods that assign and retrieve values from the underlying data member. The `set` accessor enables data members to be assigned, and the `get` accessor retrieves data member values.

This sample shows a `Person` class that has two properties: `Name` (string) and `Age` (int). Both properties provide `get` and `set` accessors, so they're considered read/write properties.

```csharp

class Person
{
    private string _name = "N/A";
    private int _age = 0;

    // Declare a Name property of type string:
    public string Name
    {
        get
        {
            return _name;
        }
        set
        {
            _name = value;
        }
    }

    // Declare an Age property of type int:
    public int Age
    {
        get
        {
            return _age;
        }
        set
        {
            _age = value;
        }
    }
}

class TestPerson
{
    static void Main()
    {
        // Create a new Person object named person:
        Person person = new Person();

        // Print out the default name and age of the person:
        Console.WriteLine($"Person details - Name = {person.Name}, Age = {person.Age}");

        // Set some values on the person object:
        person.Name = "PersonName";
        person.Age = 99;
        Console.WriteLine($"Person details - Name = {person.Name}, Age = {person.Age}");

        // Increment the Age property:
        person.Age += 1;
        Console.WriteLine($"Person details - Name = {person.Name}, Age = {person.Age}");

        // Keep the console window open in debug mode.
        Console.WriteLine("Press any key to exit.");
        Console.ReadKey();
    }
}

/* Output:
Person details - Name = N/A, Age = 0
Person details - Name = PersonName, Age = 99
Person details - Name = PersonName, Age = 100
*/

```

## Accessor syntax and coding techniques

In addition to the basic syntax for declaring properties, C# includes syntax that enables you to write more concise and expressive code. These features include:

- Expression-bodied members
- Field-backed properties
- Required properties

### Expression-bodied members

Expression-bodied members provide a more concise syntax for writing single-line property accessors.

> [!NOTE]
> Expression-bodied members can also be applied to methods, indexers, and event accessors.

Property accessors often consist of single-line statements that assign or return the result of an expression. The `Person` class that you examined earlier in this unit is a good example:

```csharp

class Student
{
    private string? _name;  // the name field
    public string Name    // the Name property
    {
        get
        {
            return _name != null ? _name : "NA";
        }
        set
        {
            _name = value;
        }
    }
}

```

In this example, the `Name` property uses a single-line statement to return the value of the `_name` field if it's not null, or the string "NA" if it's null. The `set` accessor uses a single-line statement to assign the value of the `Name` property to the `_name` field.

An expression body definition consists of the `=>` token followed by the expression used to assign or retrieve the property value. Since the accessors defined for the `Student` class implement a single-line statement, it's a good candidate for update using expression body definitions.

The following code snippet updates the `Student` class using expression body definitions for the `get` and `set` accessors:

```csharp

class Student
{
    private string? _name;  // the name field
    public string Name    // the Name property
    {
        get => _name ?? "NA";
        set => _name = value;
    }
}

```

### Field backed properties

Starting in C# 13, you can add validation or other logic in the accessor for a property using the `field` keyword preview feature. The `field` keyword accesses the compiler synthesized backing field for a property. It enables you to write a property accessor without explicitly declaring a separate backing field.

```csharp

public class Person
{
    public string? FirstName 
    { 
        get;
        set => field = value.Trim(); 
    }

    // Omitted for brevity.
}

```

> [!IMPORTANT]
> The `field` keyword is a preview feature in C# 13. You must be using .NET 9 and set your `<LangVersion>` element to preview in your project file in order to use the `field` contextual keyword.
>
> You should be careful using the `field` keyword feature in a class that has a field named `field`. The new `field` keyword shadows a field named `field` in the scope of a property accessor. You can either change the name of the `field` variable, or use the `@` token to reference the field identifier as `@field`.

### Required properties

The preceding example allows a caller to create a `Person` using the default constructor, without setting the `FirstName` property. The property type is set to a nullable string. Beginning in C# 11, you can require callers to set a property:

```csharp

public class Person
{
    public Person() { }

    [SetsRequiredMembers]
    public Person(string firstName) => FirstName = firstName;

    public required string FirstName { get; init; }

    // Omitted for brevity.
}

```

The preceding code makes two changes to the `Person` class. First, the `FirstName` property declaration includes the `required` modifier. That means any code that creates a new `Person` must set this property using an object initializer. Second, the constructor that takes a `firstName` parameter has the `System.Diagnostics.CodeAnalysis.SetsRequiredMembersAttribute` attribute. This attribute informs the compiler that this constructor sets all required members. Callers using this constructor aren't required to set `required` properties with an object initializer.

> [!IMPORTANT]
> Don't confuse `required` with non-nullable. It's valid to set a `required` property to `null` or `default`. If the type is non-nullable, such as `string` in these examples, the compiler issues a warning.

```csharp

var aPerson = new Person("PersonName");
aPerson = new Person{ FirstName = "PersonName"};
// Error CS9035: Required member `Person.FirstName` must be set:
//aPerson2 = new Person();

```
