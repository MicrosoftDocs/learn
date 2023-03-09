In this unit, you'll understand how the .NET Upgrade Assistant can help you analyze your existing ASP.NET applications and plan your upgrade to ASP.NET Core.

The [.NET Upgrade Assistant](/dotnet/core/porting/upgrade-assistant-overview) is a command-line tool that can be run on different kinds of .NET Framework apps. It's designed to assist with upgrading .NET Framework apps to .NET 6. After running the tool, **in most cases the app will require additional effort to complete the migration**. The tool includes the installation of analyzers that can assist with completing the migration.

Currently the tool supports the following .NET Framework app types:

- .NET Framework Windows Forms apps
- .NET Framework WPF apps
- .NET Framework ASP.NET MVC apps
- .NET Framework ASP.NET Web API apps
- .NET Framework console apps
- .NET Framework class libraries

### Upgrade steps performed by the Upgrade Assistant

When run on a solution in order to upgrade, the tool will:

- Determine which projects need upgraded and recommend the order in which projects should be upgraded.
- Update the project file to be an SDK-style project.
- Remove transitive NuGet package dependencies that may have been present in packages.config.
- Re-target project to .NET current, [Long Term Support (LTS)](https://dotnet.microsoft.com/platform/support/policy/dotnet-core), or preview.
- Update NuGet package dependencies to versions that are compatible with .NET current, LTS, or preview.
- Make simple updates in C# source code to replace patterns that worked in .NET Framework with current, LTS, or preview equivalents.
- For some app models (like ASP.NET apps), add common template files (like startup.cs) and make simple updates based on recognized web.config or app.config values.
- For projects targeting Windows, add a reference to the Microsoft.Windows.Compatibility package.
- Add references to analyzers that help with upgrade, such as the Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers package.

After running this tool on a solution to upgrade, the solution will likely not build until the upgrade is completed manually. Analyzers added to the solution will highlight some of the remaining changes needed after the tool runs.

### Analyze solution prior to upgrade

When run on a solution in order to analyze dependencies prior to upgrade, the tool will provide an analysis report for each of the projects in the solution containing details on:

- Package dependencies that need to be removed/added/upgraded in order to upgrade the project to chosen target framework (current, LTS, or preview).
- References that need to be removed/added/upgraded in order to upgrade the project to chosen target framework (current, LTS, or preview).
- Framework References that need to be removed/added/upgraded in order to upgrade the project to chosen target framework (current, LTS, or preview).
- Call out if there's a package upgrade across major versions that could lead towards having breaking changes.
- Unsupported API for the chosen target framework (current, LTS, or preview) used in the projects with pointers to recommended path forward if one is available.

> [!NOTE]
> The Upgrade Assistant and upgrade documentation make repeated references to **TFM**. The TFM is an abbreviation for [Target Framework Moniker](/dotnet/standard/frameworks), and is used to indicate the set of APIs available to a project or library. Some example TFM's include `net48` for .NET Framework 4.8 and `net6.0` for .NET 6.0. The Upgrade Assistant will handle the TFM conversion in your project file for you.

## Troubleshooting tips

There are several known problems that can occur when using the .NET Upgrade Assistant. In some cases, these are problems with the [try-convert tool](https://github.com/dotnet/try-convert) that the .NET Upgrade Assistant uses internally.

[The tool's GitHub repository](https://github.com/dotnet/upgrade-assistant#troubleshooting-common-issues) has more troubleshooting tips and known issues.
