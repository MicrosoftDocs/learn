Let's start by creating our first Blazor web app.

This module uses the [.NET CLI (Command Line Interface)](/dotnet/core/tools/), [Visual Studio Code](https://code.visualstudio.com), and [Visual Studio 2022](https://visualstudio.com) for local development. If you are developing with Visual Studio Code, be sure to install the [C# Dev Kit](https://code.visualstudio.com/docs/csharp/get-started#_install), which we will use in this module.

::: zone pivot="vscode"

[!include[](../../../includes/dotnet8-sdk-version.md)]

## Create a new Blazor app with C# Dev Kit

To set up a Blazor project to work with, we use Visual Studio Code and the C# Dev Kit. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, open the **Explorer** and select **Create .NET Project** .

2. Select **Blazor Web App** in the dropdown list.

3. Create a new folder in the pop up names **BlazorApp** and select **Select Folder**.

4. Name the project **BlazorApp** and press **Enter** to confirm.

5. In Visual Studio Code with the C# Dev Kit the **Solution Explorer** will load showing you a project view of the new Blazor app.

## Optional: Create a new Blazor app with the .NET CLI

If you are using the integrated **Terminal** to create the project, you can run the following command:

    ```dotnetcli
    dotnet new blazor
    ```

Whether you created the Blazor app with Visual Studio Code or the CLI it creates a basic Blazor project with all required files and pages, along with a C# project file named **BlazorApp.csproj**.

    You should now have access to these files.

    ```bash
    -| bin
    -| Components
      -| Layouts
        -| MainLayout.razor
        -| MainLayout.razor.css
        -| NavMenu.razor
        -| NavMenu.razor.css
      -| Pages
        -| Counter.razor
        -| Error.razor
        -| Home.razor
        -| Weather.razor
    -| obj
    -| Properties
      -| launchSettings.json
    -| wwwroot
      -| bootstrap
        -| bootstrap.min.css
        -| bootstrap.min.css.map
      -| app.css
      -| favicon.png
    -| appsettings.Development.json
    -| appsettings.json
    -| BlazorApp.csproj
    -| Program.cs
    ```

If Visual Studio Code prompts you to install required assets, select **Yes**.

   ![Screenshot showing Visual Studio Code prompting to install assets required to build and debug.](../media/missing-assets-visual-studio-code.png)

## Run the app with the integrated debugger

1. In Visual Studio Code, select **Run** from the menu.

1. Select  **Start Debugging**.

1. Select **C#** from the _Select debugger_ drop down.

1. Select **C#: BlazorApp [Default Configuration]**

  This builds and starts the app, then rebuilds and restarts the app whenever you make code changes. The app should automatically open in your default browser. Your browser might warn you that the site isn't secure; it's safe to proceed.

   ![Screenshot showing the default Blazor app running in a browser.](../media/hello-blazor.png)

## Optional: Run the app with the .NET CLI

1. In the terminal window, copy and paste the following command to run the app in **watch mode**:

    ```dotnetcli
    dotnet watch run
    ```

    This command builds and starts the app, then rebuilds and restarts the app whenever you make code changes. The app should automatically open in your default browser. Your browser might warn you that the site isn't secure; it's safe to proceed.

::: zone-end

::: zone pivot="vstudio"

## Create a new Blazor app

To set up a Blazor project to work with, we use Visual Studio 2022. Visual Studio includes integrated templates and compiler, which makes creating and building a new project easy.

1. In Visual Studio 2022, select **File** > **New Project**.

1. In the search box at the top of the "Create a new project" dialog, key in "Blazor", select **Blazor Web App**, and select **Next**.

   ![Screenshot of Visual Studio 2022 'Create New Project' screen and the Blazor template.](../media/visual-studio-2022-create-new-project.png)

1. On the subsequent screen, name your project "BlazorApp", specify a location on disk with settings like the following, then select **Next**:

   ![Screenshot of Visual Studio 2022 'Configure Your Project' screen and recommended settings from step 3.](../media/visual-studio-2022-configure-project.png)  

1. On the *Additional Information* screen select the following options, which should be the defaults:
   - Framework:  **.NET 8.0 (Long-term support)**
   - Authentication type: **None**
   - Configure for HTTPS: **Checked**
   - Interactive render mode: **Server**
   - Interactivity location: **Per page/component** 
   - Include sample pages: **Checked**
   - Do not use top-level statements: **NOT Checked**

   ![Screenshot of Visual Studio 2022 additional information screen for the Blazor project.](../media/visual-studio-2022-additional-information.png)

1. Select **Create**, this command creates a basic Blazor project with all required files and pages.

  You should now have access to these files. Your Solution Explorer in Visual Studio 2022 looks similar to the following screenshot:

  ![Screenshot of Visual Studio 2022 Solution Explorer with a list of the files in a default Blazor project.](../media/visual-studio-2022-solution-explorer.png)

## Run the app

1. In Visual Studio, select **Debug** > **Start Debugging**

    This command builds and starts the app, then rebuilds and restarts the app whenever you make code changes. The app should automatically open in your default browser. Your browser might warn you that the site isn't secure; it's safe to proceed.

    ![Screenshot showing the default Blazor app running in a browser.](../media/hello-blazor.png)

::: zone-end

Use this Blazor app in the following exercises.
