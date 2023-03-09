Imagine you're an employee of a pizza company named Contoso Pizza. Your manager has asked you to develop an internal pizza inventory management site. The site has to support adding, viewing, modifying, and removing types of pizza.

The .NET CLI is the simplest way to create an ASP.NET Core web app. The CLI is pre-installed when you installed the .NET SDK. In this unit, you'll use the .NET CLI to create an ASP.NET Core web app locally. You'll also gain an understanding of the resulting project.

## Create a web app project

To set up a .NET project to work with a web app, you'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **RazorPagesPizza** in the location of your choice, and then choose **Select Folder** to make it the active folder. If you're shown a prompt asking *Do you trust the authors of the files in this folder?* select the `Yes` button.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new webapp -f net6.0
    ```

    This command creates the files for a basic web app project, along with a C# project file named **RazorPagesPizza.csproj**.

    You may receive a prompt from Visual Studio Code to add assets to debug the project. Select `Yes` on the dialog.

    The command uses an ASP.NET Core project template to scaffold a C#-based web app project. A *RazorPagesPizza* directory is created, which contains an ASP.NET Core project running on .NET. The project name matches the *RazorPagesPizza* directory name.

    You should now have access to these files.

    ```bash
    -| obj
    -| Pages
       - | Shared
       - | _ViewImports.cshtml
       - | _ViewStart.cshtml
       - | Error.cshtml
       - | Error.cshtml.cs
       - | Index.cshtml
       - | Index.cshtml.cs
       - | Privacy.cshtml
       - | Privacy.cshtml.cs
    -| Properties
    -| wwwroot
    -| appsettings.Development.json
    -| appsettings.json
    -| Program.cs
    -| RazorPagesPizza.csproj
    ```

## Run the Razor Pages project and explore its UI

### Compile and run the project

1. Run the following .NET Core CLI command in the terminal:

    ```dotnetcli
    dotnet run
    ```

    The preceding command:

    * Locates the project file at the current directory.
    * Retrieves and installs any required project dependencies for this project.
    * Compiles the project code.
    * Hosts the web app with ASP.NET Core's Kestrel web server at both an HTTP and HTTPS endpoint.

    At the time the project is created, a port from 5000-5300 will be selected for HTTP, and from 7000-7300 for HTTPS. As always, the ports used during development can be easily changed by editing the project’s launchSettings.json file. This module uses the secure localhost URL beginning with `https`.

    A variation of the following output displays to indicate your app is running:

    ```console
          Now listening on: https://localhost:7192
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5211
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
      Content root path: /home/<user>/aspnet-learn/src/RazorPagesPizza
    ```

If running this app on your own machine, you could direct a browser to the HTTPS link displayed in the output (in the above case, `https://localhost:7192`) to view the resulting page.

## Tour the app

1. Note the HTTP URL displayed in the terminal output, for example, `https://localhost:7192`.

1. Open the app in your browser by browsing to the HTTPS URL.

1. Navigate to the **Privacy** page by clicking on the link in the navigation bar at the top of the page. Notice that the URL ends with *Privacy*. By convention, Razor Pages apps map page routes to the files within the *Pages* directory structure.

1. In the terminal window, stop the application by pressing the **Ctrl+C** key combination (**Command+C** on Mac).

You've verified you can successfully compile, run, and deploy the project. Let's modify it so the user can display and update a list of pizzas.
