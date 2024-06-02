Now that we've created a function app, let's look at how to build, configure, and execute a function. We'll execute our function in the next exercise, so you don't need to complete any tasks in this unit.

### Triggers

Functions are event driven, which means they run in response to an event. The type of event that starts a function is called a **trigger**. Each function must be configured with exactly one trigger.

You can trigger function execution by using HTTP requests, a scheduled timer, and events from the following Azure services:

| Azure Service | Trigger description |
|---------|---------|
| Blob Storage | Starts a function when a new or updated blob is detected. |
| Azure Cosmos DB| Start a function when inserts and updates are detected. |
| Event Grid | Starts a function when an event is received from Event Grid. |
| Event Hubs | Starts a function when an event is received from Event Hubs. |
| Queue Storage | Starts a function when a new item is received on a queue. The queue message is provided as input to the function. |
| Service Bus | Starts a function in response to messages from a Service Bus queue. |

### Bindings

A binding is a declarative way to connect data and services to your function. Bindings interact with various data sources, which means you don't have to write the code in your function to connect to data sources and manage connections. The platform takes care of that complexity for you as part of the binding code. Each binding has a direction: Your code reads data from *input* bindings, and writes data to *output* bindings. Each function can have zero or more bindings to manage the input and output data processed by the function.

A trigger is a type of input binding that has the ability to initiate execution of some code.

Azure provides a [large number of bindings](/azure/azure-functions/functions-triggers-bindings#supported-bindings) to connect to different storage and messaging services.

### Define a sample binding

Let's look at an example of configuring a function with an input binding (trigger) and an output binding. Let's say we want to write a new row to Azure Table storage whenever a new message appears in Azure Queue Storage. This scenario can be implemented using an Azure Queue Storage *trigger* and an Azure Table storage *output binding*.

The following snippet is the *function.json* file for this scenario.

```json
{
  "bindings": [
    {
      "name": "order",
      "type": "queueTrigger",
      "direction": "in",
      "queueName": "myqueue-items",
      "connection": "MY_STORAGE_ACCT_APP_SETTING"
    },
    {
      "name": "$return",
      "type": "table",
      "direction": "out",
      "tableName": "outTable",
      "connection": "MY_TABLE_STORAGE_ACCT_APP_SETTING"
    }
  ]
}
```

Our JSON configuration specifies that our function is triggered when a message is added to a queue named **myqueue-items**. The return value of our function is then written to **outTable** in Azure Table storage. 
:::zone pivot="powershell"
For PowerShell functions, output bindings are explicitly written to with the `Push-OutputBinding` cmdlet.
:::zone-end
This example is a simple illustration of how we configure bindings for a function. We could change the output to be an email using a SendGrid binding, or put an event onto a Service Bus to notify some other component in our architecture. We could even have multiple output bindings to push data to various services.

> [!TIP]
> To view and edit the contents of *function.json* in the Azure portal, from the Home page, select your function app, and in the right pane, select **JSON View**. The Resource JSON view displays the Resource ID and the editable JSON code. To close the JSON view, select the **X** in the top right corner of the pane.

Not all languages supported by Functions use the function.json file to define functions.

## Create a function in the Azure portal

Azure Functions has predefined function templates, which are based on a specific type of trigger. These templates, in your chosen language, make it easy to get started creating your first function.

This module isn't supported for all languages supported by Functions, and the portal itself doesn't support creating functions in all languages supported by Functions. 

For supported languages that use the function.json file to define functions, you can create and edit these functions directly in the Azure portal. These portal-supported languages include: JavaScript, PowerShell, Python, and C# Script (.csx). Languages that define functions directly in the code itself must be developed outside of the portal and deployed to Azure. These nonportal supported languages include: C#, Java, Python (v2 programming model), and JavaScript/TypeScript (Node.js v4 programming model).

### Function templates

When you create your first function in the portal, you can select a predefined trigger for your function. Based on your selections, Azure generates default code and configuration information, such as creating an event log entry when input data is received.

Selecting a template from the **Add function** pane provides easy access to the most common development environments, triggers, and dependencies. When you create a function in the Azure portal, you can choose from more than 20 templates. Once created, you can further customize the code.

## Navigate to your function and its files

When you create a function from a template, several files are created, including a configuration file, *function.json*, and a source code file, *index.js*.

You can create or edit functions for your function app by selecting **Functions** under the **Functions** category from the Function App menu.

When you select a function that you created in your function app, the Function pane opens. By selecting **Code + Test** from the Function menu, you have access to actions in the command bar to test and run the code, to save or discard changes you make, or to obtain the published URL. By selecting **Test/Run** from the command bar, you can run use cases for requests that include query strings and values.  The function's path above the code box displays the name of the file that is open. You can select a specific file from the dropdown to test or edit, for example, *function.json*. 

:::image type="content" source="../media/4-file-navigation.png" alt-text="Screenshot of the function code and test editor showing the expanded Test/Run view, with menu options highlighted." lightbox="../media/4-file-navigation.png":::

In the previous image, the right-hand pane has **Input** and **Output** tabs. Selecting the **Input** tab enables you to build and test the function by adding query parameters and supplying values for your query string. The **Output** tab displays the results of the request.

## Test your Azure function

After you've created a function in the portal, you'll want to test it. There are two approaches:

- Testing it in the portal
- Running it manually

### Test in the Azure portal

The portal also provides a convenient way to test your functions. As previously described, in the previous screenshot. When you select **Run** in this pane, the results automatically appear in the **Output** tab, and the **Logs** pane opens to display the status.

### Run function manually

You can start a function by manually triggering the configured trigger. For instance, if you're using an HTTP trigger, you can use a tool, such as Postman or cURL, to initiate an HTTP request to your function endpoint URL, which is available from the function definition (**Get function URL**).

## Monitoring and Application Insights dashboard

The ability to monitor your functions is critical during development and in production. The Azure portal provides a monitoring dashboard, which you turn on by enabling Application Insights integration. In the Function App menu, under **Settings**, select **Application Insights**, select **Turn on Application Insights**, and then select **Apply**. In the dialog box, select **Yes**. The Application Insights dashboard provides a quick way to view the history of function operations by displaying the timestamp, result code, duration, and operation ID populated by Application Insights.

:::image type="content" source="../media/4-monitor-function.png" alt-text="Screenshot showing the HTTP function Application Insights dashboard with function results, corresponding HTTP status codes, and the Monitoring menu items highlighted." lightbox="../media/4-monitor-function.png#lightbox":::

## Streaming logs pane

After you've enabled Application Insights in the Azure portal, you can add logging statements to your function for debugging. The called methods for each language are passed a "logging" object, which can be used to add log information to the Logs pane in the **Code + Test** pane when running a test.

::: zone pivot="javascript"
Write to logs from your code using the `log` method on the `context` object, which is passed to the handler. The following example writes to the default log level (information):

  ```javascript
  context.log('Enter your logging statement here');
  ```
::: zone-end
<!-- until we have a C# pivot
- In C#, `log.LogInformation` method, the `log` object is passed to the C# method processing the function.

  ```csharp
  log.LogInformation("Enter your logging statement here");
   ```
-->
::: zone pivot="powershell"
Write to logs from your code using the `Write-Host` cmdlet, as shown in the following example: 

   ```powershell
  Write-Host "Enter your logging statement here"
   ```
::: zone-end

### Errors, failures, warnings, and anomalies

You can use Metrics or options from the Investigate category in the Function menu to monitor performance, diagnose failures, or configure dozens of predefined workbooks to manage your function app. Everything from compilation errors and warnings in the code, to usage statistics by role.
