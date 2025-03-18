We can use the latest eShop reference application, which includes the .NET Aspire stack, to illustrate a complete and complex cloud-native app.

Imagine you work for an outdoor clothing and equipment company. Your development team has been working with .NET Aspire to create a new eShop web app for the main customer-facing site. You want to understand the architecture of this app and test its functionality before you deploy it.

In this unit, you install .NET Aspire and its prerequisites and then use the eShop app to investigate and run .NET Aspire.

## Install prerequisites

The prerequisites for this .NET Aspire exercise are:

- .NET 8
- Visual Studio 2022
- Docker Desktop
- .NET Aspire workload in Visual Studio

If you already have these prerequisites installed, you can skip ahead to explore the eShop application.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```powershell
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.403
```

### Install Visual Studio 2022

Follow this [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) link, and select **Download Visual Studio**. After the download is complete, run the installer and follow the instructions.

### Install Docker Desktop

Follow this [Docker Desktop](https://www.docker.com/products/docker-desktop/) link, and select the correct installer for your operating system. After the download is complete, run the installer and follow the instructions. For the best performance and compatibility, use the **WSL 2** backend.

Open the Docker Desktop application and accept the service agreement.

### Install the .NET Aspire workload in Visual Studio

Install the .NET Aspire workload using the .NET CLI:

1. Open a terminal.
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

    You should see a message that the .NET Aspire workload is successfully installed.

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

    You should see the details of the Aspire workload.

    ```console
    Installed Workload Id      Manifest Version      Installation Source
    ---------------------------------------------------------------------------------------------
    aspire                     8.0.0/8.0.100         SDK 8.0.300-preview.24203, VS 17.10.34902.84

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Explore the .NET Aspire eShop code

Let's use the eShop reference application to demonstrate the .NET Aspire stack. Clone the code from GitHub and examine it in Visual Studio:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the eShop sample application:

   ```console
   git clone https://github.com/dotnet/eShop.git
   ```

1. Change to the eShop directory:

   ```console
   cd eShop
   ```

1. The eShop reference app is frequently updated. To ensure that you're using the correct version for this exercise, switch to the `dotnet8` tag:

   ```console
   git checkout dotnet8
   ```

1. Start Visual Studio and then select **Open a project or solution**.
1. Browse to the folder where you cloned eShop, select the *eShop.Web.snlf* file, and then select **Open**.

   >[!IMPORTANT]
   > Make sure you open the *eShop.Web.snlf* file, not the *eShop.sln* file.

1. Examine the solution structure in **Solution Explorer**. At the top level, the eShop code includes folders for tests, GitHub actions, and solution items. Expand the *src* folder, which contains source code for the microservices:

   :::image type="content" source="../media/eshop-solution-structure.png" lightbox="../media/eshop-solution-structure.png" alt-text="Screenshot showing the structure of the eShop solution in the Visual Studio Solution Explorer.":::

1. Notice that:

   - The *src* folder includes the .NET Aspire **AppHost** and **ServiceDefaults** projects.
   - The **AppHost** project is set as the startup project for the solution.

1. Expand the **AppHost** project, and then select the *eShop.AppHost/Program.cs* file.
1. In the *Program.cs* file, notice that:

   - Integrations of the application are added to a `DistributedApplicationBuilder` object named `builder`.
   - Backing services, such as a Redis cache, a RabbitMQ messaging service, and a PostgreSQL database, are added to the builder. Each service is provisioned in a Docker container.
   - Each microservice is added to the builder by using the `builder.AddProject()` method.
   - References to the backing services are injected into each microservice by using the `.WithReference()` method.

## Edit code in the .NET Aspire eShop

Let's make a small change in the source code, that we can test when we run the app:

1. In **Solution Explorer**, expand the *src/WebApp/Components/Pages/Catalog* folder, and then select the *Catalog.razor* page.
1. Locate this line of code:

   ```csharp
   <SectionContent SectionName="page-header-subtitle">Start the season with the latest in clothing and equipment.</SectionContent>
   ```

1. Replace the line with this text, or create your own subtitle for the page:

   ```csharp
   <SectionContent SectionName="page-header-subtitle">Bringing you the latest in clothing and equipment.</SectionContent>
   ```

## Run the .NET Aspire eShop

Let's run the app and use the .NET Aspire dashboard to examine a request:

1. In Visual Studio, press <kbd>F5</kbd> or on the **Debug** menu select **Start Debugging**. Visual Studio builds the containers for the eShop.
1. If the **Start Docker Desktop** dialog appears, select **Yes**.
1. When the eShop is built and deployed to Docker, the .NET Aspire dashboard is displayed in the default browser.
1. To browse to the homepage, in the row for the **webapp** project, select the **https://localhost:&lt;port&gt;** link:

   :::image type="content" source="../media/eshop-dashboard.png" lightbox="../media/eshop-dashboard.png" alt-text="Screenshot showing the .NET Aspire dashboard for the eShop solution":::

1. The eShop homepage is displayed in a new browser tab. Notice that your subtitle is displayed. 
1. Select the **Adventurer GPS Watch** product:

   :::image type="content" source="../media/eshop-homepage.png" lightbox="../media/eshop-homepage.png" alt-text="Screenshot showing the homepage for the eShop web app.":::

1. Switch to the browser tab that displays the .NET Aspire dashboard, and then in the left menu, select **Traces**. 
1. Scroll to the bottom of the page and locate a trace with the name **webapp: GET /item/{itemId:int}**.
1. In the **Details** column, select **View**:

   :::image type="content" source="../media/eshop-dashboard-traces.png" lightbox="../media/eshop-dashboard-traces.png" alt-text="Screenshot showing the Traces page in the .NET Aspire dashboard.":::

1. The dashboard displays the trace for the **Adventurer GPS Watch**, which includes a call to the catalog microservice:

   :::image type="content" source="../media/eshop-dashboard-trace-details.png" lightbox="../media/eshop-dashboard-trace-details.png" alt-text="Screenshot showing a trace in the .NET Aspire dashboard.":::

1. To stop the debugging session, in Visual Studio, press <kbd>Shift + F5</kbd> or on the **Debug** menu, select **Stop Debugging**.
1. Close Visual Studio.

## Learn more

- [eShop Reference Application - "Adventure Works"](https://github.com/dotnet/eshop)
