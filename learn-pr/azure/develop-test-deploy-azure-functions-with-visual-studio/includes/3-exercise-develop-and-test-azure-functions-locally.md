Visual Studio provides an excellent environment for creating and testing an Azure Function App. You can develop an Azure Function locally, and verify that it operates correctly, before deploying it to the cloud.

In the luxury watch online website scenario, there's a requirement for a function that returns detailed information about a watch when given the model number of the watch. The information includes the manufacturer, the type of case back (solid, transparent, engraved), the bezel, the style of the dial, the finishing of the case, the number of jewels, and so on.

In this exercise, you'll implement and test a version of this function locally using Visual Studio.
> NOTE!
> Before starting this exercise, make sure you have VS 2019 installed, along with Web & Cloud workload extensions **ASP.NET and web development** and **Azure development**.

## Create an Azure Function App

Create an Azure Function App using the **Azure Functions** template.

1. Launch **Visual Studio Installer** and on the **Visual Studio 2019** start page, select **Modify**. 
 
1. Ensure **ASP.NET and web development** and **Azure development** are selected and available (if not select **Install while downloading**) and then select **Close**.
 
 :::image type="content" source="../media/3-visual-studio-extensions.png" alt-text="Screenshot of Visual Studio 2019 with asp dot net and Asure development workloads highlighted." loc-scope="vs":::
 
1. On **Visual Studio 2019** start page, select **Launch**. 
 
1. On the **Get started** menu, select **Create a new project**. The **Create a new project** page appears. 
 
1. Search for or scroll to **Azure Functions**, and then select **Next**.

    :::image type="content" source="../media/3-create-project.png" alt-text="Screenshot of Visual Studio 2019 Create a new project page." loc-scope="vs":::

1. The **Configure your new project** page appears. Enter the following values.
 
    | ---- | ---- |
    |**Project name** | *WatchPortalFunction* |
    | **Location** | Browse to a convenient location and create a folder on your computer to store the project. |
    | **Solution name** | Accept *WatchPortalFunction* (default). |
    | **Place solution and project in the same directory** | NOT selected (unchecked). This ensures the proper folder structure for this module. |

1. Select **Create**.

    :::image type="content" source="../media/3-configure-project.png" alt-text="Screenshot of the Visual Studio 2019 with Configure your new project link." loc-scope="vs":::

1. The **Create a new Azure Functions application** page appears. Select the following values.

    | ---- | ---- |
    |*Dropown list* | *.NET Core 2* |
    | **Function trigger** | *Http trigger* |
    | **Storage account** | Accept *Storage Emulator* (default). |
    | **Authorization level** | *Anonymous* |
 
1. If a Visual Studio notification shows that updates are ready, select **Refresh**.
 
3. Select **Create**.

    :::image type="content" source="../media/3-function-triggers.png" alt-text="Screenshot showing Azure Functions triggers, with HTTP Trigger highlighted." loc-scope="vs":::

    Visual Studio creates the `WatchPortalFunction` project with a `Function1.cs` Functions App source code file, and the code editor window displays the code for a class named `Function1`. 
    
    As shown in the example code below, the `Function1` class contains boilerplate code for an HTTP trigger. The `Run` method is annotated with `[FunctionName ("Function1")]` attribute. The previous unit described the boilerplate parameters for the `Run` method are an `HttpRequest` object containing the details of the request that triggered the function, and a trace log entry for recording trace information.

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

1. In the **Solution Explorer** window, right-click the **WatchPortalFunction** project, and in the context menu select **Add** > **New Azure Function**.

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

1. Insert the following code to the body of the `Run` method after the statement that writes to the trace log. 

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

    This code reads the `model` parameter from the query string in the URL of the HTTP request and returns the details for this model of watch. In this example, we'eve created dummy data. The function returns a response that contains these details, or, if the initial request doesn't include a query string with the `model` parameter, the function returns an error message.

## Test the Azure Function locally

1. On the command bar, select **Debug** > **Start Debugging**.

    Visual Studio builds the Azure Function App and starts the Azure Functions runtime. You'll see a window appear displaying messages as the runtime starts up. When the runtime is ready, you'll see a list of the HTTP functions available, and the URL that you can use to trigger each function.

    :::image type="content" source="../media/3-azure-functions-runtime.png" alt-text="Screenshot of the Azure Functions runtime window. The runtime has started the Azure Function App, and is displaying the URLs for the Function1 and WatchInfo Azure Functions." loc-scope="vs":::

1. Open a web browser, and enter the URL `http://localhost:7071/api/WatchInfo?model=abc`. This request triggers the `WatchInfo` function and passes the model `abc` as the query string parameter. The web browser should display the dummy details generated by the Azure Function.

    :::image type="content" source="../media/3-azure-functions-response.png" alt-text="Screenshot of a web browser triggering the WatchInfo Azure Function. The function has returned the dummy details for the model specified in the query string of the URL provided." loc-scope="vs":::

1. Enter the URL `http://localhost:7071/api/WatchInfo`. This request doesn't include a query string. The trigger returns the error response and the web browser displays the message *Please provide a watch model in the query string*.

1. Close the web browser, but leave the Azure Function App running.

1. In Visual Studio, set a breakpoint on the line of code that retrieves the model from the query string.

    ![Screenshot of Visual Studio. The user has set a breakpoint on the statement that reads the model from the query string.](../media/3-visual-studio-breakpoint.png)

1. Restart the web browser, and enter the URL without the query string again, `http://localhost:7071/api/WatchInfo`.

    You'll drop into Visual Studio at the breakpoint.

1. In Visual Studio, to step over the statement at the breakpoint, press <kbd>F10</kbd>.

1. In the `Autos` window, verify that the `model` variable is `null`. This is because the query string doesn't contain a model parameter.

    :::image type="content" source="../media/3-visual-studio-debug.png" alt-text="Screenshot of Visual Studio. The user has dropped into the debugger and is examining the value of the model variable." loc-scope="vs":::

1. Press <kbd>F10</kbd> again, and verify that control jumps to the statement that returns a `BadRequestObjectResult` object.

1. To continue running the method and return to the web browser, press <kbd>F5</kbd>. It should display the same error message as before.

1. In the web browser, enter the URL with a query string and a model parameter. Step through the Azure Function in the debugger, and verify that the model is retrieved correctly. The `model` variable should be populated with the value of the parameter, and the details of the model returned as an `OkObjectResult` object.

1. On the menu bar, select **Debug** > **Stop Debugging**.

You've now seen how the Azure Functions Tools extension simplifies the experience of creating an Azure Function App, and enables you to use familiar tools to build and debug your code.
