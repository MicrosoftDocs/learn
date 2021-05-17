See the following high-level illustration of what we're going to build in this exercise.

::: zone pivot="javascript"

:::image type="content" source="../media/3-default-http-trigger-implementation-small.PNG" alt-text="Illustration of default HTTP trigger, showing HTTP request and response as well as respective req and res binding parameters." loc-scope="other"::: <!-- no-loc -->

::: zone-end

::: zone pivot="powershell"

![Illustration of default HTTP trigger, showing HTTP request and response as well as respective req and res binding parameters.](../media/3-default-http-trigger-implementation-pwsh.png)

::: zone-end

We'll create a function that will start when it receives an HTTP request and will respond to each request by sending back a message. The parameters `req` and `res` are the trigger binding and output binding, respectively.

## Create a function app

Let's create a function app that we'll use throughout this entire module. A function app lets you group functions as a logical unit for easier management, deployment, and sharing of resources.

::: zone pivot="javascript"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**. The **Create a resource** pane appears.

1. In the left menu pane, select **Compute**, and then select **Function App** from the *Featured* list in the Azure Marketplace. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | _Concierge Subscription_ | The Azure subscription that you want to use. |
    | Resource Group | _<rgn>[sandbox resource group name]</rgn>_ | This setting is pre-populated with the resource group from your sandbox. |
    | **Instance Details** |
    | Function App name | Globally unique name | Name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. |
    | Publish | _Code_ | Option to publish code files or a Docker container. |
    | Runtime stack | _Node.js_ | The sample code in this module is written in JavaScript. |
    | **Version** | Leave *default* |
    | **Region** | _Central US_ | Choose the region nearest you. |

1. Select **Review + create** > **Create** to provision and deploy the function app.

1. You can select the **Notifications** icon in the upper-right corner of the portal, and watch for a **Deployment in progress** message similar to the following message.

    ![Screenshot of a notification that function app deployment is in progress.](../media/3-func-app-deploy-progress-small.PNG)

1. Deployment can take some time. So, stay in the Notifications hub and watch for a **Deployment succeeded** message similar to the following message.

    ![Screenshot of a notification that function app deployment has completed.](../media/3-func-app-deploy-success-small.PNG)

