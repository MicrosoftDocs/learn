 A function app provides a context for managing and executing your functions. Let's create a function app, and then add a function to it.

## Create a Function App to host our function

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **Create a resource**. The **Craete a resource** pane appears.

1. In the left menu bar, select **Compute**, and then search for and select **Function App**. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting      | Value  | Description  |
    | ------------ |  ------- | ------ |
    | **Project Details** | |
    | Subscription | Concierge Subscription | Subscription under which this new function app is created. |
    | Resource Group|  From the dropdown list, select <rgn>[sandbox resource group name]</rgn>. | Name for the resource group in which to create your function app.  Make sure to select **Use existing** and use the resource group from the last exercise. That way, all the resources we make in this module are consolidated. |
    | **Instance Details**| |
    | Function App name | Globally unique name | Name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. In our case, let's use *discover-sentiment-function*. |
    | Publish | Code | Leave as default. |
    | Runtime stack | From the dropdown list, select **Node.js**. | The sample code in this module is written in JavaScript.  |
    | Version | From the dropdown list, select **12 LTS**. |  |
    | Region | Select the same location you used earlier. | Choose a region near you or near other services your functions access.<br/><br/>Select the same region that you used when creating the Text Analytics API account in the last exercise. |

1. Select **Review + create**, and then select **Create** to provision and deploy the function app. If you get an error on the **Hosting** tab, simply create a **Storage account**.

1. Select the Notification icon in the upper-right corner of the portal, and watch for a **Deployment is in progress** message.

1. Deployment can take some time. So, stay in the notification hub and watch for a **Deployment succeeded** message.

1. After your function app is deployed, select **Go to resource**. The function app overview pane appears.

    Congratulations! You've created and deployed your function app.

> [!TIP]
> Having trouble finding your function apps in the portal? Try [adding Function Apps to your favorites in the Azure portal](/azure/azure-functions/functions-how-to-use-azure-function-app-settings).

## Create a function to execute our logic

Now that we have a function app, it's time to create a function. A function is activated through a trigger. In this module, we'll use a Queue trigger. The runtime will poll a queue and start this function to process a new message.

1. In the left menu bar, under **Functions**, select **Functions**. The **Functions** pane appears for your function app.

1. In the top menu bar, select **Add**. This action starts the Function creation process. The **Add function** pane appears.

1. In the **Development environment** field, verify **Develop in portal** is selected.

1. In the **Select a template** section, select **Azure Queue Storage trigger**.

1. If a message appears stating  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes. Wait until the installation completes before continuing.

1. Select **Add** to begin the function creation process.

   A function is created using the Queue Trigger function template. While we'll implement the function in JavaScript in this module, you can create a function in any [supported language](/azure/azure-functions/supported-languages). The **QueueTrigger1** function pane appears.

## Try it out

Let's test what we have so far. We haven't written any code yet, so this test is to make sure what we've configured so far, runs.

1. In the left menu bar, under **Developer**, select **Code + Test**.

1. In the top menu bar, select **Test/Run**. The test pane appears.

1. Select **Run**.

1. Observe the **Logs** tab that opens at the bottom of the screen. If everything works as planned, you'll see a message similar to the following message.

    ![Screenshot of response message of a successful call to our function.](../media/func-default-run.PNG)


> [!TIP]
> If the function times out or does not return successfully, try restarting the function app. Select your function app from the link at the top left corner of the portal, and then select **Restart** from the *Overview* pane. Wait for the function app to restart, and then try running your function again.

Nice work! You've successfully added a Queue-triggered function to your function app and tested to make sure it's working as expected! We'll add more functionality to the function in the next exercise.

Let's look briefly at the function's other file, the *function.json* config file. To close the Test/Run panel, select **Close**, and from the *QueueTrigger1* dropdown list, select **function.json** to view the file. The configuration data from this file is shown in the following JSON listing.

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

As you can see, this function has a trigger binding named **myQueueItem** of type `queueTrigger`. When a new message arrives in the queue that we've named **new-feedback-q**, our function is called. We reference the new message through the myQueueItem binding parameter. Bindings really do take care of some of the burdensome work for us!

In the next step, we'll add code to call the Text Analytics API service.

> [!TIP]
> You can see index.js and function.json using the QueueTrigger1 dropdown list.

This exercise was all about getting our Azure Functions infrastructure in place. We have a working function hosted in a function app that runs when a new message arrives in our queue that we've named [!INCLUDE [input-q](./q-name-input.md)]. The real fun begins in the next exercise when we add code to call an Azure Cognitive Service to do sentiment analysis.