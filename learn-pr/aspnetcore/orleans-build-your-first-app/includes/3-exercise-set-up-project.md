In order to work with Orleans, you first need to create a properly configured application. For this module, you use an ASP.NET Core 8.0 Minimal API to build a lean but useful URL shortener web service. URL shorteners allow users to submit a long URL to the app, which returns a shorter URL they can share with their customers and network. When a user enters the shortened URL in the browser, they're redirected to the correct site at the full address.

This module requires .NET 8.0 to be installed on your computer. You can verify which versions of .NET are installed using this .NET CLI command:

```dotnetcli
dotnet --list-sdks
```

Your console output should look similar to the following text and should include a version that starts with `8.x`.

```dotnetcli
8.0.100 [C:\Program Files\dotnet\sdk]
```

## Clone the completed project from GitHub

You can work through this module to build the URL shortener app from start to finish. Alternatively, you can also clone the completed sample project from GitHub to follow along or check your work against the completed code.

```bash
git clone https://github.com/Azure-Samples/build-your-first-orleans-app-aspnetcore
```

## Create the project using Visual Studio Code

If you want to build the app from start to finish, create and run a new minimal API project using the following steps.

1. To create a new minimal API project with .NET 8.0, run this command in your preferred terminal:

    ```dotnetcli
    dotnet new web -o UrlShortener -f net8.0
    ```

1. Open the project inside Visual Studio Code using the following command:

    ```dotnetcli
    cd UrlShortener
    code .
    ```

1. Once the project is open in Visual Studio Code, you can build and run the app from the integrated terminal using the `dotnet run` command.

    ```dotnetcli
    dotnet run
    ```

    After a moment, the app should launch in your browser and display the message `Hello World!`. By the end of the module, you expand this app to provide URL shortening capabilities.

## Add Orleans to the project

Orleans is available through a collection of NuGet packages. Follow these steps to integrate Orleans into the project you created.

1. For this module, you need to install the specific Orleans packages by running the following `dotnet add package` command in the Visual Studio Code terminal. The latest version of `8.x` works for this exercise, or you can use the version specified in the following command:

    ```dotnetcli
    dotnet add package Microsoft.Orleans.Server -v 8.0.*
    ```

1. Add the following `using` statement to the top of your `Program` class. This `using` statement ensures the necessary classes are available for the steps ahead.

    ```dotnetcli
    using Orleans.Runtime;
    ```

At this point, you created a basic minimal API with Orleans included. In the next step, you learn how to use grains and silos to create the basic building blocks of an Orleans app.
