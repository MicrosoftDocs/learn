An **array** is a fixed-size, ordered collection of values that all share the same type. Arrays are one of the most fundamental data structures in C# because they store multiple related values under a single variable name.

## Creating an array

You can create an array using curly braces to list its initial values, or by specifying its size up front.

```csharp
string[] colors = { "red", "green", "blue" };
int[] scores = new int[4];
```

The first line creates an array of three strings. The second line creates an array that can hold four integers, each starting at the default value of 0.

## Accessing items by index

Each item in an array has a numbered position called an **index**, starting at 0.

```csharp
string[] colors = { "red", "green", "blue" };
Console.WriteLine(colors[0]); // Output: red
Console.WriteLine(colors[2]); // Output: blue
```

## The fixed size of an array

An array's size is set when you create it and can't change afterward. You can update the value at an existing index, but you can't add or remove items.

```csharp
string[] colors = { "red", "green", "blue" };
colors[0] = "purple"; // Replaces "red" with "purple"
Console.WriteLine(colors[0]); // Output: purple

Console.WriteLine(colors.Length); // Output: 3
```

If you need to store more or fewer items than an array's fixed size allows, you need to create a new array, or use a different collection type, like a `List<T>`.

> [!TIP]
> Choose plural, descriptive array names, like `scores` or `colors`, so it's clear at a glance that the variable holds multiple items rather than one.

## Iterating over an array

Arrays work naturally with `foreach` loops, which step through every item without you having to manage an index yourself.

```csharp
int[] scores = { 95, 82, 76, 91 };

foreach (int score in scores)
{
    Console.WriteLine(score);
}
```

Output:

```output
95
82
76
91
```
