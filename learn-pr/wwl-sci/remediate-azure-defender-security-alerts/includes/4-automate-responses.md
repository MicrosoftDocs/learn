Every security program includes multiple workflows for incident response. These processes might include notifying relevant stakeholders, launching a change management process, and applying specific remediation steps. Security experts recommend that you automate as many steps of those procedures as you can. Automation reduces overhead. It can also improve your security by ensuring the process steps are done quickly, consistently, and according to your predefined requirements.

This feature can trigger Logic Apps on security alerts and recommendations. For example, you might want Security Center to email a specific user when an alert occurs.

## Create a Logic App and define when it should automatically run

From Security Center's sidebar, select Workflow automation.

From this page, you can create new automation rules as well as enable, disable, or delete existing ones.

To define a new workflow, select Add workflow automation.

A pane appears with the options for your new automation. Here you can enter:

- A name and description for the automation.

- The triggers that will initiate this automatic workflow. For example, you might want your Logic App to run when a security alert that contains "SQL" is generated.

- The Logic App that will run when your trigger conditions are met.

![Add a workflow](../media/add-workflow.png)

From the Actions section, select Create a new one to begin the Logic App creation process.

You'll be taken to Azure Logic Apps.

- Enter a name, resource group, and location, and select Create.

- In your new logic app, you can choose from built-in, predefined templates from the security category. Or you can define a custom flow of events to occur when this process is triggered.

The logic app designer supports the following Security Center triggers:

- When an Azure Security Center Recommendation is created or triggered - If your logic app relies on a recommendation that gets deprecated or replaced, your automation will stop working. You'll then need to update the trigger. To track changes to recommendations, see Azure Security Center release notes.

- When an Azure Security Center Alert is created or triggered - You can customize the trigger so that it relates only to alerts with the severity levels that interest you.

![sample logic app](../media/sample-logic-app.png)

After you've defined your logic app, return to the workflow automation definition pane ("Add workflow automation"). Click Refresh to ensure your new Logic App is available for selection.

Select your logic app and save the automation. The Logic App dropdown only shows Logic Apps with supporting Security Center connectors mentioned above.

## Manually trigger a Logic App

You can also run Logic Apps manually when viewing any security alert or recommendation.

To manually run a Logic App, open an alert or a recommendation and select Trigger Logic App

