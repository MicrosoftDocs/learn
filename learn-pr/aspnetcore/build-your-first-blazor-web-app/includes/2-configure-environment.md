To get started with Blazor, you first need to install the .NET SDK and an appropriate code editor.

## Using the .NET SDK

The .NET SDK is available for download from the [.NET website](https://dot.net). .NET provides installers and installation instructions for various different platforms and architectures. The .NET SDK includes the .NET runtime and tools for creating, building, running, publishing, and testing .NET projects. You can interact directly with the .NET SDK using the .NET command-line interface (CLI).

The .NET SDK includes templates for creating different kinds of .NET projects. You create a new project using the `dotnet new <template-name>` command. For example, to create a new Blazor web app project you can run `dotnet new blazor`. Tools, like Visual Studio and Visual Studio Code, provide convenient user interfaces for creating .NET projects using the  templates in the .NET SDK.

Once you create a new .NET project, you can build and run the project using the `dotnet build` and `dotnet run` commands. The `dotnet watch` command can be used to build and run a project and then automatically apply code changes as they're made. You can run and debug .NET projects from within Visual Studio and Visual Studio Code.

## Blazor tooling

Blazor tooling is available with [Visual Studio](https://visualstudio.com/vs) on Windows and with the [C# Dev Kit](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit) extension for [Visual Studio Code](https://code.visualstudio.com), which is supported on Windows, macOS, and Linux. Visual Studio on Windows is a fully integrated development environment (IDE), while Visual Studio Code is a lighter-weight code editor with a rich ecosystem of extensions. Both have free options available for learning and community use. When you install Visual Studio on Windows, it automatically includes the .NET SDK. The .NET SDK isn't currently included with the C# Dev Kit for Visual Studio Code and must be installed separately.
