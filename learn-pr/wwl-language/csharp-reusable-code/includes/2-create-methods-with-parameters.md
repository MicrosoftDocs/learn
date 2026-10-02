A **method** is a named, reusable block of code that runs when you call it. Methods let you write logic once and use it as many times as you need, with different inputs each time.

## Defining a method

You define a method with a return type, a name, and parentheses. Use `void` when the method doesn't return a value. The braces beneath make up the method body.

```csharp
void Greet()
{
    Console.WriteLine("Hello, world!");
}

Greet(); // Output: Hello, world!
```

Method names use PascalCase by convention, and should describe what the method does.

## Adding parameters

**Parameters** are named inputs listed inside the parentheses, each with its own type. They let you pass information into the method each time you call it.

```csharp
void Greet(string name)
{
    Console.WriteLine($"Hello, {name}!");
}

Greet("Alex"); // Output: Hello, Alex!
Greet("Sam");  // Output: Hello, Sam!
```

You can define multiple parameters by separating them with commas.

```csharp
void Greet(string name, string greeting)
{
    Console.WriteLine($"{greeting}, {name}!");
}

Greet("Alex", "Hi"); // Output: Hi, Alex!
```

## Optional parameters with default values

You can give a parameter a **default value** by assigning it with `=` in the method definition. If the caller doesn't provide that argument, the default is used.

```csharp
void Greet(string name, string greeting = "Hello")
{
    Console.WriteLine($"{greeting}, {name}!");
}

Greet("Alex");             // Output: Hello, Alex!
Greet("Alex", "Welcome");  // Output: Welcome, Alex!
```

## Named arguments

You can also pass arguments by name, which makes your code easier to read, especially when a method has several parameters.

```csharp
Greet(name: "Alex", greeting: "Welcome");
```

Named arguments can appear in any order, but any positional arguments must still come first.
