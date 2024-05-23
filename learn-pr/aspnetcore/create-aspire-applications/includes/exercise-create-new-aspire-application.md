Before you begin working on a new service for your company's latest project, you want to check your system has all the prerequisites for .NET Aspire. The best way to check is create a new .NET Aspire app with a starter template.

In the exercise you'll install all the prerequisites, and then you'll create a new .NET Aspire Starter app. Then you'll see how to add a caching component using Redis to the app. Finally, you'll test the application and quickly explore the Aspire Dashboard.

# [Visual Studio](#tab/visual-studio)

Choose this tab to see the steps in this exercise for *Visual Studio*.

# [.NET CLI](#tab/netcore-cli)

Choose this tab to see the steps in this exercise in the terminal with *dotnet CLI* commands.

---

## Install prerequisites

We discussed the prerequisites in the previous unit. Let's walk through installing them now.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```dotnetcli
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.300-preview.24203.14
```

### Install Visual Studio 2022 Preview

Follow this [Visual Studio 2022 Preview](https://visualstudio.microsoft.com/vs/preview/) link, and select **Download Preview**. After the download is complete, run the installer and follow the instructions.

### Install Docker Desktop

Follow this [Docker Desktop](https://www.docker.com/products/docker-desktop/) link, and select the correct installer for your operating system. After the download is complete, run the installer and follow the instructions.

Open the **Docker Desktop** application and accept the service agreement.

### Install the .NET Aspire workload

# [Visual Studio](#tab/visual-studio)

Install the .NET Aspire workload using Visual Studio:

1. Open the **Visual Studio Installer**.

1. Select **Modify** next to **Visual Studio**.

1. Select the **ASP.NET and web development** workload.

1. On the **Installation details** panel, select **.NET Aspire SDK (Preview)**.

1. Select **Modify** to install the .NET Aspire component.

1. Check that the latest version of .NET Aspire is installed, in a new terminal run this command:

    ```dotnetcli
    dotnet workload list
    ```

# [.NET CLI](#tab/netcore-cli)

Install the .NET Aspire workload using the .NET CLI:

1. Open a new terminal window.

1. Update .NET workloads with this command:

    ```dotnetcli
    dotnet workload update
    ```

    You should see a message that the workloads are updated successfully.

    ```console
    No workloads installed for this feature band. To update workloads installed with earlier SDK versions, include the --from-previous-sdk option.
    Updated advertising manifest microsoft.net.sdk.ios.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.net6.
    Updated advertising manifest microsoft.net.sdk.android.
    Updated advertising manifest microsoft.net.workload.emscripten.net7.
    Updated advertising manifest microsoft.net.workload.emscripten.net6.
    Updated advertising manifest microsoft.net.sdk.macos.
    Updated advertising manifest microsoft.net.workload.emscripten.current.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.current.
    Updated advertising manifest microsoft.net.sdk.maui.
    Updated advertising manifest microsoft.net.workload.mono.toolchain.net7.
    Updated advertising manifest microsoft.net.sdk.maccatalyst.
    Updated advertising manifest microsoft.net.sdk.tvos.
    Updated advertising manifest microsoft.net.sdk.aspire.
    No workloads installed for this feature band. To update workloads installed with earlier SDK versions, include the --from-previous-sdk option.
    
    Successfully updated workload(s): .
    ```

1. Install the .NET Aspire workload with this command:

    ```dotnetcli
    dotnet workload install aspire
    ```

    You should see a message that the aspire workload is installed.

    ```console
    Installing Aspire.Hosting.Sdk.Msi.x64 ...... Done
    Installing Aspire.ProjectTemplates.Msi.x64 ..... Done
    Installing Aspire.Hosting.Orchestration.win-x64.Msi.x64 ............. Done
    Installing Aspire.Hosting.Msi.x64 ..... Done
    Installing Aspire.Dashboard.Sdk.win-x64.Msi.x64 ....... Done
    
    Successfully installed workload(s) aspire.
    ```

1. Verify that the .NET Aspire workload is installed with this command:

    ```dotnetcli
    dotnet workload list
    ```

---

After installing the workload, you see:

```console
Installed Workload Id      Manifest Version      Installation Source
---------------------------------------------------------------------------------------------
aspire                     8.0.0/8.0.100         SDK 8.0.300-preview.24203, VS 17.10.34902.84

