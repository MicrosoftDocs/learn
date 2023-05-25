




The following code is one possible solution for the challenge from the previous unit:

```csharp
checked
{
    try
    {
        int num1 = int.MaxValue;
        int num2 = int.MaxValue;
        int result = num1 + num2;
        Console.WriteLine("Result: " + result);
    }
    catch (OverflowException ex)
    {
        Console.WriteLine("Error: The number is too large to be represented as an integer. " + ex.Message);
    }
}

try
{
    string? str = null;
    int length = str.Length;
    Console.WriteLine("String Length: " + length);
}
catch (NullReferenceException ex)
{
    Console.WriteLine("Error: The reference is null. " + ex.Message);
}

try
{
    int[] numbers = new int[5];
    numbers[5] = 10;
    Console.WriteLine("Number at index 5: " + numbers[5]);
}
catch (IndexOutOfRangeException ex)
{
    Console.WriteLine("Error: Index out of range. " + ex.Message);
}

try
{
    int num3 = 10;
    int num4 = 0;
    int result2 = num3 / num4;
    Console.WriteLine("Result: " + result2);
}
catch (DivideByZeroException ex)
{
    Console.WriteLine("Error: Cannot divide by zero. " + ex.Message);
}

Console.WriteLine("Exiting program.");
```

When you run this application, it will print the required messages to the console as output:

```output
Error: The number is too large to be represented as an integer. Arithmetic operation resulted in an overflow.
Error: The reference is null. Object reference not set to an instance of an object.
Error: Index out of range. Index was outside the bounds of the array.
Error: Cannot divide by zero. Attempted to divide by zero.
Exiting program.
```

This code is merely "*one possible solution*" because there are many ways to update the exception handling logic. As long as you got the right results per the rules in the challenge, then you did great!

If you succeeded, congratulations! Continue on to the knowledge check in the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
