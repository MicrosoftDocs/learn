Most useful methods don't just do something, they produce a **result** the caller can use. That result is sent back with the `return` statement.

## Declaring a return type

A method's return type appears before its name, showing what kind of value it hands back. Use `return` to send that value out of the method. Once `return` runs, the method ends immediately.

```csharp
int Add(int a, int b)
{
    return a + b;
}

int result = Add(3, 4);
Console.WriteLine(result); // Output: 7
```

You can use the returned value directly in an expression.

```csharp
Console.WriteLine(Add(10, 5) * 2); // Output: 30
```

In this example, the `Add()` method returns the sum of its two parameters, and that value is used in the multiplication expression before it's printed.

## Void methods don't return a usable value

A method declared with `void` doesn't return anything you can capture. Trying to assign the result of a `void` call to a variable is a compile error, not just an empty value.

```csharp
void Add(int a, int b)
{
    Console.WriteLine(a + b); // Shows the result, but doesn't return it
}

int x = Add(3, 4); // Compile error: Add doesn't return a value
```

If you want to use the result of a method elsewhere in your program, give it a real return type instead of `void`.

## Returning multiple values with tuples

A method can return more than one value using a **tuple**, a lightweight grouping of values. Name each part so the caller can read the result clearly.

```csharp
(double x, double y) GetCoordinates()
{
    return (10.0, 20.0);
}

var (x, y) = GetCoordinates();
Console.WriteLine($"x: {x}, y: {y}"); // Output: x: 10, y: 20
```
