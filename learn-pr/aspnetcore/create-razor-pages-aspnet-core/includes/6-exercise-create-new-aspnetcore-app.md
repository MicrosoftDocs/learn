In this exercise, you'll create an ASP.NET Core web app locally using the .NET CLI and explore the project.

## Create a web app project

1. In Visual Studio Code, create a new folder **RazorPagesPizza** and make it the active folder.
2. Open the integrated terminal and run the following command:

    ```dotnetcli
    dotnet new webapp -f net6.0
    ```

    This command creates a basic web app project with a C# project file named **RazorPagesPizza.csproj**.

## Run the Razor Pages project and explore its UI

### Compile and run the project

1. Run the following .NET Core CLI command in the terminal:

    ```dotnetcli
    dotnet run
    ```

    This command compiles the project code and hosts the web app with ASP.NET Core's Kestrel web server at both HTTP and HTTPS endpoints. A secure localhost URL beginning with `https` is used.

### Tour the app

1. Note the HTTPS URL displayed in the terminal output, e.g., `https://localhost:7192`.
2. Open the app in your browser by browsing to the HTTPS URL.
3. Navigate to the **Privacy** page by clicking on the link in the navigation bar. The URL ends with *Privacy*.
4. Stop the application in the terminal by pressing **Ctrl+C** (**Command+C** on Mac).

You've verified you can compile, run, and deploy the project. Next, you'll modify it to display and update a list of pizzas.
