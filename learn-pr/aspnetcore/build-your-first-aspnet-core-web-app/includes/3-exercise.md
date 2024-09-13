In this exercise, you will:

* Create an ASP.NET Core web app project from a template using the .NET CLI (Command Line Interface).
* Examine the structure of the created project.
* Run your web app locally and view it in a browser using HTTPS.
* Review how the web app is served.

## Create an ASP.NET Core web app

From a terminal or the command line, navigate to the directory where you want to create the new project.

Create an ASP.NET Core web app in a directory named *MyWebApp* by running the .NET CLI command `dotnet new`:

```dotnetcli
dotnet new web -o MyWebApp
```

A new ASP.NET Core empty web project is created in a directory named **MyWebApp**.

The following outlines the command syntax:

* `dotnet new`: A .NET CLI command for creating various .NET development artifacts based on templates such as projects, solutions, libraries, configuration, and other specialized files.
* `web`: A project template used to create an ASP.NET Core empty web project, containing no example content. `web` is one of the many [built-in project templates](/dotnet/core/tools/dotnet-new-sdk-templates) available in the [.NET SDK](https://dotnet.microsoft.com/download).
* `-o`: The output option specifies the directory where the new project is created:
    * If the directory doesn't exist, it's created. 
    * The directory where the project is created serves as the default project name, namespace, and assembly name (the name of the compiled output).
    * If the output option `-o <directory>` isn't used, then the current directory is used.

## Examine the structure of the project

The following sections contain an overview of the main project folders and files of the empty ASP.NET Core project:

### The `MyWebApp.csproj` project file

The `<project name>.csproj` project file is used by MSBuild to:
 
* Build and manage the project
* Manage dependencies
* Configure which version of .NET to use during the build.
* Package the app for deployment.

### The `obj` folder

The `obj` folder contains intermediate files that are used by the build system, including compiled object files generated from the source files. The final build output is placed in a `bin` folder created during the build process.

### The `Properties/launchSettings.json` file

The `Properties/launchSettings.json` file contains configuration data for how the app is launched during development. These settings include the `applicationUrl` property, which specifies the root URL the app uses, such as `https://localhost:<port>`, where `<port>` is a random local port number assigned when the project is created.

The `launchSettings.json` file contains the following:

[!code-csharp[](../code/MyWebApp/Properties/launchSettings.json)]

### The `Program.cs` file

The `Program.cs` file serves as the entry point for an ASP.NET Core app and has several key purposes, which include:

* Environment configuration: Sets up environment-specific settings for development, staging, and production.
* Service registration: Adds services to the app’s functionality, such as database contexts, logging, and specialized services such as Blazor (interactive web UIs in C#), SignalR (real-time web functionality), or gRPC (high-performance RPC communication), to name a few.
* Middleware pipeline configuration: Defines the app’s request handling pipeline as a series of middleware components.
* Host configuration: Configures the host, including setting up the web server.

In the new empty ASP.NET Core project you created, the `Program.cs` file contains the following minimal code:

[!code-csharp[](../code/MyWebApp/Program.cs?name=snippet_all)]

The following lines of code in this file create a `WebApplicationBuilder` with preconfigured defaults, and builds the app:

[!code-csharp[](../code/MyWebApp/Program.cs?name=snippet_web_application_builder)]

The `app.MapGet()` method directly defines an endpoint that handles HTTP GET requests:

[!code-csharp[](../code/MyWebApp/Program.cs?name=snippet_web_mapget)]

`app.MapGet("/")`: Defines a route for the HTTP GET request. The `/` indicates this route responds to the requests made to the root URL of the app. For example, `https://localhost:<port>/`, where `<port>` is a randomly assigned port number assigned in the `Properties/launchSettings.json` file at project creation.`

`() => "Hello World!"`: A lambda expression that serves as the request handler. When a GET request is made to the root URL, this lambda expression is executed, and it returns the string "Hello World!"

### Create a self-signed development certificate

A self-signed development certificate allows the browser to trust the certificate and avoid security warnings during development as you access the HTTPS endpoint for testing. Create a self-signed development certificate by running the following .NET CLI command:

  ```dotnetcli
  dotnet dev-certs https --trust
  ```

On Linux, the preceding command requires .NET 9 SDK or later. For Linux on .NET 8.0.401 SDK and earlier, see your Linux distribution's documentation for trusting a certificate.

The preceding command displays the following dialog, provided the certificate wasn't previously trusted:

 :::image type="content" source="../media/cert.png" alt-text="Screenshot of the security warning dialog.":::

Select **Yes** if you agree to trust the development certificate.

### Run the web app locally and view it in a browser using HTTPS

From a terminal or the command line, navigate to the `MyWebApp` project directory that contains your `MyWebApp.csproj` file.

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

Open a browser to the HTTPS URL generated at your own commandline output.

The text "Hello World!" is displayed in the browser.

Press Ctrl+C at the commandline to shut down the app.

### How the web app is served

When the `dotnet run --launch-profile https` command is run in the terminal, the following steps occur:

Build and Configuration:
* The .NET CLI invokes MSBuild to restore dependencies and compile the project. MSBuild processes the `MyWebApp.csproj` project file and compiles the source code into an assembly.
* The app reads configuration settings, including those specified in `launchSettings`.json` for the HTTPS profile.

Host Setup:
* The `CreateHostBuilder` method in `Program.cs` sets up the web host. By default, the `WebHostBuilder` configures Kestrel as the web server. Kestrel is a cross-platform web server for ASP.NET Core that’s designed for high performance.
* Kestrel starts listening for incoming HTTP requests on the configured URLs, including HTTPS if specified.

Request Handling:
* When a request is received, Kestrel forwards it to the ASP.NET Core middleware pipeline.
* The middleware pipeline processes the request through a series of middleware components, which can handle tasks such as authentication, logging, and routing.
* If the request matches a defined route, the corresponding endpoint is executed. In this case, the `app.MapGet("/", () => "Hello World!")` endpoint handles requests to the root URL and returns the string “Hello World!”.

Response:
* The response, which in this case is the string "Hello World!", is sent back through the middleware pipeline to Kestrel, which then sends it back to the client.
