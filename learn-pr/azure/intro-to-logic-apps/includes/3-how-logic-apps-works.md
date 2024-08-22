Now that we know the basics of Azure Logic Apps, let's see how the service works behind the scenes. This information helps you decide whether Azure Logic Apps can work for you without any customization. That way, in scenarios where you do need to create custom components, you can determine how difficult that might be.

## What is a connector?

A *connector* is a component that provides an interface to a service or system in the form of *operations*. For example, the X connector lets you send and retrieve tweets, while the Office 365 Outlook connector lets you manage your email, calendar, and contacts. Azure Logic Apps provides 1000+ prebuilt connectors that you can use to create your workflows.

A connector uses a service's REST or SOAP API to do the actual work. When you use a connector in your logic app workflow, the connector calls the service's underlying API for you. So, a connector is basically a wrapper around an API.

The following illustration shows the X connector and the use of the X REST API.

:::image type="content" source="../media/x-connector.png" alt-text="Diagram shows the X connector calling methods in the X API." lightbox="../media/x-connector.png":::

## Custom connectors

You can write custom connectors to access services that don't have prebuilt connectors. These services must have a REST or SOAP API, which isn't surprising because a connector is just a wrapper around an API.

To create a custom connector, you first generate an OpenAPI description for the API. You then use that API description to create a custom connector resource in the Azure portal. You can give your connector a name, an icon, and a description for each operation. The following illustration shows an example of the process. Notice that there's no coding involved.

:::image type="content" source="../media/custom-connector.png" alt-text="Diagram shows the steps to create a custom connector for a service that has a REST API." lightbox="../media/custom-connector.png":::

You can use your custom connector in your own logic app workflows and share with other people in your organization. You can also submit your connector to Microsoft for certification. After your connector is certified, it appears in the connector gallery that's available to all users.

## What are triggers and actions?

Workflows are built from different types of tasks. For example, in our social media monitoring scenario, the workflow starts when a new tweet is posted. The workflow then analyzes the sentiment and makes a decision, based on the sentiment score. Azure Logic Apps uses the terms *trigger*, *action*, and *control action* for these concepts. These operations are the building blocks for a workflow in Azure Logic Apps. The following diagram shows how to use each type of operation in the social media monitoring app.

:::image type="content" source="../media/social-media-step-types.png" alt-text="Diagram shows flowchart for shoe company social media monitoring process. Each step is labeled as a trigger, action, or control action." lightbox="../media/social-media-step-types.png":::

Let's get more specific about the definitions for a trigger and an action:

- A *trigger* is an event that happens when a specific condition is met. Triggers automatically activate or *fire* when the condition is satisfied. For example, when a timer expires or data becomes available.

- An *action* executes a specific task in your workflow. Actions run after a trigger activates or another action completes.

A connector is the container for all related triggers and actions. Let's look at a few examples.

The X connector lets your logic app workflow interact with the X service. The social media monitoring app can use a trigger from the X connector to determine when new relevant tweets are available. The following diagram shows the X connector with its trigger and actions:

:::image type="content" source="../media/x-connector-details.png" alt-text="Diagram shows the X connector with a trigger that notifies you about new tweets and with actions that can send tweets and manage your account." lightbox="../media/x-connector-details.png":::

Next, we have the Dropbox connector. Suppose you're working with a small team on a project that stores shared data in Dropbox. You can build a workflow that detects when someone changes any files and sends a notification to the other team members. The following diagram shows the Dropbox connector with its triggers and actions:

:::image type="content" source="../media/dropbox-connector-details.png" alt-text="Diagram shows the Dropbox connector with triggers that notify you when files are created or modified and with actions to manage files." lightbox="../media/dropbox-connector-details.png":::

Finally, let's look at the Twilio connector. Most connectors offer both triggers and actions, but this connector only has actions. The Twilio connector lets you send text messages for notifications. For example, you can use the Twiliio connector in the Dropbox scenario to message team members when a shared file changed. The following diagram shows the Twilio connector with its actions:

:::image type="content" source="../media/twilio-connector-details.png" alt-text="Diagram shows the Twilio connector with actions that send and retrieve text messages, but no triggers." lightbox="../media/twilio-connector-details.png":::

## How to build workflows from triggers and actions

To build a workflow, you choose operations, specifically, a trigger and actions. A workflow must start with a trigger. You can then follow the trigger with as many actions as you need to implement your workflow. The following diagram shows the trigger and actions used in the social media monitoring app:

:::image type="content" source="../media/social-media-connectors.png" alt-text="Diagram shows the trigger and actions in the social media monitoring app. Each operation shows the associated external service.":::

## How do triggers and actions work together?

Triggers and actions are essentially calls to an underlying API operation. Each operation has inputs and outputs. For example, the X trigger named **When a new tweet is posted** takes in a search string and returns the tweets that contain that string. The Text Analytics action named **Detect sentiment** action takes a string as input and returns the sentiment score as a floating-point number. The following diagram shows these two operations:

:::image type="content" source="../media/inputs-and-outputs.png" alt-text="Diagram shows the input and output for the trigger named When a new tweet is posted and action named Detect sentiment." lightbox="../media/inputs-and-outputs.png":::

Azure Logic Apps automatically makes the return values available to all subsequent operations in the workflow. This feature lets you pass the results from one operation as input to the next operation. The following diagram shows the data flow for the first two operations in the social media monitoring app:

:::image type="content" source="../media/data-flow.png" alt-text="Diagram shows how results from all preceding operations are available to all later workflow steps." lightbox="../media/data-flow.png":::

## What are control actions?

Most workflows need to run different actions, based on the data that's processed. For example, a workflow might route an expense report to a different manager, based on the expense amount. In the social media monitoring app, the workflow needs to branch, based on a tweet's sentiment score. The following diagram shows the flowchart for the social media monitoring app and highlights the control logic:

:::image type="content" source="../media/social-media-monitor-control-logic.png" alt-text="Diagram shows the branches based on tweet sentiment in the social media monitoring app." lightbox="../media/social-media-monitor-control-logic.png":::

*Control actions* are special actions built-in to Azure Logic Apps that provides these control constructs:

- *Condition* action controlled by a Boolean expression.
- *Switch* action.
- *For each* and *until* loops.
- Unconditional *branch* instructions.

The following diagram shows how to use the *condition* action in the workflow for the social media monitoring app:

:::image type="content" source="../media/social-media-monitor-control-action.png" alt-text="Diagram shows the social media monitoring workflow with the built-in control action that chooses branches, based on tweet sentiment." lightbox="../media/social-media-monitor-control-action.png":::

## What is the workflow designer?

The workflow designer is a graphical tool for creating your workflows. The designer provides a canvas surface where you build a workflow by adding a trigger and actions. For example, the social media monitoring app uses the trigger named **When a new tweet is posted**, a control action known as a *condition*, and actions named **Detect sentiment**, **Insert row**, and **Send an email**. The following screenshot shows the social media monitoring workflow in the designer:

:::image type="content" source="../media/social-media-complete-designer.png" alt-text="Screenshot shows the social media monitoring app in the workflow designer." lightbox="../media/social-media-complete-designer.png":::
