




Earlier in this module, you learned that the exception objects caught by your C# application are instances of an exception class. Generally speaking, your code will `catch` one of the following:

- An exception object that's an instance of the `System.Exception` base class.
- An exception object that's an instance of an exception type that inherits from the base class. For example, an instance of the `InvalidCastException` class.

## Examine exception properties

`System.Exception` is the base class that all derived exception types inherit from. Each exception type inherits from the base class through a specific class hierarchy. For example, the class hierarchy for the `InvalidCastException` is as follows:

```output
Object
    Exception
        SystemException
            InvalidCastException
```

Most of the exception classes that inherit from `Exception` don't add any additional functionality; they simply inherit from `Exception`. Therefore, examining the properties of the `Exception` class enables you to understand most exceptions, and how you might use an exception in your code.

Here are the properties of the `Exception` class:

- **Data**: The `Data` property holds arbitrary data in key-value pairs.
- **HelpLink**: The `HelpLink` property can be used to hold a URL (or URN) to a help file that provides extensive information about the cause of an exception.
- **HResult**: The `HResult` property can be used to access to a coded numerical value that's assigned to a specific exception.
- **InnerException**: The `InnerException` property can be used to create and preserve a series of exceptions during exception handling.
- **Message**: The `Message` property provides details about the cause of an exception.
- **Source**: The `Source` property can be used to access the name of the application or the object that causes the error.
- **StackTrace**: The `StackTrace` property contains a stack trace that can be used to determine where an error occurred.
- **TargetSite**: The `TargetSite` property can be used to get the method that throws the current exception.

It's okay if you're feeling a bit overwhelmed by this examination of exception properties, base classes, and inheritance. Don't worry, catching exceptions in your code and accessing an exception's properties are easier than explaining how exceptions and exception properties work.

> [!NOTE]
> In this module, you'll focus on using an exception's message property to report the exception in your application's user interface.

## Access the properties of an exception object

Now that you understand exception objects and their properties, it's time to start coding.

1. Update your Program.cs file as follows:

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

1. Take a minute to review the code.

    This is the same code that you saw in the previous unit (the solution code for the challenge activity). You know that an exception is thrown during the `WriteMessage` method. You also know that the exception is caught in the `Process1` method. You'll be using this code to examine exception objects and specific exception types.

1. Update the `Process1` method as follows:

    ```csharp
    static void Process1()
    {
        try
        {
            WriteMessage();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Exception caught in Process1: {ex.Message}");
        }
    }
    ```

1. Take a minute to examine your updates.

    Notice that your updated `catch` clause is catching an instance of the `Exception` class in an object named `ex`. Also notice that your `Console.WriteLine()` method is using `ex` to access the object's `Message` property and display the error message to the console.

    Although the `catch` clause can be used without arguments, that approach is not recommended. If you don't specify an argument, all exception types are caught and you can't decern between them.

    In general, you should only catch the exceptions that your code knows how to recover from. Therefore, your `catch` clause should specify an object argument that's derived from `System.Exception`. The exception type should be as specific as possible. This helps to avoid catching exceptions that your exception handler isn't able to resolve. You'll update your code to catch a specific exception type later in this exercise.

1. On the **File** menu, select **Save**.

1. Set breakpoint on the following code line:

    ```csharp
    Console.WriteLine($"Exception caught in Process1: {ex.Message}");
    ```

1. On the **Run** menu, select **Start Debugging**

    Code execution should pause at the breakpoint.

1. Hover the mouse cursor over `ex`.

    Notice that IntelliSense displays the same exception properties that you examined earlier.

1. Take a minute to examine the information describing the exception object `ex`.

    Notice that the exception is a `System.DivideByZeroException` exception type and that the `Message` property is set to `Attempted to divide by zero.`.

    Notice that the `StackTrace` property reports the method and line number where the error occurred, along with the sequence of method calls (and line numbers) that led to the error.

1. On the **Debug toolbar**, select **Continue**.

1. Take a minute to examine the console output.

    Notice that the exception's `Message` property is included in the output generated by your application:

    ```output
    ∞
    Exception caught in Process1: Attempted to divide by zero.
    Exit program
    ```

## Catch a specific exception type

Now that you know the type of exception to catch, you can update your `catch` clause to handle that specific exception type.

1. Update the `Process1` method as follows:

    ```csharp
    static void Process1()
    {
        try
        {
            WriteMessage();
        }
        catch (DivideByZeroException ex)
        {
            Console.WriteLine($"Exception caught in Process1: {ex.Message}");
        }
    }
    ```

1. Save your code, and then start a debug session.

1. Notice that your updated application reports the same messages to the console.

    Although the reported messages are the same, there is an important difference. Your `Process1` method will only catch exceptions of the specific type that it's prepared to handle.

1. To generate a different exception type, update the `WriteMessage` method as follows:

    ```csharp
    static void WriteMessage()
    {
        double float1 = 3000.0;
        double float2 = 0.0;
        int number1 = 3000;
        int number2 = 0;
        byte smallNumber;
    
        Console.WriteLine(float1 / float2);
        // Console.WriteLine(number1 / number2);
        checked
        {
            smallNumber = (byte)number1;
        }
    }
    ```

