 A function app provides a context for managing and executing your functions. Let's create a function app and then add a function to it.

## Create a Function App to host our function

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select the **Create a resource** button found on the upper left-hand corner of the Azure portal, and then select **Compute** > **Serverless Function App**.

1. Enter the function app settings as specified in the following table.

    | Setting      | Value  | Description                                        |
    | ------------ |  ------- | -------------------------------------------------- |
    | **App name** | Globally unique name | Name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`.  |
    | **Subscription** | **Concierge Subscription** | The subscription under which this new function app is created. |
    | **Resource group**|  **<rgn>[sandbox resource group name]</rgn>** | Name for the resource group in which to create your function app.<br/><br/>Make sure to select **Use existing** and use the resource group from the last exercise. That way, all the resources we make in this module are kept together. |
    | **OS** | Windows | The operating system that hosts the function app.  |
    | **Hosting Plan** |   Consumption plan | Hosting plan that defines how resources are allocated to your function app. In the default **Consumption Plan**, resources are added dynamically as required by your functions. In this [serverless](https://azure.microsoft.com/overview/serverless-computing/) hosting, you only pay for the time your functions run.   |
    | **Location** | Select the same location you used earlier. | Choose a region near you or near other services your functions access.<br/><br/>Select the same region that you used when creating the Text Analytics API account in the last exercise. |
    | **Runtime Stack** | JavaScript | The sample code in this module is written in JavaScript.  |
    | **Storage** |  Globally unique name |  Name of the new storage account used by your function app. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only. This dialog populates the field with a unique name that is derived from the name you gave the app. However, feel free to use a different name or even an existing account. |

1. Select **Create** to provision and deploy the function app.

1. Select the Notification icon in the upper-right corner of the portal, and watch for a **Deployment in progress** message.

1. Deployment can take some time. So, stay in the notification hub and  watch for a **Deployment succeeded** message.

1. Once the function app is deployed, go to **All resources** in the portal. The function app will be listed with type **App Service** and has the name you gave it. Select the function app in the list, to open it.

    Congratulations! You've created and deployed your function app.

> [!TIP]
> Having trouble finding your function apps in the portal? Try [adding Function Apps to your favorites in the Azure portal](https://docs.microsoft.com/azure/azure-functions/functions-how-to-use-azure-function-app-settings#favorite).

## Create a function to execute our logic

Now that we have a function app, it's time to create a function. A function is activated through a trigger. In this module, we'll use a Queue trigger. The runtime will poll a queue and start this function to process a new message.

1. Select the Add (**+**) button next to **Functions**. This action starts the function creation process.

1. On the **Azure Functions for JavaScript - getting started** page, select **In-portal** and then select **continue**.

1. In the **Create a function** step, select **More templates...** and then select **Finish and view templates**.

1. In the list of all templates available to this function app, select **Queue trigger** .

1. If you see a message saying  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes, so please be patient. Wait until the installation completes before continuing.

1. In the **New Function** dialog that appears, enter the following values.

    |Property  |Value  |
    |---------|---------|
    |Name     |   **discover-sentiment-function**      |
    |Queue name     |   **new-feedback-q**      |
    |Storage account connection        |  **AzureWebJobsStorage**       |

1. Select **Create** to begin the function creation process.

1. A function is created in your chosen language using the Queue Trigger function template. While we'll implement the function in JavaScript in this module, you can create a function in any [supported language](https://docs.microsoft.com/azure/azure-functions/supported-languages).

When the create process is complete, the code editor opens in the portal and loads the *index.js* page. This file is the code file where we write our function logic.

## Try it out

Let's test what we have so far. We haven't written any code yet, so this test is to make sure what we've configured so far, runs.

1. Click **Run** at the top of the code editor.

1. Observe the **Logs** tab that opens at the bottom of the screen. If everything works as planned, you'll see a message similar to the following message.
    ![Screenshot of response message of a successful call to our function.](../media/func-default-run.PNG)

    The **Run** button started our function and passed *sample queue data*, the default text from the **Test** request window to our function.

Nice work! You've successfully added a Queue-triggered function to your function app and tested to make sure it's working as expected! We'll add more functionality to the function in the next exercise.

Let's look briefly at the function's other file, the *function.json* config file. The configuration data from this file is shown in the following JSON listing.

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

As you can see, this function has a trigger binding named **myQueueItem** of type `queueTrigger`. When a new message arrives in the queue we've named **new-feedback-q**, our function is called. We reference the new message through the myQueueItem binding parameter. Bindings really do take care of some of the heavy lifting for us!

In the next step, we'll add code to call the Text Analytics API service.

> [!TIP]
> You can see index.js and function.json by expanding the **View Files** menu on the right of the function panel in the Azure portal.

This exercise was all about getting our Azure Functions infrastructure in place. We have a working function hosted in a function app that runs when a new message arrives in our queue that we've named [!INCLUDE [input-q](./q-name-input.md)]. The real fun begins in the next exercise when we add code to call an Azure Cognitive Service to do sentiment analysis.