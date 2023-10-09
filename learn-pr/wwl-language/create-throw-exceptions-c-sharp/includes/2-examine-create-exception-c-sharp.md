.NET provides a hierarchy of exception classes that derive from the `System.Exception` base class. C# applications can create and throw exceptions of any exception type. Developers can also customize exception objects with application specific information by assigning property values.

> [!NOTE]
> This module focuses on creating and throwing exceptions, and customizing exception objects. Creating custom exception classes is outside the scope of this module.

## Create an exception object

Creating and throwing exceptions from within your code is an important aspect of C# programming. The ability to generate an exception in response to a specific condition, issue, or error helps you to ensure the stability of your application.

The exception type that you create depends on the coding issue, and should match the intended purpose of the exception as closely as possible.

For example, suppose you're creating a method named `GraphData` that performs data analysis. The method receives a data array as an input parameter. The method is expecting the input data to be in a particular range. If the method receives data that's outside the expected range, it creates and throws an exception of type `ArgumentException`. The exception will be handled somewhere down the call stack by the code that's responsible for providing the data.

Here are some common exception types that you might use when creating an exception:

- `ArgumentException` or `ArgumentNullException`: Use these exception types when a method or constructor is called with an invalid argument value or null reference.
- `InvalidOperationException`: Use this exception type when the operating conditions of a method don't support the successful completion of a particular method call.
- `NotSupportedException`: Use this exception type when an operation or feature is not supported.
- `IOException`: Use this exception type when an input/output operation fails.
- `FormatException`: Use this exception type when the format of a string or data is incorrect.

The `new` keyword is used to create an instance of an exception. For example, you can create an instance of the `ArgumentException` exception type as follows:

```csharp
ArgumentException invalidArgumentException = new ArgumentException();
```

## Configure and throw customized exceptions

The process for throwing an exception object involves creating an instance of an exception-derived class, optionally configuring properties of the exception, and then throwing the object by using the `throw` keyword.

It's often helpful to customize an exception with contextual information before it's thrown. You can provide application specific information within an exception object by configuring its properties. For example, the following code creates an exception object named `invalidArgumentException` with a custom `Message` property, and then throws the exception:

```csharp
ArgumentException invalidArgumentException = new ArgumentException("ArgumentException: The 'GraphData' method received data outside the expected range.");
throw invalidArgumentException;
```

> [!NOTE]
> The `Message` property of an exception is readonly. Therefore, a custom `Message` property must be set when instantiating the object.

When customizing an exception object, it's important to provide clear error messages that describe the problem and how to resolve it. You can also include additional information such as stack traces and error codes to help users correct the issue.

An exception object can also be created directly within a `throw` statement. For example:

```csharp
throw new FormatException("FormatException: Calculations in process XYZ have been cancelled due to invalid data format.");
```

Some considerations to keep in mind when throwing an exception include:

- The `Message` property should explain the reason for the exception. However, information that's sensitive, or that represents a security concern shouldn't be put in the message text.
- The `StackTrace` property is often used to track the origin of the exception. This string property contains the name of the methods on the current call stack, together with the file name and line number in each method that's associated with the exception. A `StackTrace` object is created automatically by the common language runtime (CLR) from the point of the `throw` statement. Exceptions must be thrown from the point where the stack trace should begin.

## When to throw an exception

Methods should throw an exception whenever they can't complete their intended purpose. The exception thrown should be based on the most specific exception available that fits the error conditions.

Consider a scenario where a developer is working on an application that implements a business process. The business process is dependent on user input. If the input doesn't match the expected data type, the method that implements the business process creates and throws an exception. The exception object can be configured with application specific information in the property values. The following code sample demonstrates the scenario:

```csharp
string[][] userEnteredValues = new string[][]
{
        new string[] { "1", "two", "3"},
        new string[] { "0", "1", "2"}
};

foreach (string[] userEntries in userEnteredValues)
{
    try
    {
        BusinessProcess1(userEntries);
    }
    catch (Exception ex)
    {
        if (ex.StackTrace.Contains("BusinessProcess1") && (ex is FormatException))
        {
            Console.WriteLine(ex.Message);
        }
    }
}

static void BusinessProcess1(String[] userEntries)
{
    int valueEntered;

    foreach (string userValue in userEntries)
    {
        try
        {
            valueEntered = int.Parse(userValue);

            // completes required calculations based on userValue
            // ...
        }
        catch (FormatException)
        {
            FormatException invalidFormatException = new FormatException("FormatException: User input values in 'BusinessProcess1' must be valid integers");
            throw invalidFormatException;
        }
    }
}
```

In this code sample, the top-level statements call the `BusinessProcess1` method, passing in a string array that contains user entered values. The `BusinessProcess1` method expects user input values that can be converted to an integer. When the method encounters data with an invalid format, it creates an instance of the `FormatException` exception type using a customized `Message` property. The method then throws the exception. The exception is caught in the top-level statements as an object named `ex`. Properties of the `ex` object are examined before displaying the exception message to the user. First, the code examines the `StackTrace` property to see if it contains "BusinessProcess1". Second, the exception object `ex` is verified to be of type `FormatException`.

