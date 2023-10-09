When someone uses the term *.NET*, what they mean greatly depends on context. In this unit, you'll learn about .NET by looking at it as an ecosystem. In other words, .NET is a collection of many parts and people that together create a powerful environment for building applications.

## .NET is an ecosystem for application development

The term *ecosystem* describes the multiple facets of an application development environment and the community that surrounds it. These facets combine to create a compelling reason to invest in learning .NET and building .NET applications.

### Use .NET languages and compilers to run applications in the .NET runtime

Software developers use .NET languages like C# and F# to write source code. Each line of code they write expresses an instruction or command the computer should perform while the program is running.

Before software developers can run their code, they must first compile it. The *.NET compiler* is a program that converts the source code (in any supported programming language) into a portable language called *intermediate language* (IL).  The .NET compiler saves the IL code into a file called a *.NET assembly*. By compiling the code into an intermediate format, you can use the same code base wherever you run the code, whether on Windows or Linux, or on 32-bit or 64-bit computer hardware.

The *.NET runtime* is an execution environment for your compiled .NET assembly. In other words, the .NET runtime is what executes and manages your application as it runs on a host operating system. We'll talk more about what the .NET runtime does in just a moment.

Fortunately, as a software developer just getting started with .NET, you don't need to get into details of how these mechanisms work. With experience, you'll come to more fully understand and appreciate the underlying power of .NET languages and compilers and the runtime.

> [!TIP]
> Sometimes people think that the C# programming language *is* .NET. However, C# and .NET are distinct. C# is a programming language syntax. As part of the syntax, you can reference and call methods defined in .NET code libraries, or *assemblies*. Next, you'll use the C# compiler that's installed with the .NET SDK to create a .NET assembly from your C# code. The .NET runtime then runs the .NET assemblies. These distinctions are important concepts as you learn more about .NET and C#.

### Use .NET application frameworks and libraries to harness prebuilt functionality

All software is built in layers, meaning software runs at various levels of abstraction on a computer:
- At the lowest level, software communicates directly with your computer's hardware. It controls the flow of data on the motherboard, processors, memory, and hard drives. 
- At the next level, software allows the end user to provide instructions through an operating system.
- At the next level, software like .NET provides a way for you to develop and run applications.
- At the next level, application frameworks and libraries of functionality allow you to quickly build rich applications with less effort than older development methods.

A code library encapsulates functionality for a specific purpose into a single assembly. For .NET, thousands of libraries are available. These libraries can be first-party or third-party, and can be commercial or open source. The libraries provide a vast array of functionality you can use in your applications. You merely reference those assemblies and call the methods you need. In this way, as a developer, you build on the work of other software developers. You save time and energy because you don't have to build and maintain every feature yourself.

An application framework combines several related libraries, along with starter projects, file templates, code generators, and other tools. You can use these resources to build entire applications for a specific purpose. These application frameworks are known as *app models*. For example, .NET application frameworks are available for popular app models like web development, desktop and mobile development, and game development.

You can install the .NET SDK directly or by installing Visual Studio 2022. The .NET SDK preinstalls a comprehensive set of libraries and application frameworks called the *base class library*. You can use this library of code in your programs regardless of the platform or app models you want to build.

For other third-party libraries, developers use package managers like NuGet to find and integrate code libraries from package repositories like the NuGet Gallery.

#### What are the major app models?

You might wonder which frameworks support which app models. Use the following table to map an app model to a .NET framework.

| App model | Framework | Notes |
|---|---|---|
| Web  | ASP.NET Core |  The framework for building server-side logic. |
| Web  | ASP.NET Core MVC |  The framework for building server-side logic for web pages or web APIs. |
| Web  | ASP.NET Core Razor Pages |  The framework for building server-generated HTML.  |
| Web client | Blazor | Blazor is a part of ASP.NET Core. Its two modes allow for either Document Object Model (DOM) manipulation via sockets as a communication vehicle for running server-side code, or a WebAssembly implementation for running compiled C# on a browser.  |
| Desktop  | WinForms | A framework for building "battleship gray" Windows-style applications. |
| Desktop  | Windows Presentation Foundation (WPF) | A framework for building dynamic desktop applications that conform to different form factors. WPF allows form elements to perform movement, fades, glides, and other effects with the help of a rich library of animations. |
| Mobile | Xamarin |  Allows .NET developers to build apps for iOS and Android devices. |

.NET also powers popular third-party and open-source gaming development environments and engines like Unity.

### Use .NET tools to build .NET apps

Software developers rely on tools to write code, add references to code libraries, compile code, and debug code. This section describes several .NET tools you'll use to build .NET applications.

