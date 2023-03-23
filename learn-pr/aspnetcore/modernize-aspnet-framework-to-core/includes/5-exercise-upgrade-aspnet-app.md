In this unit, you'll upgrade an ASP.NET MVC 5 application to ASP.NET Core using the Upgrade Assistant.

## Upgrade .NET Framework ASP.NET MVC apps

This section demonstrates running the .NET Upgrade Assistant against an existing ASP.NET MVC app targeting .NET Framework.

## Verify the tools are installed

It's possible install the .NET Upgrade Assistant extension from the extension manager in Visual Studio, but for this exercise you're going to use the Visual Studio Installer. This way, you can also double-check that you have the required components to build the sample app.

1. Launch the Visual Studio Installer and select **Modify** on the Visual Studio 2022 installation.
1. On the **Workloads** tab, ensure the **ASP.NET and web development** workload is selected.
1. On the **Individual components** tab, search for the following components and ensure they are selected:
    - .NET Framework 4.8.1 targeting pack
    - .NET Upgrade Assistant
1. Select the **Modify** button (if present) to apply any changes. If no changes were made, select **Close**.

## Obtain the sample code

Let's obtain the sample app. It's just a standard boilerplate app generated from the ASP.NET MVC template.

1. Open Visual Studio 2022.
1. Using either the **Clone a repository** button on the quick start window or the **Git > Clone** command on the menu bar, download and open the sample repository from `https://github.com/MicrosoftDocs/mslearn-modernize-aspnet-framework-to-core`.

    :::image type="content" source="../media/git-clone.png" alt-text="Screenshot of the Visual Studio Git > Clone menu command.":::

1. Once the project opens, review the files in **Solution Explorer**. The app is an ASP.NET project built in .NET Framework 4.8.1. Press <kbd>F5</kbd> to run the app. After verifying it works, stop the app.

### Run the Upgrade Assistant

1. In **Solution Explorer**, right-click on the *AspNetMvcTest* project and select **Upgrade**.

    :::image type="content" source="../media/solution-explorer.png" alt-text="Solution Explorer with the project's context menu displayed and the Upgrade command highlighted.":::

    The **Upgrade Assistant** tab opens. Since the app to be upgraded is an ASP.NET MVC app, the only option available is **Side-by-side incremental project upgrade**.

    :::image type="content" source="../media/upgrade-assistant-welcome.png" alt-text="The welcome screen to the Upgrade Assistant. Only one option is displayed: Side-by-side incremental project upgrade":::

    This upgrade approach is great for web apps. It generates a new .NET project that implements YARP (Yet Another Reverse Proxy). If a resource URL is requested but not found in the new project, the request is forwarded to the old project. This way, you can incrementally migrate to the new app without losing any functionality.

