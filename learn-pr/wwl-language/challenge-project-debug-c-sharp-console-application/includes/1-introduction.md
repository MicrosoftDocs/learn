



Visual Studio Code provides great code debugging tools for C# developers. You can find debugger extensions for C# and other programming languages in the Visual Studio Code Marketplace.

Suppose you're part of a team that's working on a cash register application. You're developing a `MakeChange` method that manages the money till and calculates the amount of change returned to the customer. The `MakeChange` method tracks the number of bills of each denomination (1, 5, 10, and 20) that are available in the till. Exceptions are thrown when the cash received doesn't cover the cost of the item, and when the till isn't able to make change using the available bills. The `MakeChange` method passed your initial code verification tests, but a larger data sample exposed logic errors that need to be isolated and fixed before the code can be released.

In this module, you complete the following tasks:

- Run the cash register application and review the generated output to identify a logic issue.
- Use the Visual Studio Code debugger tools to isolate and fix the issue.

By the end of this module, your `MakeChange` method will successfully balance the money till during a simulation of daily transactions.

> [!NOTE]
> This is a challenge project module where you’ll complete an end-to-end project from a specification. This module is intended to be a test of your skills; there’s little guidance and no step-by-step instructions.

## Learning objectives

In this module, you demonstrate your ability to:

- Use the Visual Studio Code debugger tools to identify and correct an issue in your code logic.

## Prerequisites

- An installation of Visual Studio Code that's configured for C# application development.
- Ability to develop C# console applications that implement business logic using iteration statements, selection statements, and custom methods.
- Experience using the Visual Studio Code debugging tools for C#.
- Experience implementing `try-catch` exception handing and throwing exceptions in C# console applications.
