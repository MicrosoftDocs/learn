In this unit, you'll upgrade an ASP.NET MVC 5 application to ASP.NET Core using the Upgrade Assistant.

## Upgrade .NET Framework ASP.NET MVC apps

This section demonstrates running the .NET Upgrade Assistant against a newly created ASP.NET MVC app targeting .NET Framework 4.6.1.

## Create an ASP.NET MVC 5 app

1. Using Visual Studio, create a new ASP.NET Web Application project using .NET Framework.

   :::image type="content" source="../media/new-project.png" alt-text="Screenshot of the Visual Studio new project dialog with 'ASP.NET Web Application (.NET Framework)' highlighted.":::

1. Name the project **AspNetMvcTest**. Configure the project to use **.NET Framework 4.6.1**.

   :::image type="content" source="../media/configure-project.png" alt-text="Screenshot of the 'Configure your new project' dialog in Visual Studio. The Project Name has been set to AspNetMvcTest, and the Framework has been set to .NET Framework 4.6.1.":::

1. In the next dialog, choose **MVC** application, then select **Create**.

   :::image type="content" source="../media/create-mvc-web-api.png" alt-text="Screenshot of the 'Create a new ASP.NET Web Application' dialog in Visual Studio. MVC has been selected, and other settings have been left to their default values.":::

   Review the created project and its files.

1. Before converting the project, we'll want to look at the project file. Right-click the project in the Solution Explorer and select **Unload Project**. The source for the project file (`AspNetMvcTest.csproj`) will be displayed in the editor.

1. Close Visual Studio.

## Install the .NET Upgrade Assistant

- Open a console window and run the following command:

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

   :::image type="complex" source="../media/initial-run.png" alt-text="Screenshot of Windows Terminal showing the initial run of the Upgrade Assistant."::: Screenshot of the Windows Terminal. The screenshot shows the execution of the upgrade-assistant command. The command lists out the initialization information, showing the MSBuild, Visual Studio, and project file paths. It lists the steps it will perform, showing the first step is to back up the file. The first step is highlighted. A command list is shown in the bottom right of the screen. The first command is "Apply next step (Back up project)". :::image-end:::

   As each step is completed, the tool provides a set of commands allowing the user to apply or skip the next step, see more details, configure logging, or exit the process. If the tool detects that a step will perform no actions, it automatically skips that step and continues to the next step until it reaches one that has actions to do. Pressing <kbd>Enter</kbd> will start the next step if no other selection is made.

1. In this example, you will choose the apply step each time. The first step is to back up the project. Type **1** and press the <kbd>Enter</kbd> key to continue.

   ```dos
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Next step] Back up project
   2. Convert project file to SDK style
   3. Clean up NuGet package references
   4. Update TFM
   5. Update NuGet Packages
   6. Add template files
   7. Upgrade app config files
       a. Convert Application Settings
       b. Convert Connection Strings
       c. Disable unsupported configuration sections
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0002: Types should be upgraded
       b. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project

   Choose a command:
   1. Apply next step (Back up project)
   2. Skip next step (Back up project)
   3. See more step details
   4. Configure logging
   5. Exit
   >
   [13:10:38 INF] Applying upgrade step Back up project
   Please choose a backup path
      1. Use default path [C:\Users\Jon\source\repos\AspNetMvcTest.backup]
      2. Enter custom path
   > 1
   [13:11:56 INF] Backing up C:\Users\Jon\source\repos\AspNetMvcTest to C:\Users\Jon\source\repos\AspNetMvcTest.backup
   [13:12:02 INF] Project backed up to C:\Users\Jon\source\repos\AspNetMvcTest.backup
   [13:12:02 INF] Upgrade step Back up project applied successfully
   Please press enter to continue...
   ```

   The tool prompts for a custom path for the backup, or to use the default, which will place the project backup in the same folder with a `.backup` extension.

