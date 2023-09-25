[!include[](../../../includes/dotnet6-sdk-version.md)]

## Create and explore a web API project

To set up a .NET project to work with the web API, we use Visual Studio Code. Visual Studio Code includes an integrated terminal that makes creating a new project easy. If you don't want to use a code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **ContosoPizza** in the location of your choice, and then choose **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command:

    ```dotnetcli
    dotnet new webapi -f net6.0
    ```

    This command creates the files for a basic web API project that uses controllers, along with a C# project file named *ContosoPizza.csproj* that returns a list of weather forecasts. If you get an error, ensure that you have the [.NET 6 SDK](https://dotnet.microsoft.com/download) installed.

    > [!IMPORTANT]
    > Web API projects are secured with `https` by default. If you have problems, [configure the ASP.NET Core HTTPS development certificate](/aspnet/core/security/enforcing-ssl#trust-the-aspnet-core-https-development-certificate-on-windows-and-macos).

    You might receive a prompt from Visual Studio Code to add assets to debug the project. Select **Yes** in the dialog.

    The command uses an ASP.NET Core project template aliased as *:::no-loc text="webapi":::* to scaffold a C#-based web API project. A *:::no-loc text="ContosoPizza":::* directory is created. This directory contains an ASP.NET Core project running on .NET. The project name matches the *:::no-loc text="ContosoPizza":::* directory name.

    You should now have access to these files and directories:

    ```bash
    -| Controllers
    -| obj
    -| Properties
    -| appsettings.Development.json
    -| appsettings.json
    -| ContosoPizza.csproj
    -| Program.cs
    -| WeatherForecast.cs
    ```

1. Examine the following files and directories:

    | Name                                         | Description                                                     |
    |----------------------------------------------|-----------------------------------------------------------------|
    | *:::no-loc text="Controllers/":::*           | Contains classes with public methods exposed as HTTP endpoints. |
    | *:::no-loc text="Program.cs":::*             | Configures services and the app's HTTP request pipeline, and contains the app's managed entry point.   |
    | *:::no-loc text="ContosoPizza.csproj":::* | Contains configuration metadata for the project.                   |

## Build and test the web API

1. Run the following .NET Core CLI command in the command shell:

    ```dotnetcli
    dotnet run
    ```

    The preceding command:

    * Locates the project file at the current directory.
    * Retrieves and installs any required project dependencies for this project.
    * Compiles the project code.
    * Hosts the web API with the ASP.NET Core Kestrel web server at both an HTTP and HTTPS endpoint.

    A port from 5000 to 5300 is selected for HTTP, and from 7000 to 7300 for HTTPS, when the project is created. You can easily change the ports that you use during development by editing the project's *launchSettings.json* file. This module uses the secure `localhost` URL that begins with `https`.

    You should get output similar to the following, indicating that your app is running:

    ```console
    Building...
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: https://localhost:7294
    info: Microsoft.Hosting.Lifetime[14]
          Now listening on: http://localhost:5118 
    info: Microsoft.Hosting.Lifetime[0]
          Application started. Press Ctrl+C to shut down.
    info: Microsoft.Hosting.Lifetime[0]
          Hosting environment: Development        
    ```

    If you're running this app on your own machine, you could direct a browser to the HTTPS link that's displayed in the output (in the preceding case, `https://localhost:7294`) to view the resulting page. Remember this port, because you use it throughout the module where `{PORT}` is used.

    > [!IMPORTANT]
    > Check the terminal output if you encounter any unexpected behavior. If the build fails or other errors occur, the log file's information helps you troubleshoot. As you make changes to the code, you'll need to stop the web API by selecting CTRL+C on the keyboard and rerunning the `dotnet run` command.

1. Open a web browser and go to:

    ```bash
    https://localhost:{PORT}/weatherforecast
    ```

    You should see JSON output similar to this example:

    ```json
    [
        {
        "date": "2021-11-09T20:36:01.4678814+00:00",
        "temperatureC": 33,
        "temperatureF": 91,
        "summary": "Scorching"
        },
        {
        "date": "2021-11-09T20:36:01.4682337+00:00",
        "temperatureC": -8,
        "temperatureF": 18,
        "summary": "Cool"
        },
        // ...
    ]
    ```

1. Open a new integrated terminal from Visual Studio Code by selecting **Terminal** > **New Terminal** from the main menu, then run the following command:

    ```dotnetcli
    dotnet tool install -g Microsoft.dotnet-httprepl
    ```

    The preceding command installs the .NET HTTP REPL command-line tool that you use to make HTTP requests to the web API.

1. Connect to the web API by running the following command:
  
    ```dotnetcli
    httprepl https://localhost:{PORT}
    ```

    Alternatively, run the following command at any time while `HttpRepl` is running:

    ```dotnetcli
    connect https://localhost:{PORT}
    ```

    > [!TIP]
    > If the `HttpRepl` tool warns **Unable to find an OpenAPI description**, the most likely cause is an untrusted development certificate. `HttpRepl` requires a trusted connection. Before you can continue, you **must** [configure your system to trust the dev certificate](/aspnet/core/security/enforcing-ssl#trust-the-aspnet-core-https-development-certificate-on-windows-and-macos) with `dotnet dev-certs https --trust`

1. Explore available endpoints by running the following command:

    ```dotnetcli
    ls
    ```

    The preceding command detects all APIs available on the connected endpoint and lists them, as in the following output:

    ```output
    https://localhost:{PORT}/> ls
    .                 []
    WeatherForecast   [GET] 
    ```

1. Go to the `WeatherForecast` endpoint by running the following command:

    ```dotnetcli
    cd WeatherForecast
    ```

    The preceding command shows an output of available APIs for the `WeatherForecast` endpoint:

    ```output
    https://localhost:{PORT}/> cd WeatherForecast
    /WeatherForecast    [GET]
    ```

1. Make a `GET` request in `HttpRepl` by using the following command:

    ```dotnetcli
    get
    ```

    The preceding command makes a `GET` request similar to going to the endpoint in the browser:

    ```output
    HTTP/1.1 200 OK
    Content-Type: application/json; charset=utf-8
    Date: Fri, 02 Apr 2021 17:31:43 GMT
    Server: Kestrel
    Transfer-Encoding: chunked
    [
        {
        "date": 4/3/2021 10:31:44 AM,
        "temperatureC": 13,
        "temperatureF": 55,
        "summary": "Sweltering"
        },
        {
        "date": 4/4/2021 10:31:44 AM,
        "temperatureC": -13,
        "temperatureF": 9,
        "summary": "Warm"
        },
        // ..
    ]
    ```

1. End the current `HttpRepl` session by using the following command:

    ```dotnetcli
    exit
    ```

1. Return to the `dotnet` terminal in the drop-down list in Visual Studio Code. Shut down the web API by selecting CTRL+C on your keyboard.

Now that you've created the web API, we can modify it to meet the needs of the pizza web API.
