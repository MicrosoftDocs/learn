You're a developer for a company, and you and your company have heard about the new minimal API. Your manager has asked you to create a project for it so that you can discuss whether to use it on your next project.

> [!NOTE]
> This module uses the .NET CLI (Command Line Interface) and Visual Studio Code for local development. After completing this module, you can apply the concepts using Visual Studio (Windows), Visual Studio for Mac (macOS), or continued development using Visual Studio Code (Windows, Linux, & macOS).

[!include[](../../../includes/dotnet8-sdk-version.md)]

## Scaffold a project

First, you need to scaffold a project. You've installed .NET 8 and you're ready to go.

1. From a terminal, create a web API in a directory called *PizzaStore* by running `dotnet new`:

   ```bash
   dotnet new web -o PizzaStore -f net8.0
   ```

1. Switch to the new *PizzaStore* directory.

    ```bash
    cd PizzaStore
    ```

1. Run the app by calling `dotnet run`. It builds the app and hosts it on a port from 5000 to 5300. HTTPS has a port selected for it in the range of 7000 to 7300.

   > [!NOTE]
   > If you want to override the random port selection behavior, you can set the ports to use in _launchSettings.json_.

   ```bash
   dotnet run
   ```

   Here's what the output can look like in the terminal:

   ```output
   Building...
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: https://localhost:7200
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5100
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development
    info: Microsoft.Hosting.Lifetime[0]
          Content root path: /<path>/PizzaStore
   ```

1. In your browser, go to the indicated port. According to the terminal *http://localhost:{PORT}*, you should see the text "Hello World!"

Congratulations! You've created an API by using a minimal API template.

## Add Swagger

Use Swagger to ensure that you have a self-documenting API, where the docs change when you change the code.

1. Press **Ctrl+C** to stop running the API.
1. Install the Swashbuckle package:

    ```bash
    dotnet add package Swashbuckle.AspNetCore --version 6.5.0
    ```

1. Open the project in Visual Studio Code:

    ```bash
    code .
    ```

1. In Visual Studio Code, in the explorer pane, open *PizzaStore.csproj*. You should have an entry that looks like this one:

    ```xml
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
    ```

Next, configure your project to use Swagger.

1. Open *Program.cs* and add the highlighted code. Make sure you save your changes.

   :::code language="csharp" source="../code/create-minimal-api-add-swagger.cs" highlight="1, 5-9, 13-20":::

1. Press **Ctrl+\`** to open a terminal in Code. In the new terminal, run the app again:

    ```dotnetcli
    dotnet run
    ```

1. Navigate to the app's swagger endpoint, *http://localhost:{PORT}/swagger*.

   You should see the following output:

   :::image type="content" source="../media/swagger.png" alt-text="Screenshot of a Swagger UI for your API.":::

1. In the terminal, press **Ctrl+C** to terminate the program.

You've successfully added OpenAPI support to your minimal API using Swagger!