1. The next step is to convert the project file to SDK style. Press the <kbd>Enter</kbd> key to proceed.

   ```dos
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Next step] Convert project file to SDK style
   3. Clean up NuGet package references
   4. Update TFM
   5. Update NuGet Packages
   6. Add template files
   7. Upgrade app config files
       a. Convert Application Settings
       b. Convert Connection Strings
       c. Disable unsupported configuration sections
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0002: Types should be upgraded
       b. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project

   Choose a command:
      1. Apply next step (Convert project file to SDK style)
      2. Skip next step (Convert project file to SDK style)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:24:52 INF] Applying upgrade step Convert project file to SDK style
   [13:24:52 INF] Converting project file format with try-convert, version 0.3.261602+8aa571efd8bac422c95c35df9c7b9567ad534ad0
   [13:24:52 INF] Recommending executable TFM net6.0 because the project builds to a web app C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj contains a reference to System.Web, which is not supported on .NET Core. You may have significant work ahead of you to fully port this project 'C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj' is a legacy web project and/or references System.Web. Legacy Web projects and System.Web are unsupported on .NET Core. You will need to rewrite your application or find a way to not depend on System.Web to convert this project.
   [13:24:55 INF] Converting project C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj to SDK style
   [13:24:57 INF] Project file converted successfully! The project may require additional changes to build successfully against the new .NET target.
   [13:25:00 INF] Upgrade step Convert project file to SDK style applied successfully
   Please press enter to continue...
   ```

1. Once the project format has been updated, the next step is to clean up NuGet package references. This removes some transitive dependencies, replaces a framework assembly reference with a NuGet package reference, and adds a new analyzer package. Press the <kbd>Enter</kbd> key to continue.

   ```dos
   [13:26:23 INF] Initializing upgrade step Clean up NuGet package references
   [13:26:26 INF] Marking assembly reference System.Configuration for removal based on package mapping configuration System.Configuration
   [13:26:26 INF] Adding package System.Configuration.ConfigurationManager based on package mapping configuration System.Configuration
   [13:26:27 INF] Reference to .NET Upgrade Assistant analyzer package (Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers, version 0.3.261602) needs to be added
   [13:26:27 INF] References to be removed: System.Configuration
   [13:26:27 INF] Packages to be added: System.Configuration.ConfigurationManager, Version=5.0.0
   Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers, Version=0.3.261602

   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Next step] Clean up NuGet package references
   4. Update TFM
   5. Update NuGet Packages
   6. Add template files
   7. Upgrade app config files
       a. Convert Application Settings
       b. Convert Connection Strings
       c. Disable unsupported configuration sections
       d. Convert system.web.webPages.razor/pages/namespaces
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. Apply fix for UA0002: Types should be upgraded
       c. Apply fix for UA0005: Do not use HttpContext.Current
       d. Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. Apply fix for UA0010: Attributes should be upgraded
       h. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Clean up NuGet package references)
      2. Skip next step (Clean up NuGet package references)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:30:20 INF] Applying upgrade step Clean up NuGet package references
   [13:30:20 INF] Removing outdated assembly reference: System.Configuration
   [13:30:20 INF] Adding package reference: System.Configuration.ConfigurationManager, Version=5.0.0
   [13:30:20 INF] Adding package reference: Microsoft.DotNet.UpgradeAssistant.Extensions.Default.Analyzers, Version=0.3.261602
   [13:30:24 INF] Upgrade step Clean up NuGet package references applied successfully
   Please press enter to continue...
   ```

1. Next, you will use the Upgrade Assistant to update the TFM of the project. Press the <kbd>Enter</kbd> key to continue.

   ```dos
   [13:41:41 INF] Initializing upgrade step Update TFM
   [13:41:41 INF] Recommending executable TFM net6.0 because the project builds to an executable
   [13:41:41 INF] TFM needs updated to net6.0

   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Next step] Update TFM
   5. Update NuGet Packages
   6. Add template files
   7. Upgrade app config files
       a. Convert Application Settings
       b. Convert Connection Strings
       c. Disable unsupported configuration sections
       d. Convert system.web.webPages.razor/pages/namespaces
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. Apply fix for UA0002: Types should be upgraded
       c. Apply fix for UA0005: Do not use HttpContext.Current
       d. Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. Apply fix for UA0010: Attributes should be upgraded
       h. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Update TFM)
      2. Skip next step (Update TFM)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:41:47 INF] Applying upgrade step Update TFM
   [13:41:47 INF] Recommending executable TFM net6.0 because the project builds to an executable
   [13:41:49 INF] Updated TFM to net6.0
   [13:41:49 INF] Upgrade step Update TFM applied successfully
   Please press enter to continue...
   ```

