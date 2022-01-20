In this unit, you'll upgrade an ASP.NET MVC 5 application to ASP.NET Core.

## Upgrade .NET Framework ASP.NET MVC apps

This section demonstrates running the .NET Upgrade Assistant against a newly created ASP.NET MVC app targeting .NET Framework 4.6.1.

## Create an ASP.NET MVC 5 app

1. Using Visual Studio, create a new ASP.NET Web Application project using .NET Framework.

   ![New ASP.NET Web Application project in Visual Studio](../media/new-project.png)

1. Name the project **AspNetMvcTest**. Configure the project to use **.NET Framework 4.6.1**.

   ![Configure ASP.NET project in Visual Studio](../media/configure-project.png)

1. In the next dialog, choose **MVC** application, then select **Create**.

   ![Create an ASP.NET MVC project in Visual Studio](../media/create-mvc-webapi.png)

   Review the created project and its files.

1. Before converting the project, we'll want to look at the project file. Right-click the project in the Solution Explorer and select **Unload Project**. The source for the project file (`AspNetMvcTest.csproj`) will be displayed in the editor.

1. Close Visual Studio.


## Install the .NET Upgrade Assistant

1. Open a console window and run the following command:

   ```dotnetcli
   dotnet tool install -g upgrade-assistant
   ```

### Run the Upgrade Assistant

1. In your console window, navigate to the folder where the target project or solution is located.

1. Run the `upgrade-assistant` command, passing in the name of the project you're targeting (you can run the command from anywhere, as long as the path to the project file is valid).

   ```dotnetcli
   upgrade-assistant upgrade AspNetMvcTest.csproj
   ```

   The tool runs and shows you a list of the steps it will do.

   ![.NET Upgrade Assistant initial screen](../media/initial-run.png)

   As each step is completed, the tool provides a set of commands allowing the user to apply or skip the next step, see more details, configure logging, or exit the process. If the tool detects that a step will perform no actions, it automatically skips that step and continues to the next step until it reaches one that has actions to do. Pressing <kbd>Enter</kbd> will start the next step if no other selection is made.

1. In this example, you will chose the the apply step each time. The first step is to back up the project. Type **1** and press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant back up project](../media/backup-project.png)

   The tool prompts for a custom path for the backup, or to use the default, which will place the project backup in the same folder with a `.backup` extension.

1. The next step is to convert the project file to SDK style. Press the <kbd>Enter</kbd> key to proceed.

    ![.NET Upgrade Assistant convert project to SDK style](../media/convert-project.png)

1. Once the project format has been updated, the next step is to clean up NuGet package references. Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant clean up NuGet package references](../media/cleanup-package-references.png)

1. Next, you will use the Upgrade Assistant to update the TFM of the project. Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant update TFM](../media/update-tfm.png)

1. Next, the tool updates the project's NuGet packages. Several packages need updates, and a new analyzer package is added. Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant update NuGet packages](../media/update-nuget-packages.png)

   Once the packages are updated, the next step is to add template files, if any. The tool notes there are four expected template items that must be added, and then adds them. The following is a list of the template files:

   - `Program.cs`
   - `Startup.cs`
   - `appsettings.json`
   - `appsettings.Development.json`

   These files are used by ASP.NET Core for [app startup](/aspnet/core/fundamentals/startup) and [configuration](/aspnet/core/fundamentals/configuration). Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant add template files](../media/add-template-files.png)

1. Next, the tool migrates config files. The tool identifies app settings and disables unsupported configuration sections, then migrates the `appSettings` configuration values. Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant migrate configuration](../media/migrate-config.png)

   The tool completes the migration of config files by migrating `system.web.webPages.razor/pages/namespaces`.

   ![.NET Upgrade Assistant migrate config completed](../media/migrate-config2.png)

1. The tool applies known fixes to migrate C# references to their new counterparts. Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant update C# source](../media/apply-fixes.png)

1. Finally, the tool updates C# source code where possible, and notes manual updates that will need to be completed. Press the <kbd>Enter</kbd> key to continue.

   ![.NET Upgrade Assistant update C# source](../media/update-csharp.png)

1. Since this is the last project, the next step, "Move to next project", prompts to complete the process of migrating the entire solution. Press the <kbd>Enter</kbd> key to finalize the upgrade and exit the Upgrade Assistant.

   ![.NET Upgrade Assistant completing the solution](../media/complete-solution.png)

## Complete Manual Upgrade Steps

1. Open the project in Visual Studio and review it. Look for static files like these:

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