## Re-throwing exceptions

In addition to throwing a new exception, `throw` can be used re-throw an exception from inside a `catch` code block. In this case, `throw` does not take an exception operand.

```csharp
catch (Exception ex)
{
    // handle or partially handle the exception
    // ...

    // re-throw the original exception object for further handling down the call stack
    throw;
}
```

When you re-throw an exception, the original exception object is used, so you don't lose any information about the exception. If you want to create a new exception object that wraps the original exception, you can pass the original exception as an argument to the constructor of a new exception object. For example:

```csharp
catch (Exception ex)
{
    // handle or partially handle the exception
    // ...

    // create a new exception object that wraps the original exception
    throw new ApplicationException("An error occurred", ex);
}
```

For the "BusinessProcess1" application scenario, consider the following updates:

- The `BusinessProcess1` method has been updated to include additional details. `BusinessProcess1` now encounters two issues and must generate exceptions for each issue.
- The top-level statements have been updated. Top-level statements now call the `OperatingProcedure1` method. `OperatingProcedure1` calls `BusinessProcess1` within a `try` code block.
- The `OperatingProcedure1` method is able to handle one of the exception types and partially handle the other. Once the partially handled exception is processed, `OperatingProcedure1` must re-throw the original exception.

The following code sample demonstrates the updated scenario:

```csharp
try
{
    OperatingProcedure1();
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
    Console.WriteLine("Exiting application.");
}

static void OperatingProcedure1()
{
    string[][] userEnteredValues = new string[][]
    {
        new string[] { "1", "two", "3"},
        new string[] { "0", "1", "2"}
    };

    foreach(string[] userEntries in userEnteredValues)
    {
        try
        {
            BusinessProcess1(userEntries);
        }
        catch (Exception ex)
        {
            if (ex.StackTrace.Contains("BusinessProcess1"))
            {
                if (ex is FormatException)
                {
                    Console.WriteLine(ex.Message);
                    Console.WriteLine("Corrective action taken in OperatingProcedure1");
                }
                else if (ex is DivideByZeroException)
                {
                    Console.WriteLine(ex.Message);
                    Console.WriteLine("Partial correction in OperatingProcedure1 - further action required");

                    // re-throw the original exception
                    throw;
                }
                else
                {
                    // create a new exception object that wraps the original exception
                    throw new ApplicationException("An error occurred - ", ex);
                }
            }
        }

    }
}

static void BusinessProcess1(String[] userEntries)
{
    int valueEntered;

    foreach (string userValue in userEntries)
    {
        try
        {
            valueEntered = int.Parse(userValue);

            checked
            {
                int calculatedValue = 4 / valueEntered;
            }
        }
        catch (FormatException)
        {
            FormatException invalidFormatException = new FormatException("FormatException: User input values in 'BusinessProcess1' must be valid integers");
            throw invalidFormatException;
        }
        catch (DivideByZeroException)
        {
            DivideByZeroException unexpectedDivideByZeroException = new DivideByZeroException("DivideByZeroException: Calculation in 'BusinessProcess1' encountered an unexpected divide by zero");
            throw unexpectedDivideByZeroException;

        }
    }
}
```

The updated sample code produces the following output:

```output
FormatException: User input values in 'BusinessProcess1' must be valid integers
Corrective action taken in OperatingProcedure1
DivideByZeroException: Calculation in 'BusinessProcess1' encountered an unexpected divide by zero
Partial correction in OperatingProcedure1 - further action required
DivideByZeroException: Calculation in 'BusinessProcess1' encountered an unexpected divide by zero
Exiting application.
```

## Things to avoid when throwing exceptions

The following list identifies practices to avoid when throwing exceptions:

- Don't use exceptions to change the flow of a program as part of ordinary execution. Use exceptions to report and handle error conditions.
- Exceptions shouldn't be returned as a return value or parameter instead of being thrown.
- Don't throw `System.Exception`, `System.SystemException`, `System.NullReferenceException`, or `System.IndexOutOfRangeException` intentionally from your own source code.
- Don't create exceptions that can be thrown in debug mode but not release mode. To identify runtime errors during the development phase, use `Debug.Assert` instead.

> [!NOTE]
> The `Debug.Assert` method is a tool for catching logic errors during development. By default, the `Debug.Assert` method works only in debug builds. You can use `Debug.Assert` in debug sessions to check for a condition that should never occur. The method takes two parameters: a Boolean condition to check, and an optional string message to display if the condition is `false`. `Debug.Assert` should not be used in place of throwing an exception, which is a way to handle exceptional situations during normal execution of your code. You should use `Debug.Assert` to catch errors that should never occur, and use exceptions to handle errors that could occur during normal execution of your program.

## Recap

Here are a few important things to remember from this unit:

- When creating and throwing an exception, the exception type must match the intended purpose of the exception as closely as possible.
- To `throw` an exception, you create an instance of an exception-derived class, configure its properties, and then use the `throw` keyword.
- When creating an exception object, it's important to provide clear error messages and additional information to help users correct the issue.