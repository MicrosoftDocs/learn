**Scope** is the region of your code where a variable exists and can be used. Understanding scope helps you write methods that don't accidentally interfere with each other, and helps you avoid a whole class of confusing bugs.

## Local variables

A variable created inside a method is a **local variable**. It only exists while the method is running, and it can't be seen from outside the method.

```csharp
int CalculateTotal(int price, int tax)
{
    int total = price + tax; // total is local to this method
    return total;
}

CalculateTotal(10, 2);
Console.WriteLine(total); // Compile error: total doesn't exist here
```

Each call to a method gets its own set of local variables, so methods don't accidentally overwrite each other's data.

## Block scope

Variables declared inside a block, like an `if` statement or a loop, only exist within that block.

```csharp
if (true)
{
    int message = 42;
    Console.WriteLine(message); // OK: message exists in this block
}

Console.WriteLine(message); // Compile error: message doesn't exist here
```

> [!NOTE]
> C# doesn't have a direct equivalent to Python's global variables inside a single script. Sharing state between methods in C# typically means storing it in a class field, a topic for a later module. For now, prefer passing values as parameters and getting results back with return values.

## Why scope matters

-   Local variables keep methods **independent**. A variable in one method can't interfere with another.
-   Block scope keeps temporary values from leaking into the rest of your method.
-   If several methods need to share a value, pass it as a parameter and return the updated result, rather than relying on a variable declared somewhere else.
