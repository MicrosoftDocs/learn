An ASP.NET Core Minimal API application will be our server app. Recall that the notification system needs to function for all employees in the warehouse. There were a fey requirements for this implementation: real-time functionality, and connectivity regardless of client app type.

Here, you will create two projects. The first is a shared class library that will hold the abstractions that can later be shared with clients. The second is an ASP.NET Core Minimal API app that maps the notification hub to an endpoint.

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
1. Add the following C# code to the *NotificationHub.cs* file:

    :::code source="../code/src/SignalR.Server/Hubs/NotificationHub.cs":::

1. Add a new C# file to the root folder, named *GlobalUsings.cs*.
1. Add the following C# code to the *GlobalUsings.cs* file:

    :::code source="../code/src/SignalR.Server/GlobalUsings.cs":::

1. Replace the template content in the *Program.cs* file, with the following C# code:

    :::code source="../code/src/SignalR.Server/Program.cs":::

1. Add the `SignalR.Models` as a project reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Server/SignalR.Server.csproj reference SignalR.Models/SignalR.Models.csproj
    ```

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

    Goal: Helps the learner to evaluate if they completed the exercise correctly.

    Structure: Break the steps into 'chunks' where each chunk has three things:
        1. A heading of "## Check your work"
        2. An introductory paragraph describing how they'll validate their work at a high level
        3. Numbered steps (when the learner needs to perform multiple steps to verify if they were successful)
        4. Video of an expert performing the exact steps of the exercise (optional)

    Example:
        Heading:
            "Examine the results of your Twitter trigger"
        Introduction:
             "At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the Runs history table."
        Steps:
             "1. Select Overview in the navigation menu.
              2. Select Refresh once a minute until you see a row in the Runs history table.
              ...
              6. Examine the data in the OUTPUTS section. For example, locate the text of the matching tweet."
-->

## Check your work
<!-- Introduction paragraph -->
1. <!-- Step 1 (if multiple steps are needed) -->
1. <!-- Step 2 (if multiple steps are needed) -->
1. <!-- Step n (if multiple steps are needed) -->
Optional "exercise-solution" video

<!-- 

NOTES:

dotnet add SignalR.Server/SignalR.Server.csproj  package Microsoft.Identity.Web

 -->

<!-- Do not add a unit summary or references/links -->
