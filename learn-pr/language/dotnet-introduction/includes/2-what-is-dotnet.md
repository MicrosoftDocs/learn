When someone uses the term ".NET", what they mean greatly depends on context.  In this unit, we'll discover what .NET is by looking at it as an ecosystem -- a collection of many parts and people -- that together make it a powerful environment for building applcations.

## .NET is an ecosystem for application development

The term "ecosystem" describes the multi-faceted areas of an application development environment and the community surrounding it, all of which combine to create a compelling reason why to invest learning and building on .NET.

### Use .NET languages and compilers to execute applications with the .NET runtime

Software developers use .NET languages like C# and F# write source code.  Each line of code they write expresses a instruction or command for the computer to perform while the program is running. While each programming language has a different syntax and was created to enable different software development paradigms, generally speaking, source code is human-readable and writeable. 

When software developers want to execute their code, the must first compile their code, then they can run it.  The **.NET compiler** is a program that converts the source code into a special language called intermediate language.  The compiler saves the transpiled code into a file called an assembly.  By compiling into an "intermediate" format, the same code base can be used regardless of where the code will be executed, whether on Windows or Linux, or on 32-bit or 64-bit computer hardware.

The **.NET Runtime** is an execution environment for your .NET assembly.  In other words, it is what executes and manages your application as it runs on a host operating system.  We'll talk more about what the .NET Runtime does in just a moment.

Fortunately, as software developers just getting started with .NET, it's not imperative that you understand how these mechanisms work at first. With experience, you'll come to more fully understand and appreciate the underlying power of .NET languages, compilers and the runtime.

> [!TIP]
> Sometimes people confuse the C# programming language believing it to be one-in-the-same as .NET, however these are two distinct things. C# is a programming language syntax.  As part of the syntax, you can reference and call methods defined in .NET code libraries, or assemblies. Furthermore, you use the C# compiler that is installed with the .NET SDK to create an assembly from your C# code. .NET assemblies are executed by the .NET Runtime.  Understanding these distinctions will help you be aware of important concepts as you learn more about .NET and C#.

### Use .NET frameworks and libraries to harness pre-built functionality

All software is built in layers, meaning that there is software running at various levels of abstraction on a computer.  At the lowest level, you have software communicating directly with your computer's hardware to control the flow of data on the motherboard, processors, memory and hard drives. At the next level, you have software that enables the end user to provide instructions via an operating system.  At the next level, you have software like .NET that provides a means for application development.  At the next level, you have frameworks and libraries of functionality that application developers can utilize to build richer applications more quickly with less effort.

A code library encapsulates functionality for a specific purpose into a single assembly. In the case of .NET, there are thousands of libraries, both first-party and third-party, commercial and open source, that provide a vast array of functionality that you can use in your applications by merely calling the methods implemented by other software developers.  Developers use package managers like NuGet to find and integrate code libraries from package repositories like the NuGet Gallery.

A framework combines several related libraries, along with starter projects, file templates, code generators, and other tooling to enable developers to build entire applications for a specific purpose.  For example, there are popular .NET frameworks available for web development, desktop and mobile development, game development, data access, and more.

### Use .NET tools to build .NET apps

Software developers rely on tools to write code, add references to code libraries, compile code, debug code, and more. 

There are several primary .NET tools used to build .NET applications.

Visual Studio 2019 Community, Professional and Enterprise editions are Microsoft flagship development environment used by millions of developers to build applications. Menus, window panes, visual designers, dialogs and wizards guide developers through the application development process via a graphical user interface.

Developers that prefer a command line workflow might use a combination of Visual Studio Code, the world's most popular code editor, combined with the .NET CLI to create .NET applications.

There's an expansive number of first and third-party utilities for many specific .NET use cases: code profilers, unit test runners, code coverage analyzers, and much more.

Other .NET tools exist for other scenarios. For example, later in this module you'll work with Try.NET, an web browser based interface for writing simple applications for the sake of learning the C# programming language.

Finally, PowerShell is another tool that allows system administrators and DevOps engineers to write scripts that access .NET functionality to help manage their organization's computing environment.

### Find solutions and answers via documentation and tutorials

Microsoft actively provides a rich set of documentation, tutorials and training using popular modalities to aid you at each step in your learning process.  Microsoft Docs provides quick start tutorials and definitive reference documentation. Patterns and Practices help developers find solutions to common application development needs, often transcending beyond code and into products and services that enable .  The .NET team has recorded video tutorials to walk developers through common usage scenarios.  And finally, Microsoft Learn modules provide hands-on labs to help you build your skills by combining instruction, guidance, exercises, media, knowledge check questions and a means of tracking your progress.

### Interact with the .NET community to learn, grow and share solutions

The .NET ecosystem extends beyond the languages, libraries and tools to the people. The .NET community host live online events and in-person meet-ups, author open source software, participate in Q&A forums, record video tutorials, and write books and blog posts that help you learn and get un-stuck when you're not sure what to do next.

## How does the .NET ecosystem compare to others?

If you're familiar with the software development world at large, you may wonder how the .NET ecosystem compares to others. Frankly, other ecosystems can make similar claims to many of the statements made so far in this unit.

One of the most distinctive features of .NET when commpared to other ecosystems is that it's ongoing development and support from a combination of a major technology leader as well as its community. Significant portions of .NET have been open sourced. Community input and contributions are both welcomed and encouraged. Based on community input, Microsoft actively supports the platform by moving it forward with feature enahcements, bug fixes, and performance improvements.

<div style="background-color:pink;"><em>TODO:</em> What else can I / should I say without drawing the ire of members of other ecosystems? 7x performance over nodejs?  Jetbrains poll results saying C# is the most loved language?</div>

## Short history of .NET

The original .NET Framework was first released early 2002. Since then, there have been many version updates including more and more new functionality.  After a while, the original .NET Framework, particularly key libraries had grown significantly in size. Also, Microsoft had worked on making a version of .NET with cross-platform compatibility possible, allowing developers to write one code base and use it across MacOS, Linux and Windows operations systems. 

As a result of these changes, .NET Core was introduced around 2014. Microsoft has maintained the original .NET Framework, but new features and improvements would be reserved for .NET Core.

Why is this important? It's possible that you will find blog posts, videos, and source code that targets the original .NET Framework. In some cases, the instructions or code will still work, but in other cases, there might be changes required.
