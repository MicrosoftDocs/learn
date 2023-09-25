This unit focuses on the *technical* aspects of building an application. We'll use .NET languages, tools, and frameworks to outline the general workflow software developers use to build .NET applications.

## How developers use .NET to build applications

This section describes the workflow of application development in .NET, and includes details about how to get started building an application in .NET.

### Set up your development environment

The first decision developers make is selecting the tools they'll use to create their applications. In other words, they select their *development environment*. The decision is usually based on whether they prefer a more visual workflow that features a graphical user interface, or a command-line interface where they'll rely almost exclusively on the keyboard to navigate the development environment and make commands.

> [!NOTE]
> At the end of this module, you'll find links to help you get started with setting up your development environment. You can choose either Visual Studio 2022, or Visual Studio Code and the .NET Software Development Kit (SDK).

For developers who prefer a visual environment, Visual Studio 2022 is the best choice. As you might guess, because of the comprehensive and visual nature of Visual Studio 2022, you'll need time, bandwidth, and disk space to download and install the program. However, some beginners find it to be the easiest way to get started. Depending on the speed of your internet connection, the installation can take 15 minutes or more.

The Visual Studio Installer in Visual Studio 2022 gives you options in the form of workloads. A *workload* is a collection of frameworks, libraries, and other tools that work together to build a specific app model. Based on what you learned in the previous unit, you'll want to make sure that you install the **.NET Core for cross-platform development** workload to build new applications.

The **.NET Core for cross-platform development** workload installs the .NET SDK. The .NET SDK contains all the libraries, tools, and templates you need to get started writing code.

If you prefer a command-line environment, separately download and install Visual Studio Code and the .NET SDK. This choice is popular for beginners who want to get started quickly. Both tools require less bandwidth to download.

### Get started

Typically, software-development projects begin with a set of requirements. These requirements affect choices for the app model. For example, the app model you choose could be a web, desktop, or mobile application, or a background process.

When using either Visual Studio 2022 or the .NET CLI, you typically begin by creating a new project based on a project template. You can choose from many project templates. Project templates:

- Generate folders and files based on templates and the name of the project you define.
- Add references to commonly used libraries and libraries that your app model framework requires.
- Provide required code that allows you to run the application and see a tiny sample so you can confirm the code compiles.
- Sometimes include instructions in the code. These instructions guide you to modify the sample application and make it your own.

In Visual Studio 2022, the **New Project** dialog box helps you visually choose an application model from a set of installed templates, or you can choose from many community contributions. In the .NET CLI, you will choose a new project template by using the [**dotnet new**](/dotnet/core/tools/dotnet-new) command.

### Build functionality

Next, you'll begin writing the logic for your application. You'll add references to code libraries when you need to do special tasks like:

- Connecting to network resources
- Accessing a database to store or retrieve data
- Converting data from one format into another
- Adding logging to diagnose problems with your application

In some cases, the code libraries you want to use already exist on your local hard drive, because they were installed along with the .NET SDK.

In other cases, developers use the NuGet package manager to download and create references to the assembly libraries. To retrieve these resources - depending on your development environment - you can use the Visual Studio **NuGet Package Manager** dialog box, or you can use the .NET CLI's command-line interface.

### Compile and run your application

When you build new functionality, you'll create your code and run it often. This workflow allows you to assess what works correctly and what needs revisions. Both the visual approach and the command-line approach use simple commands that make the workflow easy to follow.

Code syntax is considered incorrect when the syntax doesn't follow the rules of the language. When the syntax is wrong, the .NET compiler for your language throws a *compilation error*. The compiler won't continue until you correct the syntax problem.

Sometimes the code can be compiled because it follows the syntax rules, but the application's logic has problems. If the logic prevents the .NET runtime from running a command, the program "crashes." The .NET runtime then removes the program from the computer's memory. These errors are called *runtime errors* or *exceptions*.

> [!TIP]
> Fortunately, you can programmatically prevent the raw system error messages from reaching your users. Learn more by searching for tutorials and documentation about "structured exception handling."

Some logic errors don't result in a "crash." But they also don't produce the results your users expect. You can remedy these errors only by testing and debugging your application.

### Debug your application

As you build your software, you'll run the application to gauge whether it meets your requirements and expectations. You might discover a bug in your application, but you're not sure *why* it happens or *how* to fix it.

When you debug, you watch your application as it runs to understand what's going on. You can set breakpoints that pause the application and allow you to follow the code as it runs, line by line. You can observe the values stored in variables, take control of the running path through the code to skip over or rerun lines, change the value of a variable, and so on.

Both the visual and command-line debugging tools allow you to observe and take control of running the application. Use this functionality to see what's going on in your application as it's running.

### Distribute the application

When the application is ready to release, you create a *release version* of the build. In a release version, you remove the code required for debugging. Again, in both the visual and the command-line tools, you can compile a release version.

To run the release version, you must first install the .NET runtime on the destination computer. That computer will run your compiled .NET assembly.

## How .NET works at runtime

After you install your application's .NET assembly and the .NET runtime on the destination computer, you can run your application.

The *.NET runtime* is like a protective bubble that provides a run environment for your applications. The .NET runtime:

- Compiles the intermediate code into a binary format the first time the program runs. The binary format is specific to the platform and architecture (for example, 64-bit Windows) on the computer where it's running.
- Locates the program's entry point and begins running each instruction in the proper sequence.
- Manages computer resources like memory and network access. When you hear that the .NET runtime "manages memory," that means it works with the operating system to provision memory for your application. When your application no longer needs the data stored in memory, a garbage-collection feature releases that memory back to the operating system without any instructions from the software developer.
- Secures the user's computer from software that has potentially malicious intent. It also provides a layer of isolation between applications.