1. Next, the tool updates the project's NuGet packages. Several packages need updates. Press the <kbd>Enter</kbd> key to continue.

   ```dos
   [13:42:45 INF] Initializing upgrade step Update NuGet Packages
   [13:42:46 INF] Marking package Antlr for removal based on package mapping configuration Antlr
   [13:42:46 INF] Adding package Antlr4 based on package mapping configuration Antlr
   [13:42:46 INF] Marking package WebGrease for removal based on package mapping configuration WebGrease
   [13:42:47 INF] Reference to Newtonsoft package (Microsoft.AspNetCore.Mvc.NewtonsoftJson, version 6.0.1) needs to be added
   [13:42:47 INF] Packages to be removed: Antlr, Version=3.5.0.2
   WebGrease, Version=1.6.0
   [13:42:47 INF] Packages to be added: Antlr4, Version=4.6.6
   Microsoft.AspNetCore.Mvc.NewtonsoftJson, Version=6.0.1

   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Next step] Update NuGet Packages
   6. Add template files
   7. Upgrade app config files
       a. Convert Application Settings
       b. Convert Connection Strings
       c. Disable unsupported configuration sections
       d. Convert system.web.webPages.razor/pages/namespaces
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. Apply fix for UA0002: Types should be upgraded
       c. Apply fix for UA0005: Do not use HttpContext.Current
       d. Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. Apply fix for UA0010: Attributes should be upgraded
       h. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Update NuGet Packages)
      2. Skip next step (Update NuGet Packages)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:46:34 INF] Applying upgrade step Update NuGet Packages
   [13:46:34 INF] Removing outdated package reference: Antlr, Version=3.5.0.2
   [13:46:34 INF] Removing outdated package reference: WebGrease, Version=1.6.0
   [13:46:34 INF] Adding package reference: Antlr4, Version=4.6.6
   [13:46:34 INF] Adding package reference: Microsoft.AspNetCore.Mvc.NewtonsoftJson, Version=6.0.1
   [13:46:39 INF] Marking package Microsoft.CSharp for removal because it appears to be a transitive dependency
   [13:46:39 INF] Removing outdated package reference: Microsoft.CSharp, Version=4.7.0
   [13:46:41 INF] Upgrade step Update NuGet Packages applied successfully
   Please press enter to continue...
   ```

   Once the packages are updated, the next step is to add template files, if any. The tool notes there are four expected template items that must be added, and then adds them. The following is a list of the template files:

   - `Program.cs`
   - `Startup.cs`
   - `appsettings.json`
   - `appsettings.Development.json`

   These files are used by ASP.NET Core for [app startup](/aspnet/core/fundamentals/startup) and [configuration](/aspnet/core/fundamentals/configuration). Press the <kbd>Enter</kbd> key to continue.

   ```dos
   [13:46:45 INF] Initializing upgrade step Add template files
   [13:46:45 INF] 4 expected template items needed
   
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Complete] Update NuGet Packages
   6. [Next step] Add template files
   7. Upgrade app config files
       a. Convert Application Settings
       b. Convert Connection Strings
       c. Disable unsupported configuration sections
       d. Convert system.web.webPages.razor/pages/namespaces
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. Apply fix for UA0002: Types should be upgraded
       c. Apply fix for UA0005: Do not use HttpContext.Current
       d. Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. Apply fix for UA0010: Attributes should be upgraded
       h. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Add template files)
      2. Skip next step (Add template files)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:48:41 INF] Applying upgrade step Add template files
   [13:48:41 INF] Added template file Program.cs
   [13:48:41 INF] Added template file Startup.cs
   [13:48:41 INF] Added template file appsettings.json
   [13:48:41 INF] Added template file appsettings.Development.json
   [13:48:42 INF] 4 template items added
   [13:48:42 INF] Upgrade step Add template files applied successfully
   Please press enter to continue...
   ```

