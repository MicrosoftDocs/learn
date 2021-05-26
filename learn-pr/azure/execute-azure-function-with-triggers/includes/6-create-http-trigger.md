In this unit, we're going to create an Azure function that accepts an HTTP request with a single string. The function returns a string back to the caller to represent success or failure. We'll continue working on the function from the previous exercise.

## Create an HTTP trigger

Let's continue using our existing Azure Functions application and add an HTTP trigger.

::: zone pivot="csharp"

1. Make sure you are signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **All resources**.

1. Select your function app. Your **Function App** page appears.

1. In the left menu pane, under the **Functions** section, select **Functions**. The **Functions** page for your function app appears.

1. On the top menu bar, select **Add**. This action starts the function creation process. The **Add function** pane appears.

1. In the **Select a template** section, select **HTTP trigger**.

1. In the **Template details** section, in **New Function** text box, enter a name for the function. In the **Authorization level** dropdown, select *Anonymous*, and then select **Add**.

1. Take a quick look at the auto-generated code to get an idea about what's going on. The *req* parameter represents the incoming request and contains a *name* parameter. We check to see if *name* has a value. If it does, we return a greeting. Otherwise, we return an error message.

::: zone-end

::: zone pivot="powershell"

1. Make sure you are signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **All resources**.

1. Select your function app.  Your **Function App** page appears.

1. In the left menu pane, under the **Functions** section, select **Functions**. The **Functions** page for your function app appears.

1. On the top menu bar, select **Add**. This action starts the function creation process. The **Add function** panel appears.

1. In the **Select a template** section, select **HTTP trigger**.

1. In the **Template details** section, in **New Function** text box, enter a name for the function. In the **Authorization level** dropdown, select *Anonymous*, and then select **Add**.

1. Take a quick look at the auto-generated code to get an idea about what's going on. The `$Request` parameter represents the incoming request and contains a *name* parameter. We check to see if *name* has a value. If it does, we use `Push-OutputBinding` to write a greeting to the response. Otherwise, we write an error message to the response.

::: zone-end

## Get your function URL

Now that we've created the HTTP trigger, let's get the function URL so we can begin to make a request.

1. On the top menu bar, select **Get Function Url**. The **Get Function Url** dialog appears.

1. Select **Copy** (clipboard), and select **OK** to close the function URL dialog.

## Issue a GET request to your HTTP trigger

We now have our function URL copied to our clipboard. Let's issue a GET request to see if we get a response.

::: zone pivot="csharp"

1. Open a new tab in your web browser.

1. Paste the URL into the address bar.

1. Add a query string parameter called *name* with your name for example `.../api/HttpTriggerCSharp1?name=Jesse`

1. Press <kbd>Enter</kbd> to submit the request.

::: zone-end

::: zone pivot="powershell"

1. Open a new tab in your web browser.

1. Paste the URL into the address bar.

1. Add a query string parameter called *name* with your name for example `.../api/HttpTriggerCSharp1?name=Jesse`

1. Press <kbd>Enter</kbd> to submit the request.

::: zone-end
