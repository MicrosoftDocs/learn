Framework-dependent deployments are the default for ASP.NET Core apps. When you publish a framework-dependent app, only your app's files and dependencies are included in the deployment package. The .NET runtime isn't included. The target machine must have the correct version of .NET runtime installed in order to run the app.

Your team lead asked you to prepare your team's app for deployment. Since the server your app will run on already has the .NET runtime installed, you can publish the app as a framework-dependent deployment. This reduces the size of the deployment package and make it easier to deploy the app.

In this exercise, you publish an ASP.NET Core app as a framework-dependent deployment.

## Create an ASP.NET Core app

You need an ASP.NET Core app to play the role of your team's app. Let's create a new ASP.NET Core app using C# Dev Kit extension in Visual Studio Code.

1. Launch Visual Studio Code.
1. Press **Ctrl+Shift+P** to open the command palette.
1. Search for and select **.NET New Project**.
1. Search for and select **ASP.NET Core Empty**.

    :::image type="content" source="../media/aspnet-core-empty.png" alt-text="A screenshot of the command palette with ASP.NET Core Empty selected."  lightbox="../media/aspnet-core-empty.png":::

1. Select or create a folder for the new project.
1. Name the new app *MyWebApp*.
1. Select **Create project** to create the project.

## Run the app

Test the app to make sure it runs.

1. In Visual Studio Code, press **F5** to build and run the app.
    1. When prompted, select **C#** as the debugger.
    1. When prompted, select **C#: MyWebApp [Default Configuration]** as the launch configuration to use. 

    This command starts the app and hosts it on a local web server. A browser window opens and displays, "Hello, World!".

1. Close the browser window and stop the app by pressing **Shift+F5** in Visual Studio Code.

## Publish the app as a framework-dependent deployment

Now that you've verified that the app runs correctly, you can publish it as a framework-dependent deployment.

1. In Visual Studio Code, press **Ctrl+`** to open the terminal window.
1. Navigate to the *MyWebApp* directory.

    ```dotnetcli
    cd MyWebApp
    ```

1. Run the following command to publish the app:

    ```dotnetcli
    dotnet publish -c Release -o publish-fd    
    ```

    In the preceding command:

    - `-c Release` specifies that the app should be built in release mode. This optimizes the app for performance.
    - `-o` specifies the name of the output directory. In this case, the output directory will be named *publish-fd*.

    This command publishes the app as a framework-dependent deployment to the *publish-fd* directory.

1. In the Visual Studio Code Explorer window, expand the contents of the *MyWebApp/publish-fd* directory and view the list of files. The directory includes the app's files and dependencies, but not the .NET runtime or source code files. Some of the included files and directories are:

    - **MyWebApp.dll**`**: The compiled app.
    - **Other *MyWebApp.* files**: Additional files needed to run the app.
    - **appsettings.json**: The configuration file for the app.
    - **web.config**: The configuration file for IIS (Internet Information Services) on Windows.
    - **wwwroot**: When present, this directory contains published static web assets, such as HTML, CSS, and JavaScript files. This directory isn't generated if the project doesn't contain any static web assets, so it isn't present in this case.

1. Navigate to the *publish-fd* directory and run the app.

    ```dotnetcli
    cd publish-fd
    dotnet MyWebApp.dll
    ```

    This command starts the published app and hosts it in Kestrel. Web browsers that connect to the app see the same default ASP.NET Core welcome page.

1. Close the web browser and stop the app by pressing **Ctrl+C** in the terminal window.
