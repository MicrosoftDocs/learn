In this unit, using the example from the previous unit, you'll learn how to create an approval workflow in the Azure portal using  Durable Functions.

## Create a Function App

[!include[](../../../includes/azure-sandbox-activate.md)]

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account with which you activated the sandbox.

1. Select the **Create a resource** button found on the upper left-hand corner of the Azure portal.

1. Select **Compute**, and then select **Function App**.

1. Set the function app properties as follows:


    | Property     | Suggested value  | Description  |
    |--------------|------------------|--------------|
    | **App name** | Globally unique name | Name that identifies your new function app. Valid characters are `a-z`, `0-9`, and `-`.  |
    | **Subscription** | Concierge subscription| The subscription under which this new function app is created. |
    | **Resource Group**|  Select **Use existing** and choose _<rgn>[sandbox resource group name]</rgn>_ | Name of the resource group in which to create your function app. We'll create the function app in the sandbox resource group that was assigned when we activated the sandbox, namely, _<rgn>[sandbox resource group name]</rgn>_.|
    | **OS** | Windows | The operating system that hosts the function app.  |
    | **Hosting Plan** |   Consumption plan | Hosting plan that defines how resources are allocated to your function app. In the default **Consumption Plan**, resources are added dynamically as required by your functions. In this serverless hosting model, you only pay for the time your functions run.   |
    | **Location** | Select from the list | Choose the nearest one to you that is also one of the allowed *Sandbox regions* listed below. |
    | **Runtime Stack** | Node.js | The sample code in this module is written in JavaScript.  |
    | **Storage** |  Globally unique name |  Name of the new storage account used by your function app. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only. This dialog populates the field with a unique name that is derived from the name you gave the app. However, feel free to use a different name or even an existing account. |

    ### Sandbox regions

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Create** to provision and deploy the function app. 
1. Wait for the process to complete before continuing.

## Install the durable-functions npm package 

Since we are creating JavaScript Durable Functions, we need to install the `durable-functions` npm package using the following instructions. 


1. In the left-hand navigation pane of the Azure portal, select **All resources**, and then select your function app.

1. Click **Platform Features**.

1. On the **Platform Features** tab, under **Development Tools**, select **Advanced tools (Kudu)**.

    This action starts the Kudu console. You can use this console to access the web server that hosts your functions, and write the code for your functions.

1. In the top menu of the Kudu console, select **Debug console -> CMD**. 

    A command prompt appears. This command prompt window is running on the web server. Additionally, the console should display the directory structure of the function app. An Explorer window also appears above the command line, showing the folder and file hierarchy on the web server.

1. In the Explorer window, navigate to the **site** folder, and then select the ***wwwroot** folder.

1. In the command prompt window, make sure you are in the folder **D:\home\site\wwwroot**. Run the following command:

    ```command-prompt
    npm install durable-functions
    ```

    This command installs the durable-functions package (and any required supporting packages). This may take a few minutes to complete and will display some warnings, which can be ignored.

1. Installing the durable-functions package and its dependencies takes a couple of minutes. Wait until all packages have finished installing. You can ignore any warnings that appear from the node package manager.

1. Close the Kudu window and return to the Function App page in the Azure portal.
1. In the **Overview** pane of the function app, select **Restart** and wait for restart to complete. 

## Create the client function for submitting a design proposal

1. Expand your function app and select the **+** button next to **Functions**.

1. In the **Azure Functions for JavaScript - getting started** page, select **In-portal**, and then select **Continue**.

1. Select **More templates**, and then select **Finish and view templates**.

1. In the search field, type  **durable**, and then select the **Durable Functions HTTP starter** template. This template creates a durable function that runs in response to an HTTP request

1. In the **Extensions not Installed** window, select **Install** to install the Azure DurableTask extension and any other dependencies in the function app. You only need to install the extension once per function app. 
1. Installation of the DurableTask extension takes a while. When the installation has completed, select **Continue**.

1. Name the function **HttpStart**, and then click **Create**.

