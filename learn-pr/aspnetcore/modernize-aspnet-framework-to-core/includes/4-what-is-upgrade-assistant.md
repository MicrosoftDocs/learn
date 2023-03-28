In this unit, you'll learn how the .NET Upgrade Assistant can help you analyze your existing ASP.NET applications and plan your upgrade to ASP.NET Core.

The [.NET Upgrade Assistant](/dotnet/core/porting/upgrade-assistant-overview) is a tool that helps you upgrade different kinds of application from older versions of .NET Framework, .NET Core, .NET 5, and .NET 6 to the latest .NET version. It's available in two "flavors":  A Visual Studio extension and a CLI tool. After running Upgrade Assistant, **in some cases the app will require additional effort to complete the upgrade**. The tool receives constant updates with additional analyzers that automate fixes for breaking changes and simplify the upgrade process, so make sure you have the latest version of the tool.

The Visual Studio extension is convenient and provides graphical feedback throughout the upgrade, so in this unit we'll show how to use the extension. Meanwhile, if you prefer to use CLI, the [documentation and installer are available on GitHub](https://github.com/dotnet/upgrade-assistant/blob/main/README.md).

To follow along you'll need to download and install VS extension:
> [!div class="nextstepaction"]
> [Visual Studio: .NET Upgrade Assistant extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.upgradeassistant)

The tool supports the following .NET Framework app types:

- Windows Forms apps
- WPF apps
- ASP.NET MVC apps
- ASP.NET Web API apps
- Console apps
- Class libraries

It upgrades apps from the following versions of .NET:

- .NET Framework
- .NET Core
- .NET 5
- .NET 6

to the latest Standard Term Support (STS), Long Term Support (LTS), or Preview versions of .NET.

The tool also supports upgrades:

- from Xamarin.Forms to .NET MAUI
- from WCF to Core WCF

### Upgrade steps performed by the Upgrade Assistant

When upgrading a solution the tool will:

- Determine which projects need upgraded and recommend the order in which projects should be upgraded.
- Update the project file to be an SDK-style project.
- Remove transitive NuGet package dependencies that may have been present in packages.config.
- Re-target project to [Standard Term Support (STS), Long Term Support (LTS), or Preview](https://dotnet.microsoft.com/platform/support/policy/dotnet-core).
- Update NuGet package dependencies to versions that are compatible with STS, LTS, or Preview.
- Make simple updates in C# source code to replace patterns that worked in .NET Framework with STS, LTS, or Preview equivalents.
- For some app models (like ASP.NET apps), add common template files (like _Startup.cs_) and make simple updates based on recognized web.config or app.config values.
- For projects targeting Windows, add a reference to the `Microsoft.Windows.Compatibility` package.

> [!TIP]
> The Upgrade Assistant and upgrade documentation make repeated references to **TFM**. The TFM is an abbreviation for [Target Framework Moniker](/dotnet/standard/frameworks), and is used to indicate the set of APIs available to a project or library. Some example TFM's include `net48` for .NET Framework 4.8 and `net7.0` for .NET 7.0. The Upgrade Assistant will handle the TFM conversion in your project file for you.

## Troubleshooting tips

Several known problems can occur when using the .NET Upgrade Assistant. In some cases, these are problems with the [try-convert tool](https://github.com/dotnet/try-convert) that the .NET Upgrade Assistant uses internally.

[The tool's GitHub repository](https://github.com/dotnet/upgrade-assistant#troubleshooting-common-issues) has more troubleshooting tips and known issues.
