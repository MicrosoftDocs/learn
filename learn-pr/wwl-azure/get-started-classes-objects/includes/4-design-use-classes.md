In object-oriented programming (OOP), classes are the building blocks of an application. Understanding the relationship between classes and objects is essential.

- Classes are the blueprints that developers use to define the properties (data) and methods (behaviors) of objects. Classes provide a way to encapsulate data and behavior, making it easier to organize and manage code.
- Objects are instances of classes. When a class is instantiated, an object is created in memory. Each object has its own set of properties and methods, but shares the same structure defined by the class.

Examining the real-world objects around you can help you understand how classes and objects work in programming. Objects in the real world have attributes (properties) and behaviors (methods) that define their purpose and functionality. For example, a car is an object with attributes such as make, model, and color, and behaviors such as driving and stopping.

## Real-world objects

People interact with objects constantly in their daily lives. In fact, nearly everything that we interact with can be thought of as an object.

The following criteria can be used to define objects in the real world:

- Objects are the things that we can see and touch.
- Objects have a purpose.
- Objects have parts that support their purpose.

A pencil is an example of a physical object. The purpose of a pencil is to create a note or a drawing. The parts of a pencil include the body, the tip, and maybe an eraser. The parts work together to achieve the intended purpose of the pencil.

There are also physical objects that exist as an assembly of other objects. The following list provides examples of objects that are composed of other objects:

- A car: The purpose of a car is to provide ground transportation for individuals and families. The parts of a car include an engine, the wheels, a steering wheel, and many others. The parts of a car work together to enable ground transportation.
- A house: The purpose of a house is to provide shelter. The parts of a house include a foundation, outside walls, a roof, and rooms. These parts work together to create a living space.
- A smart phone: The purpose of a smart phone is to assist the user with day-to-day tasks and activities. The parts of a smart phone include a screen, a microprocessor, memory and storage, a battery, cameras, and buttons. These parts work together to enable communication, entertainment, and productivity features.

Each part of a car, house, or smart phone is an object with its own purpose and may also be an assembly of objects.

### Attributes and features of a physical object

Take a minute to consider the example of a pencil. A pencil has parts (body, tip, eraser) and a purpose (create a note or drawing). Pencils share these basic characteristics. However, not all pencils are the same.

Some pencils are short, some are long. Some pencils are yellow, some are black. Some pencils have a dull tip, some have a sharpened tip. Some pencils have an eraser, some don't have an eraser.

The attributes of an object are often divided into the following physical and behavioral categories:

- Physical: Physical attributes are the aspects of an object that can be seen or measured.
- Behavioral: Behavioral attributes are the aspects of an object that describe its capabilities or interactions with other objects.

For the pencil example, physical attributes include the length of the body, the color of the body, the sharpness of the tip, and whether or not the pencil has an eraser. The behavioral attributes include the ability to write, the ability to erase, and the ability to be sharpened. A pencil interacts with paper or other solid objects that can be written or drawn on.

