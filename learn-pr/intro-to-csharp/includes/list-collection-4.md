You've been using the `string` type in lists so far. Let's make a <xref:System.Collections.Generic.List%601> using a different type. Let's build a set of numbers. Delete the code you wrote so far, and replace it with this:

```csharp
var fibonacciNumbers = new List<int> {1, 1};
```

That creates a list of integers, and sets the first two integers to the value 1. These are the first two values of a *Fibonacci Sequence*, a sequence of numbers. Each next Fibonacci number is found by taking the sum of the previous two numbers. Add this code:

```csharp
var previous = fibonacciNumbers[fibonacciNumbers.Count - 1];
var previous2 = fibonacciNumbers[fibonacciNumbers.Count - 2];

fibonacciNumbers.Add(previous + previous2);
foreach(var item in fibonacciNumbers)
    Console.WriteLine(item);
```

Press **Run** to see the results;

> [!NOTE]
> This online coding experience is in preview mode. If you encounter problems, please report them [on the dotnet/try repo](https://github.com/dotnet/try/issues).