*Visual Studio 2022* is the Microsoft flagship development environment. Millions of developers use it to build .NET applications. A graphical user interface (that includes menus, windows, visual designers, dialog boxes, and wizards) guides developers through the application development process. Visual Studio 2022 is available in three editions: Community, Professional, and Enterprise. Each edition includes different tools and is licensed for different purposes.

Developers who prefer a command-line workflow might use a combination of *Visual Studio Code*, the world's most popular code editor, and the .NET command-line interface, also known as the *.NET CLI*.

Furthermore, you can choose from numerous first-party and third-party tools for many advanced .NET use cases. Options include code profilers, unit test runners, and code coverage analyzers.

You can find other .NET tools for other scenarios. For example, later in this module you'll work with *Try .NET*. You'll use this browser-based interface to write simple applications to help you learn the C# programming language.

### Find solutions and answers in documentation and tutorials

Microsoft actively provides a rich set of documentation, tutorials, and training. You'll find learning materials in popular modalities to help you at each step in your learning process.

The following table features a few great resources you might want to bookmark and come back to.

| Resource | Purpose |
|---|---|---|
| [Microsoft Learn](/?azure-portal=true) | Provides quick-start tutorials and definitive reference documentation. |  
| [Patterns and Practices](/azure/architecture/?azure-portal=true) | Helps developers and software architects find solutions to common application development needs. Resources often transcend the low-level details of writing code and delve into choosing products and services that enable seemingly infinite scalable architectures. |
| [.NET Videos](https://dotnet.microsoft.com/learn/videos?azure-portal=true) | Provides video tutorials from the .NET team. These videos walk developers through common usage scenarios. |
| [Get started with C#](../../../paths/get-started-c-sharp-part-1/index.yml?azure-portal=true) | Provides hands-on labs to help you build your skills by combining instruction, exercises, media, knowledge checks, and a means of tracking your progress. |

### Interact with the .NET community to learn and share solutions

The .NET ecosystem extends beyond languages, libraries, and tools to the people. You're free to both learn from and contribute to the community.

- **Learn**: .NET community members host live online events and in-person meet-ups. They build open-source software, participate in Q&A forums, and record video tutorials. They write books and blog posts that help you learn and get unstuck when you're not sure what to do next.
- **Contribute**: .NET is open source on [GitHub](https://github.com/dotnet?azure-portal=true). The projects in this repository are managed by the .NET Foundation. This independent organization is dedicated to growing a trusted, commercially friendly, open-source ecosystem around the .NET development platform. In this repository, you can share your unique perspective and voice to help others learn.

## How does the .NET ecosystem compare to others?

If you're familiar with the software development world, you might wonder how the .NET ecosystem compares to others. Frankly, other ecosystems can make similar claims to some or many of the statements made so far in this unit.

However, one of the most distinctive features of .NET is that its ongoing development and support comes from not only a major technology leader, but also the community. Significant portions of .NET were developed through open-source means. Community input and contributions are both welcomed and encouraged. In fact, 87 percent of contributors are outside of Microsoft. Based on community input, Microsoft actively moves the platform forward with feature enhancements, bug fixes, and performance improvements. More than 100,000 pull requests have been accepted from the community.

Additionally, the .NET ecosystem has momentum:

- .NET developers number more than 5 million!
- The results of Stack Overflow polls in 2019 and 2020 showed that .NET Core is the most loved framework.
- Students love .NET; 40 percent of developers who are new to .NET are students.
- The GitHub repositories for .NET and ASP.NET are ranked among the top 30 highest-velocity open-source software (OSS) projects.
- GitHub lists C# in the top five programming languages, and the language is increasing in popularity according to the 2020 TIOBE programming community index.
- .NET has the fastest web framework on the planet according to [TechEmpower benchmarks](https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=plaintext&a=2?azure-portal=true), an independent, open-source set of web performance benchmarks that measure dozens of languages and application frameworks.


## A brief history of .NET

The original .NET Framework was first released in early 2002. Since then, many updates and much more functionality have followed. After years of enhancements and new features, the original .NET Framework, especially key code libraries, grew significantly.

After 2002, Microsoft worked to make a version of .NET that had cross-platform compatibility. The goal was to allow developers to write one code base and use it across macOS, Linux, and Windows operating systems.

Through these efforts, .NET Core was introduced around 2014. Microsoft has maintained the original .NET Framework, but new features and improvements are reserved for .NET Core. *Core* was later dropped from the name. The next major versions are .NET 5, .NET 6, .NET 7, and so on. Versions are generally released each November.

Why is the .NET history worth mentioning? Because you'll likely find blog posts, videos, and source code that targets the original .NET Framework. In some cases, the instructions or code still work, but in other cases, you might need to make adjustments to fit the new .NET.
