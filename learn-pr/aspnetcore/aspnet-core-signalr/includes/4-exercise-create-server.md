An ASP.NET Core Minimal API application will be our server app. Recall that the notification system needs to function for all employees in the warehouse. There were a fey requirements for this implementation: real-time functionality, and connectivity regardless of client app type.

Here, you will create two projects. The first is a shared class library that will hold the abstractions that can be shared with .NET clients. The second is an ASP.NET Core Minimal API app that maps the notification hub to an endpoint.

## New shared project

Let's create some abstractions in the form of a class library. This class library can be shared by .NET clients, to enable code reuse for models that are sent through SignalR. In other words, the exact same model that is used on the server has the potential to be used on the client.

1. Create the project using the following command.

    ```dotnetcli
    dotnet new classlib -n SignalR.Models
    ```

1. Open the project in Visual Studio Code.

    > [!TIP]
    > You can easily open any folder in Visual Studio Code using the `code .` command.

1. Rename the *Class1.cs* file to *Notification.cs*.
1. Replace the contents of this file, with the following C# code:

    :::code source="../code/src/SignalR.Models/Notification.cs":::

1. Create a new C# code file, named *PackageStatus.cs*.
1. Replace the file contents with the following C# code:

    :::code source="../code/src/SignalR.Models/PackageStatus.cs":::

1. Create a new C# code file, named *Package.cs*.
1. Replace the file contents with the following C# code:

    :::code source="../code/src/SignalR.Models/Package.cs":::

1. Create a new C# code file, named *Address.cs*.
1. Replace the file contents with the following C# code:

    :::code source="../code/src/SignalR.Models/Address.cs":::

## New Minimal API project

ASP.NET Core Minimal APIs are an easy way to create web applications. With an emphasis on *minimalism first*, starting from the template you can easily grow the app to fit your needs.

Open the [**Integrated Terminal** in Visual Studio Code](https://code.visualstudio.com/docs/editor/integrated-terminal), and run the following command:

```dotnetcli
dotnet new web -n SignalR.Server
```

The template is a great starting point, but we'll need to add a bit more functionality. We'll create the `NotificationHub` class, update the existing *Program.cs* file, and make use of `global using` directives.

1. Create a new folder named *Hubs*.
1. Add a new C# file to the *Hubs* folder, named *NotificationHub.cs*.
1. Replace the *NotificationHub.cs* contents with the following C# code:

    :::code source="../code/src/SignalR.Server/Hubs/NotificationHub.cs":::

1. Add a new C# file to the root folder, named *GlobalUsings.cs*.
1. Replace the *GlobalUsings.cs* contents with the following C# code:

    :::code source="../code/src/SignalR.Server/GlobalUsings.cs":::

1. Replace the template content in the *Program.cs* file with the following C# code:

    :::code source="../code/src/SignalR.Server/Program.cs":::

1. Add the `SignalR.Models` as a project reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Server/SignalR.Server.csproj reference SignalR.Models/SignalR.Models.csproj
    ```

1. Add the `Microsoft.AspNetCore.SignalR.Protocols.MessagePack` NuGet package reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Client/SignalR.Server.csproj package Microsoft.AspNetCore.SignalR.Protocols.MessagePack
    ```

## Check your work

To verify that you're projects are correct, compile them using the `dotnet build` command. From Visual Studio Code's **Integrated Terminal** window, change directories to the *SignalR.Server* folder, and run the following command:

```dotnetcli
dotnet build
```

You should the "Build succeeded." message in the output.
