In order to work with Orleans, you'll first need to create a properly configured application. For this module, you'll use an ASP.NET Core 7.0 Minimal API to build a lean but useful URL shortener web service. URL shorteners allow users to submit a long URL to the app, which will then return a much shorter URL they can share with their customers and network. When a user enters the shortened URL in the browser, they'll be redirected to the correct site at the full address.

This module requires .NET 7.0 to be installed on your computer. You can verify which versions of .NET are installed using the .NET CLI command below.

```dotnetcli
dotnet --list-sdks
```

Your console output should look similar to the text below and should include a version that starts with `7.x`.

```dotnetcli
7.0.0 [C:\Program Files\dotnet\sdk]
```

## Clone the completed project from GitHub

You can work through this module to build the URL shortener app from start to finish. Alternatively, you can also clone the completed sample project from GitHub to follow along or check your work against the completed code.

```bash
git clone https://github.com/Azure-Samples/build-your-first-orleans-app-aspnetcore
```

## Create the project using Visual Studio Code

If you want to build the app from start to finish, create and run a new minimal API project using the steps below.

1) To create a new minimal API project with .NET 7.0, run the command below in your preferred terminal:
    
    ```dotnetcli
    dotnet new web -o UrlShortener -f net7.0
    ```

2) Open the project inside Visual Studio Code using the following command:
    
    ```dotnetcli
    cd UrlShortener
    code .
    ```

3) Once the project is open in Visual Studio Code, you can build and run the app from the integrated terminal using the `dotnet run` command.
    
    ```dotnetcli
    dotnet run
    ```

    After a moment, the app should launch in your browser and display the message `Hello World!`. By the end of the module you'll expand this app to provide URL shortening capabilities.

## Add Orleans to the project

Orleans is available through a collection of NuGet packages. Follow the steps below to integrate Orleans into the project you created.

1) For this module, you'll need to install the specific Orleans packages below by running the `dotnet add package` command in the Visual Studio Code terminal. The latest version of `7.x` will work for this exercise, or you can use the version specified in the following command:

    ```dotnetcli
    dotnet add package Microsoft.Orleans.Server -v 7.0.0
    ```

2) Add the `using` statements below to the top of your `Program` class. These `using` statements will ensure the necessary classes are available for the steps ahead.
    
    ```dotnetcli
    using Microsoft.AspNetCore.Http.Extensions;
    using Orleans.Runtime;
    ```

At this point, you've created a basic minimal API with Orleans included. In the next step, you'll learn how to use grains and silos to create the basic building blocks of an Orleans app.