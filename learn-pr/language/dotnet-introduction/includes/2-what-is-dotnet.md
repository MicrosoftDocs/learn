When someone uses the term *.NET*, what they mean greatly depends on context. In this unit, you'll learn about .NET by looking at it as an ecosystem.  In other words, you'll learn that .NET is a collection of many parts and people that together create a powerful environment for building applications.

## .NET is an ecosystem for application development

The term *ecosystem* describes the multifaceted aspects of an application development environment and the community that surrounds it. These facets combine to create a compelling reason to invest in learning and building applications on .NET.

### Use .NET languages and compilers to run applications in the .NET runtime

Software developers use .NET languages like C# and F# to write source code. Each line of code they write expresses an instruction or command that the computer should perform while the program is running. 

Programming languages have different syntaxes. They're created to enable different software development paradigms. But generally speaking, source code is readable and writeable by humans. 

Before software developers can run their code, they must first compile it.  The *.NET compiler* is a program that converts source code into a special language called *intermediate language* (IL).  The compiler saves the IL code in a file called an *assembly*. Compiled into an "intermediate" format, the code base can be used wherever the code will be run. You can run it on Windows or Linux, or on 32-bit or 64-bit computer hardware.

The *.NET runtime* is an execution environment for your compiled .NET assembly. In other words, the .NET runtime is what runs and manages your application on a host operating system. We'll talk more about what the .NET runtime does in just a moment.

Fortunately, as a software developer just getting started with .NET, you don't have to understand how these mechanisms work at first. With experience, you'll come to more fully understand and appreciate the underlying power of .NET languages and compilers and the runtime.

> [!TIP]
> Although people confuse the C# programming language with .NET, they're two distinct things. C# is a programming language syntax. As part of the syntax, you can reference and call methods that are defined in .NET code libraries or assemblies. Furthermore, you use the C# compiler that's installed with the .NET SDK to create an assembly from your C# code. .NET assemblies are run by the .NET runtime. By understanding these distinctions, you'll be more aware of important concepts as you learn about .NET and C#.

### Use .NET application frameworks and libraries to harness prebuilt functionality

All software is built in layers, meaning that software runs at various levels of abstraction on a computer:  
- At the lowest level, you have software that communicates directly with your computer's hardware. It controls the flow of data on the motherboard, processors, memory, and hard drives. 
- At the next level, you have software that enables the end user to provide instructions through an operating system.  
- At the next level, you have software like .NET that provides a way for you to develop applications.  
- At the next level, you have application frameworks and libraries of functionality. Application developers can use these resources to build richer applications more quickly and with less effort than older development methods allowed.

A code library encapsulates functionality for a specific purpose into a single assembly. In the case of .NET, thousands of libraries are available, both first-party and third-party, commercial, and open source. These libraries provide a vast array of functionality that you can use in your applications. You just call the methods that other software developers have implemented.  

An application framework combines several related libraries, along with starter projects, file templates, code generators, and other tools to enable developers to build entire applications for a specific purpose.  These applications are known as *app models*. For example, popular .NET application frameworks are available for app models like web development, desktop and mobile development, and game development.

When you install the .NET SDK, whether directly or by installing Visual Studio 2019, it preinstalls a comprehensive set of libraries and application frameworks called the *base class libraries*. You can use these libraries on any platform or for app model that you want to build.

For other libraries, developers use package managers like NuGet. Developers find and integrate code libraries from package repositories like the NuGet Gallery.

#### What are the major app models?

You might wonder which .NET frameworks support which app models. Use the following table to map an app model to a .NET framework.

| App model | Framework | Notes |
|---|---|---|
| Web  | ASP.NET Core |  The framework for building server-side logic. |
| Web  | ASP.NET Core MVC |  The framework for building server-side logic for web pages or web APIs. |
| Web  | ASP.NET Core Pages |  The framework for building server-generated HTML.  |
| Web client | Blazor | Blazor is a part of ASP.NET Core. Its two modes allow for either Document Object Model (DOM) manipulation via sockets as a communication vehicle for running server-side code, or a WebAssembly implementation for running compiled C# on a browser.  |
| Desktop  | WinForms | A framework for building "battleship gray" Windows-style applications. |
| Desktop  | Windows Presentation Foundation (WPF) | A framework for building dynamic desktop applications that conform to different form factors. WPF allows form elements to perform movement, fades, glides, and other effects with the help of a rich library of animations. |
| Mobile | Xamarin |  Allows .NET developers to build apps for iOS and Android devices. |

Furthermore, .NET powers popular third-party and open-source gaming development environments and engines like Unity.

