Imagine you're an employee of a pizza company named Contoso Pizza. Your manager has asked you to develop a RESTful pizza inventory management service as a prerequisite for the company's web storefront. The service has to support adding, viewing, modifying, and removing types of pizza&mdash;a standardized usage of HTTP action verbs better known as **C**reate, **R**ead, **U**pdate, **D**elete (CRUD).

The .NET CLI is the simplest way to create an ASP.NET Core web API. The CLI is pre-installed when you installed the .NET SDK.

In this unit, you'll use the .NET CLI to create a web API locally. You'll also gain an understanding of the resulting project.

## Install .NET 6

[!include[](../../../includes/dotnet6-sdk-version.md)]

## Create and explore a web API project

To set up a .NET project to work with web API, we'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **ContosoPizza** in the location of your choice, and then click **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new webapi -f net6.0
    ```

    This command creates the files for a basic web API project that uses Controllers, along with a C# project file named **ContosoPizza.csproj** that will return a list of weather forecasts. If you run into an error, ensure that you have the [.NET 6 SDK](https://dotnet.microsoft.com/download) installed.


    > [!IMPORTANT]
    > Web API projects are secured with `https` by default. If you run into issues, you will want to [configure the ASP.NET Core HTTPS development certificate](/aspnet/core/security/enforcing-ssl#trust-the-aspnet-core-https-development-certificate-on-windows-and-macos). 

    You may receive a prompt from Visual Studio Code to add assets to debug the project. Click `Yes` on the dialog.

    The command uses an ASP.NET Core project template, aliased as *:::no-loc text="webapi":::*, to scaffold a C#-based web API project. A *:::no-loc text="ContosoPizza":::* directory is created, which contains an ASP.NET Core project running on .NET. The project name matches the *:::no-loc text="ContosoPizza":::* directory name.    

    You should now have access to these files.

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


    The preceding command uses an ASP.NET Core project template, aliased as *:::no-loc text="webapi":::*, to scaffold a C#-based web API project. A *:::no-loc text="ContosoPizza":::* directory is created, which contains an ASP.NET Core project running on .NET. The project name matches the *:::no-loc text="ContosoPizza":::* directory name.

1. Examine the following files and directories:

    | Name                                         | Description                                                     |
    |----------------------------------------------|-----------------------------------------------------------------|
    | *:::no-loc text="Controllers/":::*           | Contains classes with public methods exposed as HTTP endpoints. |
    | *:::no-loc text="Program.cs":::*             | Configures services and the app's HTTP request pipeline & contains the app's managed entry point.   |
    | *:::no-loc text="ContosoPizza.csproj":::* | Contains configuration metadata for the project.                |

## Build and test the web API

1. Run the following .NET Core CLI command in the command shell:

    ```dotnetcli
    dotnet run
    ```

    The preceding command:

    * Locates the project file at the current directory.
    * Retrieves and installs any required project dependencies for this project.
    * Compiles the project code.
    * Hosts the web API with ASP.NET Core's Kestrel web server at both an HTTP and HTTPS endpoint.

    A port from 5000-5300 will be selected for HTTP, and from 7000-7300 for HTTPS, at the time the project is created. As always, the ports used during development can be easily changed by editing the project’s launchSettings.json file. This module uses the secure localhost URL beginning with `https`.

    A variation of the following output displays to indicate your app is running:

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

    If running this app on your own machine, you could direct a browser to the HTTPS link displayed in the output (in the above case, `https://localhost:7294`) to view the resulting page. Remember this port as you will use it throughout the module where `{PORT}` is used.

    > [!IMPORTANT]
    > Check terminal output if you encounter any unexpected behavior. If the build fails or other errors occur, the log file's information helps troubleshoot. As we make changes to the code we will need to stop the web API by pressing `CTRL+C` on the keyboard and re-running the `dotnet run` command.

1. Open a web browser and navigate to:

    ```bash
    https://localhost:{PORT}/weatherforecast
    ```

    The following output represents an excerpt of the JSON that is returned:

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

1. Open a new integrated terminal from Visual Studio Code by selecting **Terminal** > **New Terminal** from the main menu and run the following command:

   ```dotnetcli
     dotnet tool install -g Microsoft.dotnet-httprepl
   ```

   The preceding command installs the .NET HTTP Read-Eval-Print Loop (REPL) command-line tool that we will use to make HTTP requests to our web API.

1. Connect to our web API by running the following command:
  
   ```dotnetcli
   httprepl https://localhost:{PORT}
   ```

   Alternatively, run the following command at any time while the HttpRepl is running:

   For example:

   ```dotnetcli
   (Disconnected)> connect https://localhost:{PORT}
   ```

1. Explore available endpoints by running the following command:

   ```dotnetcli
   ls
   ```

   The preceding command will detect all APIs available on the connected endpoint. It should display the following:

    ```dotnetcli
   https://localhost:{PORT}/> ls
   .                 []
   WeatherForecast   [GET] 
   ```

1. Navigate to the WeatherForecast endpoint by running the following command:

     ```dotnetcli
     cd WeatherForecast
     ```

   The following command will output available APIs available for the `WeatherForecast` endpoint:

   ```dotnetcli
   https://localhost:{PORT}/> cd WeatherForecast
   /WeatherForecast    [GET]
   ```

1. Make a `GET` request in the HttpRepl by using the following command:

   ```dotnetcli
   get
   ```

   The following command will make a `GET` request similar to navigating to the endpoint in the browser:

   ```dotnetcli
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

1. Quit current HttpRepl session by using the following command:

   ```dotnetcli
   exit
   ```

1. Return to the `dotnet` terminal in the dropdown list in Visual Studio Code and shut down the web API pressing `CTRL+C` on your keyboard.

Now that the web API has been created, let's modify it to meet the needs of our pizza web API.
