In this exercise, you will:

- Run your web app locally and view it in a browser.
- Review how the web app is served.


## Run the web app using Visual Studio Code and view in a browser

1. In Visual Studio Code, press <kbd>F5</kbd> to run the app. 

1. At the **Select debugger** prompt in the **Command Palette** at the top of the Visual Studio Code UI, select **C#**. At the next prompt, select the default launch configuration (`C#: MyWebApp [Default Configuration]`):

    :::image type="content" source="../media/vsc-select-bebugger.png" alt-text="Chosing Select debugger in the Command Pallette":::

    The default browser is launched at `http://localhost:{PORT}`, which displays the app's response. The `{PORT}` placeholder is the random port assigned to the app when the app's project is created. If you need to change the port due to a local port conflict, change the port in the project's `Properties/launchSettings.json` file.

    The response displayed in the browser:

    :::image type="content" source="../media/browser-displays-helloworld.png" alt-text="A browser displaying the text output":::

1. Close the browser window.

1. In Visual Studio, either:

    - From the **Run** menu, select **Stop Debugging**.
    - Press <kbd>Shift</kbd>+<kbd>F5</kbd> on the keyboard.

## Alternatively run the web app using the .NET CLI

1. From a terminal in Visual Studio Code or the command line, navigate to the `MyWebApp` project directory that contains your `MyWebApp.csproj` file.

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

    Since the port number in the URL provided is set randomly in configuration at project creation, your endpoint may have a different port number.

1. Open a browser to the URL generated at your own command line output, the app's response `Hello World!` is displayed.

1. Press Ctrl+C at the command line to shut down the app.

### How the web app is served

When the `dotnet run --launch-profile https` command is run in the terminal, the following steps occur:

Build and Configuration:

- The .NET CLI invokes MSBuild to restore dependencies and compile the project. MSBuild processes the `MyWebApp.csproj` project file and compiles the source code into an assembly.
- The app reads configuration settings, including those specified in `launchSettings.json` for the HTTPS profile.

Host Setup:

- The `CreateHostBuilder` method in `Program.cs` sets up the web host. By default, the `WebHostBuilder` configures Kestrel as the web server. Kestrel is a cross-platform web server for ASP.NET Core that’s designed for high performance.
- Kestrel starts listening for incoming HTTP requests on the configured URLs, including HTTPS if specified.

Request Handling:

- When a request is received, Kestrel forwards it to the ASP.NET Core middleware pipeline.
- The middleware pipeline processes the request through a series of middleware components, which can handle tasks such as authentication, logging, and routing.
- If the request matches a defined route, the corresponding endpoint is executed. In this case, the `app.MapGet("/", () => "Hello World!")` endpoint handles requests to the root URL and returns the string `Hello World!`.

Response:

- The response, which in this case is the string "Hello World!", is sent back through the middleware pipeline to Kestrel, which then sends it back to the client.