Physical attributes are often referred to as properties, while behavioral attributes are often referred to as functions (methods in C# programming).

### Code classes and objects in C\# programming

In the world of C# programming, object properties and methods are defined by a class. Classes provide the blueprint for what an object (an instance of the class) is able to do. The blueprint for a class is called a class definition.

When an app is running, the computer uses a class definition to allocate memory for an object (an instance of the class). The computer uses the blueprint to configure a block of memory that's the right size for the object. An object is basically a block of memory.

Code objects, just like physical objects, can have different values assigned to its properties.

### Classes encapsulate data and behavior

Classes provide a way to encapsulate data and behavior. Encapsulation is the process of combining data and behavior into a single unit. Classes use properties to enable access to data and methods to enable behaviors.

### Class properties

Class properties are used to manage the data that differentiates one object (class instance) from another object of the same type.

Class properties enable objects to read, write, or compute the value of variables (data fields) defined within the class. Properties appear as public data members, but they're implemented as special methods called *accessors*. This feature enables callers to access data easily and still helps promote data safety and flexibility.

Property values can be read using a `get` accessor and assigned using a `set` accessor.

### Class methods

Class methods define the actions (behaviors) that a class can perform.

Methods can take parameters that provide input data, and can return output data through parameters. Methods can also return a value directly, without using a parameter.

For example, the `Console` class includes `WriteLine`, `ReadLine`, and `Clear` methods (among others). These methods help to enable the intended behaviors of the `Console` class. Methods can be used to perform actions, such as calculations, data manipulation, or interaction with other objects.

Methods are often designed to accept one or more method arguments. Method arguments are passed to the method as parameters of the calling statement used to invoke the method. For example, the `WriteLine` method of the `Console` class can accept a string argument that's provided by the calling statement.

### Class definitions in C\# code

The following example shows a simple class in C#. The `Phone` class has properties for `Brand`, `Model`, and `Year`. The class also includes methods for `Call` and `Text`.

```csharp

public class Phone
{
    public string? Brand { get; set; }
    public string? Model { get; set; }
    public int Year { get; set; }

    public void Call(string phoneNumber)
    {
        Console.WriteLine($"Calling {phoneNumber}...");
    }

    public void Text(string phoneNumber, string message)
    {
        Console.WriteLine($"Texting {phoneNumber}: {message}");
    }
}

```

## Using namespaces

In C# programming, namespaces are used in two ways:

- The .NET class library uses namespaces to organize its many classes.
- Developers declare their own namespaces to help control the scope of class and method names in larger programming projects.

### Namespaces in the .NET class library

Namespaces are used by the .NET class library to group related types together, making it easier to find and use them.

Consider the following code snippet:

```csharp

System.Console.WriteLine("Hello World!");

```

In this example, `System` is a namespace and `Console` is a class in that namespace.

Providing the fully qualified name of the class (`System.Console`) ensures that the correct class is used. However, using fully qualified names can be cumbersome when working with many classes from the same namespace. To improve code readability, you can use the `using` directive. The `using` directive allows you to use types defined in a namespace without specifying the fully qualified namespace of that type.

The following code snippet implements the `using` directive to improve code readability:

```csharp

using System;

Console.WriteLine("Hello World!");

```

> [!NOTE]
> Starting in .NET 6, *implicit* `global using` directives are added to new C# projects. This means that you can use types defined in these namespaces without having to specify their fully qualified name or manually add a using directive. The *implicit* aspect refers to the fact that the global using directives are added to a generated file in the project's obj directory. This feature enables you to use `Console.WriteLine` without explicitly declaring `using System` when developing apps in versions 6.0 or later of .NET.

### Organizing classes with namespaces

Declaring your own namespaces can help you control the scope of class and method names in larger programming projects. Use the `namespace` keyword to declare a namespace.

Consider the following code snippet:

```csharp

namespace SampleNamespace
{
    class SampleClass
    {
        public void SampleMethod()
        {
            System.Console.WriteLine("SampleMethod inside SampleNamespace");
        }
    }
}

```

The name of the namespace must be a valid C# identifier name.

You can declare a namespace for all types defined in that file, as shown in the following code snippet:

```csharp

namespace SampleNamespace;

class SampleClass
{
    public void SampleMethod()
    {
        System.Console.WriteLine("SampleMethod inside SampleNamespace");
    }
}

class AnotherSampleClass
{
    public void AnotherSampleMethod()
    {
        System.Console.WriteLine("AnotherSampleMethod inside SampleNamespace");
    }
}

```

The advantage of this new syntax is that it's simpler, saving horizontal space and braces. That makes your code easier to read.

### Namespaces overview

Namespaces have the following properties:

- They organize large code projects.
- They're delimited by using the `.` operator.
- The `using` directive obviates the requirement to specify the name of the namespace for every class.
- The global namespace is the "root" namespace: `global::System` always refers to the .NET System namespace.

Using namespaces to group related types together makes it easier to find and use them.
