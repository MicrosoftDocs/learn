In this unit, you use developer tools to create the code for a starter web application.

To diagnose application startup errors, you need to deploy code to your web app in Azure App Service. In this exercise, you create and deploy an ASP.NET Core web app.

## Create a new web project

Use the `dotnet` command line tool to create a new ASP.NET Core web project:

1. Sign in to the sandbox and review the permissions.

1. In Azure Cloud Shell on the right, create a new ASP.NET Core MVC application named *HotelApp*. The command creates a new folder named *HotelApp* to hold your project.

    ```bash
    dotnet new mvc --name HotelApp
    ```

1. Run the following commands to build and run the application:

    ```bash
    cd HotelApp
    dotnet run
    ```

1. Check for output that's similar to the following example:

    ```output
    Using launch settings from /home/your-user/Documents/HotelApp/Properties/launchSettings.json...
    ...
    Hosting environment: Production
    Content root path: /home/your-user/HotelApp
    Now listening on: http://localhost:5000
    Application started.
    ```

    The output indicates that the application is running and listening at port 5000.

    If you're running the app on your own machine, you can open a browser and go to `http://localhost:5000` to view the app. To make the app accessible outside your own machine, you'll need to deploy the app to a public endpoint.

1. Press Ctrl+C to stop the application.

## Update the web project code

1. Edit the *Program.cs* file to add code that causes a startup error. Use the following command to open the file in an editor in the sandbox:

    ```bash
    code Program.cs
    ```

1. In the *Program.cs* file, add `.UseContentRoot("invalid path")` after `UseStartup<Startup>()`. Your file should look like the following code:

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.Hosting;
    using Microsoft.Extensions.Logging;
    
    namespace HotelApp
    {
        public class Program
        {
            public static void Main(string[] args)
            {
                CreateHostBuilder(args).Build().Run();
            }
    
            public static IHostBuilder CreateHostBuilder(string[] args) =>
                Host.CreateDefaultBuilder(args)
                    .ConfigureWebHostDefaults(webBuilder =>
                    {
                        webBuilder.UseStartup<Startup>().UseContentRoot("invalid path");
                    });
        }
    }
    ```

1. Press Ctrl+S and then Ctrl+Q to save the file and close the editor.

1. Deploy the project to a new web app. The web app name must be unique in Azure App Service. The following code uses the `$RANDOM` variable to add a random string to the app name to ensure that the name is unique:

    ```bash
    az webapp up \
        --name HotelApp-$RANDOM \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --sku F1 \
        --location centralus
    ```

    Copy the name of your app, so you can refer to it later.

    Wait for the web app creation process to finish and for the cursor to appear in Azure Cloud Shell.

1. At the cursor, run the application:

    ```bash
    dotnet run

    ```

1. Check the Azure Cloud Shell sandbox for an error message that looks similar to the following example:

    :::image type="content" source="../media/dotnet-run-command.png" alt-text="Screenshot that shows an error when the application runs in Azure Cloud Shell.":::
