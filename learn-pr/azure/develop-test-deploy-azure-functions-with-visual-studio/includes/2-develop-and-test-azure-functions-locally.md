Users can write, debug, and deploy an Azure Function from within the Azure portal. However, writing functions directly in a production, staging, or test environment might not be suitable. For example, writing automated unit tests for Azure Functions, or using on-demand deployment of Azure Functions to Function Apps in Azure. Usually, developers prefer to use a code editor and development tools rather than the environment provided by the Azure portal. Visual Studio enables you to develop and manage Azure Functions code using other code and services in a single project.

In the online luxury watch scenario, developers are already familiar with Visual Studio 2022 (hereafter referred to as Visual Studio), so you decide to use Visual Studio as the primary development environment for creating Azure Functions. Additionally, Visual Studio provides an excellent environment for testing your functions locally before deploying them to Azure.

In this unit, you'll learn to use tools available in Visual Studio for building and testing an Azure Function on your local computer.

>[!IMPORTANT]
>This article supports .NET class library functions that run in-process with the runtime. Your C# functions can also run out-of-process and isolated from the Functions runtime. The isolated worker process model is the only way to run non-LTS versions of .NET and .NET Framework apps in current versions of the Functions runtime. To learn more, see [.NET isolated worker process functions](dotnet-isolated-process-guide.md).

## Modify Visual Studio Install

First, let's set up Visual Studio with the web and cloud tools you'll need for your development environment.

1. With Visual Studio 2022 installed locally, open **Visual Studio Installer**, and on the **Visual Studio Community 2022**, select **Modify.**

    :::image type="content" source="../media/2-visual-studio-installer-modify.png" alt-text="Screenshot of Visual Studio Installer with Modify highlighted." loc-scope="vs":::

1. The **Modifying - Visual Studio** page appears.

    :::image type="content" source="../media/2-visual-studio-workloads.png" alt-text="Screenshot of Modifying Visual Studio Community 2022 workloads tab with ASP.NET and web development and Azure development highlighted." loc-scope="vs":::

1. On the **Workloads** tab, select the **ASP.NET and Web development** and **Azure development** checkboxes, and then select **Modify**.  

1. In the verification dialog, select **Yes**.  The **Visual Studio Installer** page appears and displays the progress of the packages being installed.

## Azure Functions Tools extension for Visual Studio

Azure Functions Tools is a Visual Studio extension that enables you to create, test, and deploy Azure Functions in your local development environment. To quickly create a new Azure Function App, this extension provides a template for you to build and then deploy an Azure Function directly to Azure from Visual Studio.

The **Azure Functions and Web Jobs Tools** extension is included in Visual Studio 2022.

## Azure Function App

An Azure Function App hosts one or more Azure Functions. It provides the environment and runtime for the functions.

An Azure Function is triggered by an event rather than being called directly from an app. You specify the type of event that will trigger each function in your Azure Function App. The events available include:

- **Blob trigger**. This type of function runs when a file is uploaded or modified in Azure Blob storage.
- **Event Hub trigger**. An Event Hub trigger runs the function when an Event Hub receives a message.
- **Azure Cosmos DB trigger**. This trigger runs when a document is added to, or modified in an Azure Cosmos DB database. You can use this trigger to integrate Azure Cosmos DB with other services. For example, if a document representing a customer's order is added to a database, you could use a trigger to send a copy of the order to a queue for processing.
- **Http trigger**. An HTTP trigger runs the function when an HTTP request occurs in a web app. You can also use this trigger to respond to webhooks. A webhook is a callback that occurs when an item hosted by a website is modified. For example, you can create an Azure Function that is triggered by a webhook from a GitHub repository when an item in the repository changes.
- **Queue trigger**. This trigger starts the function when a new item is added to an Azure Storage Queue.
- **Service Bus Queue trigger**. This trigger runs the function when a new item is added to an Azure Service Bus Queue.
- **Service Bus Topic trigger**. This trigger runs the function in response to a new message arriving on a Service Bus Topic.
- **Timer trigger**. This event runs the Azure Function at regular intervals, following a schedule that you define.

:::image type="content" source="../media/2-function-triggers.png" alt-text="Screenshot showing the Azure Function triggers available, with HTTP Trigger highlighted." loc-scope="vs":::

The following table shows the highest level of .NET Core or .NET Framework that you can use with a specific version of Functions.

| Functions runtime version | In-process | Isolated worker process |
| ---- | ---- | --- |
| Functions 4.x | .NET 6.0 | .NET 6.0<br/>.NET 7.0<br/>.NET Framework 4.8 |
| Functions 1.x | .NET Framework 4.8 | n/a |

