When someone uses the term ".NET", what they mean greatly depends on context. In this unit, you'll discover .NET by looking at it as an ecosystem.  In other words, you'll learn that .NET is a collection of many parts and people that together make it a powerful environment for building applications.

## .NET is an ecosystem for application development

The term "ecosystem" describes the multi-faceted areas of an application development environment and the community surrounding it. These facets combine to create a compelling reason for learning .NET and building .NET applications.

### Use .NET languages and compilers to execute applications with the .NET runtime

Software developers use .NET languages like C# and F# to write source code. Each line of code they write expresses an instruction or command for the computer to perform while the program is running. While each programming language has a different syntax and was created to enable different software development paradigms, generally speaking, source code is human-readable and writeable. 

When software developers want to execute their code, they must first compile their code.  The **.NET compiler** is a program that converts the source code into a special language called **intermediate language** or IL.  The .NET compiler saves the IL code into a file called a **.NET assembly**. By compiling into an "intermediate" format, the same code base can be used regardless of where the code will be executed, whether on Windows or Linux, or on 32-bit or 64-bit computer hardware.

The **.NET runtime** is an execution environment for your compiled .NET assembly. In other words, the .NET runtime is what executes and manages your application as it runs on a host operating system. We'll talk more about what the .NET runtime does in just a moment.

Fortunately, as software developers just getting started with .NET, it's not imperative that you understand how these mechanisms work at first. With experience, you'll come to more fully understand and appreciate the underlying power of .NET languages, compilers, and the runtime.

> [!TIP]
> Sometimes people confuse the C# programming language believing it to be one-in-the-same as .NET, however these are two distinct things. C# is a programming language syntax. As part of the syntax, you can reference and call methods defined in .NET code libraries, or assemblies. Furthermore, you use the C# compiler that is installed with the .NET SDK to create an assembly from your C# code. .NET assemblies are executed by the .NET runtime. Understanding these distinctions will help you be aware of important concepts as you learn more about .NET and C#.

### Use .NET application frameworks and libraries to harness pre-built functionality

All software is built in layers, meaning that there is software running at various levels of abstraction on a computer. At the lowest level, you have software communicating directly with your computer's hardware to control the flow of data on the motherboard, processors, memory, and hard drives. At the next level, you have software that enables the end user to provide instructions via an operating system. At the next level, you have software like .NET that provides a means for application development and execution. At the next level, you have application frameworks and libraries of functionality that application developers can utilize to build richer applications more quickly with less effort.

A code library encapsulates functionality for a specific purpose into a single assembly. In the case of .NET, there are thousands of libraries, both first-party and third-party, both commercial and open source, that provide a vast array of functionality you can use in your applications.  You merely reference those assemblies and call the methods you need. In this way, as a developer, you leverage the work of other software developers and save a lot of time and energy from having to build and maintain every feature yourself.

An application framework combines several related libraries, along with starter projects, file templates, code generators, and other tooling to enable developers to build entire applications for a specific purpose. These applications frameworks are known as **app models**. For example, there are popular .NET application frameworks available for app models like web development, desktop and mobile development, game development, and more.

When you install the .NET SDK, whether directly or as a result of installing Visual Studio 2019, it pre-installs a comprehensive set of libraries and application frameworks called the **Base Class Library**.  This library of code can be leveraged in your programs regardless of the platform or app models that you want to build.

For other third-party libraries, developers use package managers like NuGet to find and integrate code libraries from package repositories like the NuGet Gallery.

#### What are the major app models?

You might wonder which frameworks support which app models.  The following table will help you map an app model to a framework.

| App Model | Framework | Notes |
|---|---|---|
| Web  | ASP.NET Core |  The framework for building server-side logic. |
| Web  | ASP.NET Core MVC |  The framework for building server-side logic for web pages or web APIs. |
| Web  | ASP.NET Core Pages |  The framework for building server-generated HTML.  |
| Web Client | Blazor | Blazor is a part of ASP.NET Core. Its two modes allow for either DOM manipulation via sockets as a communication vehicle for running server-side code, or as a WebAssembly implementation for running compiled C# on the browser.  |
| Desktop  | WinForms | A framework for building "battleship gray" Windows-style applications. |
| Desktop  | WPF | A framework for building more dynamic desktop applications that conform more easily to different form factors and allows form elements to perform movement, fades, glides and other effects with the help of a rich library of animations. |
| Mobile | Xamarin |  Allows .NET developers to build apps for iOS and Android devices. |

Furthermore, .NET powers popular third-party and open source gaming development environment and engines like Unity.

### Use .NET tools to build .NET apps

Software developers rely on tools to write code, add references to code libraries, compile code, debug code, and more. 

There are several tools used to build .NET applications.

**Visual Studio 2019** is Microsoft's flagship development environment used by millions of developers to build .NET applications. Menus, window panes, visual designers, dialogs, and wizards guide developers through the application development process via a graphical user interface. Visual Studio 2019 is available in three editions: Community, Professional, and Enterprise editions. Each edition includes different tools and is licensed for different purposes.

