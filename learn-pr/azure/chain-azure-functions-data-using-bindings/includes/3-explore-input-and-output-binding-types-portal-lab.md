In this exercise, we'll create a function that runs when it receives an HTTP request, and responds to each request by returning a message. 

See the following high-level illustration of what we're going to build.

::: zone pivot="javascript"

:::image type="content" source="../media/3-default-http-trigger-implementation-javascript-small.png" alt-text="Screenshot of Code and Test pane showing default code for HTTP trigger function template." lightbox="../media/3-default-http-trigger-implementation-javascript.png":::

The parameter `req` is the *trigger binding*, and the parameter `res` is the *output binding*. It might help to think of these parameters as abbreviations for "request" and "response".

::: zone-end

::: zone pivot="powershell"

:::image type="content" source="../media/3-default-http-trigger-implementation-powershell-small.png" alt-text="Screenshot of Code and Test pane showing default code for HTTP trigger function template." lightbox="../media/3-default-http-trigger-implementation-powershell.png"::: 

The parameter `Request` is the *trigger binding*, and the parameter `Response` is the *output binding*.

::: zone-end

## Create a function app

Let's create a function app that we'll use throughout this module. A function app lets you group functions as a logical unit for easier management, deployment, and sharing of resources.

::: zone pivot="javascript"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the account that you used to activate the sandbox.

1. On the resource menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Compute**, and in the results list select **Function App**. You might need to search for **Function App** in the *Search services and marketplace* window.

1. Select **Create.** The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The Azure subscription that you want to use for this exercise. |
    | Resource Group | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> | The resource group for the sandbox. |
    | **Instance Details** |
    | Function App name | Enter a *globally unique name* | This name identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. |
    | Publish | Code | Option to publish code files or a Docker container. |
    | Runtime stack | From the dropdown list, select **Node.js** | The sample code in this module is written in JavaScript. |
    | Version | Accept *default* | The default value is sufficient for this exercise. |
    | Region | From the dropdown list, select a *location* | Select the region nearest to you. |

1. Accept the defaults for all other options. Select **Review + create** to validate your settings, and then select **Create** to provision and deploy the function app.

1. Deployment can take some time. In the global controls next to your account name, select the **Notifications** icon, and watch for a **Deployment succeeded** message.

1. When your function deployment is complete, select **Go to resource**. The **Overview** pane for your function app appears.

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. On the resource menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the **Create a resource** menu, select **Compute**, and then search for and select **Function App**. You might need to search for **Function App** in the *Search services and marketplace* window.

1. Select **Create.** The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The Azure subscription that you want to use for this exercise. |
    | Resource Group | From the dropdown list, select <rgn>[sandbox resource group name]</rgn> | The resource group for the sandbox. |
    | **Instance Details** |
    | Function App name | Enter a *globally unique name* | This name identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. |
    | Publish | Code | Option to publish code files or a Docker container. |
    | Runtime stack | From the dropdown list, select *PowerShell Core* | The sample code for this module is written in PowerShell. |
    | Version | Accept *default* | The default value is sufficient for this exercise. |
    | Region | From the dropdown list, select a *location* | Select the region nearest to you. |

1. Accept the defaults for all other options. Select **Review + create** to validate your input, and then select **Create** to provision and deploy the function app.

1. Deployment can take some time. In the global controls next to your account name, select the **Notifications** icon, and watch for a **Deployment succeeded** message.

1. When your function deployment is complete, select **Go to resource**. The **Overview** pane for your function app appears.

::: zone-end

> [!TIP]
> If you're having trouble finding your function app in the Azure portal, learn how to [add function apps to your favorites in the Azure portal](/azure/azure-functions/functions-how-to-use-azure-function-app-settings).

## Create a function

::: zone pivot="javascript"

Now that we have a function app, it's time to create a function. Each function is activated by a trigger. In this module, we'll define an HTTP trigger by using a predefined template.

1. Select the **Create in Azure portal** button in the **Functions** tab on the **Overview** page.

