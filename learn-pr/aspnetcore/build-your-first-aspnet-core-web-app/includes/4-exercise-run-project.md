In this exercise, you will:

- Run your web app locally and view it in a browser.
- Review how the web app is served.


## Run the web app and view in a browser

::: zone pivot="vscode"

Run the web app in Visual Studio Code and view in a browser:

1. In Visual Studio Code, press <kbd>F5</kbd> to run the app. 

    Visual Studio Code:
    
    - Triggers the .NET CLI command `dotnet run` which builds and runs the application.
    - Attaches the debugger to the running application.

    The first time the project is run in Visual Studio Code, the **Select debugger** prompt is displayed.

1. At the **Select debugger** prompt in the **Command Palette** at the top of the Visual Studio Code UI, select **C#**. At the next prompt, select the default launch configuration (`C#: MyWebApp [Default Configuration]`):

    :::image type="content" source="../media/vs-code-select-debugger.png" alt-text="Screenshot of choosing Select debugger in the Command Palette.":::

    The default browser is launched at `http://localhost:{PORT}`, which displays the app's response. The `{PORT}` placeholder is the random port assigned to the app when the app's project is created. If you need to change the port due to a local port conflict, change the port in the project's *Properties/launchSettings.json* file.

    The response displayed in the browser:

    :::image type="content" source="../media/browser-displays-hello-world.png" alt-text="Screenshot of a browser displaying the text output.":::

1. Close the browser window.

1. In Visual Studio, either:

    - From the **Run** menu, select **Stop Debugging**.
    - Press <kbd>Shift</kbd>+<kbd>F5</kbd> on the keyboard.

::: zone-end

::: zone pivot="shell"

Run the web app using the .NET CLI:

1. From a terminal or the command line, navigate to the *MyWebApp* project directory that contains your *MyWebApp.csproj* file.

1. Build and Run the app with the following command:

    ```dotnetcli
    dotnet run
    ```

    The project is built, run, and shows the following output on the command line:

    ```output
    C:\MyWebApp> dotnet run
    Building...
    info: Microsoft.Hosting.Lifetime[14]
            Now listening on: http://localhost:5267
    info: Microsoft.Hosting.Lifetime[0]
            Application started. Press Ctrl+C to shut down.
    ```

    Since the port number in the URL provided is set randomly in configuration at project creation, your endpoint might have a different port number.

1. Open a browser to the URL generated at your own command line output, the app's response `Hello World!` is displayed:

    :::image type="content" source="../media/browser-displays-hello-world.png" alt-text="Screenshot of a browser displaying the text output.":::

1. To shut down the app, press Ctrl+C at the command line.

::: zone-end

### How the web app is served

When the app is built and run, the following steps occur:

Build and Configuration:

- MSBuild is invoked to restore dependencies and compile the project. MSBuild processes the *MyWebApp.csproj* project file and compiles the source code into an assembly.
- The app reads configuration settings, including the settings specified in *launchSettings.json* for the default launch profile (the first one listed).

Host Setup:

- The `WebApplication.CreateBuilder` method in *Program.cs* sets up the web host. By default, this method configures Kestrel as the web server. Kestrel is a cross-platform web server for ASP.NET Core designed for high performance.
- Kestrel starts listening for incoming HTTP requests on the configured URLs, including HTTPS if specified.

Request Handling:

- When a request is received, Kestrel forwards it to the ASP.NET Core middleware pipeline.
- The middleware pipeline processes the request through a series of middleware components, which can handle tasks such as authentication, logging, and routing.
- If the request matches a defined route, the corresponding endpoint is executed. In this case, the `app.MapGet("/", () => "Hello World!")` endpoint handles requests to the root URL and returns the string `Hello World!`.

Response:

- The response, which in this case is the string "Hello World!", is sent back through the middleware pipeline to Kestrel, which then sends it back to the client.
