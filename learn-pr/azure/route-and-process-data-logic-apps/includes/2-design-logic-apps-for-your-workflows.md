Implementing any business process is difficult because you need to make diverse services work together. Think about everything your company uses to store and process data: Salesforce, Office 365, Oracle, Twitter, YouTube, Dropbox, Google services, Azure AI services, and so on. How do you integrate all these products?

Azure Logic Apps gives you hundreds of pre-built connectors that work with various kinds of apps, data, services, and systems plus other components to organize and integrate everything into a workflow. For example, in this athletic shoe company scenario, we want to monitor social media reaction to our new basketball shoe product. We'll build a logic app workflow to integrate Twitter, Azure AI services, SQL Server, and Outlook email.

In this unit, we'll plan the sequence of steps needed to implement a business process. Then we'll map those steps to the components available in Azure Logic Apps. Finally, we'll assemble these pieces into a workflow using the designer in Azure Logic Apps. The following diagram shows an overview of the app development process.

:::image type="content" source="../media/app-design-process.png" alt-text="Diagram showing the typical sequence of activities to create a logic app workflow. The process has five steps. First, plan your business process. Second, identify the type for each step in your process. Third, decide which component will implement each step. Fourth, use the designer to build your workflow from the components. Fifth, save your design. Your logic app workflow will now run automatically in the cloud." border="false":::

The following sections describes each of these five steps in the app development process:

## Plan your business process

The first step to creating a logic app workflow is planning the steps of your business process. In the social media monitoring scenario, the steps are as follows:

- Detect tweets about the product
- Analyze the sentiment
- Store a link to positive tweets
- Email customer service for negative tweets

Typically, you can use a flowchart to capture the steps of the process. The following diagram shows the flowchart for the social media monitoring app.

:::image type="content" source="../media/social-media-monitor-workflow.png" alt-text="Diagram showing a flowchart for the way the fictional shoe company processes tweets written about their product." border="false":::

## Identify the type for each step in your process

The steps in a business process perform different types of operations. Some respond to external events, some process or store data, and others make decisions based on the data. Azure Logic Apps uses the terms *trigger*, *action*, and *control action* for these three categories.

For example, in our social media monitoring scenario, a *trigger* starts the process when a new tweet is posted, an *action* performs a task such as analyzing the sentiment, and a *control action* makes a decision based on the sentiment score. The following diagram shows the type for each step in the social media monitoring app.

:::image type="content" source="../media/social-media-step-types.png" alt-text="Diagram showing the flowchart for the shoe company social media monitoring app. Each step is labeled as a trigger, action, or control action." border="false":::

## Map your steps to components

To decide which pre-built component to implement, we need to be clear about component types. Let's be more formal about the definitions of the component types:

- A *trigger* is an event that occurs when a specific conditions are met. Triggers activate automatically when the conditions are right, for example, when a timer expires or data becomes available. Every workflow must start with a trigger. In our example, we want to trigger the workflow when a new tweet mentions our product.

- An *action* is an operation that runs one of the tasks in your business process. Actions run when a trigger activates or another action completes. Our social media monitoring app has three actions: analyze sentiment, insert database row, and send email.

- *Control actions* are special built-in actions that let you add decisions and loops to your workflow. Our example uses a control action to branch based on the sentiment score.

A *connector* is a group of related triggers and actions. Conceptually, you can think of a connector as a component that lets you access a service or system. For example, the Twitter connector lets you send and receive tweets, while the Microsoft 365 Outlook connector allows you to manage your email, calendar, and contacts. The following diagram shows the Twitter connector and its operations divided into the two categories.

:::image type="content" source="../media/twitter-connector-details.png" alt-text="Diagram showing the triggers and actions available in the Twitter connector." border="false":::

Now, you need to map each task in your flowchart to the triggers and actions available in Azure Logic Apps. The following diagram shows the connectors we'd use in the social media app with the relevant triggers and actions highlighted.

:::image type="content" source="../media/social-media-design-process.png" alt-text="Diagram showing the operations available in the connectors used by the social media monitoring app. Specifically, the connectors are Twitter, Text Analytics, SQL Server, and Office 365 Outlook along with a graphical representation for each control action. The trigger and actions used in the social media monitoring app are highlighted." border="false":::

## Define your workflow with the designer

The designer in Azure Logic Apps is a graphical tool for creating your workflows. You can pick from a gallery of connectors that contain the triggers and actions that you can use in your workflow. You'll use designer to arrange the trigger, actions, and control actions. The following screenshot shows the designer with the completed workflow.

:::image type="content" source="../media/social-media-app-designer-view.png" alt-text="Screenshot showing the workflow designer with the completed social media monitoring app. The workflow starts with the Twitter trigger, which is followed by three actions: detect sentiment, insert row, and send email. A control action determines whether the insert row or send email action executes based on the score of the **Detect sentiment** action." border="false":::

After you save your workflow, your logic app is automatically published live and runs whenever the trigger activates.

## Knowledge check

The questions in this knowledge check relate to the workflows shown in the following diagrams. Each question will ask you to evaluate one of the workflows to find the correct answer.

| Social media workflow | Email attachment processing workflow |
| --- | --- |
| :::image type="content" source="../media/social-media-monitor-logic-app.png" alt-text="Diagram of a social media monitoring workflow. This workflow triggers when a user posts a new tweet that mentions a specific product. The next action sends the text of the tweet through Text Analytics to determine sentiment. If the sentiment score is greater than 0.7, then a row containing the tweet is added to a database. If the tweet is rated less than 0.7, an email will be sent to customer support." border="false"::: | :::image type="content" source="../media/email-workflow.png" alt-text="Diagram of an email attachment processing workflow. This workflow is triggered when a new email arrives. Next, a control action uses an *if* statement to check whether the email has an attachment. If the email doesn't have attachments, the workflow ends. If attachments exist, the workflow creates a blob for the email body. Next, another control action called a *for each* loop creates a blob for every attachment. Finally, an email is sent for review." border="false"::: |
| | |
