In this exercise, you'll use the example scenario from the previous unit to learn how to create an approval workflow in the Azure portal using Durable Functions.

## Create a Function App

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. In the left menu pane, select **Compute**, and then select **Function App**. The **Create Function App** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Project Details** |
    | **Subscription** | _Concierge subscription_ | Specifies the subscription under which this new function app is created. |
    | **Resource Group**| _<rgn>[sandbox resource group name]</rgn>_ | Specifies the name of the resource group in which to create your function app. We'll create the function app in the sandbox resource group that was assigned when we activated the sandbox, namely, _<rgn>[sandbox resource group name]</rgn>_. |
    | **Instance Details** |
    | **Function App name** | _[Globally unique name]_ | Specifies the name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. |
    | **Publish** | _Code_ | Specifies that the function will use code instead of a container. |
    | **Runtime stack** | _Node.js_ | Specifies that the sample code in this module is written in JavaScript. |
    | **Version** | _12 LTS_ | Specifies the version of the runtime stack. |
    | **Region** | _[Select from the list below]_ | Choose the region closest to you that is also one of the allowed *Sandbox regions* listed below. |

    **Sandbox regions**

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Next : Hosting**.

1. On the **Hosting** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Storage** |
    | **Storage account** | _[Globally unique name]_ | Specifies the name of the new storage account used by your function app (which does not need to match the globally unique name that you specified for your function). Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only. This dialog automatically populates the field with a unique name that is dynamically generated. However, feel free to use a different name or even an existing account. |
    | **Operating system** |
    | **Operating System** | _Windows_ | Specifies the operating system that hosts the function app. |
    | **Plan** |
    | **Plan type** | _Consumption (Serverless)_ | Specifies the hosting plan that defines how resources are allocated to your function app. In the default **Consumption** plan, resources are added dynamically as required by your functions. In this serverless hosting model, you only pay for the time your functions run. |

1. Select **Next : Monitoring**.

1. On the **Monitoring** tab, enter the following values for each setting.

    | Setting | Value | Description |
    |---|---|---|
    | **Application Insights** |
    | **Enable Application Insights** | _No_ | Specifies that Application Insights will be disabled for this module. |

1. Select **Review + create** and review the options that you configured. If you're satisfied with your options, select **Create** to provision and deploy the function app.

1. Wait for the deployment to complete before continuing. This might take a few minutes.

## Install the durable-functions npm package

Because we are creating JavaScript Durable Functions, we need to install the `durable-functions` npm package. To do so, perform the following steps.

1. Select **Go to resource** to select your function app.

1. In the left menu pane, under **Development Tools**, select **App Service Editor**.

1. When the App Service Editor opens in a new browser window or tab, highlight the **wwwroot** folder.

1. In the left menu, select **Open Console**.

    This action starts the console. You can use this console to access the web server that hosts your functions, and write the code for your functions.

1. Create a new _package.json_ file.

    1. Run the following commands in the console to create the new JSON file and open it in the editor.

        ```bash
        touch package.json
        open package.json
        ```

    1. Add the following code.

        ```json
        {
          "name": "example",
          "version": "1.0.0"
        }
        ```

        Where `example` should be replaced with the name of your package. For example, you could use the globally unique name that you specified for your function earlier.

    1. Select <kbd>Ctrl+S</kbd> to save the file, then <kbd>Ctrl+Q</kbd> to close the document.

<<<<<<< HEAD
1. In the console window, run the following command.
=======
1. Switch back to **Azure**. In **Development Tools** on the left-hand menu, open **Console**, enter the following command:
>>>>>>> 183054ec6cb80ee2cd232eaa37e39841ff7527cb

    ```bash
    npm install durable-functions
    ```

    This command instructs the node package manager to install the durable-functions package and any dependencies that are required. This may take a few minutes to complete, and the node package manager may display some warnings, which you can ignore.

1. Wait until all packages have finished installing.

1. Select **Overview**, then select **Restart**, and then select **Yes** when prompted to restart. Wait for the restart to complete before continuing.

## Create the client function for submitting a design proposal

<<<<<<< HEAD
1. On the Azure portal menu or from the **Home** page, select **All resources**, and then select your function app.

1. In the Azure portal, under **Functions**, select **Functions**, and then select **Add**.
=======
1. On the left menu, under **Functions**, click **Functions**, and then click **+ Add**.
>>>>>>> 183054ec6cb80ee2cd232eaa37e39841ff7527cb

1. Select the **Durable Functions HTTP starter** template. This template creates a durable function that runs in response to an HTTP request.

1. Name the function **HttpStart**, select **Function** authorization level, and then select **Add**.

1. When the function is created, select **Code + Test**, and the code for the **index.js** file appears in the editor. Your file should resemble the following example.

    ```javascript
    const df = require("durable-functions");

    module.exports = async function (context, req) {
        const client = df.getClient(context);
        const instanceId = await client.startNew(req.params.functionName, undefined, req.body);

        context.log(`Started orchestration with ID = '${instanceId}'.`);

        return client.createCheckStatusResponse(context.bindingData.req, instanceId);
    };
    ```

