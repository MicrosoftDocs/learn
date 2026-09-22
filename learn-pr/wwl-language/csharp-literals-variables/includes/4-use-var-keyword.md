
So far, you've explicitly declared the data type of each variable. But C# has a shorthand: the `var` keyword, which lets the compiler figure out the type for you.

## Using the var keyword

When you assign a value to a `var` variable, C# automatically determines its data type based on the assigned value:

```csharp
var name = "Alice";           // C# sees a string, so name is string
var age = 25;                 // C# sees a whole number, so age is int
var price = 19.99;            // C# sees a decimal, so price is double
```

This is equivalent to writing:

```csharp
string name = "Alice";
int age = 25;
double price = 19.99;
```

## When to use var

Use `var` when:
- The type is obvious from the value (like `var count = 5;` clearly creates an int)
- It makes your code easier to read
- You're working with complex types

Use explicit types when:
- You want to be extra clear about what type something is
- You're just starting out (it helps you learn the data types)

## Important: var is still typed

Don't think of `var` as "any type." Once C# determines the type, that variable is locked to that type:

```csharp
var count = 10;      // count is an int
count = "five";      // ERROR! Can't assign a string to an int variable
```

## Try it yourself

Experiment with `var` in the [C# Code Editor](https://microsoftlearning.github.io/c-sharp-minor):

```csharp
var message = "Hello!";
var favorite = 42;
var average = 87.5;

Console.WriteLine(message);
Console.WriteLine(favorite);
Console.WriteLine(average);
```

The `var` keyword is a convenience feature that saves typing, but it's optional. You can always use explicit types if you prefer.
