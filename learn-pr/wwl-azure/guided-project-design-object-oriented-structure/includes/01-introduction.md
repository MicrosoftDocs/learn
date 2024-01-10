Exception handling is a fundamental and crucial aspect of programming. It's a simple concept that involves managing unexpected events that may occur during the execution of a program. These events can cause the program to stop functioning. By handling exceptions, the program can continue to operate or shut down gracefully, preventing abrupt termination.

Suppose you have an exception caused by something like invalid user input, a hardware malfunction, network failure, or programming error. How would you "handle" it? Exceptions are handled by creating an object known as an "exception object." An exception object contains information about the type of error that occurred and the location of the error in the code. Exceptions can also be explicitly "thrown" by developers, using the 'throw' keyword to indicate a specific error condition in their code.

C# has a built-in mechanism for handling exceptions that occur during program execution. This mechanism allows developers to catch and manage exceptions using a try-catch block. The try block contains the code that may cause an exception, while the catch block specifies how you handle an exception.

When an exception occurs, you can manage it by logging an error message, displaying a user-friendly message, or taking corrective action. If you don't catch the exception, the program may terminate. In this module, you'll implement error handling while building the Langton’s Ant code.

## Learning objectives

In this module, you'll practice how to:

- Create and exception class.
- Use a Try/Catch block.
- Throw an exception.
- Implement exception handling in your code.

## Prerequisites

- Installation of Visual Studio Code that's configured for C# application development, including C# Dev Kit.
- Experience with the VS Code editor.
- Ability to develop C# console applications that implement business logic using loops, if statements, properties, and methods.
- Experience with basic C# syntax rules.