1. The **Create function** pane appears.

    :::image type="content" source="../media/3-add-function-small.png" alt-text="Screenshot for the Create Function pane." lightbox="../media/3-add-function.png":::

1. In the **Select a template** section, select the **HTTP trigger** template.

1. In the **Template details** section, confirm the following settings.

    - In the **New Function** text box, accept the default name *HttpTrigger1*. Azure automatically creates unique names for the functions you create. You can choose a different name, but this is a reminder to use meaningful names.

    - In the **Authorization level** text box, accept the default value *Function*. Authorization level determines what keys need to be present on the request in order for it to run. *Function* authorization level requires a function-specific key, which we'll find once it's created.

1. Select **Create**. When the trigger function has propagated to your function app, the **Functions** pane for your *Function App* appears, listing *HttpTrigger1*.

1. In the command bar, select **Get Function Url**. The **Get Function Url** dialog box appears.

1. In the dropdown list, select **default (function key)**, select the *Copy to clipboard* icon at the end of the URL, and then select **OK** to close the dialog.

1. In the address bar of a new browser tab, paste the function URL you copied. Press <kbd>Enter</kbd> to run the request in your browser. The response may take a couple of minutes as the function app initializes. If you receive a timeout error, refresh to resend the request.

   When the function responds, you should see output similar to the following example displayed in your browser.

    ```output
    This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.
    ```

1. Add the following query string `&name=Joe` to the end of the URL. Your resulting URL should resemble the following example:

    `https://example.azurewebsites.net/api/HttpTrigger1?code=AbCdEfGhIjKlMnOpQrStUvWxYz==&name=Joe`  

1. Press <kbd>Enter</kbd> to run the request in your browser. When the function responds, you should see output similar to the following example displayed in your browser.

    ```output
    Hello, Joe. This HTTP triggered function executed successfully.
    ```

    As you can see from this exercise so far, you must define a trigger when you create a function. Each function has a single trigger. In this example, we're using an HTTP trigger, which means our function starts when it receives an HTTP request. The default implementation from the template, shown in JavaScript in the following screenshot, returns the value of the parameter *name* that was in the query string or body of the request. If no query string was provided, the function responds with a message that asks whomever is calling to supply a name value.

    :::image type="content" source="../media/3-default-http-trigger-implementation-javascript-small.png" alt-text="Illustration of default HTTP trigger, showing HTTP request and response binding parameters." lightbox="../media/3-default-http-trigger-implementation-javascript.png":::

1. In the Azure portal, in the **Function** menu, select **Code + Test**.

    The **Code + Test** pane for your function appears, and displays the contents of your **index.js** file. The default JavaScript code for your function should resemble the following example.

    ```javascript
    module.exports = async function (context, req) {
        context.log('JavaScript HTTP trigger function processed a request.');
   
        const name = (req.query.name || (req.body && req.body.name));
        const responseMessage = name
            ? "Hello, " + name + ". This HTTP triggered function executed successfully."
            : "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.";

        context.res = {
            // status: 200, /* Defaults to 200 */
            body: responseMessage
        };
    }
    ```

1. Let's look briefly at the function's other file--the **function.json** config file. Access this file by selecting **function.json** from the dropdown list in the filepath above the code block. The configuration data is shown in the following JSON listing.

    ```json
    {
        "bindings": [
        {
            "authLevel": "function",
            "type": "httpTrigger",
            "direction": "in",
            "name": "req",
            "methods": [
            "get",
            "post"
            ]
        },
        {
            "type": "http",
            "direction": "out",
            "name": "res"
        }
      ]
    }
    ```

    This function has a *trigger binding* named **req** of type `httpTrigger`, and an output binding named **res** of type `http`.
  
In the preceding code for our function, we saw that we accessed the payload of the incoming HTTP request through the **req** parameter. Similarly, we sent an HTTP response by setting our **res** parameter. Bindings really do take care of some of the burdensome work for us!
  
::: zone-end