### Use .NET tools to build .NET apps

Software developers rely on tools to write code, add references to code libraries, compile code, and debug code. This section describes several .NET tools that you'll use to build .NET applications.

Visual Studio 2019 is the Microsoft flagship development environment. Millions of developers use it to build applications. A graphical user interface that includes menus, windows, visual designers, dialog boxes, and wizards guides developers through the application development process. 

Visual Studio 2019 is available in three editions: Community, Professional, and Enterprise. Each edition includes different tools and is licensed for different purposes. Developers who prefer a command-line workflow might use a combination of Visual Studio Code, the world's most popular code editor, and the .NET command-line interface, also known as the *.NET CLI*, as they create .NET applications.

Developers can choose from an expansive number of first-party and third-party tools for advanced .NET use cases. Options include code profilers, unit test runners, and code coverage analyzers.

You can use other .NET tools for other scenarios. For example, later in this module you'll work with Try .NET. This application is a browser-based interface for writing simple applications that will help you learn the C# programming language.

Finally, PowerShell is a tool that allows system administrators and DevOps engineers to write scripts that access .NET functionality. Administrators use these scripts to help manage their organization's computing environment.

### Find solutions and answers in documentation and tutorials

Microsoft actively provides a rich set of documentation, tutorials, and training. You'll find learning materials in popular modalities to help you at each step in your learning process.  

Microsoft Docs provides quickstart tutorials and definitive reference documentation. Patterns and Practices documentation helps developers find solutions to common application development needs. Resources often transcend code and delve into products and services that enable seemingly infinite scalable architectures. The .NET team provides video tutorials to walk developers through common usage scenarios.  

And finally, Microsoft Learn modules like this one provide hands-on labs to help you build your skills. They combine instruction, guidance, exercises, media, knowledge checks, and a means of tracking your progress.

### Interact with the .NET community to learn, grow, and share solutions

The .NET ecosystem extends beyond the languages, libraries, and tools to the people. .NET community members host live online events and in-person meet-ups. They build open-source software, participate in Q&A forums, and record video tutorials. They write books and blog posts that help you learn and get unstuck when you're not sure what to do next.

.NET is open source on [GitHub](https://github.com/dotnet?azure-portal=true). The projects within that repository are managed by the .NET Foundation. This independent organization is dedicated to growing a trusted, commercially friendly, open-source ecosystem around the .NET development platform.

## How does the .NET ecosystem compare to others?

If you're familiar with the software development world at large, you might wonder how the .NET ecosystem compares to others. Frankly, other ecosystems can make similar claims to some or many of the statements made so far in this unit.

However, one of the most distinctive features of .NET is that its ongoing development and support comes from not only a major technology leader but also the community. Significant portions of .NET were developed through open-source means. Community input and contributions are both welcomed and encouraged. In fact, 87 percent of contributors are outside of Microsoft. Based on community input, Microsoft actively moves the platform forward with feature enhancements, bug fixes, and performance improvements. More than 100,000 pull requests have been accepted from the community.

Additionally, the .NET ecosystem has momentum:

- .NET developers number more than 5 million!
- The results of a Stack Overflow poll in 2019 and 2020 showed that .NET Core  is the most loved framework.
- Students love .NET; 40 percent of developers who are new to .NET are students.
- The GitHub repositories for .NET and ASP.NET are ranked among the top 30 highest-velocity open-source software (OSS) projects.
- GitHub lists C# in the top five programming languages. And the language is increasing in popularity, according to the 2020 TIOBE programming community index.
- .NET has the fastest web framework on the planet, according to [TechEmpower benchmarks](https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=plaintext&a=2?azure-portal=true), an independent, open-source set of web performance benchmarks that measure dozens of languages and application frameworks.


## A brief history of .NET

The original .NET Framework was first released in early 2002. Since then, many updates and much more functionality have followed.  After years of enhancements and new features, the original .NET Framework, especially key code libraries, grew significantly.

After 2002, Microsoft worked to make a version of .NET that had cross-platform compatibility. The goal was to allow developers to write one code base and use it across macOS, Linux, and Windows operating systems. 

Through these efforts, .NET Core was introduced around 2014. Microsoft has maintained the original .NET Framework. But new features and improvements are reserved for .NET Core. *Core* was later dropped from the name. The next major versions are .NET 5, .NET 6, .NET 7, and so on. Versions are generally released each November.

Why is the .NET history worth mentioning? Because you'll likely find blog posts, videos, and source code that targets the original .NET Framework. In some cases, the instructions or code still work, but in other cases, you might need to make adjustments to fit the new .NET.