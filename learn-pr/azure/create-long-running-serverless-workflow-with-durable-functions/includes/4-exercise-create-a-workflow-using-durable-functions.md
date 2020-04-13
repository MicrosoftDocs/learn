In this exercise, you'll use the example scenario from the previous unit to learn how to create an approval workflow in the Azure portal using Durable Functions.

## Create a Function App

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Create a resource**.

1. Select **Compute**, and then select **Function App**.

1. Configure the following function app properties on the tabs listed below.

    1. On the **Basics** tab, specify the following options:

        | Property | Suggested value | Description |
        |---|---|---|
        | **Subscription** | _Concierge subscription_ | Specifies the subscription under which this new function app is created. |
        | **Resource Group**| Select **Use existing** and choose _<rgn>[sandbox resource group name]</rgn>_ | Specifies the name of the resource group in which to create your function app. We'll create the function app in the sandbox resource group that was assigned when we activated the sandbox, namely, _<rgn>[sandbox resource group name]</rgn>_. |
	| **Function App name** | _[Globally unique name]_ | Specifies the name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`. |
        | **Publish** | _Code_ | Specifies that the function will use code instead of a container. |
        | **Runtime Stack** | _Node.js_ | Specifies that the sample code in this module is written in JavaScript. |
        | **Version** | _12_ | Specifies the version of the runtime stack. |
        | **Region** | _[Select from the list below]_ | Choose the region closest to you that is also one of the allowed *Sandbox regions* listed below. |

        **Sandbox regions**

        [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

    1. On the **Hosting** tab, specify the following options:

        | Property | Suggested value | Description |
        |---|---|---|
        | **Storage account** | _[Globally unique name]_ | Specifies the name of the new storage account used by your function app. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only. This dialog populates the field with a unique name that is derived from the name you gave the app. However, feel free to use a different name or even an existing account. |
	| **Operating system** | _Windows_ | Specifies the operating system that hosts the function app. |
        | **Plan type** | _Consumption (Serverless)_ | Specifies the hosting plan that defines how resources are allocated to your function app. In the default **Consumption** plan, resources are added dynamically as required by your functions. In this serverless hosting model, you only pay for the time your functions run. |

    1. On the **Monitoring** tab, specify the following option:

        | Property | Suggested value | Description |
        |---|---|---|
        | **Enable Application Insights** | _No_ | Specifies that Application Insights will be disabled for this module. |

1. Click **Review + create** and review the options that you configured. If you are satisfied with your options, click **Create** to provision and deploy the function app.

1. Wait for the deployment to complete before continuing. This might take a few minutes.

## Install the durable-functions npm package 

Since we are creating JavaScript Durable Functions, we need to install the `durable-functions` npm package. To do so, use the following steps.

1. On the Azure portal menu or from the **Home** page, select **All resources**, and then select your function app.

1. Click the **Platform Features** tab.

1. On the **Platform Features** tab, under **Development Tools**, click **Advanced tools (Kudu)**.

    This action starts the Kudu console. You can use this console to access the web server that hosts your functions, and write the code for your functions.

1. In the top menu of the Kudu console, select **Debug console**, then click **CMD**. 

    A command prompt appears. This command prompt window is running on the web server. Additionally, the console should display the directory structure of the function app. An Explorer window also appears above the command line, showing the folder and file hierarchy on the web server.

1. In the Explorer window, navigate to the **site** folder, and then select the **wwwroot** folder.

1. Click the **+** icon next to **wwwroot**, then select **New file**.

    1. Name the file _package.json_, then click the **Edit** icon to open the file in the editor.

    1. Enter the following JSON code, replacing the value for `name` with the globally unique name that you specified for you **Function App name** earlier.

        ```json
        {
          "name": "example",
          "version": "1.0.0"
        }
        ````

    1. Click **Save**.

1. In the command prompt window, verify that you are in the **D:\home\site\wwwroot** folder, then run the following command:

    ```command-prompt
    npm install durable-functions
    ```

    This command instructs the node package manager to install the durable-functions package and any dependencies that are required. This may take a few minutes to complete, and the node package manager may display some warnings, which you can ignore.

1. Wait until all packages have finished installing, then close the Kudu window and return to the Function App page in the Azure portal.

1. Click the **Overview** tab, then click **Restart**. Wait for the restart to complete before continuing.

## Create the client function for submitting a design proposal

1. Expand your function app and select the **+** button next to **Functions**.

