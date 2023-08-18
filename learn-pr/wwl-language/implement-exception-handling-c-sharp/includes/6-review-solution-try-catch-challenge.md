




The following code is one possible solution for the challenge from the previous unit:

```csharp
try
{
    Process1();
}
catch
{
    Console.WriteLine("An exception has occurred");
}

Console.WriteLine("Exit program");

static void Process1()
{
    try
    {
        WriteMessage();
    }
    catch
    {
        Console.WriteLine("Exception caught in Process1");
    }

}

static void WriteMessage()
{
    double float1 = 3000.0;
    double float2 = 0.0;
    int number1 = 3000;
    int number2 = 0;

    Console.WriteLine(float1 / float2);
    Console.WriteLine(number1 / number2);
}
```

In this solution, the `Process1` method has been updated to use the `try-catch` pattern. The `WriteMessage` method is called in the `try` code block, which enables `Process1` to catch the exception before it's caught by the `catch` clause in the top-level statements.

Running this application generates the required output:

```output
∞
Exception caught in Process1
Exit program
```

Notice that since the exception is caught inside `Process1`, the `catch` code block in the top-level statements is not executed. The benefits gained by catching exceptions at different levels in the call stack becomes more evident when specific exception types are being caught. You'll examine exception types in the next unit.

If you succeeded in this challenge, congratulations! Continue on to the next unit.

> [!IMPORTANT]
> If you had trouble completing this challenge, maybe you should review the previous units before you continue on.