Use `dotnet workload search` to find additional workloads to install.
```

## Create a new .NET Aspire Starter app

Now that the prerequisites are installed, let's create a new app.

# [Visual Studio](#tab/visual-studio)

1. Open **Visual Studio**. In the dialog select **Create a new project**.
1. In the **Search for templates** box, enter **aspire**.
1. Select **.NET Aspire Starter Application**, and then select **Next**.
1. In the **Solution name** box, enter **AspireTestApp**.
1. In the **Location** box, enter the folder where you want to create the new app.
1. Select **Next**.
1. Leave the default **.NET 8.0 (Long Term Support)** selected.
1. Uncheck **Use Redis for caching (requires a supported container runtime)**.

    You'll be manually adding Redis support in the next steps.

1. Select **Create**.
1. From the menu select **Debug**, and then select **Start Debugging** (Alternatively, press <kbd>F5</kbd>).
1. If prompted to start Docker Engine, select **Yes**.

# [.NET CLI](#tab/netcore-cli)

1. In the same terminal window, navigate to the folder where you want to create the new test app.

1. Run the following command to create a new .NET Aspire Starter app:

    ```dotnetcli
    dotnet new aspire-starter --output AspireTestApp
    ```

    The following output is displayed:

    ```console
    The template ".NET Aspire Starter Application" was created successfully.
    This template contains technologies from parties other than Microsoft, see https://aka.ms/aspire/1.0-third-party-notices for details.
    
    Processing post-creation actions...
    Restoring C:\Users\...\source\repos\AspireTestApp\AspireTestApp.sln:
      Determining projects to restore...
      Restored C:\Users\...\source\repos\AspireTestApp\AspireTestApp.ApiService\AspireTestApp.ApiService.csproj (in 1.38
      sec).
      Restored C:\Users\...\source\repos\AspireTestApp\AspireTestApp.Web\AspireTestApp.Web.csproj (in 1.38 sec).
      Restored C:\Users\...\source\repos\AspireTestApp\AspireTestApp.AppHost\AspireTestApp.AppHost.csproj (in 1.38 sec).
      Restored C:\Users\...\source\repos\AspireTestApp\AspireTestApp.ServiceDefaults\AspireTestApp.ServiceDefaults.csproj
       (in 1.38 sec).
    Restore succeeded.
    Restoring C:\Users\...\source\repos\AspireTestApp\AspireTestApp.AppHost\AspireTestApp.AppHost.csproj:
      Determining projects to restore...
      All projects are up-to-date for restore.
    Restore succeeded.
    Restoring C:\Users\...\source\repos\AspireTestApp\AspireTestApp.ServiceDefaults\AspireTestApp.ServiceDefaults.csproj:
      Determining projects to restore...
      All projects are up-to-date for restore.
    Restore succeeded.
    Restoring C:\Users\...\source\repos\AspireTestApp\AspireTestApp.ApiService\AspireTestApp.ApiService.csproj:
      Determining projects to restore...
      All projects are up-to-date for restore.
    Restore succeeded.
    Restoring C:\Users\...\source\repos\AspireTestApp\AspireTestApp.Web\AspireTestApp.Web.csproj:
      Determining projects to restore...
      All projects are up-to-date for restore.
    Restore succeeded.
    ```

1. Run the app:

    ```dotnetcli
    dotnet run --project AspireTestApp/AspireTestApp.AppHost
    ```

    You should see this output:

    ```console
    Building...
    info: Aspire.Hosting.DistributedApplication[0]
          Distributed application starting.
    info: Aspire.Hosting.DistributedApplication[0]
          Application host directory is: C:\Users\...\source\repos\AspireTestApp\AspireTestApp.AppHost
    info: Aspire.Hosting.DistributedApplication[0]
          Now listening on: http://localhost:15157
    info: Aspire.Hosting.DistributedApplication[0]
          Distributed application started. Press CTRL-C to stop.
    ```

1. <kbd>Ctrl</kbd> + click on the listening URL to open this .NET Aspire dashboard. In the above example, the URL is **http://localhost:15157**.

---

The dashboard opens in your default web browser.

:::image type="content" source="../media/aspire-starter-app-dashboard.png" alt-text="A screenshot of the Aspire dashboard showing the Blazor App and API services." lightbox="../media/aspire-starter-app-dashboard.png":::

Select the **webfrontend** endpoint URL. The port is randomly assigned so your dashboard might not match.

:::image type="content" source="../media/blazor-app.png" alt-text="A screenshot of the Blazor web app frontend." lightbox="../media/blazor-app.png":::

The Blazor App has a simple counter page and a Weather page that calls the backend API service to get forecast data to display.

Close the browser tabs for the Blazor App and the .NET Aspire dashboard. In Visual Studio, stop debugging.

## Add a caching component to a .NET Aspire app

Now let's add a Redis caching component to the .NET Aspire app. We'll start with the app host:

# [Visual Studio](#tab/visual-studio)

1. In **Solution Explorer**, right-click on the **AspireTestApp.AppHost** project, and select **Manage NuGet Packages**.
1. Select the **Browse** tab, and select **Include prerelease**.
1. Search for **aspire redis**, and select the **Aspire.Hosting.Redis** package.
1. In the right pane, for **Version** select the latest **8.0.0**, and then select **Install**.
1. In the **License Acceptance** dialog, select **I Accept**.

# [.NET CLI](#tab/netcore-cli)

1. Navigate into the web project folder:

    ```console
    cd AspireTestApp/AspireTestApp.AppHost
    ```

1. Add the Redis package to the project:

    ```dotnetcli
    dotnet add AspireTestApp.AppHost.csproj package Aspire.Hosting.Redis --version 8.0.0
    ```

---

1. To add the Redis configuration to the app host project, open the _AspireTestApp.AppHost/Program.cs_ file and add this code:

    ```csharp
    // Add Redis
    var redis = builder.AddRedis("cache");
    ```

    This code configures the orchestration to create a local Redis container instance.

1. Change the current **webfrontend** service to use the Redis cache. Change this code:

    ```csharp
    builder.AddProject<Projects.AspireTestApp_Web>("webfrontend")
        .WithExternalHttpEndpoints()
        .WithReference(apiService);
    ```

    To this code:

    ```csharp
    builder.AddProject<Projects.AspireTestApp_Web>("webfrontend")
        .WithExternalHttpEndpoints()
        .WithReference(apiService)
        .WithReference(redis);
    ```

    The `WithReference` extension method configures the UI to use Redis automatically for output caching.

    Next, we can use Redis in the consuming project.

# [Visual Studio](#tab/visual-studio)

1. In **Solution Explorer**, right-click on the **AspireTestApp.Web** project, and select **Manage NuGet Packages**.
1. Select the **Browse** tab, and select **Include prerelease**.
1. Search for **aspire redis**, and select the **Aspire.StackExchange.Redis.OutputCaching** package.
1. In the right pane, for **Version** select the latest **8.0.0**, and then select **Install**.
1. In the **License Acceptance** dialog, select **I Accept**.

# [.NET CLI](#tab/netcore-cli)

1. Navigate into the web project folder:

    ```console
    cd AspireTestApp/AspireTestApp.Web
    ```

1. Add the Redis package to the project:

    ```dotnetcli
    dotnet add package Aspire.StackExchange.Redis.OutputCaching --version 8.0.0
    ```

---

Now use Visual Studio to add code to use the Redis component.

1. If you need to, open the **AspireTestApp** solution in Visual Studio.
1. In **Solution Explorer**, under the **AspireTestApp.Web** project, select *Program.cs*.
1. Add this code under `var builder = WebApplication.CreateBuilder(args);`:

    ```csharp
    // Add Redis caching
    builder.AddRedisOutputCache("cache");
    ```

    This code:

    - Configures ASP.NET Core output caching to use a Redis instance with the specified connection name.
    - Automatically enables corresponding health checks, logging, and telemetry.

1. Replace the contents of **AspireTestApp.Web/Components/Pages/Home.razor** with the following code:

    ```razor
    @page "/"
    @attribute [OutputCache(Duration = 10)]
    
    <PageTitle>Home</PageTitle>
    
    <h1>Hello, world!</h1>
    
    Welcome to your new app on @DateTime.Now
    ```

    In the preceding code, the `OutputCache` attribute specifies a 10-second duration. After the page is cached, every subsequent request within the 10-second window receives the cached output.

You can see that Aspire is designed to make it easy to add new components to your application. You add a new component to your application by adding a NuGet package, and then add a few lines of code to the *Program.cs* file in the **Web** and **AppHost** projects. Aspire then automatically configures the Redis container and the output caching for you.

## Test the application

Now let's run the application to see the caching in action. In Visual Studio:

1. From the menu select **Debug**, and then select **Start Debugging** (Alternatively, press <kbd>F5</kbd>). The solution builds, and the Aspire Dashboard opens in your default web browser.
1. Select the **Endpoint** URL for the **webfrontend** service to view the home page of the application.
1. In the browser, refresh the page a few times. The time on the page doesn't change within the 10 second cache duration.

    :::image type="content" source="../media/cache-aspire-app.png" alt-text="A screenshot of the updated Aspire Starter template with caching on the home page." lightbox="../media/cache-aspire-app.png":::

    The solution creates a Redis container. Open **Docker Desktop** to see the container running.

    :::image type="content" source="../media/redis-docker-desktop.png" alt-text="A screenshot of the Redis container running in Docker Desktop." lightbox="../media/redis-docker-desktop.png":::

1. To stop the solution running in Visual Studio, press <kbd>Shift</kbd>+<kbd>F5</kbd>.

1. Open **Docker Desktop**, and select **Containers/Apps**. You should see the **redis:latest** is no longer running.

You've seen how easy it is to add a new caching component to an application using .NET Aspire. You added a NuGet package, and then added a few lines of code. .NET Aspire automatically configured the Redis container and the output caching for you.