Developers that prefer a command-line workflow might use a combination of **Visual Studio Code**, the world's most popular code editor, combined with the .NET command-line interface, also known as the **.NET CLI**, to create .NET applications.

Furthermore, there's an expansive number of first and third-party utilities for many advanced .NET use cases: code profilers, unit test runners, code coverage analyzers, and much more.

Other .NET tools exist for other scenarios. For example, later in this module you'll work with **Try .NET**, a web browser-based interface for writing simple applications for the sake of learning the C# programming language.

Finally, PowerShell is another tool that allows system administrators and DevOps engineers to write scripts that access .NET functionality to help manage their organization's computing environment.

### Find solutions and answers via documentation and tutorials

Microsoft actively provides a rich set of documentation, tutorials, and training using popular modalities to aid you at each step in your learning process. 

The following table features a few great resources that you may want to bookmark and come back to.

| Resource | Purpose | URL |
|---|---|---|
| Microsoft Docs  | Provides quick start tutorials and definitive reference documentation. |  [https://docs.microsoft.com/](https://docs.microsoft.com/?azure-portal=true) |
| Patterns and Practices | Helps developers and software architects find solutions to common application development needs, often transcending the low-level details of writing code into choosing the right products and services that enable seemingly infinite scalable architectures. | [https://docs.microsoft.com/azure/architecture/](https://docs.microsoft.com/azure/architecture/?azure-portal=true) |
| .NET Videos | Video tutorials directly from the .NET team that walk developers through common usage scenarios. | [https://dotnet.microsoft.com/learn/videos](https://dotnet.microsoft.com/learn/videos?azure-portal=true) |
| Microsoft Learn | Provides hands-on labs to help you build your skills by combining instruction, guidance, exercises, media, knowledge check questions and a means of tracking your progress. | https://docs.microsoft.com/learn/paths/csharp-first-steps/ |

### Interact with the .NET community to learn, grow, and share solutions

The .NET ecosystem extends beyond the languages, libraries, and tools to the people. You are free to both learn from the community, and contribute to the community.

- **Learn** - .NET community members host live online events and in-person meet-ups, build open-source software, participate in Q&A forums, record video tutorials, and write books, and author blog posts that help you learn and get unstuck when you're not sure what to do next.
- **Contribute** - .NET is open source on GitHub [https://github.com/dotnet](https://github.com/dotnet?azure-portal=true) and the projects within that repository are managed by the .NET Foundation, an independent organization dedicated to growing a trusted, commercially friendly, open-source ecosystem built around the .NET development platform.  Or, you can contribute by helping others learn using your unique perspective and voice.

## How does the .NET ecosystem compare to others?

If you're familiar with the software development world at large, you may wonder how the .NET ecosystem compares to others. Frankly, other ecosystems can make similar claims to some, if not many of the statements made so far in this unit.

However, one of the most distinctive features of .NET when compared to other ecosystems is that its ongoing development and support comes from a combination of a major technology leader as well as the community. Significant portions of .NET have been open-sourced. Community input and contributions are both welcomed and encouraged. In fact, 87% of contributors are outside of Microsoft. Based on community input, Microsoft actively supports the platform by moving it forward with feature enhancements, bug fixes, and performance improvements. Over 100,000 pull requests have been accepted from the community.

Additionally, the .NET ecosystem has momentum:

- There are more than 5 million .NET developers!
- The results of a StackOverflow poll in 2019 and 2020 showed that .NET Core  is the most loved framework.
- Students love .NET! 40% of developers new to .NET are students.
- The GitHub repositories for .NET and ASP.NET are ranked among the top 30 highest velocity OSS projects.
- GitHub lists C# in the top five programming languages, and is moving up in popularity according to the TIOBE Language Index 2020.
- .NET has the fastest web framework on the planet according to [TechEmpower benchmarks](https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=plaintext&a=2?azure-portal=true), an independent, open source set of web performance benchmarks that measure dozens of languages and application frameworks.


## A brief history of .NET

The original .NET Framework was first released early 2002. Since then, there have been many updates including more and more new functionality. After years of enhancements and new features, the original .NET Framework, particularly key code libraries, had grown significantly in size.

Furthermore, over the years, Microsoft had worked on making a version of .NET with cross-platform compatibility possible, allowing developers to write one code base and use it across macOS, Linux, and Windows operations systems. 

As a result of these changes, .NET Core was introduced around 2014. Microsoft has maintained the original .NET Framework, but decided that new features and improvements would be reserved for .NET Core. Going forward, the "Core" in the name has been removed and the next major versions are .NET 5, .NET 6, .NET 7, etc. and will release every year in November.

Why is .NET's history important? It's possible that you will find blog posts, videos, and source code that targets the original .NET Framework. In some cases, the instructions or code will still work, but in other cases, there might be changes required.