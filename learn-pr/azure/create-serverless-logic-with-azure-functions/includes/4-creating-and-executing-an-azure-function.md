Now that we have a function app created, let's look at how to build, configure, and execute a function.

### Triggers

Functions are event driven, which means they run in response to an event. The type of event that starts a function is called a **trigger**. Each function must be configured with exactly one trigger.

Azure supports triggers for the following services.

| Service | Trigger description |
|---------|---------|
| Blob Storage | Starts a function when a new or updated blob is detected. |
| Azure Cosmos DB| Start a function when inserts and updates are detected. |
| Event Grid | Starts a function when an event is received from Event Grid. |
| HTTP | Starts a function with an HTTP request. |
| Microsoft Graph Events | Starts a function in response to an incoming webhook from the Microsoft Graph. Each instance of this trigger can react to one Microsoft Graph resource type. |
| Queue Storage | Starts a function when a new item is received on a queue. The queue message is provided as input to the function. |
| Service Bus | Starts a function in response to messages from a Service Bus queue. |
| Timer | Starts a function on a schedule. |

### Bindings

A binding is a declarative way to connect data and services to your function. Bindings know how to interact with different services, which means you don't have to write code in your function to connect to data sources and manage connections. The platform takes care of that complexity for you as part of the binding code. Each binding has a direction - your code reads data from *input* bindings, and writes data to *output* bindings. Each function can have zero or more bindings to manage the input and output data processed by the function.

A trigger is a special type of input binding that has the additional capability of initiating execution.

Azure provides a [large number of bindings](/azure/azure-functions/functions-triggers-bindings#supported-bindings) to connect to different storage and messaging services.

### Define a sample binding

Let's look at an example of configuring a function with an input binding (trigger) and an output binding. Let's say we want to write a new row to Azure Table storage whenever a new message appears in Azure Queue Storage. This scenario can be implemented using an Azure Queue Storage _trigger_ and an Azure Table storage _output binding_.

The following snippet is the _function.json_ file for this scenario.

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

Our JSON configuration specifies that our function will be triggered when a message is added to a queue named **myqueue-items**. The return value of our function is then written to the **outTable** table in Azure Table storage. For PowerShell functions, output bindings are explicitly written to with the `Push-OutputBinding` cmdlet.

This example is a simple illustration of how we configure bindings for a function. We could change the output to be an email using a SendGrid binding, or put an event onto a Service Bus to notify some other component in our architecture, or even have multiple output bindings to push data to various services.

> [!TIP]
> To view and edit the contents of _function.json_ in the Azure portal, from the Home page, select your function app, and in the right pane, select **JSON View**. The Resource JSON view displays the Resource ID and the editable JSON code. To close the JSON view, select the **X** in to top right corner of the pane.

## Create a function in the Azure portal

Azure provides several pre-made function templates for common scenarios:

- Quickstart
- Custom functions

### Add function templates

When adding your first function, you are presented with the **Add function** pane where you can choose the trigger for your function. Based on your selections, Azure will generate the function code and configuration with some sample code provided to display the input data received in the log.

### Custom function templates

Selecting a template from the **Add function** pane provides easy access to the most common templates. Azure provides over 30 additional templates you can start with. These can be selected from the template list when creating subsequent functions.

## Navigate to your function and files

When you create a function from a template, several files are created. For example, if you opted to use the Webhook + API Quickstart using JavaScript, the files generated would be a configuration file, **function.json**, and a source code file, **index.js**.

The functions you create in a function app appear by selecting **Functions** under the **Functions** category in the left menu pane of your function app.

When you select a function in your function app, your function pane appears. To display and edit your code for your function, in the left menu pane, under **Developer**, select **Code + Test**. In the function's path above the code box, select *function.json* from the dropdown list, and then select **Test/Run** from the top menu bar for the Input/Output pane to appear. See the following screenshot.

:::image type="content" source="../media/4-file-navigation.png" alt-text="Screenshot of the function editor pane showing the expanded Test/Run menu, with HttpTrigger1 function selected in app service navigation and Input tab highlighted." lightbox="../media/4-file-navigation.png":::

As you can see, the pane on the right has tabs for **Input** and **Output**. Selecting the **Input** tab provides parameters to test the HTTP request for your function.

## Test your Azure function

After you've created a function, you'll want to test it. There are two approaches:

- Running it manually
- Testing it from within the Azure portal itself

### Run function manually

You can start a function by manually triggering the configured trigger. For instance, if you are using an HTTP trigger, you can use a tool, such as Postman or cURL, to initiate an HTTP request to your function endpoint URL, which is available from the function definition (**Get function URL**).

### Test in the Azure portal

The portal also provides a convenient way to test your functions. As previously described, after selecting **Test/Run** from the top menu bar, on the right side of the code box, a tabbed *Test* pane appears. Here, you can provide parameters to test the HTTP request. When you select **Run** in this pane, the results appear in the **Output** tab, along with a status code in the **Logs** pane.

## Monitoring and Application Insights dashboard

The ability to monitor your functions is critical during development and in production. The Azure portal provides a monitoring dashboard if you turn on the Application Insights integration. In the left menu pane of your function app, under **Monitoring**, select **Logs**, and open **Application Insights**. This Application Insights dashboard provides a quick way to view the history of function executions, and displays the timestamp, result code, duration, and operation ID populated by Application Insights.

:::image type="content" source="../media/4-monitor-function.png" alt-text="Screenshot showing the HTTP function Application Insights dashboard with several function results, their corresponding HTTP status codes, and the Monitoring menu item of the function highlighted." lightbox="../media/4-monitor-function.png#lightbox":::

## Streaming logs pane

You're also able to add logging statements to your function for debugging in the Azure portal. The called methods for each language are passed a "logging" object, which may be used to log information to the Logs pane located at the bottom of the code window in the **Code + Test** pane after running a test.

The following JavaScript code snippet shows how to log a message using the `context.log` method (the `context` object is passed to the handler).

```javascript
context.log('Enter your logging statement here');
```

We could do the same thing in C# using the `log.LogInformation` method. In this case, the `log` object is passed to the C# method processing the function.

```csharp
log.LogInformation("Enter your logging statement here");
```

In PowerShell, use `Write-Host` to write to the log:

```powershell
Write-Host "Enter your logging statement here"
```

### Errors and warnings in the logs pane

You can locate the errors and warnings pane tab in the same flyout menu as the log pane. This pane shows compilation errors and warnings within your code.
