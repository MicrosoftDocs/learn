In this unit, you will create an ASP.NET Core web app.

## Create a new web project

The heart of the .NET CLI tools is the `dotnet` command line tool. Using this command, you will create a new ASP.NET Core web project.

In the Cloud Shell on the right, create a new ASP.NET Core MVC application. Name it "BestBikeApp".

```bash
dotnet new mvc --name BestBikeApp
```

The command will create a new folder named "BestBikeApp" to hold your project. `cd` there, then build and run the application to verify it is complete.

```bash
cd BestBikeApp
dotnet run
```

You should get something like:

```console
Using launch settings from /home/your-user/Documents/BestBikeApp/Properties/launchSettings.json...
...
Hosting environment: Production
Content root path: /home/your-user/BestBikeApp
Now listening on: http://localhost:5000
Application started.
```

The output describes the situation after starting your app: the application is running and listening at port 5000.

If were running the app on our own machine we'd be able to open a browser to http://localhost:5000. Since we're on Azure Cloud Shell, we'll need to deploy the app to somewhere with a public endpoint. The App Service instance we created earlier is perfect for that.