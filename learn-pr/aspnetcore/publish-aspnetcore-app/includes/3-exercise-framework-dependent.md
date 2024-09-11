Framework-dependent deployments are the default for ASP.NET Core apps. When you publish a framework-dependent app, only your app's files and dependencies are included in the deployment package. The .NET runtime is not included. The target machine must have the correct version of .NET runtime installed in order to run the app.

Your team lead has asked you to prepare your team's app for deployment. Since the server your app will run on already has the .NET runtime installed, you can publish the app as a framework-dependent deployment. This will reduce the size of the deployment package and make it easier to deploy the app.

In this exercise, you'll publish an ASP.NET Core app as a framework-dependent deployment.

## Create an ASP.NET Core app

You'll need an ASP.NET Core app to play the role of your team's app. Let's create a new ASP.NET Core app using the .NET CLI.

1. Open a terminal window.
1. Run the following command to create a new ASP.NET Core app:

    ```dotnetcli
    dotnet new webapp -o MyWebApp
    ```

    This command creates a new ASP.NET Core web app in a folder named `MyWebApp`.

1. Change to the `MyWebApp` directory and run the following command to build the app:

    ```dotnetcli
    dotnet build
    ```

    This command compiles the app and its dependencies.

1. Run the following command to start the app:

    ```dotnetcli
    dotnet run
    ```

    This command starts the app and hosts it on a local web server.

1. In the output from `dotnet run`, find the URL where the app is hosted (for example, `http://localhost:5000`). Hold the **Ctrl** key and click the URL to open it in a web browser. You should see the default ASP.NET Core welcome page.

## Publish the app as a framework-dependent deployment

Now that you've verified that the app runs correctly, you can publish it as a framework-dependent deployment.

1. Run the following command to publish the app:

    ```dotnetcli
    dotnet publish -c Release -o publish-fd
    ```

    In the preceding command:

    - `-c Release` specifies that the app should be built in release mode. This optimizes the app for performance.
    - `-o publish-fd` specifies the output directory for the published app.

    This command publishes the app as a framework-dependent deployment to the *publish-fd* directory.

1. Change to the *publish-fd* directory and list the files in the directory. 

    ```dotnetcli
    cd publish-fd
    dir
    ```

    > [!NOTE]
    > Most command shells contain a `dir` command that lists the files in the current directory. If you're using a different shell, use the appropriate command to list the files, such as `ls`.

    A list of files that includes the app's files and dependencies, but not the .NET runtime or source code files, is displayed. Some of the included files and directories are:

    - `MyWebApp.dll`: The compiled app.
    - Other `MyWebApp.*` files: Additional files needed to run the app.
    - `wwwroot`: The directory that contains static web assets, such as HTML, CSS, and JavaScript files.
    - `appsettings.json`: The configuration file for the app.
    - `web.config`: The configuration file for IIS (Internet Information Services) on Windows.

1. Run the following command to start the published app:

    ```dotnetcli
    dotnet MyWebApp.dll
    ```

    This command starts the published app and hosts it in Kestrel. Web browsers that connect to the app will see the same default ASP.NET Core welcome page.

1. Close the web browser and stop the app by pressing **Ctrl+C** in the terminal window.
