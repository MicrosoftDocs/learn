The `double` numeric type represents a double-precision floating point
number. Those terms may be new to you. A **floating point** number is
useful to represent non-integral numbers that may be very large or small
in magnitude. **Double-precision** means that these numbers are stored
using greater precision than **single-precision**. On modern computers,
it is more common to use double precision than single precision numbers.
Let's explore. Try the following code in the interactive window and see the result:

```csharp
double a = 5;
double b = 4;
double c = 2;
double d = (a  + b) / c;
Console.WriteLine(d);
```

Notice that the answer includes the decimal portion of the quotient. Try a slightly
more complicated expression with doubles:

```csharp
double a = 19;
double b = 23;
double c = 8;
double d = (a  + b) / c;
Console.WriteLine(d);
```

The range of a double value is much greater than integer values. Try the following
code in the interactive window:

```csharp
double max = double.MaxValue;
double min = double.MinValue;
Console.WriteLine($"The range of double is {min} to {max}");
```

These values are printed out in scientific notation. The number to
the left of the `E` is the significand. The number to the right is the exponent,
as a power of 10.

Just like decimal numbers in math, doubles in C# can have rounding errors. Try this code:

```csharp
double third = 1.0 / 3.0;
Console.WriteLine(third);
```

You know that `0.3` repeating is not exactly the same as `1/3`.

***Challenge***

Try other calculations with large numbers, small numbers, multiplication
and division using the `double` type.  Try more complicated calculations.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).