An Azure Function App stores management information, code, and logs in Azure storage. Create a Storage Account to hold this data. The storage account must support Azure Blob, Queue, Files, and Table storage; use a general Azure Storage account for this purpose. You specify which storage account to use for the function using the dialog previously shown.

An Azure Function can perform privileged or sensitive operations. An Azure Function triggered by an HTTP request could be exposed publicly. You might need to limit the ability to run this function to selected groups of users. You protect an Azure Function by specifying the access rights required to trigger the function. An Azure Function triggered by an HTTP request supports three levels of access rights:

- **Anonymous**. No authentication is required, and any user can trigger the function.
- **Function**. The HTTP request must provide a key that enables the Azure Function runtime to authorize the request. You create this key separately, and you can maintain it using the Azure portal.
- **Admin**. Similar to **Function**. The user must specify a key with the HTTP request that triggers the function. The difference is that the key is an *admin* key. This key can be used to access any function in the function app. As with a function key, you create this key separately.

If you're creating a function triggered by events other than HTTP requests, you're required to provide a connection string and other details necessary for the function app to access the resource triggering the event. For example, if you're writing a function triggered by a Blob Storage event, you must specify the connection string for the corresponding Blob Storage account.

## Structure of an Azure Function

An Azure Function is implemented as a static class. The class provides a static, asynchronous method named `Run`, which acts as the entry point for the class.

The parameters passed to the `Run` method provide the context for the trigger. In the case of an HTTP trigger, the function receives an *HttpRequest* object. This object contains the header and body of the request. You can access the data in the request using the same techniques available in any HTTP app. The attributes applied to this function specify the authorization requirements (*Anonymous* in this case), and the HTTP operations to which the Azure Function responds (*GET* and *POST*).

The following code example generated by Visual Studio examines the query string provided as part of the URL for the request, and looks for a parameter called *name*. The code also uses a *StreamReader* to deserialize the body of the request, and attempts to read the value of a property also called *name* from the request. If *name* is found in either the query string or the body of the request, it's returned in the response; otherwise, the function generates an error response with the message. Please pass a name on the query string or in the request body*.

```csharp
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
```

The function returns a value containing output data and results, wrapped in an *IActionResult* object. The value is returned in the body of the HTTP response for the request.

Different types of triggers receive different input parameters and return types. The next example shows the code generated for a Blob trigger. In this example, the contents of the blob are returned through a *Stream* object, and the name of the blob is also provided. No data is returned by the trigger; its purpose is to read and process the data in the named blob.

```csharp
public static class Function2
{
    [FunctionName("Function2")]
    public static void Run([BlobTrigger("samples-workitems/{name}", Connection = "xxxxxxxxxxxxxxxxxxxxxxx")]Stream myBlob, string name, ILogger log)
    {
        log.LogInformation($"C# Blob trigger function Processed blob\n Name:{name} \n Size: {myBlob.Length} Bytes");
    }
}
```

In all cases, an Azure Function is passed an *ILogger* parameter. The function can use this parameter to write log messages, which the function app will write to storage for later analysis.

An Azure Function also contains metadata that specifies the type of the trigger, security requirements, and any other specific information requirements. You can modify metadata using the *HttpTrigger*, *BlobTrigger*, or other trigger attributes, as shown in the examples. The *FunctionName* attribute that precedes a function is an identifier for the function used by the Function App. This name doesn't have to be the same as the name of the function, but it's good practice to keep them synchronized to avoid confusion.

## Test an Azure Function App locally

You can use the Visual Debugger to build and test an Azure Function App locally. To launch the debugger, press <kbd>F5</kbd>, or, on the **Debug** menu, select **Start Debugging**. The local version of the Function Runtime will start. Your functions will be available for testing. The example shows the runtime hosting *Function1*. This is the function triggered by an HTTP event. The URL indicates the endpoint to which the function is currently attached.

![Screenshot showing the Azure Function Runtime -  example 1.](../media/2-function-runtime.png)

If you open a web browser and visit this URL, you'll trigger the function. The following image shows the response generated by an HTTP GET request that doesn't include a body. You can see the message generated by the code that returns the *BadRequestObjectResult* object from the function.

:::image type="content" source="../media/2-bad-request.png" alt-text="Screenshot showing the Azure Function Runtime." loc-scope="other"::: <!-- no-loc -->

If you provide a query string that includes a *name* parameter, the value is read and processed by the function.

![Screenshot showing the Azure Function Runtime -  example 2.](../media/2-name-request.png)

While the code is running, you'll see trace messages appearing in the Function Runtime window. You can use standard debugging features in Visual Studio if you need to set breakpoints and examine the flow of control in a function.