1. In the dropdown list for the files in your function, select **function.json** to view the bindings associated with your new function. This information specifies any authentication requirements, together with the HTTP methods that can trigger the function. This file also specifies that the function is a client that starts the orchestration process. Your file should resemble the following example.

    ```json
    {
      "bindings": [
        {
          "authLevel": "function",
          "name": "req",
          "type": "httpTrigger",
          "direction": "in",
          "route": "orchestrators/{functionName}",
          "methods": [
            "post",
            "get"
          ]
        },
        {
          "name": "$return",
          "type": "http",
          "direction": "out"
        },
        {
          "name": "starter",
          "type": "orchestrationClient",
          "direction": "in"
        }
      ]
    }
    ```

    > [!NOTE]
    > A binding associates resources and other items with a trigger. It is a declarative mechanism that removes the need to hard-code references to other services and functions in your code.

## Create the orchestrator function

1. On the Azure portal menu or from the **Home** page, select **All resources**, and then select your function app.

1. In the Azure portal, under **Functions**, select **Functions**, and then select **Add**.

1. Select the **Durable Functions orchestrator** template. This template creates a durable function that orchestrates the execution of functions.

1. Name the new function **OrchFunction**, and then select **Add**.

1. When the function is created, select **Code + Test**, and the code for the **index.js** file appears in the editor. Replace the existing code with the following code.

    ```javascript
    const df = require("durable-functions");

    module.exports = df.orchestrator(function* (context) {
        const outputs = [];

        /*
        * We will call the approval activity with a reject and an approved to simulate both
        */

        outputs.push(yield context.df.callActivity("Approval", "Approved"));
        outputs.push(yield context.df.callActivity("Approval", "Rejected"));

        return outputs;
    });
    ```

    This code calls an Activity function named **Approval**, which you'll create shortly. The code in the orchestrator function invokes the **Approval** function twice. The first time simulates accepting the proposal, and the second time tests the proposal rejection logic.

    The value returned by each call is combined together, and passed back to the client function. In a production environment, your orchestration function would call a series of activity functions that make the accept/reject decision, and return the result of these activities.

1. Select **Save** to save your new function.

## Create the activity function

1. On the Azure portal menu or from the **Home** page, select **All resources**, and then select your function app.

1. In the Azure portal, under **Functions**, select **Functions**, and then select **Add**.

1. Select the **Durable Functions activity** template. This template creates a durable function that is run when an Activity is called by an orchestrator function.

1. Name the function **Approval**, and then select **Add**.

1. When the function is created, select **Code + Test**, and the code for the **index.js** file appears in the editor. Replace the existing code with the following code.

    ```javascript
    module.exports = async function (context) {
        return `Your project design proposal has been -  ${context.bindings.name}!`;
    };
    ```

    This function returns a message indicating the status of the proposal. The expression `context.bindings.name` will either be `Accepted` or `Rejected`, depending on the parameter passed to the function from the orchestrator. In a real world scenario, you would add the logic that handles the accept or reject operations in this function.

1. Select **Save** to save your new function.

<!--

## Enable Azure Functions version 2 compatibility mode

JavaScript Durable Functions currently require Azure Functions version 2 compatibility to be enabled. To do so, use the following steps.

1. In the **Function Apps** pane, select the name of your function app.

1. On the **Platform Features** tab, under **General Settings**, select **Configuration**.

1. Select the **Function runtime settings** tab.

1. Change the **Runtime version** to **~2**.

1. Select **Save** to persist the change.

-->

## Verify that the durable functions workflow starts

1. On the Azure portal menu or from the **Home** page, select **All resources**, and then select your function app.

1. In the Azure portal, under **Functions**, select **Functions**, and then select your **HttpStart** function.

1. Select **Get Function URL**, and copy the URL. Your URL should resemble the following example.

    ```
    https://example.azurewebsites.net/api/orchestrators/{functionName}?code=AbCdEfGhIjKlMnOpQrStUvWxYz==
    ```

    You'll use this URL to run your functions.

1. Open a new browser window and navigate to the URL that you copied. In the URL, replace the **{functionName}** placeholder with **OrchFunction**, which should resemble the following example.

    ```
    https://example.azurewebsites.net/api/orchestrators/OrchFunction?code=AbCdEfGhIjKlMnOpQrStUvWxYz==
    ```

   The response message contains a set of URI endpoints that you can use to monitor and manage the execution, which should resemble the following example.

    ```json
    {
      "id": "f0e1d2c3b4a5968778695a4b3c2d1e0f",
      "statusQueryGetUri": "https://example.azurewebsites.net/...",
      "sendEventPostUri": "https://example.azurewebsites.net/...",
      "terminatePostUri": "https://example.azurewebsites.net/...",
      "rewindPostUri": "https://example.azurewebsites.net/...",
      "purgeHistoryDeleteUri": "https://example.azurewebsites.net/..."
    }
    ```

1. Copy the **statusQueryGetUri** value, and use your web browser to navigate to this URL. You should see a response message that resembles the following example.

    ```json
    {
      "name": "OrchFunction",
      "instanceId": "f0e1d2c3b4a5968778695a4b3c2d1e0f",
      "runtimeStatus": "Completed",
      "input": null,
      "customStatus": null,
      "output": [
        "Your project design proposal has been -  Approved!",
        "Your project design proposal has been -  Rejected!"
      ],
      "createdTime": "2019-04-16T15:23:03Z",
      "lastUpdatedTime": "2019-04-16T15:23:35Z"
    }
    ```

    Recall that the orchestration function runs the activity function twice. The first time, the activity function indicates that the project proposal has been accepted. The second time, the proposal is rejected. The messages from both function calls are combined by the orchestration function and returned to the client function.
