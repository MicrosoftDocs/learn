In this unit, you'll learn how the .NET Upgrade Assistant can help you analyze your existing ASP.NET applications and plan your upgrade to ASP.NET Core.

The [.NET Upgrade Assistant](/dotnet/core/porting/upgrade-assistant-overview) is a command-line tool that can be run on different kinds of .NET Framework apps. It's designed to assist with upgrading .NET Framework apps to .NET 7. After running the tool, **in most cases the app will require additional effort to complete the migration**. The tool includes the installation of analyzers that can assist with completing the migration.

While you may choose to use the CLI tool to upgrade your project, this unit covers using the official Visual Studio extension. To follow along you'll need to download and install it:

> [!div class="nextstepaction"]
> [Visual Studio: .NET Upgrade Assistant extension](https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.upgradeassistant)

The tool supports the following .NET Framework app types:

- .NET Framework Windows Forms apps
- .NET Framework WPF apps
- .NET Framework ASP.NET MVC apps
- .NET Framework ASP.NET Web API apps
- .NET Framework console apps
- .NET Framework class libraries

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
- Add references to analyzers that help with upgrade, such as the `Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers` package.

After running this tool on a solution to upgrade, the solution will likely not build until the upgrade is completed manually. Analyzers added to the solution will highlight some of the remaining changes needed after the tool runs.

### Analyze solution prior to upgrade

When run on a solution in order to analyze dependencies prior to upgrade, the tool will provide an analysis report for each of the projects in the solution containing details on:

- Package dependencies that need to be removed/added/upgraded in order to upgrade the project to chosen target framework (STS, LTS, or Preview).
- References that need to be removed/added/upgraded in order to upgrade the project to chosen target framework (STS, LTS, or Preview).
- Framework References that need to be removed/added/upgraded in order to upgrade the project to chosen target framework (STS, LTS, or Preview).
- Call out if there's a package upgrade across major versions that could lead towards having breaking changes.
- Unsupported API for the chosen target framework (STS, LTS, or Preview) used in the projects with pointers to recommended path forward if one is available.

> [!TIP]
> The Upgrade Assistant and upgrade documentation make repeated references to **TFM**. The TFM is an abbreviation for [Target Framework Moniker](/dotnet/standard/frameworks), and is used to indicate the set of APIs available to a project or library. Some example TFM's include `net48` for .NET Framework 4.8 and `net7.0` for .NET 7.0. The Upgrade Assistant will handle the TFM conversion in your project file for you.

## Troubleshooting tips

There are several known problems that can occur when using the .NET Upgrade Assistant. In some cases, these are problems with the [try-convert tool](https://github.com/dotnet/try-convert) that the .NET Upgrade Assistant uses internally.

[The tool's GitHub repository](https://github.com/dotnet/upgrade-assistant#troubleshooting-common-issues) has more troubleshooting tips and known issues.
