In this exercise, you'll use the OpenTelemetry APIs to add custom data to the logs. You'll also examine the logs to find your custom events.

## Install prerequisites

The prerequisites for this exercise are:

- .NET 8
- Visual Studio 2022 Preview
- Docker Desktop
- .NET Aspire workload in Visual Studio

If you've already got these packages installed, you can skip ahead to begin working with OpenTelemetry logging.

### Install .NET 8

Follow this [.NET 8](https://dotnet.microsoft.com/download/dotnet/8.0) link, and select the correct installer for your operating system. For example, if you're using Windows 11, and a modern processor, select the x64 .NET 8 SDK for Windows.

After the download is complete, run the installer and follow the instructions. In a terminal window, run the following command to verify that the installation was successful:

```powershell
dotnet --version
```

You should see the version number of the .NET SDK you installed. For example:

```console
8.0.300-preview.24203.14
```

### Install Visual Studio 2022 Preview

Follow this [Visual Studio 2022 Preview](https://visualstudio.microsoft.com/vs/preview/) link, and select **Download Preview**. After the download is complete, run the installer and follow the instructions.

### Install Docker Desktop

Follow this [Docker Desktop](https://www.docker.com/products/docker-desktop/) link, and select the correct installer for your operating system. After the download is complete, run the installer and follow the instructions. For the best performance and compatibility, use the WSL 2 backend.

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

    You should see a message that the Aspire workload has been installed.

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

    You should see the details of the .NET Aspire workload.

    ```console
	Installed Workload Id      Manifest Version      Installation Source
    ---------------------------------------------------------------------------------------------
    aspire                     8.0.0/8.0.100         SDK 8.0.300-preview.24203, VS 17.10.34902.84

    Use `dotnet workload search` to find additional workloads to install.
    ```

## Clone the sample app

Let's use `git` to obtain a sample app. Because the app includes .NET Aspire, **OpenTelemetry** is included with default logging, metrics, and distributed tracing:

1. In the command line, browse to a folder of your choice where you can work with code.
1. Execute the following command to clone the **Northern Mountains eShop** sample application:

    ```dotnetcli
    git clone -b aspire-telemetry https://github.com/MicrosoftDocs/mslearn-aspire-starter
    ```

## Log a message using compile time source generation

We can use compile time source generation to create performant logging code automatically. Let's implement that technique for getting products brands:

1. Open Visual Studio and select **Open a project or solution**.
1. Browse to the folder where you cloned the starter project, select **start/eShop.aspiretelemetry.sln**, and then select **Open**.
1. In **Solution Explorer**, expand **WebApp > Services** and then double-click _CatalogService.cs_.
1. Locate the following line of code, which declares the `CatalogService` class:

    ```csharp
    public class CatalogService(HttpClient httpClient)
    ```

1. To use compile time source generation, we have to make this class `partial` and use dependency injection to obtain the logger. Modify the line to match this code:

    ```csharp
    public partial class CatalogService(HttpClient httpClient, ILogger<CatalogService> logger)
    ```

1. Next, anywhere in the `CatalogService` class outside other methods, create a new `static partial` method named **LogGetBrands**:

    ```csharp
    public static partial void LogGetBrands(string uri, ILogger logger);
    ```

1. Immediately before that line, add the `LoggerMessageAttribute` and define the logging level and message:

    ```csharp
    [LoggerMessage(
    EventId = 0,
    Level = LogLevel.Information,
    Message = "Getting brands from URI: {uri}")]
    ```

1. Locate the `GetBrands()` method and the following line of code in it:

    ```csharp
    var uri = $"{remoteServiceBaseUrl}catalogBrands";
    ```

1. To call your new logging method, insert the following code after that line:

    ```csharp
    LogGetBrands(uri, logger);
    ```

1. To save your changes press <kbd>CTRL + S</kbd> or select **File > Save All**.

## Test the instrumentation

Now, we'll test the compile time source generation logging:

1. In Visual Studio, to start the app in debugging mode, press <kbd>F5</kbd> or select **Debug > Start Debugging**. 
1. If the **Start Docker Desktop** message appears, select **Yes**. The app starts and displays the .NET Aspire dashboard in a browser tab.
1. To make some requests, locate the **webapp** project in the **Resources** list and then select one of its entries in the **Endpoints** column:

    :::image type="content" source="../media/aspire-dashboard-open-webapp.png" lightbox="../media/aspire-dashboard-open-webapp.png" alt-text="Screenshot showing the .NET Aspire dashboard and the location of the webapp's endpoint links.":::

1. A new browser tab appears and displays the Northern Mountains homepage. The brands list is included on the left. Switch back to the .NET Aspire dashboard and on the left, select **Structured**.
1. In the **Filter** textbox, type **Getting brands**. The page displays your logged event:

    :::image type="content" source="../media/structured-logs-compile-time-event.png" lightbox="../media/structured-logs-compile-time-event.png" alt-text="Screenshot showing filtered events in the .NET Aspire dashboard.":::

1. In the **Details** column for your event, select **View**. The dashboard opens a lower pane to display the details of the entry.
1. Close the browser tabs and in Visual Studio, press <kbd>SHIFT + F5</kbd> or select **Debug > Stop Debugging**.
1. Close Visual Studio.