1. After your function app is deployed, select **Go to resource**. The Overview pane for your function app appears.

    >[!TIP]
    >If you are having trouble finding your function app in the portal, find out how to [add function apps to your favorites in the portal](https://docs.microsoft.com/azure/azure-functions/functions-how-to-use-azure-function-app-settings).

::: zone-end

::: zone pivot="powershell"

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the left menu pane, select **Compute**, and then select **Function App** from the *Featured* list in the Azure Marketplace. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription | The Azure subscription that you want to use for this Azure Cosmos DB account. |
    | Resource Group | <rgn>[sandbox resource group name]</rgn> | This setting is pre-populated with the resource group from your sandbox. |
    | **Instance Details** |
    | Function App name | *Globally unique name* | Name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. |
    | Publish | Code | Option to publish code files or a Docker container. |
    | Runtime stack | Node.js | The sample code in this module is written in JavaScript. |
    | Version | Leave *default* |
    | Region | Central US | Choose the region nearest you. |

1. Select **Review + create** > **Create** to provision and deploy the function app.

1. Select the **Notifications** icon in the upper-right corner of the portal and watch for a **Deployment in progress** message similar to the following message.

    ![Screenshot of a notification that function app deployment is in progress.](../media/3-func-app-deploy-progress-small.PNG)

1. Deployment can take some time. So, stay in the Notifications hub and watch for a **Deployment succeeded** message similar to the following message.

    ![Screenshot of a notification that function app deployment has completed.](../media/3-func-app-deploy-success-small.PNG)

1. After your function app is deployed, select **Go to resource**. The Overview pane for your function app appears.

    >[!TIP]
    >If you are having trouble finding your function apps in the portal, find out how to [add function apps to your favorites in the portal](https://docs.microsoft.com/azure/azure-functions/functions-how-to-use-azure-function-app-settings).

::: zone-end

## Create a function

::: zone pivot="javascript"

Now that we have a function app, it's time to create a function. A function is activated through a trigger. In this module, we'll use an HTTP trigger.

1. In the left menu pane, under **Functions**, select **Functions**. The **Functions** pane for your function app appears. This opens the function creation process.

1. From the top menu bar, select **Add**. The **Add function** pane appears.

1. In the **Select a template** section, select **HTTP trigger**.

1. In the **Template details** section, in the **New Function** text box, you can change the name if you want. Leave the **Authorization level** dropdown as _Function_, and then select **Add**. The Authorization level option determines what kind of key is used to securely access your function. Choosing _Function_ requires callers of your function to provide a function-specific key with their requests.The **HttpTrigger*x*** pane appears.

1. In your new function, in the top menu bar, select **Get Function Url**.

1. In the **Get Function Url** dialog box, select **default (function key)**, then select the *Copy to clipboard* icon at the end of the URL, and select **OK**.

1. Paste the function URL you copied into the address bar of a new tab in your browser.

1. Add the query string value `&name=Azure` to the end of this URL, and then press <kbd>Enter</kbd> to execute the request. You should see a response similar to the following response returned by the function displayed in your browser.

    ```output
    Hello, Azure. This HTTP triggered function executed successfully.
    ```

    As you can see from this exercise so far, you have to select a trigger type when you create a function. Every function has a single trigger. In this example, we're using an HTTP trigger, which means that our function starts when it receives an HTTP request. The default implementation, shown in the following screenshot in JavaScript, responds with the value of the parameter *name* it received in the query string or body of the request. If no string was provided, the function responds with a message that asks whomever is calling to supply a name value.

1. Return to the portal, and in the left menu pane, under **Developer**, select **Code + Test** to view the code.

    ![Screenshot of the default JavaScript implementation of an HTTP-triggered Azure function.](../media/3-default-http-trigger-implementation-small.PNG)

    Let's look briefly at the function's other file - the **function.json** config file. Access this file by selecting **function.json** from the filepath's dropdown list. The configuration data is shown in the following JSON listing.

    >[!TIP]
    > You can view the additional code by selecting the dropdown list in the middle of the **Code + Test** screen.

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

    As you can see, this function has a trigger binding named **req** of type `httpTrigger`, and an output binding named **res** of type `http`. In the preceding code for our function, we saw how we accessed the payload of the incoming HTTP request through our **req** parameter. Similarly, we sent an HTTP response simply by setting our **res** parameter. Bindings really do take care of some of the burdensome work for us.

::: zone-end

::: zone pivot="powershell"

Now that we have a function app, it's time to create a function. A function is activated through a trigger. In this module, we'll use an HTTP trigger.

1. In the left menu pane, under **Functions**, select **Functions**. The **Functions** pane for your function app appears. This opens the function creation process.

1. From the top menu bar, select **Add**. The **Add function** panel appears.

1. In the **Select a template** section, select **HTTP trigger**.

1. In the **Template details** section, in the **New Function** text box, you can change the name if you want. Leave the **Authorization level** dropdown as _Function_, and then select **Add**. The Authorization level option determines what kind of key is used to securely access your function. Choosing _Function_ requires callers of your function to provide a function-specific key with their requests.

1. In your new function, in the top menu bar, select **Get Function Url**.

1. In the **Get Function Url** dialog box, select **default (Function key)**, and then select the *Copy to clipboard* icon at the end of the URL.

1. Paste the function URL you copied into the address bar of a new tab in your browser.

1. Add the query string value `&name=Azure` to the end of this URL, and then press <kbd>Enter</kbd> to run the request. You should see a response similar to the following response returned by the function displayed in your browser.

    The response may take a couple of minutes to come back as the function app warms up for the first time. If you receive a timeout error, refresh to resend the request. After the function is able to respond, you should see a response similar to the following response returned by the function displayed in your browser.

    ```output
    Hello, Azure. This HTTP triggered function executed successfully.
    ```

    As you can see from this exercise so far, you have to select a trigger type when you create a function. Every function has a single trigger. In this example, we're using an HTTP trigger, which means that our function starts when it receives an HTTP request. The default implementation, shown in the following image in PowerShell, uses the `Push-OutputBinding` cmdlet to respond with the value of the parameter *name* it received in the query string or body of the request. If no string was provided, the function responds with a message that prompts whomever is calling to supply a name value.

    ![Screenshot of the default PowerShell implementation of an HTTP-triggered Azure function.](../media/3-default-http-trigger-implementation-pwsh.png)

1. Return to the portal, and in the left menu pane, under **Developer**, select **Code + Test** to view the code.

    >[!TIP]
    >You can see the **run.ps1** and **function.json** files by selecting them from the dropdown list.

    Let's look briefly at the function's other file, the **function.json** config file. Access this file by selecting **function.json** from the filepath's dropdown list. The configuration data is shown in the following JSON listing.

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

As you can see, this function has a trigger binding named **Request** of type `httpTrigger`, and an output binding named **Response**  of type `http`. In the preceding code for our function, we saw how we accessed the payload of the incoming HTTP request through our **Request** parameter. Similarly, we sent an HTTP response simply by setting our **Response** parameter. Bindings really do take care of some of the burdensome work for us.

::: zone-end

### Explore binding types

1. In the left menu pane, under **Developer**, select **Integration**. The **Integration** pane for your function appears.

    :::image type="content" source="../media/3-func-integrate-tab-small.png" alt-text="Screen shot of the integration screen. Trigger and Inputs lead to Function and on to Output.":::

    > [!NOTE]
    > We have already defined a trigger and an output binding, as shown in the image. You can see that we can't add more than _one_ trigger. In fact, to change the trigger for our function, we would have to first delete the trigger, and create a new one. However, the **Inputs** and **Outputs** sections of this pane display a plus sign (+) to add more bindings so we can accept more than one input value, and emit more than one output value.

1. Select **Add input** in the **Inputs** box. The **Create Input** pane appears showing a list of all possible input **Binding Types** when selecting the dropdown list.

    :::image type="content" source="../media/3-func-input-bindings-selector-small.png" alt-text="Screen shot of the Add input options.":::

    Take a moment to consider each of these input bindings, and how you might use them in a solution. There are many selections to choose from.

1. We'll get back to adding input bindings later in the module but, for now, select **Cancel** to dismiss this pane.

1. Select **Add output** in the **Outputs** box. The **Create Output** pane appears showing a list of all possible output **Binding Types** when selecting the dropdown list.

1. As you can see, there are several output binding types. We'll get back to adding output bindings later in the module but, for now, select **Cancel** to dismiss this pane.

So far, we've learned how to create a function app and add a function to it. We've seen a simple function in action, one that runs when an HTTP request is made to it. We've also explored the Azure portal and types of input and output binding that are available to our functions. In the next unit, we'll use an input binding to read text from a database.
