Programs perform two types of operations: compute-bound and I/O-bound. Compute-bound operations involve calculations. The more powerful the computer's resources (memory and CPU), the faster it completes them. I/O-bound operations involve waiting for external devices, such as a disk or network, to exchange information.

Suppose that whenever you try to add a new ant to the game, the screen freezes and stops responding. How would you fix the problem? If the problem is related to input or output (I/O) issues, one possible solution is to run the user interface (UI) updates in a separate thread. This way, the processing isn't blocked.

While waiting for I/O-bound operations to complete, the system resources used by the current thread are released for other code to use. User interface (UI) updates run in a single thread. Moving compute-bound operations to another thread can improve the application's UI experience. Using asynchronous I/O for I/O-bound operations can prevent UI freezes and make the application more responsive.

The concept of threads and their implementation has existed for a while. Programmers consider using and managing threads as a "low-level" or advanced subject. However, Microsoft has made it easier to use and manage threads through their implementation, which utilizes a higher level concept called a Task. In C#, a Task is an object that represents code to be executed asynchronously.

## Learning objectives

In this module, you'll learn how to:

- Implement asynchronous programming in C# to create a new Task and prevent UI freezes during calculations.
- Implement asynchronous IO operations using the `async` and `await` keywords in C# to make file IO operations asynchronous and prevent UI freezes.

## Prerequisites

- Installation of Visual Studio Code configured for C# application development, including C# Dev Kit.
- Experience with the VS Code editor.
- Ability to develop C# console applications that implement business logic using loops, if statements, properties, and methods.
- Experience with basic C# syntax rules.