1. Next, the tool migrates config files. The tool identifies app settings and disables unsupported configuration sections, then migrates the `appSettings` configuration values. Press the <kbd>Enter</kbd> key to continue.

   ```dos
   [13:48:51 INF] Initializing upgrade step Upgrade app config files
   [13:48:51 INF] Found 4 app settings for upgrade: webpages:Version, webpages:Enabled, ClientValidationEnabled, UnobtrusiveJavaScriptEnabled
   [13:48:51 INF] Found 0 connection strings for upgrade:
   [13:48:51 INF] 1 web page namespace imports need upgraded: AspNetMvcTest
   
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Complete] Update NuGet Packages
   6. [Complete] Add template files
   7. Upgrade app config files
       a. [Next step] Convert Application Settings
       b. [Complete] Convert Connection Strings
       c. [Complete] Disable unsupported configuration sections
       d. Convert system.web.webPages.razor/pages/namespaces
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. Apply fix for UA0002: Types should be upgraded
       c. Apply fix for UA0005: Do not use HttpContext.Current
       d. Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. Apply fix for UA0010: Attributes should be upgraded
       h. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Convert Application Settings)
      2. Skip next step (Convert Application Settings)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:52:14 INF] Applying upgrade step Convert Application Settings
   [13:52:14 INF] Upgrade step Convert Application Settings applied successfully
   Please press enter to continue...
   ```

   The tool completes the migration of config files by migrating `system.web.webPages.razor/pages/namespaces`. This moves namespaces that are automatically imported into views from config files to a _ViewImports.cshtml file, instead.

   ```dos
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Complete] Update NuGet Packages
   6. [Complete] Add template files
   7. Upgrade app config files
       a. [Complete] Convert Application Settings
       b. [Complete] Convert Connection Strings
       c. [Complete] Disable unsupported configuration sections
       d. [Next step] Convert system.web.webPages.razor/pages/namespaces
   8. Update Razor files
       a. Apply code fixes to Razor documents
       b. Replace @helper syntax in Razor files
   9. Update source code
       a. Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. Apply fix for UA0002: Types should be upgraded
       c. Apply fix for UA0005: Do not use HttpContext.Current
       d. Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. Apply fix for UA0010: Attributes should be upgraded
       h. Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Convert system.web.webPages.razor/pages/namespaces)
      2. Skip next step (Convert system.web.webPages.razor/pages/namespaces)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:53:46 INF] Applying upgrade step Convert system.web.webPages.razor/pages/namespaces
   [13:53:46 INF] View imports written to C:\Users\Jon\source\repos\AspNetMvcTest\Views\_ViewImports.cshtml
   [13:53:46 INF] Upgrade step Convert system.web.webPages.razor/pages/namespaces applied successfully
   [13:53:46 INF] Applying upgrade step Upgrade app config files
   [13:53:46 INF] Upgrade step Upgrade app config files applied successfully
   Please press enter to continue...
   ```

