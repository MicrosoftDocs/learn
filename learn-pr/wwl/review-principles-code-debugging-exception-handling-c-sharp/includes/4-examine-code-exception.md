


Earlier in this module you learned that runtime errors in C# are called exceptions and that you need to "catch" them before they crash your application. Really? Catching exceptions before they can crash your application sounds more like a video game than writing an application. So what exactly does it mean to "catch" an exception? To answer that question, you need to start by taking a closer look at what an exception is.

## What are exceptions?

Here is a more formal definition that describes what an exception is and how an exception is used in a C# application:

*In C#, errors in the program at runtime are propagated through the program by using a mechanism called exceptions. Exceptions are thrown by code that encounters an error and caught by code that can correct the error. Exceptions can be thrown by the .NET runtime or by code in a program. Exceptions are represented by classes derived from Exception. Each class identifies the type of exception and contains properties that have details about the exception.*

> [!IMPORTANT] This training does not expect you to have learned about classes, so don't worry if that definition is a bit confusing.

The source documentation that contains this definition includes some additional details, but this portion provides the details that you need in order to understand what exceptions are and how you can use them in your applications.

Don't worry, you don't need to subject yourself to a deep study of classes (and everything that goes along with classes) in order for you to use exceptions in your code. In simple terms, you can think of an exception as a variable that has some extra capabilities. Any of the extra capabilities that you need to understand will be explained as you encounter them.

So what can you do with exceptions? Here is a list:

- You can access the contents of an exception.
- You can pass an exception as a parameter

## What does it mean to "throw" and "catch" an exception?

Evaluating the definition of what an exception is and how an exception is used in a C# application can help to explain "throw" and "catch".
  
The second sentence of the definition says "Exceptions are thrown by code that encounters an error and caught by code that can correct the error". The first part of this sentence is telling you that exceptions are created by the .NET runtime when an error occurs in your code. The second part of the sentence is telling you that you can write code to catch an exception that's been thrown. In addition, the code that catches the exception can be used to take some kind of corrective action, hopefully mitigating the situation caused by the code that resulted in the error. In other words, you can write code that protects your application when an error occurs.

After evaluating that second sentence of the definition, you know the following:

- an exception gets created at runtime when your code produces an error.
- the exception can be treated like a some kind variable that has some extra capabilities.
- you can write code that accesses the exception and completes some action that corrects for the error.

The remaining portion of the definition tells you that if the .NET runtime detects an error, it will generate the exception, and that the exception contains information about the type of error that occurred. In other words, your code that catches the exception can access the information that it needs in order to correct the error.

## Recap

Here are a few important things to remember from this unit:

- Exceptions are used in C# to propagate errors at runtime, and are represented by classes derived from `System.Exception`.
- Exceptions are thrown by code that encounters an error and caught by code that can correct the error.
- When an exception is caught, code can access its contents and take corrective action to mitigate the error.
- The .NET runtime generates exceptions when it detects an error and the exception contains information about the type of error that occurred.