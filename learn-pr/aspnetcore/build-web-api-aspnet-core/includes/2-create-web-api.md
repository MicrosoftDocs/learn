The .NET Core CLI is the simplest way to create an ASP.NET Core web API. The CLI is pre-installed in the Cloud Shell environment used in this unit.

In this unit, you'll use the .NET Core CLI to create a web API within the Cloud Shell command shell to the right. You'll also gain an understanding of the resulting project.

## Set up the development environment

Run the following command in the command shell:

```bash
. <(wget -q -O - https://aka.ms/create-web-api-aspnet-core-setup)
```

[!INCLUDE[OS-specific keyboard shortcuts](../../../includes/azure-cloudshell-copy-paste-tip.md)]

The preceding command installs a specific version of the .NET Core SDK in the Cloud Shell environment.

## Create and explore a web API project

1. Run the following .NET Core CLI command in the command shell:

    ```dotnetcli
    dotnet new webapi -o ContosoPets.Api
    ```

    The preceding command uses an ASP.NET Core project template, aliased as *:::no-loc text="webapi":::*, to scaffold a C#-based web API project. A *:::no-loc text="ContosoPets.Api":::* directory is created, which contains an ASP.NET Core project running on .NET Core. The project name matches the *:::no-loc text="ContosoPets.Api":::* directory name.

1. Run the following command in the command shell:

    ```bash
    cd ./ContosoPets.Api
    ```

    The current directory changes to the newly created *:::no-loc text="ContosoPets.Api":::* directory.

1. Run the following command in the command shell:

    ```bash
    code .
    ```

    The *:::no-loc text="ContosoPets.Api":::* project directory opens in the [Azure Cloud Shell editor](/azure/cloud-shell/using-cloud-shell-editor).

1. Examine the following files and directories:

    | Name                                         | Description                                                     |
    |----------------------------------------------|-----------------------------------------------------------------|
    | *:::no-loc text="Controllers/":::*           | Contains classes with public methods exposed as HTTP endpoints. |
    | *:::no-loc text="Program.cs":::*             | Contains a `Main` method&mdash;the app's managed entry point.   |
    | *:::no-loc text="Startup.cs":::*             | Configures services and the app's HTTP request pipeline.        |
    | *:::no-loc text="ContosoPets.Api.csproj":::* | Contains configuration metadata for the project.                |

## Build and test the web API

1. [!INCLUDE[dotnet build command](../../includes/dotnet-build-command.md)]

1. Run the following .NET Core CLI command in the command shell:

    ```dotnetcli
    dotnet ./bin/Debug/netcoreapp3.1/ContosoPets.Api.dll > ContosoPets.Api.log &
    ```

    The preceding command:

    * Hosts the web API with ASP.NET Core's Kestrel web server.
    * Displays the background task's process ID.

    .NET Core emits logging information and blocks command shell input. The command shell needs to be usable to test the running app. Therefore, the `dotnet run` output is redirected to a *:::no-loc text="ContosoPets.Api.log":::* text file. Additionally, the `&` runs the app as a background task to unblock command shell input.

    The web API is hosted at both `http://localhost:5000` and `https://localhost:5001`. This module uses the secure URL beginning with `https`.

    > [!IMPORTANT]
    > Check *:::no-loc text="ContosoPets.Api.log":::* if you encounter any unexpected behavior. If the build fails or other errors occur, the log file's information helps troubleshoot. If you make code changes, run `kill $(pidof dotnet)` to stop all .NET Core apps before attempting to run again.

1. Send an HTTP GET request to the web API:

    ```bash
    curl -k -s https://localhost:5001/weatherforecast | jq
    ```

    [curl](https://curl.haxx.se) is a cross-platform command-line tool for testing web APIs and other HTTP endpoints. The preceding command uses:

    * HTTPS to send a request to the web API running on port 5001 of localhost. The `WeatherForecastController` class's parameterless `Get` action method handles the request.
    * The `-k` option to indicate that `curl` should allow insecure server connections when using HTTPS. The .NET Core SDK includes an HTTPS development certificate for testing. By default, `curl` rejects secure connections using this certificate.
    * The `-s` option to suppress all output except the JSON payload. The JSON is sent to the *:::no-loc text="jq":::* command-line JSON processor for improved display.

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

1. [!INCLUDE[kill command](../../includes/kill-dotnet-processes.md)]

Now that the web API has been created, let's modify it to meet the retailer's needs.
