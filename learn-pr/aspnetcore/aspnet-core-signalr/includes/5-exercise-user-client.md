ASP.NET Core SignalR [supports several platforms](xref:signalr/supported-platforms), enabling clients for nearly every scenario. To make use of the `SignalR.Models` library we created earlier, let's use .NET as our platform.

Here, you will create an ASP.NET Core Blazor WebAssembly project that will act as a client. This web application can be accessed by all of the employees, from anywhere within the warehouse.

## New Blazor WebAssembly project

ASP.NET Core Blazor WebAssembly can be deployed as a static web application, and as a progressive web application (PWA). It offers many benefits, and simplifies .NET web development. The web application will use a `HubConnection` object instance to establish a connection to the server, thus enabling real-time functionality.

Open the [**Integrated Terminal** in Visual Studio Code](https://code.visualstudio.com/docs/editor/integrated-terminal), and run the following command:

```dotnetcli
dotnet new blazorwasm -n SignalR.Client
```

## Remove unnecessary parts

The template for the client application has a few things we do *not* need, so let's start by deleting them.

1. Delete the *sample-data* folder, which contains the *weather.json*.
1. Delete the *SurveyPrompt.razor* component, in the *Shared* folder.
1. Delete the reference to the `SurveyPrompt` component, in the *Pages/Index.razor* file.
1. Ensure that the application still compiles, but running the following command:

    ```dotnetcli
    dotnet build SignalR.Client/SignalR.Client.csproj
    ```

## Add references

Our client application needs to rely on the shared models project, to understand the shape of the notifications. Additionally, the client needs to reference the SignalR client SDK and corresponding MessagePack protocol package.

1. Add the `SignalR.Models` as a project reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Client/SignalR.Client.csproj reference SignalR.Models/SignalR.Models.csproj
    ```

1. Add the `Microsoft.AspNetCore.SignalR.Client` NuGet package reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Client/SignalR.Client.csproj package Microsoft.AspNetCore.SignalR.Client
    ```

1. Add the `Microsoft.AspNetCore.SignalR.Protocols.MessagePack` NuGet package reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Client/SignalR.Client.csproj package Microsoft.AspNetCore.SignalR.Protocols.MessagePack
    ```

## Repurpose the `FetchData` component

The `FetchData` component will be repurposed, to serve as our notifications page.

1. Rename the *FetchData.razor* file to *Notifications.razor*.
1. Replace the contents of the *Notifications.razor* with the following Razor markup:

    :::code source="../code/src/SignalR.Client/Pages/Notifications.razor":::

1. Create a new C# file named *Notifications.razor.cs*, which will shadow the Razor component markup.
1. Replace the contents of the *Notifications.razor.cs* with the following C# code:

    :::code source="../code/src/SignalR.Client/Pages/Notifications.razor.cs":::

1. Update the *NavMenu.razor* markup, replacing the entire `<NavLink href="fetchdata">` element node with the following Razor markup:

    ```razor
    <NavLink class="nav-link" href="notifications">
        <span class="oi oi-bolt" aria-hidden="true"></span> Notifications
    </NavLink>
    ```

<!-- 5. Validation chunk -------------------------------------------------------------------------------------

1. Add the `SignalR.Models` as a project reference to the `SignalR.Server` project:

    ```dotnetcli
    dotnet add SignalR.Server/SignalR.Server.csproj reference SignalR.Models/SignalR.Models.csproj
    ```

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

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->
