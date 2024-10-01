




Every software developer needs to complete some level of testing and debugging when they develop their code, and exception handling is often required. But how are these three tasks related and when should they be implemented?

## Testing, debugging, and exception handling

Code debugging is clearly related to both code development and testing. After all, you make corrections to your code logic as you develop your application, and you also run your code periodically to verify that your code syntax and logic are correct. But is updating code logic during the development process really what's meant by debugging? And is verifying that your code builds and runs really what's meant by testing? No, not really.

How does exception handling relate to code development and testing? In fact, what does "exception handling" mean and is a developer expected to do it? In C# development, the errors that occur during the application runtime (versus build errors that occur during the build process) are referred to as exceptions, and "exception handling" is the process that a developer uses to manage those runtime exceptions within their code.

You may be wondering how exception handling relates to code development and testing. In fact, what does "exception handling" mean and is a developer expected to do it? In C# development, the errors that occur while the application is running are referred to as exceptions. The term "exception handling" refers to the process that a developer uses to manage those runtime exceptions within their code. Errors that occur during the build process are referred to as errors, and aren't part of the exception handling process.

The following sections describe the developer's role in testing, debugging, and exception handling.

## Software testing and developer responsibilities

The software development process can involve a lot of testing. In fact, software testing has its own specialized discipline, and software testers play an important role in the development of large applications. There are even approaches to the software development process that are based on testing, such as test-driven development.

Software testing categories can be organized under the _types_ of testing, the _approaches_ to testing, or a combination of both. One way to categorize the types of testing is to split testing into _Functional_ and _Nonfunctional_ testing. The functional and nonfunctional categories each include subcategories of testing. For example, functional and nonfunctional testing could be divided into the following subcategories:

- Functional testing   - Unit testing   - Integration testing   - System testing   - Acceptance testing
- Nonfunctional testing   - Security testing   - Performance testing   - Usability testing   - Compatibility testing

Although most developers probably don't consider themselves to be testers, some level of testing is expected before a developer hands off their work. When developers are assigned a formal role in the testing process, it's often at the level of unit testing.

> [!NOTE]
> Since software testing is such a large topic, and since it's often performed by a separate job role, formal approaches to software testing won't be discussed in this module.

## Code debugging and developer responsibilities

Code debugging is a process that developers use to isolate an issue and identify one or more ways to fix it. The issue could be related to either code logic or an exception. Either way, you work on debugging your code when it isn't working the way you want it to. Generally speaking, the term debugging is reserved for runtime issues that aren't easy to isolate. Therefore, fixing syntax issues such as a missing ";" at the end of a code statement, isn't normally considered debugging.

Consider the following sample code:

```csharp
string[] students = new string[] {"Sophia", "Nicolas", "Zahirah", "Jeong"};

int studentCount = students.Length;

Console.WriteLine("The final name is: " + students[studentCount]);
```

The code sample is intended to accomplish the following:

- Declare a string array named `students`. The `students` array contains the names of students.
- Declare an integer named `studentCount`. The code uses the `Length` method of the array to assign a value to `studentCount`.
- Print the name of the final student to the console. The code uses `studentCount` to access the final name in the `students` array, and it uses the `Console.WriteLine()` method to print the information to the console.

At first glance, everything seems fine. However, this code generates an exception when attempting to print the student name to the console. The developer forgot that arrays are zero-based. The final name in the array should be accessed using `students[studentCount - 1]`.

Code debugging is definitely a developer responsibility. In this code sample, you may have recognized the issue right away. However, in more complex coding scenarios, finding an issue isn't always easy. Don't worry, there are tools and approaches that you can use to track down issues that're hard to find.

## Exception handling and developer responsibilities

As you read earlier, errors that occur during the application runtime are referred to as exceptions. If an application generates an exception, and that exception isn't managed in code, it can result in the application being shut down.

Handling exceptions is definitely a responsibility of the developer. C# provides a way for you to "try" the code that you know might generate an exception, and a way for you to "catch" any exceptions that do occur.

## Recap

Here are a few important things to remember from this unit:

- Testing, debugging, and exception handling are all important tasks for software developers.
- Testing can be categorized into functional and nonfunctional testing, and developers are expected to perform some level of testing.
- Code debugging is the process of isolating issues and identifying ways to fix them, and it's a developer responsibility.
- Exception handling is the process of managing errors that occur during runtime, and developers are responsible for handling exceptions by using "try" and "catch" statements in their code.