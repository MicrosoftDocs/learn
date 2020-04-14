The company has asked you to amend your new workflow to incorporate an escalation step to take action if a project design proposal isn't approved in a timely fashion.

In this exercise, you'll add a timer to control timeout during the execution of your workflow. You'll also learn how to use the timeout to control which execution path the workflow takes.

## Add moment npm package to your function app

Before changing our workflow, we'll add the **moment** npm package to our function app through the Kudo console. 

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account that you used to activate the sandbox.

1. Navigate to the function app that you created in the previous exercise.

1. Select your function app's name, click **Platform Features**, and then select **Advanced tools (Kudu)**.

1. In the top menu of the Kudu console, select **Debug console**, then click **CMD**. 

1. In the Explorer window, navigate to the **site** folder, and then select the **wwwroot** folder.

1. In the command prompt window, run the following command:

    ```command-prompt
    npm install moment
    ```

    This command installs the **moment.js** library, which contains date/time functions that you can use with durable functions. This may take a few seconds to complete, and the node package manager may display some warnings that you can ignore.

1. Wait until all packages have finished installing, then close the Kudu window and return to the Function App page in the Azure portal.

## Add an escalation activity to your function app

1. Expand your function app and select the **+** button next to **Functions**.

1. Select the **Durable Functions activity** template.

1. Name the function **Escalation**, and then select **Create**.

1. When the function has been created, replace the code in **index.js** for this function with the following example:

    ``` javascript
    module.exports = async function (context) {
        return `ESCALATION : You have not approved the project design proposal - reassigning to your Manager!  ${context.bindings.name}!`;
    };
    ```

    This code returns a message indicating that the workflow has been escalated. In a production system, this function would contain the logic to remind the recipient, or reassign the task.

1. Select **Save** to save your new function.

## Update the orchestration function to use the escalation function

1. In your function app, select the orchestration function that you created in the previous exercise, which you named **OrchFunction**.

1. In the **index.js** code file, add a reference to the **moment** library

    ```javascript
    const moment = require("moment");
    ```

1. Replace the body of the function with the following code, which will test whether the deadline for approval has passed:

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

    To keep things brief for the purposes of this exercise, if the **Approval** function doesn't respond within 20 seconds, the **Escalation** function is called. The code also changes the call to **Approval** to wait for an external input. This way we can control when the response comes back for testing purposes.

1. Select **Save**.

## Verify that the Durable Functions workflow starts

1. Select the **HttpStart** function you created in the preceding exercise.

1. Select **</> Get function URL**, and copy the URL.

1. Open another browser window and navigate to the URL that you copied, replacing **{functionName}** with **OrchFunction**.

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

1. Copy the **statusQueryGetUri** value, and use the web browser to navigate to this URL. You should see a response message that shows the instance is pending as it is waiting for the timer to countdown to 20 seconds, which should resemble the following example:

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

1. If you wait for 20 seconds and refresh the browser window, the timeout should have been reached and the workflow will call the **Escalate** activity. You'll see a response that should resemble the following example:

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
