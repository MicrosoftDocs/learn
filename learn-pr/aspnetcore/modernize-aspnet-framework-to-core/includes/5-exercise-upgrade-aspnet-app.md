In this unit, you'll upgrade an ASP.NET MVC 5 application to ASP.NET Core.

## Upgrade .NET Framework ASP.NET MVC apps

This section demonstrates running the .NET Upgrade Assistant against a newly created ASP.NET MVC app targeting .NET Framework 4.6.1.

## Install the .NET Upgrade Assistant

The [Get Started tutorial](https://aka.ms/dotnet-upgrade-assistant-install) walks through how to install and use the .NET Upgrade Assistant.

### Verify your prerequisites

- This tool uses MSBuild to work with project files. Make sure that a recent version of MSBuild is installed. An easy way to satisfy this requirement is to [install Visual Studio 2022](https://visualstudio.microsoft.com/downloads/).

### Install the .NET Upgrade Assistant

Open a console window and run the following command:

```dotnet
dotnet tool install -g upgrade-assistant
```

### Create an ASP.NET MVC 5 app

Using Visual Studio, create a new ASP.NET Web Application project using .NET Framework.

![New ASP.NET Web Application project in Visual Studio](../media/new-project.png)

Name the project **AspNetMvcTest**. Configure the project to use **.NET Framework 4.6.1**.

![Configure ASP.NET project in Visual Studio](../media/configure-project.png)

In the next dialog, choose **MVC** application, then select **Create**.

![Create an ASP.NET MVC project in Visual Studio](../media/create-mvc-webapi.png)

Review the created project and its files, especially its project file(s).

### Run the Upgrade Assistant

Open a terminal and navigate to the folder where the target project or solution is located. Run the `upgrade-assistant` command, passing in the name of the project you're targeting (you can run the command from anywhere, as long as the path to the project file is valid).

```console
upgrade-assistant upgrade .\AspNetMvcTest.csproj
```

The tool runs and shows you a list of the steps it will do.

![.NET Upgrade Assistant initial screen](../media/initial-run.png)

As each step is completed, the tool provides a set of commands allowing the user to apply or skip the next step, see more details, configure logging, or exit the process. If the tool detects that a step will perform no actions, it automatically skips that step and continues to the next step until it reaches one that has actions to do. Pressing <kbd>Enter</kbd> will start the next step if no other selection is made.

In this example, the apply step is chosen each time. The first step is to back up the project.

![.NET Upgrade Assistant back up project](../media/backup-project.png)

The tool prompts for a custom path for the backup, or to use the default, which will place the project backup in the same folder with a `.backup` extension. The next step the tool does is to convert the project file to SDK style.

![.NET Upgrade Assistant convert project to SDK style](../media/convert-project.png)

Once the project format has been updated, the next step is to update the TFM of the project.

![.NET Upgrade Assistant update TFM](../media/update-tfm.png)

Next, the tool updates the project's NuGet packages. Several packages need updates, and a new analyzer package is added.

![.NET Upgrade Assistant update NuGet packages](../media/update-nuget-packages.png)

Once the packages are updated, the next step is to add template files, if any. The tool notes there are four expected template items that must be added, and then adds them. The following is a list of the template files:

- `Program.cs`
- `Startup.cs`
- `appsettings.json`
- `appsettings.Development.json`

These files are used by ASP.NET Core for [app startup](/aspnet/core/fundamentals/startup) and [configuration](/aspnet/core/fundamentals/configuration).

![.NET Upgrade Assistant add template files](../media/add-template-files.png)

Next, the tool migrates config files. The tool identifies app settings and disables unsupported configuration sections, then migrates the `appSettings` configuration values.

![.NET Upgrade Assistant migrate configuration](../media/migrate-config.png)

The tool completes the migration of config files by migrating `system.web.webPages.razor/pages/namespaces`.

![.NET Upgrade Assistant migrate config completed](../media/migrate-config2.png)

The tool applies known fixes to migrate C# references to their new counterparts.

![.NET Upgrade Assistant update C# source](../media/update-csharp.png)

Since this is the last project, the next step, "Move to next project", prompts to complete the process of migrating the entire solution.

![.NET Upgrade Assistant completing the solution](../media/complete-solution.png)

Once this process has completed, open the project file and review it. Look for static files like these:

```xml
  <ItemGroup>
    <Content Include="fonts\glyphicons-halflings-regular.woff2" />
    <Content Include="fonts\glyphicons-halflings-regular.woff" />
    <Content Include="fonts\glyphicons-halflings-regular.ttf" />
    <Content Include="fonts\glyphicons-halflings-regular.eot" />
    <Content Include="Content\bootstrap.min.css.map" />
    <Content Include="Content\bootstrap.css.map" />
    <Content Include="Content\bootstrap-theme.min.css.map" />
    <Content Include="Content\bootstrap-theme.css.map" />
    <Content Include="Scripts\jquery-3.4.1.slim.min.map" />
    <Content Include="Scripts\jquery-3.4.1.min.map" />
  </ItemGroup>
```

Static files that should be served by the web server should be moved to an appropriate folder within a root level folder named `wwwroot`. See [Static files in ASP.NET Core](/aspnet/core/fundamentals/static-files) for details. Once the files have been moved, the `<Content>` elements in the project file corresponding to these files can be deleted. In fact, all `<Content>` elements and their containing groups can be removed. Also, any `<PackageReference>` to a client-side library like `bootstrap` or `jQuery` should be removed.

By default, the project will be converted as a class library. Change the first line's `Sdk` attribute to `Microsoft.NET.Sdk.Web` and set the `<TargetFramework>` to `net6.0`. Compile the project. At this point, the number of errors should be fairly small. When porting a new ASP.NET 4.6.1 MVC project, the remaining errors refer to files in the `App_Start` folder:

- BundleConfig.cs
- FilterConfig.cs
- RouteConfig.cs

These files, and the entire `App_Start` folder, can be deleted. Likewise, the `Global.asax` and `Global.asax.cs` files can be removed.

At this point the only errors that remain are related to bundling. There are [several ways to configure bundling and minification in ASP.NET Core](/aspnet/core/migration/mvc#configure-bundling-and-minification). Choose whatever makes the most sense for your project.