1. The tool applies known fixes to migrate C# references to their new counterparts. Press the <kbd>Enter</kbd> key to continue.

   ```dos
   [13:54:31 INF] Initializing upgrade step Update Razor files
   [13:54:33 INF] Identified 0 diagnostics in Razor files in project AspNetMvcTest
   [13:54:33 INF] Found @helper functions in 0 documents
   [13:54:33 INF] Initializing upgrade step Update source code
   [13:54:33 INF] Running analyzers on AspNetMvcTest
   [13:54:33 INF] Identified 5 diagnostics in project AspNetMvcTest
   
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Complete] Update NuGet Packages
   6. [Complete] Add template files
   7. [Complete] Upgrade app config files
       a. [Complete] Convert Application Settings
       b. [Complete] Convert Connection Strings
       c. [Complete] Disable unsupported configuration sections
       d. [Complete] Convert system.web.webPages.razor/pages/namespaces
   8. [Complete] Update Razor files
       a. [Complete] Apply code fixes to Razor documents
       b. [Complete] Replace @helper syntax in Razor files
   9. Update source code
       a. [Complete] Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. [Next step] Apply fix for UA0002: Types should be upgraded
       c. [Complete] Apply fix for UA0005: Do not use HttpContext.Current
       d. [Complete] Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. [Complete] Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. [Complete] Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. [Complete] Apply fix for UA0010: Attributes should be upgraded
       h. [Complete] Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Apply fix for UA0002: Types should be upgraded)
      2. Skip next step (Apply fix for UA0002: Types should be upgraded)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:56:08 INF] Applying upgrade step Apply fix for UA0002: Types should be upgraded
   [13:56:08 INF] Diagnostic UA0002 fixed in C:\Users\Jon\source\repos\AspNetMvcTest\Controllers\HomeController.cs
   [13:56:08 INF] Running analyzers on AspNetMvcTest
   [13:56:08 INF] Identified 4 diagnostics in project AspNetMvcTest
   [13:56:08 INF] Diagnostic UA0002 fixed in C:\Users\Jon\source\repos\AspNetMvcTest\Controllers\HomeController.cs
   [13:56:08 INF] Running analyzers on AspNetMvcTest
   [13:56:08 INF] Identified 3 diagnostics in project AspNetMvcTest
   [13:56:08 INF] Diagnostic UA0002 fixed in C:\Users\Jon\source\repos\AspNetMvcTest\Controllers\HomeController.cs
   [13:56:08 INF] Running analyzers on AspNetMvcTest
   [13:56:08 INF] Identified 2 diagnostics in project AspNetMvcTest
   [13:56:08 INF] Diagnostic UA0002 fixed in C:\Users\Jon\source\repos\AspNetMvcTest\Controllers\HomeController.cs
   [13:56:08 INF] Running analyzers on AspNetMvcTest
   [13:56:08 INF] Identified 1 diagnostics in project AspNetMvcTest
   [13:56:08 INF] Upgrade step Apply fix for UA0002: Types should be upgraded applied successfully
   Please press enter to continue...
   ```

1. Finally, the tool updates C# source code where possible, and notes manual updates that will need to be completed. Press the <kbd>Enter</kbd> key to continue.

   ```dos
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Complete] Update NuGet Packages
   6. [Complete] Add template files
   7. [Complete] Upgrade app config files
       a. [Complete] Convert Application Settings
       b. [Complete] Convert Connection Strings
       c. [Complete] Disable unsupported configuration sections
       d. [Complete] Convert system.web.webPages.razor/pages/namespaces
   8. [Complete] Update Razor files
       a. [Complete] Apply code fixes to Razor documents
       b. [Complete] Replace @helper syntax in Razor files
   9. [Next step] Update source code
       a. [Complete] Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. [Complete] Apply fix for UA0002: Types should be upgraded
       c. [Complete] Apply fix for UA0005: Do not use HttpContext.Current
       d. [Complete] Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. [Complete] Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. [Complete] Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. [Complete] Apply fix for UA0010: Attributes should be upgraded
       h. [Complete] Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. Move to next project
   
   Choose a command:
      1. Apply next step (Update source code)
      2. Skip next step (Update source code)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [13:56:39 INF] Applying upgrade step Update source code
   [13:56:41 INF] Source updates complete with 1 diagnostics remaining which require manual updates
   [13:56:41 WRN] Manual updates needed to address: UA0013_C@SourceFile(C:\Users\Jon\source\repos\AspNetMvcTest\App_Start\BundleConfig.cs[261..277)): Script and style bundling works    differently in ASP.NET Core. BundleCollection should be replaced by alternative bundling technologies. https://learn.microsoft.com/aspnet/core/client-side/bundling-and-minification
   [13:56:41 INF] Upgrade step Update source code applied successfully
   Please press enter to continue...
   ```

