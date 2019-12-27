In this unit, you will use developer tools to create the code for a starter web application.

To diagnose application startup errors, you need to deploy code to your web app in Azure App Service. For this module, you'll create and deploy an ASP.NET Core web app.

## Create a new web project

Use the `dotnet` command line tool to create a new ASP.NET Core web project.

1. In the Cloud Shell on the right, create a new ASP.NET Core MVC application. Name it "HotelApp".

    ```bash
    dotnet new mvc --name HotelApp
    ```

1. The command will create a new folder named "HotelApp" to hold your project. `cd` there, then build and run the application to verify it is complete.

    ```bash
    cd HotelApp
    dotnet run
    ```

1. You should see output similiar to the following:

    ```output
    Using launch settings from /home/your-user/Documents/HotelApp/Properties/launchSettings.json...
    ...
    Hosting environment: Production
    Content root path: /home/your-user/HotelApp
    Now listening on: http://localhost:5000
    Application started.
    ```

    The output describes the situation after starting your app: the application is running and listening at port 5000.

    If you are running the app on your own machine, you'd be able to open a browser to `http://localhost:5000`. To make this accessible from outside of our own machine, you'll need to deploy the app to somewhere with a public endpoint.
    
1. Use <kbd>Ctrl+c</kbd> to stop the application.

## Update the web project code

1. Edit the *Program.cs* file to add code that will cause a startup error. Open an editor with the following command:

    ```bash
    code Program.cs
    ```
1. In the *Program.cs* file Add `.UseContentRoot("invalid path")` after `UseStartup<Startup>()`. Your file should look like the following:

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.Logging;

    namespace HotelApp
    {
        public class Program
        {
            public static void Main(string[] args)
            {
                CreateWebHostBuilder(args).Build().Run();
            }

            public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
                WebHost.CreateDefaultBuilder(args)
                    .UseStartup<Startup>().UseContentRoot("invalid path");
        }
    }
    ```

1. Use <kbd>Ctrl+s</kbd> to save the file after editing and then <kbd>Ctrl+q</kbd> to close the editor.

1. Deploy the project to a new web app. The web app name must be unique in Azure App Service, so we'll add a random string to the end to ensure the name is unique:

    ```bash
    az webapp up \
        --name HotelApp-$RANDOM \
        --resource-group <rgn>[Sandbox resource group]</rgn> \
        --sku F1 \
        --location centralus
    ```

    Copy the name of your app service so you can refer to it again.
You will need to wait till the web app creation process is complete before clicking on the **Check your work** button.
