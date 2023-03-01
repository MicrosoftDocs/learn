Visual Studio provides an excellent environment for creating and testing an Azure Function App. You can develop an Azure Function locally, and verify that it operates correctly, before deploying it to the cloud.

In the luxury watch online website scenario, there's a requirement for a function that returns detailed information about a watch when given the model number of the watch. The data you need returned includes the manufacturer, the type of case back (solid, transparent, engraved), the bezel, the style of the dial, the finishing of the case, the number of jewels, and so on.

In this exercise, you'll implement and test a version of this function locally using Visual Studio.

> [!NOTE]
> Before starting this exercise, make sure you have VS 2022 installed, along with the Web & Cloud workload extensions **ASP.NET and web development** and **Azure development**.

## Create an Azure Function App

Create an Azure Function App using an **Azure Functions** template.

1. Launch **Visual Studio Installer** and on the **Visual Studio 2022** start page, select **Modify**.

1. Ensure **ASP.NET and web development** and **Azure development** are selected and available (if not select **Install while downloading**) and then select **Close**.

    :::image type="content" source="../media/3-visual-studio-extensions.png" alt-text="Screenshot of Visual Studio 2022 with asp dot net and Azure development workloads highlighted.":::

1. On the **Visual Studio 2022** start page, select **Launch**.

1. On the **Get started** menu, select **Create a new project**. The **Create a new project** page appears.

1. Search for or scroll to **Azure Functions** template, and then select **Next**.

    :::image type="content" source="../media/3-create-project.png" alt-text="Screenshot of Visual Studio 2022 Create a new project page with Azure functions template highlighted." :::

1. The **Configure your new project** page appears. Enter the following values.

    | Field | Value |
    | ---- | ---- |
    | **Project name** | *WatchPortalFunction* |
    | **Location** | Browse to or create a folder on your local computer to store the project. |
    | **Solution name** | Accept *WatchPortalFunction* (default). |
    | **Place solution and project in the same directory** | Unchecked (NOT selected). This ensures the correct folder structure for this module. |
  
    :::image type="content" source="../media/3-configure-project.png" alt-text="Screenshot of Configure your new project page with create highlighted." loc-scope="vs":::

1. Select **Next**.

1. The **Additional information** page appears.

1. Select the following values.

    | Field | Value |
    | ---- | ---- |
    | **Dotnet version** | *.NET 6.0 (Long Term Support) |
    | **Function trigger** | *Http trigger* |
    | **Use Azurite for runtime storage account (AzureWebJobsStorage)** | *Checked* |
    | **Enable Docker** | *Unchecked* |
    | **Authorization level** | *Anonymous* |

    If a Visual Studio notification shows that updates are ready, select **Refresh**.

1. Select **Create**.

    :::image type="content" source="../media/3-function-triggers.png" alt-text="Screenshot showing Azure Functions triggers, with HTTP Trigger highlighted." loc-scope="vs":::

    Visual Studio creates the `WatchPortalFunction` project and displays the Functions App source code file `Function1.cs` in the code editor window. The file contains the code for a class named `Function1`.

    As shown in the following example code, the `Function1` class contains boilerplate code from the HTTP trigger template. The `Run` method is annotated with the `[FunctionName ("Function1")]` attribute. In the previous unit, we learned that the boilerplate parameters for the `Run` method are an `HttpRequest` object containing the details of the request that triggered the function, and a trace log entry for recording trace information.

    ```csharp
    namespace WatchPortalFunction
    {
        public static class Function1
        {
            [FunctionName("Function1")]
            public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
            ILogger log)
            {
                log.LogInformation("C# HTTP trigger function processed a request.");

                string name = req.Query["name"];

                string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
                dynamic data = JsonConvert.DeserializeObject(requestBody);
                name = name ?? data?.name;

                return name != null
                    ? (ActionResult)new OkObjectResult($"Hello, {name}")
                    : new BadRequestObjectResult("Please pass a name on the query string or in the request body");
            }
        }
    }
    ```

## Create the WatchInfo Azure Function

1. In the View menu, select **Solution Explorer**. In the **Solution Explorer** window, right-click the **WatchPortalFunction** Azure Functions project, and in the context menu select **Add** > **New Azure Function**.

    :::image type="content" source="../media/3-new-azure-function.png" alt-text="Screenshot of the Solution Explorer window. The user has selected Add -> New Azure Function." loc-scope="vs":::

1. In the **Add New Item - WatchPortalFunction** window, select **Azure Function**. In the **Name** field, enter *WatchInfo.cs*, and then select **Add**.

    :::image type="content" source="../media/3-new-item.png" alt-text="Screenshot of the Add New Item window. The user has selected the Azure Function template, and named the new function WatchInfo.cs." loc-scope="vs":::