::: zone pivot="powershell"

Now that we have a function app, let's create a function. Each function is activated by a trigger. In this module, we'll create an HTTP trigger by using a template.

1. Select the **Create in Azure portal** button in the **Functions** tab on the **Overview** page.

1. The **Create function** pane appears.

1. In the **Select a template** section, select the **HTTP trigger** template.

1. In the **Template details** section, confirm the following settings.

    - In the **New Function** text box, accept the default name *HttpTrigger1*. Azure automatically provides a unique name when you create a function. You can choose a different name, but this is a reminder to use meaningful names.

    - In the **Authorization level** text box, accept  the default value *Function*. Authorization level determines what keys need to be present on the request in order for it to run. *Function* requires a function-specific key.

        :::image type="content" source="../media/3-add-function-small.png" alt-text="Screenshot for the Add Function pane." lightbox="../media/3-add-function.png#lightbox":::

1. Select **Create**. The **HttpTrigger1** pane for your *Function* appears.

1. In the command bar, select **Get Function Url**. The **Get Function Url** dialog box appears.

1. Select **default (function key)** from the dropdown list, then select the *Copy to clipboard* icon at the end of the URL, and then select **OK** to close the dialog box.

1. In the address bar of a new browser tab, paste the function URL you copied. Press <kbd>Enter</kbd> to run the request in your browser. The response may take a couple of minutes as the function app initializes. If you receive a timeout error, refresh to resend the request.

   When the function responds, you should see output similar to the following example displayed in your browser.

    ```output
    This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.
    ```

1. Add query string `&name=Joe` to the end of the URL. Your resulting URL should resemble the following example:

   `https://example.azurewebsites.net/api/HttpTrigger1?code=AbCdEfGhIjKlMnOpQrStUvWxYz==&name=Joe`  

1. Press <kbd>Enter</kbd> to run the request in your browser. When the function responds, you should see output similar to the following example displayed in your browser.

    ```output
    Hello, Joe. This HTTP triggered function executed successfully.
    ```

    As you can see from this exercise so far, you must define a trigger when you create a function. Each function has a single trigger. In this example, we're using an HTTP trigger, which means our function starts when it receives an HTTP request. The default implementation from the template, shown in PowerShell in the following screenshot, uses the `Push-OutputBinding` cmdlet to respond with the value of the parameter name that was part of the query string or body of the request. If no string was provided, the function responds with a message that prompts whomever is calling to supply a name value.

    :::image type="content" source="../media/3-default-http-trigger-implementation-powershell-small.png" alt-text="Code and Test pane for HTTP request showing response and respective binding parameters." lightbox="../media/3-default-http-trigger-implementation-powershell.png#lightbox)"::: <!-- no-loc -->

1. In the Function menu, select **Code + Test**. The **Code + Test** pane for your function appears, and displays the contents of your **run.ps1** file.

    The default PowerShell code for your function should resemble the following example.

    ```powershell
    using namespace System.Net
    
    # Input bindings are passed in via param block.
    param($Request, $TriggerMetadata)
    
    # Write to the Azure Functions log stream.
    Write-Host "PowerShell HTTP trigger function processed a request."
    
    # Interact with query parameters or the body of the request.
    $name = $Request.Query.Name
    if (-not $name) {
        $name = $Request.Body.Name
    }
    
    $body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."
    
    if ($name) {
        $body = "Hello, $name. This HTTP triggered function executed successfully."
    }
    
    # Associate values to output bindings by calling 'Push-OutputBinding'.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body = $body
    })
    ```

1. Let's look briefly at the function's other file, the **function.json** config file. Open this file by selecting **function.json** from the filepath's dropdown list. The configuration data is shown in the following JSON listing.

    ```json
    {
      "bindings": [
        {
          "authLevel": "function",
          "type": "httpTrigger",
          "direction": "in",
          "name": "Request",
          "methods": [
            "get",
            "post"
          ]
        },
        {
          "type": "http",
          "direction": "out",
          "name": "Response"
        }
      ]
    }
    ```

    As you can see, this function has a trigger binding named **Request** of type `httpTrigger`, and an output binding named **Response** of type `http`. In the preceding code for our function, we saw how we accessed the payload of the incoming HTTP request through the **Request** parameter. Similarly, we sent an HTTP response simply by setting the **Response** parameter. Bindings really do take care of some of the burdensome work for us.

