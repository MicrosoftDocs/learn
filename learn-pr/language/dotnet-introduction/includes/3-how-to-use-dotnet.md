In this unit, we'll center our focus on the more technical aspects of building an application using .NET languages, tools, and frameworks to outline the general workflow of software developers who are building .NET applications.

## How developers use .NET to build applications

In this section, we'll describe the workflow of application development in .NET, including details about what it takes to get started with building an application in .NET.

### Setting up your development environment

The first decision developers make is selecting the tools they'll use to create their applications, or in other words, their development environment.  The decision is based purely on whether they prefer a more visual workflow featuring a graphical user interface or a command-line interface where they'll rely almost exclusively on keyboard commands to navigate the development environment and issue commands.

> [!NOTE]
> We'll provide links at the end of this module to get started with setting up your development environment using either Visual Studio 2019 or Visual Studio Code and the .NET SDK.

For those who prefer a visual environment, Visual Studio 2019 is the best choice. As you might guess, due to its comprehensive and visual nature, it requires more time, bandwidth, and disk space to download and install Visual Studio 2019. However, some beginners find it to be the easiest way to get started ... as long as they're patient enough to wait 15 minutes or more, depending on the speed of their internet connection, for the installer to finish.

The Visual Studio Installer in Visual Studio 2019 gives you options in the form of workloads. A **workload** is a collection of frameworks, libraries, and other tools that work together to build a specific app model. Based on what you learned in the previous unit, you'll want to make sure that you install the ".NET Core for cross-platform development" workload to build new applications.

The ".NET Core for cross-platform development" workload will install the .NET Software Development Kit, or **.NET SDK**. The .NET SDK contains all of the libraries, tools, and templates that you need to get started writing code.

Alternatively, for those who prefer a command-line environment, you can download and install Visual Studio Code and the .NET SDK separately. This is a popular choice for beginners who want to get started quickly since both tools require less bandwidth to download.

### Getting started

Typically, most software development projects begin with a set of requirements that decide on the app model, such as a web application, desktop, mobile, background process, etc.

Using either Visual Studio 2019 or the .NET CLI, you typically begin by creating a new project based on a project template.  There are many templates to choose from.  Project templates:

- Generate folders and files based on templates and the name of the project you define.
- Add references to commonly used libraries and libraries required by the app model framework you selected.
- Required code that allows you to execute the application and see a tiny sample application so you can confirm the code compiles.
- Sometimes, it includes instructions in the code on what to do next to modify the sample application and make it your own.

In Visual Studio 2019, the New Project dialog helps you visually choose an application model from a set of installed templates, or choose from many community contributions.  In the .NET CLI, you can choose a new project template using a combination of a command and flags.

### Building functionality

Next, you begin writing the logic for your application. When you need to perform special tasks like:

- connecting to network resources
- accessing a database to store or retrieve data
- converting data from one format into another
- adding logging for the purposes of diagnosing issues with your application

... you add references to code libraries.

In some cases, the code libraries you want to use already exist on your local hard drive because they were installed along with the .NET SDK.

In other cases, developers use the NuGet package manager to download and create references to the assembly libraries. Depending on your development environment, you can use Visual Studio's visual NuGet Package Manager dialog, or the .NET CLI's command-line interface to retrieve these resources.

### Compiling and running your application

When building new functionality, it's common to build your code and execute it often. This workflow allows you to assess what is working correct and what needs more work. Both the visual and command-line workflows have simple commands that make this easy to do.

If the syntax of your code is incorrect, in other words, if the syntax does not follow the rules of the language, the .NET compiler for your language will throw a compilation error and refuse to continue until you correct the problem. These are called **compilation errors**.

Alternatively, if the code can be compiled because it follows the syntax rules correctly, but the logic of the application causes the .NET Runtime to be unable to carry out a command, then the program will "crash", and the .NET Runtime will remove the program from the computer's memory.  These are called **runtime errors** or **exceptions**.

> [!NOTE]
> Fortunately, there are programmatic ways to prevent ugly error messages from reaching your users. You can learn more about "structured exception handling" via various tutorials and documentation.

Finally, there are logic errors that do not manifest themselves in a "crash", however they do not produce the results your users expect. These can only be remedied by much testing and debugging of your application.

### Debugging your application

During the course of building software, you will likely want to run the application to gauge whether it meets your requirements and expectations. Perhaps you discover a bug in your application, but you're not sure *why* it's occurring or *how* to fix it.

Debugging allows you to execute the application under development in an effort to understand what's going on as it is running. You can set break points which pause the execution of the application and allow you to step through the code as it's executing, observing the value stored in variables, or even taking control of the execution path through the code to skip over or re-execute lines, change the value of variables, and so on.

Both the visual and command line debugging tools will allow you to observe and take control of the execution of the application to see what's going on in your application as it's running.

### Distributing the application

Once the application is ready to be released, you create a release version of the build, meaning that you remove extra code required for debugging.

Once again, the visual and command-line tools provide functionality to compile a version to be released. In order to run the application, the .NET runtime must be installed on the destination computer since it is what will execute your compiled .NET assembly.

## How .NET works at runtime

Once your application's .NET assembly and the .NET runtime are installed on the destination computer, you can run your application.

The **.NET runtime** is the protective bubble that provides an execution environment for the applications, meaning that it:

- Compiles the intermediate code into a binary format specific to the given platform and architecture (for example, 64-bit Windows) where it's running upon the first time the program is executed.
- Locates the program's entry point and begins executing each instruction in the proper sequence.
- Manages computer resources like memory, network access, and so on.  When we say that the .NET runtime "manages memory", we mean that it will work with the operating system to provision memory for use your application, and when your application no longer needs the data stored in memory, a garbage collection feature will release that memory back to the operating system without any special instructions from the software developer.
- Secures the user's computer from code with potentially malicious intent, and provides a layer of isolation between applications.