1. Select **Side-by-side incremental project upgrade**.
1. Select **New project** and select **Next**.
1. Select a name for the new project. The assistant has suggested the name **AspNetMvcTestCore**. That's descriptive enough, so leave it alone. Verify that the **Project template** is set to *ASP.NET Core MVC* and select **Next**.
1. Choose your target framework. Select **.NET 7.0** and select **Next**.
1. Review the tasks to be performed:

   :::image type="content" source="../media/summarize-tasks.png" alt-text="The last screen of the wizard, displaying the tasks to be performed when creating the new AspNetMvcTestCore project.":::

   The Upgrade Assistant will:

   - Create a new ASP.NET Core project.
   - Set a new Start action (*Don't open a page*).
   - Set both projects as the solution's Startup projects.
   - Add YARP and System.Web adapter packages to the new project.
   - Add YARP settings to *appsettings.json*. The settings will be configured to forward requests to the old project.

1. Select **Finish** and the upgrade assistant will complete the initial migration.
1. Select **Done** to view the upgrade summary.

   :::image type="content" source="../media/ua-summary.png" alt-text="The summary screen showing the Endpoints distribution. Currently all the endpoints are in the ASP.NET MVC project.":::

## Incrementally upgrade controllers

From here, you can move classes and controllers incrementally to the new project.

1. Select the **Endpoints explorer** button and review the endpoints.

   :::image type="content" source="../media/endpoints-explorer.png" alt-text="The endpoints explorer step showing the detected endpoints, all of which or on HomeController.":::

   The detected routes and endpoints are displayed. Note that the endpoints are all actions on the *Home* controller.

1. Select the **Upgrade** dropdown and select **Controller**.
1. In the **Select controller to upgrade** dialog, select **AspNewMvcTest.Controllers.HomeController** and select **Upgrade**.
1. On the **Select components** dialog, expand all the nodes on the treeview.

   :::image type="content" source="../media/select-components.png" alt-text="The Select Components dialog with the treeview expanded.":::

   The Upgrade Assistant has detected the routes, classes, and views that need to be migrated to support the *Home* controller.

1. Select **Upgrade selection** to upgrade the selected components.
1. Select **Endpoints explorer** and note the endpoints and routes are now present in the new project.

## Complete manual upgrade steps

After completing the steps in the Upgrade Assistant, you'll need to complete some manual steps to complete the upgrade. The static *.js* and *.css* files aren't part of the automated upgrade, so you'll need to take an alternative approach. For this app, we'll move those by hand.

### Move static files to *wwwroot*

Static files that should be served by the web server should be moved to an appropriate folder within a root level folder named `wwwroot`. See [Static files in ASP.NET Core](/aspnet/core/fundamentals/static-files) for details.

1. Create a new `wwwroot` directory in the root of the *AspNewMvcTextCore* project.
1. Create a subdirectory to `wwwroot` named `css`.
1. Create another subdirectory to `wwwroot` named `js`.

   :::image type="content" source="../media/wwwroot-structure.png" alt-text="The wwwroot directory with the js and css subdirectories.":::

1. Copy the following files from the `Content` directory in the **old** *AspNetMvcTest* project to `wwwroot/css` in the **new** *AspNetMvcTestCore* project:

   - *bootstrap.min.css*
   - *Site.css*

1. Copy the following files from the `Scripts` directory in the **old** *AspNetMvcTest* project to `wwwroot/js` in the **new** *AspNetMvcTestCore* project:

   - *bootstrap.min.js*
   - *jquery-3.6.4.min.js*
   - *jquery.validate.min.js*
   - *jquery.validate.unobtrusive.min.js*
   - *modernizr-2.8.3.js*

The required static files have been moved.

:::image type="content" source="../media/wwwroot-with-files.png" alt-text="The wwwroot directory and subdirectories with all the required files present.":::

### Update static file references in the Layout page

The static files are where they need to be, so now we can update the Razor layout to reflect their new location.

1. In the **new** *AspNetMvcTestCore* project, Open `Views/Shared/_Layout.cshtml`.
1. Find the following lines in the `<head>` element:

   ```razor
   @*@Styles.Render("~/Content/css")*@
   @*@Scripts.Render("~/bundles/modernizr")*@
   ```

1. Replace the above lines with:

   ```html
   <link rel="stylesheet" href="~/css/bootstrap.min.css" />
   <link rel="stylesheet" href="~/css/bootstrap-theme.min.css" />
   <link rel="stylesheet" href="~/css/site.css" />
   ```

1. Find the following lines from the bottom of the `<body>` element:

   ```razor
   @*@Scripts.Render("~/bundles/jquery")*@
   @*@Scripts.Render("~/bundles/bootstrap")*@
   ```

1. Replace the above lines with:

   ```html
   <script src="~/js/jquery-3.6.4.min.js"></script>
   <script src="~/js/jquery.validate.min.js"></script>
   <script src="~/js/jquery.validate.unobtrusive.min.js"></script>
   <script src="~/js/modernizr-2.8.3.js"></script>
   <script src="~/js/bootstrap.min.js"></script>
   ```

## Run the application

Return to the Summary dialog and note that no non-upgraded endpoints remain in the old .NET Framework app. You may need to build the app to update the assistant.

:::image type="content" source="../media/endpoints-summary-done.png" alt-text="The Summary tab in the Upgrade Assistant showing all the endpoints have been migrated.":::

When you press <kbd>F5</kbd>, the application should build and run successfully. Congratulations!

:::image type="content" source="../media/upgraded-app-running.png" alt-text="Screenshot of browser window showing the ASP.NET Core application's home page.":::

If this app had more controllers, you would repeat this process for the additional controllers until the entire app is upgraded.

## Remove YARP

Now that all the endpoints have been migrated, there's no need for a reverse proxy mapping to the old project anymore.

In the new app, complete the following steps to remove YARP:

1. In *Program.cs*, remove the line that calls `builder.Services.AddReverseProxy().LoadFromConfig()`.
1. In that same file, remove the line `app.MapReverseProxy();`.
1. In *appsettings.json*, remove the `ReverseProxy` configuration object.

The new app can now be built and deployed independently from the original app.

> [!NOTE]
> In this simple scenario, you were able to complete the modernization in one step. In many real world applications, modernization will require a longer period of time. In this case, the YARP proxy will remain in place to allow you to allow you to incrementally update your application. 
## Summary

In this section, you completed an upgrade for a simple, specific test scenario: a default ASP.NET MVC 5 app with no authentication, data access, additional NuGet packages, or custom code. In a more complex scenario, you'll need to complete additional migration steps as detailed in the [ASP.NET Core Migration Guide](/aspnet/core/migration/index).
