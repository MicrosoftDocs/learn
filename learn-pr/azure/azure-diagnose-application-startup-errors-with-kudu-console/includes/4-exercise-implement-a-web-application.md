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

If you are running the app on your own machine, you'd be able to open a browser to http://localhost:5000. To make this accessible from outside of our own machine, you'll need to deploy the app to somewhere with a public endpoint.

## Update the web project code

1. Switch to the project folder by running:

```bash
cd HotelApp
```

2. Edit the Program.cs file to add code that will cause a startup error. Open an editor with command `code Program.cs`. Add `.UseContentRoot("invalid path")` after `UseStartup<Startup>()`. **Save** the file after editing and **close** the editor.


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

3. Deploy the project to a new web app. The web app name must be unique in Azure App Service, so add your name in front of `HotelApp` when you specify a name for the new web app `[<yourname>HotelApp]`:

```bash
az webapp up --name [<yourname>HotelApp] --resource-group <rgn>[Sandbox resource group]</rgn> --sku F1
```

You will need to wait till the web app creation process is complete before clicking on the **Check your work** button.