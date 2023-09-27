




Earlier in this module you learned that runtime errors in C# are called exceptions and that you need to "catch" them before they crash your application. Really? Catching exceptions before they can crash your application sounds more like a video game than writing an application. So what exactly does it mean to "catch" an exception? To answer that question, you need to start by taking a closer look at what an exception is.

## What are exceptions?

Here is a more formal definition that describes what an exception is and how an exception is used in a C# application:

*In C#, errors in the program at runtime are propagated through the program by using a mechanism called exceptions. Exceptions are thrown by code that encounters an error and caught by code that can correct the error. Exceptions can be thrown by the .NET runtime or by code in a program. Exceptions are represented by classes derived from Exception. Each class identifies the type of exception and contains properties that have details about the exception.*

> [!IMPORTANT] 
> This training does not require a deep understanding of .NET classes. Don't worry if this definition is a bit confusing. You can use exceptions in your code without a deep understanding of classes.

Microsoft's documentation on exceptions goes into great detail. However, this definition provides the information that you need right now. Specifically, you need to understand two things:

- You need to understand what exceptions are.
- You need to understand how to use exceptions in your applications.

You can think of an exception as a variable that has extra capabilities. You can do the same type of things with exceptions that you do with variables, for example:

- You can create different types of exceptions.
- You can access the contents of an exception.

## What does it mean to "throw" and "catch" an exception?

The terms "throw" and "catch" can be explained by evaluating the definition of an exception.

The second sentence of the definition says "Exceptions are thrown by code that encounters an error and caught by code that can correct the error". The first part of this sentence tells you that exceptions are created by the .NET runtime when an error occurs in your code. The second part of the sentence tells you that you can write code to catch an exception that's been thrown. In addition, the code that catches the exception can be used to complete a corrective action, hopefully mitigating the situation caused by the code that resulted in the error. In other words, you can write code that protects your application when an error occurs.

After evaluating that second sentence of the definition, you know the following:

- An exception gets created at runtime when your code produces an error.
- The exception can be treated like a variable that has some extra capabilities.
- You can write code that accesses the exception and takes corrective action.

The remaining portion of the definition tells you that if the .NET runtime detects an error, it generates the exception. The exception that's generated contains information about the error that occurred. Your code can catch an exception and correct the issue using the information stored in the exception.

## Recap

Here are a few important things to remember from this unit:

- Exceptions are used in C# to propagate errors at runtime, and are represented by classes derived from the `Exception` class.
- Exceptions are thrown by code that encounters an error and caught by code that can correct the error.
- When an exception is caught, code can access its contents and take corrective action to mitigate the error.
- The .NET runtime generates exceptions when it detects an error and the exception contains information about the type of error that occurred.