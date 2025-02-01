C# is a strongly typed language. Every variable and constant has a type, as does every expression that evaluates to a value. Every method declaration specifies a name, the type and kind (value, reference, or output) for each input parameter and for the return value. The .NET class library defines built-in numeric types and complex types that represent a wide variety of constructs. These constructs include the file system, network connections, collections and arrays of objects, and dates. A typical C# program uses types from the class library and user-defined types that model the concepts that are specific to the program's problem domain.

## Built-in types

C# provides a standard set of built-in types. These standard types represent integers, floating point values, Boolean expressions, text characters, decimal values, and other types of data. There are also built-in string and object types. These types are available for you to use in any C# program.

## Custom types

You use the `struct`, `class`, `interface`, `enum`, and `record` constructs to create your own custom types. The .NET class library itself is a collection of custom types that you can use in your own applications. By default, the most frequently used types in the class library are available in any C# program. Others become available only when you explicitly add a project reference to the assembly that defines them. After the compiler has a reference to the assembly, you can declare variables (and constants) of the types declared in that assembly in source code.

## Common type system

It's important to understand two fundamental points about the type system in .NET:

- It supports the principle of inheritance. Types can derive from other types, called base types. The derived type inherits (with some restrictions) the methods, properties, and other members of the base type. The base type can in turn derive from some other type, in which case the derived type inherits the members of both base types in its inheritance hierarchy. All types, including built-in numeric types such as System.Int32 (C# keyword: int), derive ultimately from a single base type, which is `System.Object` (C# keyword: `object`). This unified type hierarchy is called the Common Type System (CTS).

- Each type in the CTS is defined as either a value type or a reference type. These types include all custom types in the .NET class library and also your own user-defined types. Types that you define by using the struct keyword are value types; all the built-in numeric types are structs. Types that you define by using the class or record keyword are reference types. Reference types and value types have different compile-time rules, and different run-time behavior.

The following illustration shows the relationship between value types and reference types in the CTS.

![Diagram showing value and reference types](../media/value-reference-types-common-type-system.png)

Classes and structures are two of the basic constructs of the common type system in .NET. Each is essentially a data structure that encapsulates a set of data and behaviors that belong together as a logical unit. The data and behaviors are the members of the `class`, `struct`, or `record`. The members of a class include properties (data), methods (behaviors), fields (variables declared inside the class), and many others.

A `class`, `struct`, or `record` declaration is like a blueprint that is used to create instances or objects at run time. If you define a class named `Person`, `Person` is the name of the type. If you declare and initialize a variable `p` of type `Person`, `p` is said to be an object or instance of `Person`. Multiple instances of the same `Person` type can be created, and each instance can have different values in its properties and fields.

A class is a reference type. When an object of the type is created, the variable to which the object is assigned holds only a reference to that memory. When the object reference is assigned to a new variable, the new variable refers to the original object. Changes made through one variable are reflected in the other variable because they both refer to the same data.

A `struct` is a value type. When a `struct` is created, the variable to which the `struct` is assigned holds the `struct`'s actual data. When the `struct` is assigned to a new variable, the data value is copied. The new variable and the original variable therefore contain two separate copies of the same data. Changes made to one copy don't affect the other copy.

Record types can be either reference types (`record class`) or value types (`record struct`). Record types contain methods that support value-equality.

In general, classes are used to model more complex behavior. Classes typically store data that is intended to be modified after a class object is created. Structures are best suited for small data structures. Structures typically store data that isn't intended to be modified after the `struct` is created. Record types are data structures with other compiler synthesized members. Records typically store data that isn't intended to be modified after the object is created.

## Value types

Value types derive from `System.ValueType`, which derives from `System.Object`. Types that derive from `System.ValueType` have special behavior in the common language runtime. Value type variables directly contain their values. The memory for a `struct` is allocated inline in whatever context the variable is declared. There's no separate heap allocation or garbage collection overhead for value-type variables. You can declare record struct types that are value types and include the synthesized members for records.

There are two categories of value types: struct and enum.

The built-in numeric types are structs, and they have fields and methods that you can access:

```csharp

// constant field on type byte.
byte b = byte.MaxValue;

```

But you declare and assign values to them as if they're simple non-aggregate types:

```csharp

byte num = 0xA;
int i = 5;
char c = 'Z';

```

Value types are *sealed*. You can't derive a type from any value type, for example `System.Int32`. You can't define a `struct` to inherit from any user-defined `class` or `struct` because a `struct` can only inherit from `System.ValueType`.

You use the struct keyword to create your own custom value types. Typically, a struct is used as a container for a small set of related variables, as shown in the following example:

```csharp

public struct Coords
{
    public int x, y;

    public Coords(int p1, int p2)
    {
        x = p1;
        y = p2;
    }
}

```

The other category of value types is `enum`. An `enum` defines a set of named integral constants. For example, the `System.IO.FileMode` enumeration in the .NET class library contains a set of named constant integers that specify how a file should be opened. The syntax for an `enum` is shown in the following example:

```csharp

public enum FileMode
{
    CreateNew = 1,
    Create = 2,
    Open = 3,
    OpenOrCreate = 4,
    Truncate = 5,
    Append = 6,
}

```

The `System.IO.FileMode.Create` constant has a value of 2. However, the name is much more meaningful for humans reading the source code, and for that reason it's better to use enumerations instead of constant literal numbers.

All `enums` inherit from `System.Enum`, which inherits from `System.ValueType`. All the rules that apply to `structs` also apply to `enums`.

## Reference types

The `class`, `record`, `delegate`, `array`, and `interface` types are *reference types*.

When you declare a variable of a reference type, it contains the value null until you assign it with an instance of that type or create one using the `new` operator.

The following example demonstrates how to declare reference type variables using arrays:

```csharp

// Declaring an array variable
int[] numbers;

// Initializing the array with a size of 5
numbers = new int[5];

// Alternatively, declaring and initializing an array in one line
int[] numbers2 = new int[] { 1, 2, 3, 4, 5 };

// Assigning a reference to another variable
int[] numbers3 = numbers2;

```

The `new` operator creates an instance of the type and returns a reference to that instance. The reference is the memory address of the object, and that reference is stored in the variable. When you assign a reference type variable to another variable, you're copying the reference, not the object itself. Both variables refer to the same object in memory.

> [!NOTE]
> In addition to being reference types, arrays are collections. Collections can be initialized using collection expressions, which eliminate the requirement to include the `new` keyword when declaring and initializing an array in one line. For example: `int[] numbers = [ 1, 2, 3, 4, 5 ];`.

You can create an instance of a class using the same syntax used to instantiate the built-in types. The following example demonstrates how to create an instance of a class:

```csharp

MyClass myClass = new MyClass();
MyClass myClass2 = myClass;

```

The `new` operator creates an instance of the class and returns a reference to that instance. The reference is the memory address of the object, and that reference is stored in the variable. When you assign a reference type variable to another variable, you're copying the reference, not the object itself. Both variables refer to the same object in memory.
