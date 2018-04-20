That last sample showed you that integer division truncates the result.
You can get the **remainder** by using the **modulo** operator, the `%` character:

```csharp
int a = 7;
int b = 4;
int c = 3;
int d = (a  + b) / c;
int e = (a + b) % c;
Console.WriteLine($"quotient: {d}");
Console.WriteLine($"remainder: {e}");
```

The C# integer type differs from mathematical integers in one other
way: the `int` type has minimum and maximum limits. Run this code
in the interactive window to see those limits:

```csharp
int max = int.MaxValue;
int min = int.MinValue;
Console.WriteLine($"The range of integers is {min} to {max}");
```

If a calculation produces a value that exceeds those limits, you
have an **underflow** or **overflow** condition. The answer appears
to wrap from one limit to the other. Add these two lines to the interactive
window to see an example:

```csharp
int what = max + 3;
Console.WriteLine($"An example of overflow: {what}");
```

Notice that the answer is very close to the minimum (negative) integer. It's
the same as `min + 2`.
The addition operation **overflowed** the allowed values for integers.
The answer is a very large negative number because an overflow "wraps around"
from the largest possible integer value to the smallest.

There are other numeric types with different limits and precision that you
would use when the `int` type doesn't meet your needs. Let's explore those next.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).