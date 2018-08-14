In this exercise, we're going to create an Azure Function that accepts an HTTP request with a single string. The function will also return a string back to the caller to represent success or failure.

> [!NOTE] To complete this exercise make sure you're logged into the [Azure portal](https://portal.azure.com/) with a valid account.

## Create an HTTP trigger

Let's continue using our existing Azure Function application and add an HTTP trigger.

1. Hover your mouse over **Functions** and click the plus icon.

    ![Functions hover](../media/4-hover-function.png)

1. Click **HTTP trigger**.

1. Select **C#** as the language. 

1. Leave the **Name** as its default value.

1. Set the **Authorization level** to **Anonymous**

1. Click **Create**.

1. Briefly look at the auto-generated code to get an idea about what's going on. The *req* parameter represents the incoming request and contains a *name* parameter. We check to see if *name* has a value. If it does we return a greeting, if it doesn't we return an error message.

## Get your function URL

Now that we created the HTTP trigger, let’s get the function URL so that we can begin to make a request.

1. Select your HTTP trigger to open the code screen.

1. To the right of the **Run** button, click **Get function URL**.

1. Click **Copy**.

1. Click **Run** to start your function.

## Issue a GET request to your HTTP trigger

We now have our function URL copied into our clipboard and now let’s issue a GET request to see if we get a response.

1. Open a new tab in your web browser.

1. Paste the URL into the address bar.

1. Add a query string parameter called *name* with your name. For example, it would look something like this:

    ```
    .../api/HttpTriggerCSharp1?name=Jesse
    ```

1. Submit the request by clicking your *enter* key.

## Cleanup

To ensure you don't get charged for this function, make sure you select **Pause** above the log window.

![Pause](../media/4-pause-timer.png)


