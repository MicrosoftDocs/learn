In this unit, you will use developer tools to create the code for a starter web application.

To diagnose application startup errors, you need to deploy code to your web app in Azure App Service. For this module, you'll create and deploy an ASP.NET Core web app.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a new web project

Use the `dotnet` command line tool to create a new ASP.NET Core web project.

1. In the Cloud Shell on the right, create a new ASP.NET Core MVC application. Name it "HotelApp".

```bash
dotnet new mvc --name HotelApp
```

2. The command will create a new folder named "HotelApp" to hold your project. `cd` there, then build and run the application to verify it is complete.

```bash
cd HotelApp
dotnet run
```

3. You should get something like:

```console
Using launch settings from /home/your-user/Documents/HotelApp/Properties/launchSettings.json...
...
Hosting environment: Production
Content root path: /home/your-user/HotelApp
Now listening on: http://localhost:5000
Application started.
```

The output describes the situation after starting your app: the application is running and listening at port 5000.

If you were running the app on our own machine, we'd be able to open a browser to http://localhost:5000. To make this accessible from outside of our own machine, we'll need to deploy the app to somewhere with a public endpoint. The App Service instance we created earlier is perfect for that. Press Ctrl+C to shut down the application.

## Update the web project code

1. Ensure that you are in the web app folder HotelApp by running:

```bash
cd HotelApp
```

2. Access the Program.cs file and edit it using `code Program.cs` command to update the file to include a startup exception `UseContentRoot("invalid path")`. **Save** the file after editing and **close** the editor.


```csharp
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
```

3. Deploy the web app to implement the changes after updating the web app name to include your name in the `[<yourname>HotelApp]` parameter value:

```bash
az webapp up --name [<yourname>HotelApp] --resource-group <rgn>[Sandbox resource group]</rgn> --sku S1
```

You will need to wait till the web app creation process is complete before clicking on the **Check your work** button.