1. Notice the use of the `checked` statement.

    When performing integral type calculations that assign the value of one integral type to another integral type, the result depends on the overflow-checking context. In a `checked` context, the conversion succeeds if the source value is within the range of the destination type. Otherwise, an `OverflowException` is thrown. In an unchecked context, the conversion always succeeds, and proceeds as follows:

    - If the source type is larger than the destination type, then the source value is truncated by discarding its "extra" most significant bits. The result is then treated as a value of the destination type.

    - If the source type is smaller than the destination type, then the source value is either sign-extended or zero-extended so that it's of the same size as the destination type. Sign-extension is used if the source type is signed; zero-extension is used if the source type is unsigned. The result is then treated as a value of the destination type.

    - If the source type is the same size as the destination type, then the source value is treated as a value of the destination type.

    > [!NOTE]
    > Integral type calculations that are not inside a `checked` code block are treated as if they are inside an `unchecked` code block.

1. Save your code, and then start a debug session.

1. Notice that a new exception type is caught by the `catch` clause in the top-level statements rather than inside the `Process1` method.

    Your application prints the following messages to the console:

    ```output
    ∞
    An exception has occurred
    Exit program
    ```

    > [!NOTE]
    > The `catch` block in `Process1` is not executed. This is the behavior that you wanted. Only catch the exceptions that your code is prepared to handle.

## Catch multiple exceptions in a code block

At this point, you may be wondering what happens when multiple exceptions occur in a single code block. Will your code `catch` each exception as they occur?

1. Update the `WriteMessage` method as follows:

    ```csharp
    static void WriteMessage()
    {
        double float1 = 3000.0;
        double float2 = 0.0;
        int number1 = 3000;
        int number2 = 0;
        byte smallNumber;
    
        Console.WriteLine(float1 / float2);
        Console.WriteLine(number1 / number2);
        checked
        {
            smallNumber = (byte)number1;
        }
    }
    ```

1. Set breakpoint inside the `WriteMessage()` method on the following code line:

    ```csharp
    Console.WriteLine(float1 / float2);
    ```

1. Save your code, and then start a debug session.

1. Step through your code one line at a time, and notice what happens after your code handles the first exception.

    When the first exception occurs, control is passed to the first `catch` clause that can handle the exception. The code that would generate the second exception is never reached. This means that some of your code is never executed. This could lead to serious issues.

1. Take a minute to consider how you could manage multiple exceptions, and when/why you might not want your code to manage multiple exceptions.

    You learned earlier in this module that exceptions should be caught as close to where they occur as possible. With this in mind, you may choose to update the `WriteMessage` method to catch exceptions using its own `try-catch`. For example:

    ```csharp
    static void WriteMessage()
    {
        double float1 = 3000.0;
        double float2 = 0.0;
        int number1 = 3000;
        int number2 = 0;
        byte smallNumber;
    
        try
        {
            Console.WriteLine(float1 / float2);
            Console.WriteLine(number1 / number2);
        }
        catch (DivideByZeroException ex)
        {
            Console.WriteLine($"Exception caught in WriteMessage: {ex.Message}");
        }
        checked
        {
            smallNumber = (byte)number1;
        }
    }
    ```

    You could also wrap the code that causes the `OverflowException` in a separate `try-catch` within the `WriteMessage()` method.
  
1. Under what conditions would it be undesirable to catch subsequent exceptions?

    Consider the case when your method (or code block) is completing a two part process. Assume that the second part of the process is dependent on the first part completing. If the first part of the process is unable to complete successfully, there's no point in continuing on to the second part of the process. In this case, it's often better to present the user with a message explaining the error condition without attempting the remaining portion or portions of the larger process.

## Catch separate exception types in a code block

There are times when variations in your data may cause different types of exceptions.

1. Clear your breakpoints, and then replace the contents of your Program.cs file with the following code:

    ```csharp
    // inputValues is used to store numeric values entered by a user
    string[] inputValues = new string[]{"three", "9999999999", "0", "2" };
    
    foreach (string inputValue in inputValues)
    {
        int numValue = 0;
        try
        {
            numValue = int.Parse(inputValue);
        }
        catch (FormatException)
        {
            Console.WriteLine("Invalid readResult. Please enter a valid number.");
        }
        catch (OverflowException)
        {
            Console.WriteLine("The number you entered is too large or too small.");
        }
        catch(Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
    }
    ```

1. Take a minute to review this code.

    First, the code creates a string array named `inputValues`. The data in the array is intended to represent the input values entered by a user who was instructed to enter numeric values. Depending on the value entered, different exception types may occur.

    Notice that the code uses the `int.Parse` method to convert the string "input" values to integers. The `int.Parse` code is placed inside a `try` code block.

1. Set a breakpoint on the following code line:

    ```csharp
    int numValue = 0;
    ```

1. Save your code, and then start a debug session.

1. Step through the code one line at a time, and notice that different exception types are caught.

## Recap

Here are a few important things to remember from this unit:

- The `catch` clause should be configured to catch a specific exception type. For example, the `DivideByZeroException` exception type.
- The properties of an exception object can be accessed within the `catch` block. For example, you can use the `Message` property to inform the application user of an issue.
- You can specify two or more `catch` clauses when you need to catch more than one exception type.
