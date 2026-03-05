A trigger defines how a function is invoked and a function must have exactly one trigger. Triggers have associated data, which is often provided as the payload of the function.

Binding to a function is a way of declaratively connecting another resource to the function; bindings might be connected as *input bindings*, *output bindings*, or both. Data from bindings is provided to the function as parameters.

You can mix and match different bindings to suit your needs. Bindings are optional and a function might have one or multiple input and/or output bindings.

Triggers and bindings let you avoid hardcoding access to other services. Your function receives data (for example, the content of a queue message) in function parameters. You send data (for example, to create a queue message) by using the return value of the function.

When you develop your functions locally, you need to take trigger and binding behaviors into consideration. For HTTP triggers, you can call the HTTP endpoint on the local computer, using `http://localhost/`. For non-HTTP triggered functions, there are several options to run locally:

* The easiest way to test bindings during local development is to use connection strings that target live Azure services. You can target live services by adding the appropriate connection string settings in the `Values` array in the local.settings.json file. When you do this, local executions during testing use live service data. Because of this, consider setting-up separate services to use during development and testing, and then switch to different services during production.
* For storage-based triggers, you can use the local [Azurite emulator](/azure/storage/common/storage-use-azurite) when testing functions with Azure Storage bindings (Queue Storage, Blob Storage, and Table Storage), without having to connect to remote storage services.
* You can manually run non-HTTP trigger functions by using special administrator endpoints. For more information, see [Manually run a non HTTP-triggered function](/azure/azure-functions/functions-manually-run-non-http).

## Trigger and binding definitions

Triggers and bindings are defined differently depending on the development language and runtime model.

| Language | Configure triggers and bindings by... |
|--|--|
| C# class library | decorating methods and parameters with C# attributes (in-process or isolated worker) |
| Java | decorating methods and parameters with Java annotations |
| JavaScript/TypeScript | v4 programming model: define inputs/outputs in code using `@azure/functions`; v3: configure in a per-function *function.json* |
| Python | v2 programming model: define inputs/outputs with decorators; v1: configure in *function.json* |
| PowerShell | configure in *function.json* |

> [!NOTE]
> In modern models (Node.js v4 and Python v2), you author trigger and binding configuration in code and the runtime generates the corresponding *function.json*. Older models (Node.js v3, Python v1, PowerShell) use *function.json* directly. You can't mix programming models within the same function app.

For languages that rely on *function.json* (for example, Node.js v3, Python v1, and PowerShell), the portal provides a UI for adding bindings in the **Integration** tab. You can also edit the file directly in the portal in the **Code + test** tab of your function. For code-first models like Node.js v4 and Python v2, configure bindings in code in your local project; the portal reflects configuration but might not support direct edits.

In .NET and Java, the parameter type defines the data type for input data. For instance, use `string` to bind to the text of a queue trigger, a byte array to read as binary, and a custom type to deserialize to an object. Since .NET class library functions and Java functions don't rely on *function.json* for binding definitions, they can't be created and edited in the portal. C# portal editing is based on C# script, which uses *function.json* instead of attributes.

For languages that are dynamically typed such as JavaScript (using the v3 model) or PowerShell, use the `dataType` property in the *function.json* file. For example, to read the content of an HTTP request in binary format, set `dataType` to `binary`:

```json
{
    "dataType": "binary",
    "type": "httpTrigger",
    "name": "req",
    "direction": "in"
}
```

Other options for `dataType` are `stream` and `string`.

## Binding direction

All triggers and bindings have a direction property in the *function.json* file:

* For triggers, the direction is always `in`
* Input and output bindings use `in` and `out`
* Some bindings support a special direction `inout`. If you use `inout`, only the **Advanced editor** is available via the **Integrate** tab in the portal.

When you use attributes in a class library to configure triggers and bindings, the direction is provided in an attribute constructor or inferred from the parameter type.

## Azure Functions trigger and binding examples

Suppose you want to write a message to Azure Queue storage whenever an HTTP request is received. You can implement this with an HTTP trigger and a Storage Queue output binding. The configuration approach depends on your language and programming model.

Here's a legacy *function.json* file for this scenario (applicable to Node.js v3, Python v1, or PowerShell).

```json
{
    "disabled": false,
    "bindings": [
        {
            "type": "httpTrigger",
            "direction": "in",
            "name": "req",
            "authLevel": "function",
            "methods": ["get","post"]
        },
                {
                    "type": "queue",
                    "direction": "out",
                    "name": "outqueue",
                    "queueName": "outqueue",
                    "connection": "AzureWebJobsStorage"
                }
  ]
}
```

The first element in the `bindings` array is the HTTP trigger. The `type` and `direction` properties identify the trigger. The `name` property identifies the function parameter that receives the HTTP request, and `methods` lists the supported HTTP verbs.

The second element in the `bindings` array is the Storage Queue output binding. The `type` and `direction` properties identify the binding. The `name` property specifies how the function provides the new queue message, the `queueName` identifies the queue, and `connection` refers to the app setting that holds the storage connection string.

> [!NOTE]
> Disabling a function via the `disabled` property in *function.json* is legacy behavior. Prefer using the app setting `AzureWebJobs.<FunctionName>.Disabled=true`.

### C# (isolated worker) example

This example shows an HTTP-triggered function that writes a message to a Storage Queue using an output binding defined by attributes. For more information, see [C# isolated worker guide](/azure/azure-functions/dotnet-isolated-process-guide).

```csharp
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;

public static class HttpToQueue
{
    [Function("HttpToQueue")]
    public static MultiResponse Run(
        [HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequestData req)
    {
        var message = "Processed request";
        return new MultiResponse
        {
            Messages = new[] { message },
            HttpResponse = req.CreateResponse(System.Net.HttpStatusCode.OK)
        };
    }
}

public class MultiResponse
{
    [QueueOutput("outqueue", Connection = "AzureWebJobsStorage")]
    public string[] Messages { get; set; }
    public HttpResponseData HttpResponse { get; set; }
}
```

### Node.js (v4 programming model) example

In the v4 Node.js programming model, you configure inputs and outputs in code using `@azure/functions`. For more information, see [Node.js developer guide (v4)](/azure/azure-functions/functions-reference-node?pivots=nodejs-model-v4#inputs-and-outputs).

```javascript
import { app, output } from "@azure/functions";

const queueOutput = output.storageQueue({
  queueName: "outqueue",
  connection: "AzureWebJobsStorage"
});

app.http("HttpToQueue", {
  methods: ["GET", "POST"],
  authLevel: "function",
  extraOutputs: [queueOutput],
  handler: async (request, context) => {
    const body = await request.text();
    context.extraOutputs.set(queueOutput, body || "Processed request");
    return { status: 200, body: "Queued" };
  }
});
```

### Python (v2 programming model) example

In the v2 Python programming model, you use decorators to define bindings. The runtime generates *function.json* for you. Visit the [Python developer guide](/azure/azure-functions/functions-reference-python) for more information.

```python
import azure.functions as func

app = func.FunctionApp()

@app.route(route="HttpToQueue", auth_level=func.AuthLevel.FUNCTION)
@app.queue_output(arg_name="msg", queue_name="outqueue", connection="AzureWebJobsStorage")
def HttpToQueue(req: func.HttpRequest, msg: func.Out[str]) -> func.HttpResponse:
    body = req.get_body().decode("utf-8") if req.get_body() else "Processed request"
    msg.set(body)
    return func.HttpResponse("Queued", status_code=200)
```

> [!NOTE]
> In Node.js v4 and Python v2, the runtime generates *function.json* from your code. Avoid editing *function.json* directly in the portal for these models; make changes in code and republish.