1. In the **New Azure Function - WatchInfo** window, select **Http trigger**. In the **Authorization level** dropdown list, select **Anonymous**, and then select **Add**.

    :::image type="content" source="../media/3-new-azure-function-trigger.png" alt-text="Screenshot of the New Azure Function window. The user has selected the Http Trigger with Anonymous access rights." loc-scope="vs":::

    Visual Studio creates a new function and the `Run` method is annotated with the `[FunctionName("WatchInfo")]` attribute.

1. In the body of the `Run` function, delete the code after the `log.LogInformation` line. The result should look like this.

    ```csharp
    namespace WatchPortalFunction
    {
        public static class WatchInfo
        {
            [FunctionName("WatchInfo")]
            public static async Task<IActionResult> Run(
                [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)] HttpRequest req,
                ILogger log)
            {
                log.LogInformation("C# HTTP trigger function processed a request.");
            }
        }
    }
    ```

1. Insert the following code in the body of the `Run` method after `log.LogInformation` line.

    ```csharp
    // Retrieve the model id from the query string
    string model = req.Query["model"];

    // If the user specified a model id, find the details of the model of watch
    if (model != null)
    {
        // Use dummy data for this example
        dynamic watchinfo = new { Manufacturer = "abc", CaseType = "Solid", Bezel = "Titanium", Dial = "Roman", CaseFinish = "Silver", Jewels = 15 };

        return (ActionResult)new OkObjectResult($"Watch Details: {watchinfo.Manufacturer}, {watchinfo.CaseType}, {watchinfo.Bezel}, {watchinfo.Dial}, {watchinfo.CaseFinish}, {watchinfo.Jewels}");
    }
    return new BadRequestObjectResult("Please provide a watch model in the query string");
    ```

    This code reads the `model` parameter from the query string in the HTTP request and returns the details for that watch model. In this example code, we've created dummy `watchinfo` data. The function returns a response that contains these details, or, if the HTTP request doesn't include a query string, the function returns an error message.

## Test the Azure Function locally

1. On the command bar, select **Debug** > **Start Debugging**.

    Visual Studio builds the Azure Function App and starts the Azure Functions runtime. An Output window opens to display messages as the runtime starts up. When the runtime is ready, a list of the HTTP functions and the URL that you can use to trigger each function are displayed.

    :::image type="content" source="../media/3-azure-functions-runtime.png" alt-text="Screenshot of the Azure Functions runtime window. The runtime has started the Azure Function App, and is displaying the URLs for the Function1 and WatchInfo Azure Functions." loc-scope="vs":::

1. Open a web browser, and enter the URL `http://localhost:7071/api/WatchInfo?model=abc`. This request triggers the `WatchInfo` function and passes the model `abc` as the query string parameter. The web browser should display the dummy details generated by the Azure Function.

    :::image type="content" source="../media/3-azure-functions-response.png" alt-text="Screenshot of a web browser triggering the WatchInfo Azure Function. The function has returned the dummy details for the model specified in the query string of the URL provided." loc-scope="vs":::

1. Enter the URL `http://localhost:7071/api/WatchInfo`. This request doesn't include a query string. The trigger returns the error response and the web browser displays the message `Please provide a watch model in the query string`.

1. Close the web browser, but leave the Azure Function App running.

1. In Visual Studio, set a breakpoint on the line of code that retrieves the model from the query string.

    :::image type="content" source="../media/3-visual-studio-breakpoint.png" alt-text="Screenshot of Visual Studio showing a breakpoint on the statement that reads the model from the query string.":::

1. Restart the web browser, and enter the URL without the query string `http://localhost:7071/api/WatchInfo`.

   Visual Studio highlights the code at the breakpoint where execution is paused.

1. In Visual Studio, to step over the statement at the breakpoint, press <kbd>F10</kbd>.

1. In the **Autos** tab of the **Debugger** window, verify that the `model` variable is `null`. This is because the query string doesn't contain a model parameter.

    :::image type="content" source="../media/3-visual-studio-debug.png" alt-text="Screenshot of Visual Studio debugger showing the value of the model variable." loc-scope="vs":::

1. Press <kbd>F10</kbd> again, and verify that control jumps to the statement that returns a `BadRequestObjectResult` object.

1. To continue running the method and return to the web browser, press <kbd>F5</kbd>. The same error message should display.

1. In the web browser, enter the URL with a query string and a model parameter. Step through the Azure Function in the debugger, and verify that the model is retrieved correctly. The `model` variable should be populated with the value of the parameter, and the details of the model returned as an `OkObjectResult` object.

1. On the menu bar, select **Debug** > **Stop Debugging**.

You've now seen how the Azure Functions Tools extension in Visual Studio simplifies the experience of creating an Azure Function App, by letting you use familiar tools to build and debug your code.
