The company has asked you to amend your new workflow to incorporate an escalation step to take action if a project design proposal isn't approved in a timely fashion.

In this exercise, you'll add a timer to control timeout during the execution of your workflow. You'll also learn how to use the timeout to control which execution path the workflow takes.

## Add moment npm package to your function app

Before changing our workflow, we'll add the **moment** npm package to our function app through the console.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **All resources**, and then select the function app that you created in the previous exercise. Your **Function App** pane appears.

1. In the left menu bar, under **Development Tools**, select **Console**. The **Console** pane appears for your function app.

1. Verify that the console window opens in the *C:\home\site\wwwroot* folder, then run the following commands to install the libraries that are required for this sample function app.

    1. Run the following command to install the *TypeScript* library, which is a required dependency for static typing.

        ```bash
        npm install typescript
        ```

    1. Run the following command to install the *moment* library, which contains date/time functions that you can use with durable functions.

        ```bash
        npm install moment
        ```

        These commands might take a few seconds to complete, and the node package manager might display some warnings, which you can ignore.

1. Wait until all packages have finished installing, then close the console window.

[//]: # (NOTE: DO NOT LOCALIZE THIS NOTE.)
[//]: # (NOTE: The preceding library installation commands were intentionally split into two separate steps, because copying and pasting the combined commands into the Console window according to the steps in an earlier version of this module did not install the _moment_ library, which made the sample code fail. It took a while to discover the root cause of the problem, and with that in mind, it seemed like a better idea to split the commands so that they are run independently, and therefore less prone to error.)

## Add an escalation activity to your function app

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **All resources**, and then select your function app. Your **Function App** pane appears.

1. Select the **Functions** tab in the center of the screen.

1. In the **Functions** tab menu bar, select **Create**. The **Create function** pane appears.

1. Under **Select a template**, in the **Filter** box, enter *Durable Functions activity* and select that template from the list. This template creates a durable function that is run when an activity is called by an orchestrator function.

1. Under **Template details**, for the **New Function** field, enter *Escalation* for the name of the function, and select **Create**. The **escalation** pane appears for your function.

1. In the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears for your function.

    The code for the **index.js** file appears in the editor.

1. Replace the existing code with the following code:

    ``` javascript
    module.exports = async function (context) {
        return `ESCALATION : You have not approved the project design proposal - reassigning to your Manager!  ${context.bindings.name}!`;
    };
    ```

    This code returns a message indicating that the workflow has been escalated. In a production system, this function would contain the logic to remind the recipient, or reassign the task.

1. In the top menu bar, select **Save** to save your new function.

## Update the orchestration function to use the escalation function

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **All resources**, and then select your function app. Your **Function App** pane appears.

1. Select the **Functions** tab in the center of the screen.

1. Select your **OrchFunction** function that you created in the previous exercise. The **OrchFunction** function pane appears.

1. In the left menu pane, under **Developer**, select **Code + Test**. The **Code + Test** pane appears for your function.

    The code for the **index.js** file appears in the editor.

1. Add the following reference to the **moment** library.

    ```javascript
    const moment = require("moment");
    ```

1. Replace the body of the function with the following code, which will test whether the deadline for approval has passed.

    ```javascript
    module.exports = df.orchestrator(function* (context) {
        const outputs = [];
        const deadline = moment.utc(context.df.currentUtcDateTime).add(20, "s");
        const activityTask = context.df.waitForExternalEvent("Approval");
        const timeoutTask = context.df.createTimer(deadline.toDate());

        const winner = yield context.df.Task.any([activityTask, timeoutTask]);
        if (winner === activityTask) {
            outputs.push(yield context.df.callActivity("Approval", "Approved"));
        }
        else
        {
            outputs.push(yield context.df.callActivity("Escalation", "Head of department"));
        }

        if (!timeoutTask.isCompleted) {
            // All pending timers must be complete or canceled before the function exits.
            timeoutTask.cancel();
        }

        return outputs;
    });
    ```

    To keep things brief for the purposes of this exercise, if the **Approval** function doesn't respond within 20 seconds, the **Escalation** function is called. The code also changes the call to **Approval** to wait for an external input. This way, we can control when the response comes back for testing purposes.

1. In the top menu bar, select **Save**.

## Verify that the Durable Functions workflow starts

1. On the Azure portal menu or from the **Home** page, under **Azure services**, select **All resources**, and then select your function app. Your **Function App** pane appears.

1. On the **Overview** pane, on the top menu bar, select **Restart**, and then select **Yes** when prompted to restart. Wait for the restart to complete before continuing. Your **Function App** pane reappears.

1. Select the **Functions** tab in the center of the screen.

1. Select your **HttpStart** function. The **HttpStart** pane appears.

1. On the top menu bar, select **Get Function Url**, and copy the URL. Your URL should resemble the following example:

    ```text
    https://example.azurewebsites.net/api/orchestrators/{functionName}?code=AbCdEfGhIjKlMnOpQrStUvWxYz==
    ```

    You'll use this URL to run your functions.

1. Open a new browser window, and navigate to the URL that you copied. In the URL, replace the **{functionName}** placeholder with **OrchFunction**, which should resemble the following example:

    ```text
    https://example.azurewebsites.net/api/orchestrators/OrchFunction?code=AbCdEfGhIjKlMnOpQrStUvWxYz==
    ```

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

1. Copy the **statusQueryGetUri** value and use your web browser to navigate to that URL. You should see a response message that shows the status as _Running_ while it's waiting for the timer to count down to 20 seconds, which should resemble the following example:

    ```json
    {
      "name": "OrchFunction",
      "instanceId": "f0e1d2c3b4a5968778695a4b3c2d1e0f",
      "runtimeStatus": "Running",
      "input": null,
      "customStatus": null,
      "output": null,
      "createdTime": "2019-04-14T13:17:26Z",
      "lastUpdatedTime": "2019-04-14T13:17:27Z"
    }
    ```

1. Wait for 20 seconds and refresh the browser window. The timeout will have been reached, and the workflow will call the **Escalate** activity. You'll see a response that should resemble the following example:

    ```json
    {
        "name": "OrchFunction",
        "instanceId": "f0e1d2c3b4a5968778695a4b3c2d1e0f",
        "runtimeStatus": "Completed",
        "input": null,
        "customStatus": null,
        "output": [
            "ESCALATION : You have not approved the project design proposal - reassigning to your Manager!  Head of department!"
        ],
        "createdTime": "2019-04-14T13:43:09Z",
        "lastUpdatedTime": "2019-04-14T13:43:31Z"
    }
    ```
