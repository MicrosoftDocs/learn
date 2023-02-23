In this exercise, you'll work with integral types. An **integral type** is a simple value type that represents whole numbers (non-fractional). The most popular in this category is the `int` data type.

There are two subcategories of integral types: **signed** and **unsigned** integral types.

## Signed integral Types

A *signed type* uses its bytes to represent an equal number of positive and negative numbers. The following exercise will give you exposure to the signed integral types in C#.

### Step 1 - Use the MinValue and MaxValue properties for each signed integral type

To see the value ranges for the various data types, type or paste the following code into the .NET Editor:

```csharp-interactive
Console.WriteLine("Signed integral types:");

Console.WriteLine($"sbyte  : {sbyte.MinValue} to {sbyte.MaxValue}");
Console.WriteLine($"short  : {short.MinValue} to {short.MaxValue}");
Console.WriteLine($"int    : {int.MinValue} to {int.MaxValue}");
Console.WriteLine($"long   : {long.MinValue} to {long.MaxValue}");
```

### Step 2 - Run the code to inspect each data type's range of values

You should get the following output:

```output
Signed integral types:
sbyte  : -128 to 127
short  : -32768 to 32767
int    : -2147483648 to 2147483647
long   : -9223372036854775808 to 9223372036854775807
```

For most non-scientific applications, you'll likely only need to work with `int`. Most of the time, you won't need more than a positive to negative 2.14 billion whole numbers.

## Unsigned integral types

An *unsigned type* uses its bytes to represent only positive numbers. The remainder of the exercise introduces the unsigned integral types in C#.

### Step 3 - Use the MinValue and MaxValue properties for each unsigned integral type

Below the previous code passage, add the following code:

```csharp-interactive
Console.WriteLine("");
Console.WriteLine("Unsigned integral types:");

Console.WriteLine($"byte   : {byte.MinValue} to {byte.MaxValue}");
Console.WriteLine($"ushort : {ushort.MinValue} to {ushort.MaxValue}");
Console.WriteLine($"uint   : {uint.MinValue} to {uint.MaxValue}");
Console.WriteLine($"ulong  : {ulong.MinValue} to {ulong.MaxValue}");
```

### Step 4 - Run the code to inspect each data type's range of values

If you run the code, you'll get the following output:

```output
Signed integral types:
sbyte  : -128 to 127
short  : -32768 to 32767
int    : -2147483648 to 2147483647
long   : -9223372036854775808 to 9223372036854775807

Unsigned integral types:
byte   : 0 to 255
ushort : 0 to 65535
uint   : 0 to 4294967295
ulong  : 0 to 18446744073709551615
```

While a given data type can be used for any purpose, given the fact that the `byte` data type can represent a value from 0 to 255, it's obvious that this is intended to hold a value that represents a *byte* of data. Data stored in files or data transferred across the internet is often in a binary format. When working with data from these external sources, you'll need to receive data as an array of bytes, then convert them into strings. Many of the methods in the .NET Class Library that deal with encoding and decoding data require you handle byte arrays.

## Recap

- An integral type is a simple value data type that can hold whole numbers.
- There are signed and unsigned data types. Signed integral types use one bit to store whether the value is positive or negative.
- You can use the `MaxValue` and `MinValue` properties of numeric data types to evaluate whether a number can fit in a given data type.
