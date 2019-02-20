The .NET Core CLI is the simplest way to create an ASP.NET Core web API. The CLI is pre-installed in the Azure Cloud Shell environment used in this unit.

In this unit, you'll use the .NET Core CLI to create a web API within the Cloud Shell command shell to the right. You'll also gain an understanding of the resulting project.

## Create a web API

[!include[](../../../includes/azure-sandbox-activate.md)]

### Scaffold and explore a web API project

1. Run the following .NET Core CLI command in the command shell:

    ```bash
    dotnet new webapi -o RetailApi
    ```

    The preceding command uses an ASP.NET Core project template, aliased as *webapi*, to scaffold a C#-based starter web API project. A directory named *RetailApi* is created that contains an ASP.NET Core project targeting .NET Core. The project name matches the directory name.
1. Run the following command in the command shell:

    ```bash
    cd ./RetailApi
    ```

    The current directory changes to the newly created *RetailApi* directory.
1. Run the following command in the command shell:

    ```bash
    code .
    ```

    The *RetailApi* project directory opens in the [Azure Cloud Shell editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor).
1. Examine the following files and directories:

    |Name              |Description                                                    |
    |------------------|---------------------------------------------------------------|
    |*Controllers/*    |Contains classes with public methods exposed as HTTP endpoints.|
    |*Program.cs*      |Contains a `Main` method&mdash;the app's managed entry point.  |
    |*RetailApi.csproj*|Contains configuration metadata for the project.               |
    |*Startup.cs*      |Configures services and the app's HTTP request pipeline.       |

## Build and test

1. Run the following .NET Core CLI command in the command shell:

    ```bash
    dotnet run > RetailApi.log &
    ```

    The preceding command:

    * Restores the project's NuGet packages.
    * Builds the project code.
    * Hosts the web API with ASP.NET Core's Kestrel web server.
    * Displays the background task's process ID.

    .NET Core emits logging information and blocks command shell input. The command shell needs to be usable to test the running app. Therefore, the `dotnet run` output is redirected to a *RetailApi.log* text file. Additionally, the `&` runs the app as a background task to unblock command shell input.

    The web API is hosted at both `http://localhost:5000` and `https://localhost:5001`. This module uses the secure URL beginning with `https`.

    > [!IMPORTANT]
    > Check *RetailApi.log* if you encounter any unexpected behavior. If the build fails or other errors occur, the log file's information helps troubleshoot.
1. Send an HTTP GET request to the web API:

    ```bash
    curl -k -s https://localhost:5001/api/values | python -m json.tool
    ```

    > [!NOTE]
    > [curl](https://curl.haxx.se/) is a cross-platform command-line tool for testing web APIs and other HTTP endpoints.

    The preceding command uses:

    * HTTPS to send a request to the web API running on port 5001 of localhost. The `ValuesController` class' parameterless `Get` action method handles the request.
    * The `-k` option to indicate that curl should allow insecure server connections when using HTTPS. The .NET Core SDK includes an HTTPS development certificate for testing. By default, curl rejects secure connections using this certificate.
    * The `-s` option to suppress all output except the JSON payload. The JSON is sent to a Python *json.tool* module for improved display.

    The following JSON is returned:

    ```json
    [
      "value1",
      "value2"
    ]
    ```
1. Stop all running .NET Core apps:

    ```bash
    kill $(pidof dotnet)
    ```

Now that the web API has been created, let's modify it to meet the retailer's needs.