1. Since this is the last project, the next step, "Move to next project", prompts to complete the process of migrating the entire solution. Press the <kbd>Enter</kbd> key to finalize the upgrade and exit the Upgrade Assistant.

   ```dos
   [13:56:46 INF] Initializing upgrade step Move to next project
   
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   Current Project: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   1. [Complete] Back up project
   2. [Complete] Convert project file to SDK style
   3. [Complete] Clean up NuGet package references
   4. [Complete] Update TFM
   5. [Complete] Update NuGet Packages
   6. [Complete] Add template files
   7. [Complete] Upgrade app config files
       a. [Complete] Convert Application Settings
       b. [Complete] Convert Connection Strings
       c. [Complete] Disable unsupported configuration sections
       d. [Complete] Convert system.web.webPages.razor/pages/namespaces
   8. [Complete] Update Razor files
       a. [Complete] Apply code fixes to Razor documents
       b. [Complete] Replace @helper syntax in Razor files
   9. [Complete] Update source code
       a. [Complete] Apply fix for UA0001: ASP.NET Core projects should not reference ASP.NET namespaces
       b. [Complete] Apply fix for UA0002: Types should be upgraded
       c. [Complete] Apply fix for UA0005: Do not use HttpContext.Current
       d. [Complete] Apply fix for UA0006: HttpContext.DebuggerEnabled should be replaced with System.Diagnostics.Debugger.IsAttached
       e. [Complete] Apply fix for UA0007: HtmlHelper should be replaced with IHtmlHelper
       f. [Complete] Apply fix for UA0008: UrlHelper should be replaced with IUrlHelper
       g. [Complete] Apply fix for UA0010: Attributes should be upgraded
       h. [Complete] Apply fix for UA0012: 'UnsafeDeserialize()' does not exist
   10. [Next step] Move to next project
   
   Choose a command:
      1. Apply next step (Move to next project)
      2. Skip next step (Move to next project)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [14:37:56 INF] Applying upgrade step Move to next project
   [14:37:56 INF] Upgrade step Move to next project applied successfully
   Please press enter to continue...
   
   [14:38:02 INF] Recommending executable TFM net6.0 because the project builds to an executable
   [14:38:02 INF] Recommending executable TFM net6.0 because the project builds to an executable
   [14:38:02 INF] Recommending executable TFM net6.0 because the project builds to an executable
   [14:38:02 INF] Initializing upgrade step Finalize upgrade
   
   Upgrade Steps
   
   Entrypoint: C:\Users\Jon\source\repos\AspNetMvcTest\AspNetMvcTest.csproj
   
   [14:38:02 INF] Recommending executable TFM net6.0 because the project builds to an executable
   1. [Next step] Finalize upgrade
   
   Choose a command:
      1. Apply next step (Finalize upgrade)
      2. Skip next step (Finalize upgrade)
      3. See more step details
      4. Configure logging
      5. Exit
   >
   [14:38:19 INF] Applying upgrade step Finalize upgrade
   [14:38:19 INF] Upgrade step Finalize upgrade applied successfully
   Please press enter to continue...
   
   [14:38:22 INF] Upgrade has completed. Please review any changes.
   
   C:\Users\Jon\source\repos\AspNetMvcTest>
   ```

## Complete manual upgrade steps

After completing the steps in the Upgrade Assistant, you'll need complete some manual steps to complete the upgrade.

> [!NOTE]
> Since both NuGet packages and the Upgrade Assistant are regularly updated, you may not hit the issues listed below, or you may encounter different issues. Troubleshooting steps are provided in the [Upgrade Assistant documentation](/dotnet/core/porting/upgrade-assistant-aspnetmvc).

### Remove unneeded NuGet packages

The Upgrade Assistant will attempt remove any packages that are no longer needed, but in some cases, the tool can't determine if a package is no longer needed. These packages will need to be reviewed removed manually.

As you upgrade your existing projects, you'll need to decide how you adapt to some architectural and stylistic changes. In this walkthrough, we'll be removing a NuGet reference to `Newtonsoft.Json` because a newer version already included in the `Microsoft.AspNetCore.Mvc.NewtonsoftJson` package. Additionally, we'll be removing NuGet packages which are used to include static JavaScript and CSS libraries.

