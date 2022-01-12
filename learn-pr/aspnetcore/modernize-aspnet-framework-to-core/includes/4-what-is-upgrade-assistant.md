In this unit, you'll understand how the .NET Upgrade Assistant can help you analyze your existing ASP.NET applications and plan your upgrade to ASP.NET Core.

The [.NET Upgrade Assistant](/dotnet/core/porting/upgrade-assistant-overview) is a command-line tool that can be run on different kinds of .NET Framework apps. It's designed to assist with upgrading .NET Framework apps to .NET 6. After running the tool, **in most cases the app will require additional effort to complete the migration**. The tool includes the installation of analyzers that can assist with completing the migration.

Currently the tool supports the following .NET Framework app types:

- .NET Framework Windows Forms apps
- .NET Framework WPF apps
- .NET Framework ASP.NET MVC apps
- .NET Framework console apps
- .NET Framework class libraries

## How to install the .NET Upgrade Assistant

The [Get Started tutorial](https://aka.ms/dotnet-upgrade-assistant-install) walks through how to install and use the .NET Upgrade Assistant.

### Prerequisites

- This tool uses MSBuild to work with project files. Make sure that a recent version of MSBuild is installed. An easy way to satisfy this requirement is to [install Visual Studio 2019](https://visualstudio.microsoft.com/downloads/).

### Installation steps

The tool can be installed as a .NET CLI tool by running:

```dotnet
dotnet tool install -g upgrade-assistant
```

Similarly, because the .NET Upgrade Assistant is installed as a .NET CLI tool, it can be easily updated by running:

```dotnet
dotnet tool update -g upgrade-assistant
```
