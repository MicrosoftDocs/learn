


C# developers are responsible for code debugging and exception handling in their applications. The C# language supports exception handling patters such as the `try-catch` and `try-catch-finally` patterns. Visual Studio Code the supports code debugging in most software development languages through the use of Extensions. You can find debugger extensions in the Visual Studio Code Marketplace.

Suppose you're part of a team that's developing retail-support applications. The team is working on a cash register application that manages retail transactions. You're developing the `MakeChange` method that manages the cash till and calculates the amount of change returned to the customer. The `MakeChange` method tracks the number of bills of each denomination (1, 5, 10, and 20) that are available in the till. Exceptions are throw when the cash received doesn't cover the cost of the item, and when the till isn't able to make change using the available bills. Any exception that's thrown inside `MakeChange` should be caught and processed by the that's further down the call stack.

This module guides you through a code review and debugging process, as well as the process for adding exception handling to the application.

By the end of this module, you'll be able to debug a C# application using the Visual Studio Code debugger, implement a `try-catch` pattern, and create and throw exceptions that're caught at a lower level of the call stack.

> [!NOTE]
> This is a guided project module where you’ll complete an end-to-end project by following step-by-step instructions.

## Learning Objectives

In this module, you'll practice how to:

- Use the Visual Studio Code debugger tools to identify and correct an issue in your code logic.
- Implement exception handling in a C# console application using the `try-catch` pattern.
- Create and throw exceptions with customized properties.
- Catch exceptions at a lower level in the call stack.

## Prerequisites:

- An installation of Visual Studio Code that's configured for C# application development.
- Ability to develop C# console applications that implement business logic using iteration statements, selection statements, and custom methods.
- Experience using the Visual Studio Code debugging tools for C#.
- Experience implementing `try-catch` exception handing and throwing exceptions in C# console applications.