1. Open the project file in Visual Studio and reload the project if it's unloaded (by right-clicking it in the solution explorer and choosing "Reload project").
1. Delete the **PackageReference** elements for the following packages:

   - `bootstrap`
   - `jQuery`
   - `jQuery.Validation`
   - `Microsoft.jQuery.Unobtrusive.Validation`
   - `Modernizr`
   - `Newtonsoft.Json`

1. Save and close the project file.

### Delete unused source files

1. Attempt to build the project. You'll get multiple build errors in `BundleConfig.cs`, `FilterConfig.cs`, `RouteConfig.cs`, `HomeController,cs`, and `Global.asax.cs`.

   In a production application, you'd need to review all of these files and manually migrate any custom code. Since this is a default project without any customizations, we can simply delete all of these files with the exception of `HomeController.cs`.

1. Delete the `App_Start` directory.
1. Delete `Global.asax.cs`.
1. Delete `web.config`.

### Remove unnecessary Using directives in the HomeController

The `HomeController` has an error due to a `using` directive that references `System.Web.Mvc`. This `using` statement will need to be removed in order to make the code compile. However, we can take advantage of the new [implicit usings](/dotnet/core/tutorials/top-level-templates#implicit-using-directives) feature in C# 6.0 to simplify our code further but removing all `using` directives from the `HomeController`.

1. Open the `HomeController.cs` and delete the top 5 lines to remove all `using` directives from the file.

### Move static files to *wwwroot*

Static files that should be served by the web server should be moved to an appropriate folder within a root level folder named `wwwroot`. See [Static files in ASP.NET Core](/aspnet/core/fundamentals/static-files) for details.

For this upgrade, we're going to follow the structure in a new ASP.NET Core 6 project, but you're free to structure the static files in `wwwroot` however you like.

1. Create a new `wwwroot` directory in the root of the project.
1. Drag the `Scripts` directory into the `wwwroot` directory.
1. Rename the `Scripts` directory to `lib`.
1. Drag the `Content` directory into the `wwwroot` directory.
1. Rename the `Content` directory to `css`.
1. Open the project file and delete the entire `<ItemGroup>` element that contains the JavaScript and CSS files that have been moved to `wwwroot`.

> [!NOTE]
> If you encounter build errors due to JavaScript references, you can close and re-open the project in Visual Studio.

### Update static file references in the Layout page

1. Open `Views/Shared/_Layout.cshtml`.
1. Delete the following lines from the `<head>` element:

   ```razor
    @Styles.Render("~/Content/css")
    @Scripts.Render("~/bundles/modernizr")
   ```

1. Replace the above lines with:

   ```html
    <link rel="stylesheet" href="~/css/bootstrap.min.css" />
    <link rel="stylesheet" href="~/css/bootstrap-theme.min.css" />
    <link rel="stylesheet" href="~/css/site.css" />
   ```

1. Delete the following lines from the bottom of the `<body>` element:

   ```razor
    @Scripts.Render("~/bundles/jquery")
    @Scripts.Render("~/bundles/bootstrap")
   ```

1. Replace the above lines with:

   ```html
    <script src="~/lib/jquery-3.4.1.min.js"></script>
    <script src="~/lib/jquery.validate.min.js"></script>
    <script src="~/lib/jquery.validate.unobtrusive.min.js"></script>
    <script src="~/lib/modernizr-2.8.3.js"></script>
    <script src="~/lib/bootstrap.min.js"></script>
   ```

### Run the application

At this point, the application should build and run successfully. Congratulations!

   :::image type="content" source="../media/upgraded-app-running.png" alt-text="Screenshot of browser window showing the ASP.NET Core application's home page.":::

## Summary

In this section, you completed an upgrade for a simple, specific test scenario: a default ASP.NET MVC 5 app with no authentication, data access, additional NuGet packages, or custom code. In a more complex scenario, you'll need to complete additional migration steps as detailed in the [ASP.NET Core Migration Guide](/aspnet/core/migration/index).