::: zone-end

### Explore binding types

::: zone pivot="javascript"

1. In the **Function** menu, select **Integration**. The **Integration** pane for your function appears.

   Notice that we've already defined a trigger and an output binding, as shown in the following image. The integration view adjusts to the best fit for the width and height of your screen. The same information can display horizontally, if your screen is wide enough.

   :::image type="content" source="../media/3-function-integration-vertical-small.png" alt-text="Screenshot of vertical flow diagram showing Trigger and Inputs leading to Function and Function leading to Outputs." lightbox="../media/3-function-integration-vertical.png":::

   You can see that we can't add more than _one_ trigger. To change a trigger for a function, you need to delete the trigger and create a new one. However, the **Inputs** and **Outputs** sections enable you to add more than one binding, so the request can accept more than one input value and return more than one output value.

1. In the **Inputs** box, select **Add input**. The **Create Input** pane appears. Select the dropdown list for **Binding Type** to view a list of all possible input binding types.

   :::image type="content" source="../media/3-function-input-bindings.png" alt-text="Screenshot of the Add input options.":::

   Take a moment to consider how you might use each of these input bindings in a solution.

   We'll get back to adding input bindings later in this module, but for now, select **Cancel** to dismiss this pane.

1. In the **Outputs** box, select **Add output**. The **Create Output** pane appears. Select the dropdown list for **Binding Type** to view a list of all possible output binding types.

    :::image type="content" source="../media/3-function-output-bindings.png" alt-text="Screenshot of the Add output options.":::

    As you can see, there are several output binding types. We'll get back to adding output bindings later in this module but, for now, select **Cancel** to dismiss this pane.

::: zone-end

::: zone pivot="powershell"

1. In the **Function** menu, select **Integration**. The **Integration** pane for your function appears.

    Notice that we've already defined a trigger and an output binding, as shown in the following image. The integration view adjusts to the best fit for the width and height of your screen. The same information can display vertically, if your screen isn't wide enough.

    :::image type="content" source="../media/3-function-integration-horizontal-small.png" alt-text="Screenshot of horizontal flow diagram showing Trigger and Inputs leading to Function and Function leading to Outputs." lightbox="../media/3-function-integration-horizontal.png":::

    You can see that we can't add more than _one_ trigger. To change the trigger for a function, you need to delete the trigger and create a new one. However, the **Inputs** and **Outputs** sections enable you to add multiple bindings, so the function can accept more than one input value and return more than one output value.

1. In the **Inputs** box, select **Add input**. The **Create Input** pane appears. Select the dropdown list for **Binding Type** to view a list of all possible input binding types.

    :::image type="content" source="../media/3-function-input-bindings.png" alt-text="Screenshot of the Add input options.":::

    Take a moment to consider how you might use each of these input bindings in a solution. There are many possibilities to choose from.

    We'll get back to adding input bindings later in this module but for now, select **Cancel** to dismiss this pane.

1. In the **Outputs** box, select **Add output**. The **Create Output** pane appears. Select the dropdown list for **Binding Type** to view a list of all possible output binding types.

    :::image type="content" source="../media/3-function-output-bindings.png" alt-text="Screenshot of the Add output options.":::

    As you can see, there are several output binding types. We'll get back to adding output bindings later in this module but, for now, select **Cancel** to dismiss this pane.

::: zone-end

So far, we've learned how to create a function app and add a function to it. We've seen a simple function in action--one that runs when an HTTP request is made. We've also explored the Azure portal and the types of input and output bindings that are available to functions. In the next unit, we'll use an input binding to read text from a database.
