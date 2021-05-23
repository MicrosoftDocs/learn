Imagine you're an employee of a pizza company named Contoso Pizza. Your manager has asked you to develop a RESTful pizza inventory management service as a prerequisite for the company's web storefront. The service has to support adding, viewing, modifying, and removing types of pizza&mdash;a standardized usage of HTTP action verbs better known as **C**reate, **R**ead, **U**pdate, **D**elete (CRUD).

The .NET CLI is the simplest way to create an ASP.NET Core web API. The CLI is pre-installed when you installed the .NET SDK.

In this unit, you'll use the .NET CLI to create a web API locally. You'll also gain an understanding of the resulting project.

## Create and explore a web API project

To set up a .NET project to work with web API, we'll use Visual Studio Code. Visual Studio Code includes an integrated terminal, which makes creating a new project easy. If you don't want to use another code editor, you can run the commands in this module in a terminal.

1. In Visual Studio Code, select **File** > **Open Folder**.

1. Create a new folder named **ContosoPizza** in the location of your choice, and then click **Select Folder**.

1. Open the integrated terminal from Visual Studio Code by selecting **View** > **Terminal** from the main menu.

1. In the terminal window, copy and paste the following command.

    ```dotnetcli
    dotnet new webapi --no-https
    ```

    This command creates the files for a basic web API project, along with a C# project file named **ContosoPizza.csproj** that will return a list of weather forecasts. 

    The `--no-https` flag creates an app that will run without an HTTPS certificate, to keep things as simple as possible for local development.

    > [!IMPORTANT]
    > Before doing any production work with web APIs, and definitely before deploying to production, you will want to [configure the ASP.NET Core HTTPS development certificate](/aspnet/core/security/enforcing-ssl#trust-the-aspnet-core-https-development-certificate-on-windows-and-macos). This will help keep your API communications private, as well as safeguard against tampering via *man-in-the-middle* attacks.

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
    -| Startup.cs
    -| WeatherForecast.cs
    ```


    The preceding command uses an ASP.NET Core project template, aliased as *:::no-loc text="webapi":::*, to scaffold a C#-based web API project. A *:::no-loc text="ContosoPizza":::* directory is created, which contains an ASP.NET Core project running on .NET. The project name matches the *:::no-loc text="ContosoPizza":::* directory name.

1. Examine the following files and directories:

    | Name                                         | Description                                                     |
    |----------------------------------------------|-----------------------------------------------------------------|
    | *:::no-loc text="Controllers/":::*           | Contains classes with public methods exposed as HTTP endpoints. |
    | *:::no-loc text="Program.cs":::*             | Contains a `Main` method&mdash;the app's managed entry point.   |
    | *:::no-loc text="Startup.cs":::*             | Configures services and the app's HTTP request pipeline.        |
    | *:::no-loc text="ContosoPizza.csproj":::* | Contains configuration metadata for the project.                |

## Build and test the web API

1. Run the following command to build the app:

    ```dotnetcli
    dotnet build
    ```

1. Run the following .NET Core CLI command in the command shell:

    ```dotnetcli
    dotnet run
    ```

    The preceding command:

    * Hosts the web API with ASP.NET Core's Kestrel web server.
    * Outputs log information of the running web API.

    The web API is hosted at both `http://localhost:5000`. If we didn't pass the `--no-https` flag we would see that the API would also run on `https://localhost:5001`.

    > [!IMPORTANT]
    > Check terminal output if you encounter any unexpected behavior. If the build fails or other errors occur, the log file's information helps troubleshoot. As we make changes to the code we will need to stop the web API by pressing `CTRL+C` on the keyboard and re-running the `dotnet run` command.

    In the future, we will use only the `dotnet run` command as this command also will build our project if anything has changed.

1. Open a web browser and navigate to:

    ```bash
   http://localhost:5000/weatherforecast
    ```

    The following output represents an excerpt of the JSON that is returned:

    ```json
    [
      {
        "date": "2021-02-12T20:36:01.4678814+00:00",
        "temperatureC": 33,
        "temperatureF": 91,
        "summary": "Scorching"
      },
      {
        "date": "2021-02-13T20:36:01.4682337+00:00",
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
   httprepl http://localhost:5000
   ```

   Alternatively, run the following command at any time while the HttpRepl is running:

   For example:

   ```dotnetcli
   (Disconnected)> connect http://localhost:5000
   ```

1. Explore available endpoints by running the following command:

   ```dotnetcli
   ls
   ```

   The preceding command will detect all APIs available on the connected endpoint. It should display the following:

    ```dotnetcli
   http://localhost:5000/> ls
   .                 []
   WeatherForecast   [GET] 
   ```

1. Navigate to the WeatherForecast endpoint by running the following command:

     ```dotnetcli
     cd WeatherForecast
     ```

   The following command will output available APIs available for the `WeatherForecast` endpoint:

   ```dotnetcli
   http://localhost:5000/> cd WeatherForecast
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
