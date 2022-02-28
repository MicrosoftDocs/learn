Let's start by creating our first Blazor web app.

This module uses the [.NET CLI (Command Line Interface)](/dotnet/core/tools/) and [Visual Studio Code](https://code.visualstudio.com) for local development. After you complete this module, you can apply its concepts using a development environment like Visual Studio (Windows), Visual Studio for Mac (macOS), or continue development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet6-sdk-version.md)]

## Create a new Blazor app

To set up a Blazor project to work with, we'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **BlazorApp** in the location of your choice, and then choose **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new blazorserver -f net6.0
    ```

    This command creates a basic Blazor server project with all required files and pages, along with a C# project file named **BlazorApp.csproj**.

    You should now have access to these files.

    ```bash
    -| bin
    -| Data
    -| obj
    -| Pages
      -| _Host.cshtml
      -| Counter.razor
      -| Error.cshtml
      -| Error.cshtml.cs
      -| FetchData.razor
      -| Index.razor
    -| Properties
    -| Shared
      -| MainLayout.razor
      -| MainLayout.razor.css
      -| NavMenu.razor
      -| NavMenu.razor.css
      -| SurveyPrompt.razor
    -| wwwroot
    -| _Imports.razor
    -| App.razor
    -| appsettings.Development.json
    -| appsettings.json
    -| BlazorApp.csproj
    -| Program.cs
    ```

1. If Visual Studio Code prompts you to install required assets, select **Yes**.

    ![Screenshot showing Visual Studio Code prompting to install assets required to build and debug.](../media/missing-assets-visual-studio-code.png)
    
## Run the app

1. In the terminal window, copy and paste the following command to run the app in **watch mode**:

    ```dotnetcli
    dotnet watch run
    ```

    This will build and start the app, and then rebuild and restart the app whenever you make code changes. The app should automatically open in your default browser. Your browser might warn you that the site isn't secure; it's safe to proceed.

    ![Screenshot showing the default Blazor WebAssembly client app running in a browser.](../media/hello-blazor.png)

1. When you're ready to stop, return to the terminal in Visual Studio code, and press <kbd>Ctrl+C</kbd> to stop the app.

You'll use this Blazor app in the following exercises.
