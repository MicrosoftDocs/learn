In this exercise, you will:

* Create a self-signed development certificate.
* Run your web app locally and view it in a browser using HTTPS.
* Review how the web app is served.

## Create a self-signed development certificate

A self-signed development certificate allows the browser to trust the certificate and avoid security warnings during development as you access the HTTPS endpoint for testing. 

Create a self-signed development certificate by running the following .NET CLI command in the Visual Studio Code terminal or the command line:

  ```dotnetcli
  dotnet dev-certs https --trust
  ```

On Linux, the preceding command requires .NET 9 SDK or later. For Linux on .NET 8.0.401 SDK and earlier, see your Linux distribution's documentation for trusting a certificate.

The preceding command displays the following dialog, provided the certificate wasn't previously trusted:

 :::image type="content" source="../media/cert.png" alt-text="Screenshot of the security warning dialog.":::

Select **Yes** if you agree to trust the development certificate.

## Run the web app using HTTPS

From a terminal in Visual Studio Code or the command line, navigate to the `MyWebApp` project directory that contains your `MyWebApp.csproj` file.

Build and Run the app with the following command:

```csharp
dotnet run --launch-profile https
```

The following outlines the command syntax:

* `dotnet run`: This command builds and runs the ASP.NET Core app.
* `--launch-profile https`: This option launches the https profile, and provides both an HTTPS and HTTP endpoint. If this option isn't used, by default `donet run` provides only the HTTP endpoint.

The project is built, run, and shows the following output on the command line:

```output
dotnet run --launch-profile https
Building...
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: https://localhost:7140
info: Microsoft.Hosting.Lifetime[14]
      Now listening on: http://localhost:5218
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
```

The port number in the URL provided is set randomly in configuration at project creation, so your endpoint may have a different port number.

Open a browser to the HTTPS URL generated at your own commandline output, the following is displayed:

 :::image type="content" source="../media/browser-displays-helloworld.png" alt-text="A browser displaying the text output":::

Press Ctrl+C at the commandline to shut down the app.

### How the web app is served

When the `dotnet run --launch-profile https` command is run in the terminal, the following steps occur:

Build and Configuration:
* The .NET CLI invokes MSBuild to restore dependencies and compile the project. MSBuild processes the `MyWebApp.csproj` project file and compiles the source code into an assembly.
* The app reads configuration settings, including those specified in `launchSettings.json` for the HTTPS profile.

Host Setup:
* The `CreateHostBuilder` method in `Program.cs` sets up the web host. By default, the `WebHostBuilder` configures Kestrel as the web server. Kestrel is a cross-platform web server for ASP.NET Core that’s designed for high performance.
* Kestrel starts listening for incoming HTTP requests on the configured URLs, including HTTPS if specified.

Request Handling:
* When a request is received, Kestrel forwards it to the ASP.NET Core middleware pipeline.
* The middleware pipeline processes the request through a series of middleware components, which can handle tasks such as authentication, logging, and routing.
* If the request matches a defined route, the corresponding endpoint is executed. In this case, the `app.MapGet("/", () => "Hello World!")` endpoint handles requests to the root URL and returns the string `Hello World!`.

Response:
* The response, which in this case is the string "Hello World!", is sent back through the middleware pipeline to Kestrel, which then sends it back to the client.
