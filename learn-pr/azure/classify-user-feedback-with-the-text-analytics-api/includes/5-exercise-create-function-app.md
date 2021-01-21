 A function app provides a context for managing and executing your functions. Let's create a function app and then add a function to it.

## Create a Function App to host our function

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**, and then select **Compute** > **Function App**.

1. Enter the function app settings as specified in the following table.

    | Setting      | Value  | Description                                        |
    | ------------ |  ------- | -------------------------------------------------- |
    | **Subscription** | Concierge Subscription | The subscription under which this new function app is created. |
    | **Resource group**|  <rgn>[sandbox resource group name]</rgn> | Name for the resource group in which to create your function app.  Make sure to select **Use existing** and use the resource group from the last exercise. That way, all the resources we make in this module are kept together. |
    | **App name** | Globally unique name | Name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. In our case, let's use *discover-sentiment-function*. |
    | **Publish** | Code | Leave as default. |
    | **Runtime Stack** | Node.js | The sample code in this module is written in JavaScript.  |
    | **Version** | 12 LTS | Leave as default. |
    | **Region** | Select the same location you used earlier. | Choose a region near you or near other services your functions access.<br/><br/>Select the same region that you used when creating the Text Analytics API account in the last exercise. |

1. Select **Create** to provision and deploy the function app.  If you get an error on **Hosting** tab, simply create a **Storage account**.

1. Select the Notification icon in the upper-right corner of the portal, and watch for a **Deployment in progress** message.

1. Deployment can take some time. So, stay in the notification hub and  watch for a **Deployment succeeded** message.

1. Once the function app is deployed, go to **All resources** in the portal. The function app will be listed with type **App Service** and has the name you gave it. Select the function app in the list, to open it.

    Congratulations! You've created and deployed your function app.

> [!TIP]
> Having trouble finding your function apps in the portal? Try [adding Function Apps to your favorites in the Azure portal](https://docs.microsoft.com/azure/azure-functions/functions-how-to-use-azure-function-app-settings).

## Create a function to execute our logic

Now that we have a function app, it's time to create a function. A function is activated through a trigger. In this module, we'll use a Queue trigger. The runtime will poll a queue and start this function to process a new message.

1. From the left-hand side, select **Function**. Select Add (**+**) at the top middle of the page. This action starts the Function creation process.

1. On the **Azure Functions for JavaScript - getting started** page, verify **In-portal** is selected.

1. In the list of templates available to this function app, select **Azure Queue Storage trigger**.

1. If you see a message stating  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes. Wait until the installation completes before continuing.

1. Select **Add** to begin the function creation process.
   A function is created using the Queue Trigger function template. While we'll implement the function in JavaScript in this module, you can create a function in any [supported language](https://docs.microsoft.com/azure/azure-functions/supported-languages).

1. If you have not already done so, select the **Trigger** you just created.

## Try it out

Let's test what we have so far. We haven't written any code yet, so this test is to make sure what we've configured so far, runs.

1. Select **Code + Test** on the left-hand side. 

1. Select **Test/Run** at the top of the code editor, and then select **Run** at the bottom of the page.

1. Observe the **Logs** tab that opens at the bottom of the screen. If everything works as planned, you'll see a message similar to the following message.

    ![Screenshot of response message of a successful call to our function.](../media/func-default-run.PNG)


> [!TIP]
> If the function times out or does not return successfully, try restarting the functions app. Select your functions app in the menu on the left and then select **Restart** from the *Overview* panel. Wait for the functions app to restart and then try running your function again.

Nice work! You've successfully added a Queue-triggered function to your function app and tested to make sure it's working as expected! We'll add more functionality to the function in the next exercise.

Let's look briefly at the function's other file, the *function.json* config file (close the Test/Run box, and select the dropdown to view the file. The configuration data from this file is shown in the following JSON listing.

```json
{
  "bindings": [
    {
      "name": "myQueueItem",
      "type": "queueTrigger",
      "direction": "in",
      "queueName": "new-feedback-q",
      "connection": "AzureWebJobsDashboard"
    }
  ],
  "disabled": false
}
```

As you can see, this function has a trigger binding named **myQueueItem** of type `queueTrigger`. When a new message arrives in the queue we've named **new-feedback-q**, our function is called. We reference the new message through the myQueueItem binding parameter. Bindings really do take care of some of the burdensome work for us!

In the next step, we'll add code to call the Text Analytics API service.

> [!TIP]
> You can see index.js and function.json by expanding the **View Files** menu on the right of the function panel in the Azure portal.

This exercise was all about getting our Azure Functions infrastructure in place. We have a working function hosted in a function app that runs when a new message arrives in our queue that we've named [!INCLUDE [input-q](./q-name-input.md)]. The real fun begins in the next exercise when we add code to call an Azure Cognitive Service to do sentiment analysis.