1. In the **Azure Functions for JavaScript - getting started** page, select **In-portal**, and then select **Continue**.

1. Select **More templates**, and then select **Finish and view templates**.

1. Select the **Durable Functions HTTP starter** template. This template creates a durable function that runs in response to an HTTP request.

1. Name the function **HttpStart**, and then click **Create**.

1. When the function is created, the code for the **index.js** file appears in the editor. Your file should resemble the following example:

    ```javascript
    const df = require("durable-functions");

    module.exports = async function (context, req) {
        const client = df.getClient(context);
        const instanceId = await client.startNew(req.params.functionName, undefined, req.body);

        context.log(`Started orchestration with ID = '${instanceId}'.`);

        return client.createCheckStatusResponse(context.bindingData.req, instanceId);
    };
    ```

    The JavaScript code in this file runs when the user visits the web site hosting the function. It invokes an orchestration function (which you'll define shortly).

1. In the right-hand panel, select **View Files**. You might have to scroll horizontally to the right in order to see this menu. 

1. Select **function.json** to view the bindings associated with your new function. This information specifies any authentication requirements, together with the HTTP methods that can trigger the function. This file also specifies that the function is a client that starts the orchestration process. Your file should resemble the following example:

    ```json
    {
        "bindings": [
            {
                "authLevel": "anonymous",
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
        ],
        "disabled": false
    }
    ```

    > [!NOTE]
    > A binding associates resources and other items with a trigger. It is a declarative mechanism that removes the need to hard-code references to other services and functions in your code.

2. Select **Save** to save your new client function. 

## Create the orchestrator function

1. Expand your function app and select the **+** button next to **Functions**.

1. Select the **Durable Functions orchestrator** template. This template creates a durable function that orchestrates the execution of functions.

1. Name the new function **OrchFunction**, and then select **Create**.

1. When the function is created, the **index.js** file appears in the editor for this function. Replace the existing code with the following code:

    ```JavaScript
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

1. Expand your function app and select the **+** button next to **Functions**.

1. Select the **Durable Functions activity** template.

1. Name the function **Approval**, and then select **Create**.

1. Replace the existing code in the **index.js** field with the following code:

    ```javascript
    module.exports = async function (context) {
        return `Your project design proposal has been -  ${context.bindings.name}!`;
    };
    ```

    This function returns a message indicating the status of the proposal. The expression `context.bindings.name` will either be `Accepted` or `Rejected`, depending on the parameter passed to the function from the orchestrator. In a real world scenario, you would add the logic that handles the accept or reject operations in this function.

1. Select **Save** to save your new function. 

## Enable Azure Functions version 2 compatibility mode

JavaScript Durable Functions currently require Azure Functions version 2 compatibility to be enabled. To do so, use the following steps.

1. In the **Function Apps** pane, click the name of your function app.

1. On the **Platform Features** tab, under **General Settings**, click **Configuration**.

1. Select the **Function runtime settings** tab.

1. Change the **Runtime version** to **~2**.

1. Select **Save** to persist the change.

## Verify that the durable functions workflow starts

1. In the **Function Apps** pane, navigate to your **HttpStart** function.

1. Click **</> Get function URL**, and copy the URL. Your URL should resemble the following example:

    ```
    https://example.azurewebsites.net/api/orchestrators/{functionName}?code=AbCdEfGhIjKlMnOpQrStUvWxYz==
    ```

    You'll use this URL to run the **HttpStart** function.

1. Open a new browser window and navigate to the URL that you copied. In the URL, replace the **{functionName}** placeholder with **OrchFunction**

   The response message contains a set of URI endpoints that you can use to monitor and manage the execution, which should resemble the following example:

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

1. Copy the **statusQueryGetUri** value, and use the web browser to navigate to this URL. You should see a response message that resembles the following example:

    ```json
    {
      "instanceId": "f0e1d2c3b4a5968778695a4b3c2d1e0f",
      "runtimeStatus": "Completed",
      "input": null,
      "customStatus": null,
      "output": ["Your project design proposal has been -  Approved!", "Your project design proposal has been -  Rejected!"],
      "createdTime": "2019-04-16T15:23:03Z",
      "lastUpdatedTime": "2019-04-16T15:23:35Z"
    }
    ```

    Recall that the orchestration function runs the activity function twice. The first time, the activity function indicates that the project proposal has been accepted. The second time, the proposal is rejected. The messages from both function calls are combined by the orchestration function and returned to the client function.
