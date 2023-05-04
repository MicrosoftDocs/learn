

Exceptions can be thrown by your code when an issue or error condition is encountered. Exception objects that describe an error are created and then thrown with the `throw` keyword. When an exception is thrown by your code, the runtime searches for the nearest `catch` clause that can handle the exception.

Suppose you're working on a data processing application for a company. The application relies on business rules and specifications to ensure that purchase order processing and inventory management tasks are completed appropriately. In addition, the application must use specific language to inform the user when data anomalies and other issues are encountered. Customized exceptions must be thrown, caught, and reflected in the application's user interface when issues are encountered. Business rules provide specific guidance in the following categories:

- Data input requirements for the processes.
- Success and failure criteria for the processes.  
- Sequence order requirements for the processes.
- Process failure reporting and mitigation requirements.

In this module, you learn how to create exception objects, how to customize the properties of an exception object, and the process for creating, throwing, and catching custom exception objects in a C# application.

By the end of this module, you'll be able to create, customize, throw, and catch exception objects that satisfy the requirements for your application.

## Learning objectives

In this module, you will:

- Learn how exception objects are created and how to customize their property settings.
- Develop C# console applications that create and throw customized exception objects.
- Develop C# console applications that catch custom exception objects and manage exception property information.

## Prerequisites

- An installation of Visual Studio Code that's configured for C# application development.
- Ability to develop C# console applications that implement business logic using iteration statements, selection statements, and custom methods.
- Experience using the Visual Studio Code debugging tools for C#.
- Experience implementing `try-catch` exception handing in C# console applications.
