You've seen the basic numeric types in C#: integers and doubles.  There is one
other type to learn: the `decimal` type. The `decimal` type has a smaller
range but greater precision than `double`. The term **fixed point** means
that the decimal point (or binary point) doesn't move. Let's take a look:

```csharp
decimal min = decimal.MinValue;
decimal max = decimal.MaxValue;
Console.WriteLine($"The range of the decimal type is {min} to {max}");
```

Notice that the range is smaller than the `double` type. You can see the greater
precision with the decimal type by trying the following code:

```csharp
double a = 1.0;
double b = 3.0;
Console.WriteLine(a / b);

decimal c = 1.0M;
decimal d = 3.0M;
Console.WriteLine(c / d);
```

The `M` suffix on the numbers is how you indicate that a constant should use the
`decimal` type.

Notice that the math using the decimal type has more digits to the right
of the decimal point.

***Challenge***

Now that you've seen the different numeric types, write code that calculates
the area of a circle whose radius is 2.50 centimeters. Remember that the area of a circle
is the radius squared multiplied by PI. One hint: .NET contains a constant
for PI, <xref:System.Math.PI?displayProperty=nameWithType> that you can use for that value.

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).

You should get an answer between 19 and 20.