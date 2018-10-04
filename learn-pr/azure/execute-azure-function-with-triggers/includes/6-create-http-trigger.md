In this unit, we're going to create an Azure function that accepts an HTTP request with a single string. The function returns a string back to the caller to represent success or failure. We'll continue working on the function from the previous exercise.

## Create an HTTP trigger

Let's continue using our existing Azure Functions application and add an HTTP trigger.

1. Make sure you are signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Navigate to the **All resources** screen and select your function app.

1. Select the Add (**+**) button next to **Functions**. This action starts the function creation process.

1. In the list of all templates available to this function app, select **HTTP trigger** .

1. In the **New Function** dialog, choose a name for the function and select  *Anonymous* from the **Authorization level** dropdown.
1. Select **Create** to create the function. 

1. Take a quick look at the auto-generated code to get an idea about what's going on. The *req* parameter represents the incoming request and contains a *name* parameter. We check to see if *name* has a value. If it does, we return a greeting. Otherwise, we return an error message.

## Get your function URL

Now that we've created the HTTP trigger, let's get the function URL so we can begin to make a request.

1. Select your HTTP trigger to open the code screen.

1. To the right of **Run**, select **Get function URL**.

1. Select **Copy**, then close the function URL popup.

## Issue a GET request to your HTTP trigger

We now have our function URL copied to our clipboard. Let's issue a GET request to see if we get a response.

1. Open a new tab in your web browser.

1. Paste the URL into the address bar.

1. Add a query string parameter called *name* with your name for example `.../api/HttpTriggerCSharp1?name=Jesse`

1. Press <kbd>ENTER</kbd> to submit the request.