1. When the function is created, the code for the **index.js** file appears in the editor. The JavaScript code in this file runs when the user visits the web site hosting the function. It invokes an orchestration function (which you'll define shortly). The code in the file should look like this:

    ```javascript
    const df = require("durable-functions");

    module.exports = async function (context, req) {
        const client = df.getClient(context);
        const instanceId = await client.startNew(req.params.functionName, undefined, req.body);

        context.log(`Started orchestration with ID = '${instanceId}'.`);

        return client.createCheckStatusResponse(context.bindingData.req, instanceId);
    };
    ```

1. In the right-hand panel, select **View Files**. You might have to scroll horizontally to the right in order to see this menu. 

1. Select **function.json** to view the bindings associated with your new function. This information specifies any authentication requirements, together with the HTTP methods that can trigger the function. This file also specifies that the function is a client that starts the orchestration process. The file should look like this:

    > [!NOTE]
    > A binding associates resources and other items with a trigger. It is a declarative mechanism that removes the need to hard-code references to other services and functions in your code.

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

2. Select **Save** to save your new client function. 

## Create the orchestration function

1. Expand your function app and select the **+** button next to **Functions**.

1. In the search field, type  **durable**, and then select the **Durable Functions orchestrator** template.

1. Name the new function **OrchFunction**, and then select **Create**.

1. When the function is created, the **index.js** file appears in the editor for this function. Replace this code with the code in the following snippet. This code calls an Activity function named **Approval**. You'll add this function shortly. The code in the orchestrator function invokes the **Approval** function twice; the first time simulates accepting the proposal, and the second time tests the proposal rejection logic. The value returned by each call is combined together, and passed back to the client function. In a production environment, your orchestration function would call a series of activity functions that make the accept/reject decision, and return the result of these activities.

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

1. Select **Save** to save your new function. 

## Create the activity function

1. Click the **+** button next to **Functions**.

1. In the search field, type  **durable**, and then select the **Durable Functions activity** template.

1. Name the function **Approval**, and then select **Create**.

1. Replace the code in the **index.js** field for this new function with the code in the following snippet. The function returns a message indicating the status of the proposal. The expression `context.bindings.name` will either be `Accepted` or `Rejected`, depending on the parameter passed to the function from the orchestrator. In the real world, you would add logic that handles the accept or reject operations here:

    ```javascript
    module.exports = async function (context) {
        return `Your project design proposal has been -  ${context.bindings.name}!`;
    };
    ```

1. Select **Save** to save your new function. 

## Verify that the durable functions workflow starts

1. Return to the **HttpStart** function.

1. Click **</> Get function URL**, and copy the URL.

   You use this URL to run the **HttpStart** function.

1. Open a new browser window and navigate to the URL that you copied. In the URL, replace the text **{functionName}** with **OrchFunction**

   The response message contains a set of URI endpoints that you can use to monitor and manage the execution, which looks like the following example:

    ```json
    {  
        "id":"10585834a930427195479de25e0b952d",
        "statusQueryGetUri":"https://...",
        "sendEventPostUri":"https://...",
        "terminatePostUri":"https://...",
        "rewindPostUri":"https://...",
        "purgeHistoryDeleteUri":"https://..."
    }
    ```

1. Copy the **statusQueryGetUri** value, and use the web browser to navigate to this URL.

    You should see a response message that looks like this:

    ```json
    {"instanceId":"53f220433d6640fcbe006ca5b04fdf89","runtimeStatus":"Completed","input":null,"customStatus":null,"output":["Your project design proposal has been -  Approved!","Your project design proposal has been -  Rejected!"],"createdTime":"2019-04-16T15:23:03Z","lastUpdatedTime":"2019-04-16T15:23:35Z"}
    ```

    Recall that the orchestration function runs the activity function twice. The first time, the activity function indicates that the project proposal has been accepted. The second time, the proposal is rejected. The messages from both function calls are combined by the orchestration function and returned to the client function.