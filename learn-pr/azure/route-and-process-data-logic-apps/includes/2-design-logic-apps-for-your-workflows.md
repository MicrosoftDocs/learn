When you implement a business process, you might find this work challenging because you typically need to make diverse services work together. Consider everything that your company uses to receive, store, and process data. For example, you can use Salesforce, Microsoft 365, Oracle, X, YouTube, Dropbox, Google services, Azure AI services, and so on. How do you integrate all these products?

Azure Logic Apps gives you 1,000+ prebuilt connectors to access various cloud services, systems, apps, and data plus other components to organize and integrate everything into a workflow. For example, for the fictional athletic shoe company scenario, suppose you want to monitor the media reaction to athletic shoe launches and other industry news. So, you set out to build a logic app workflow that integrates the **Bing Search** service, Azure Cognitive Services, Azure Storage, and Outlook email.

In this unit, you plan the sequence of steps necessary to implement a business process. You then map these steps to the components available in Azure Logic Apps. Finally, you put these pieces together by building a workflow using the designer in Azure Logic Apps. The following diagram shows an overview for the app development process:

:::image type="content" source="../media/app-design-process.png" alt-text="Diagram shows typical sequence of activities to create a logic app workflow." border="false":::

The following sections describe each step in the app development process:

## Plan your business process

The first step to creating a logic app workflow is planning the steps of your business process. For the news media monitoring scenario, here are the steps:

- Find news articles about the athletic shoe market.
- Analyze the sentiment.
- Store links to positive articles for marketing to review.
- Email PR about negative news articles.

Typically, you use a flowchart to capture and organize these steps. The following diagram shows the flowchart for the news media monitoring app:

:::image type="content" source="../media/news-monitoring-workflow.png" alt-text="Diagram shows flowchart for the fictional company on how to process news articles about their market." border="false":::

## Identify the type for each step in your process

The steps in a business process perform different kinds of operations. Some respond to external events, some process or store data, and others make decisions based on the data. Azure Logic Apps uses the terms *trigger*, *action*, and *control action* for these three categories.

For example, in our news monitoring scenario, a *trigger* starts the process when a new article is available. An *action* performs a task such as analyzing the sentiment. And finally, a *control action* makes a decision based on the sentiment. The following diagram shows the type for each step in the news monitoring app:

:::image type="content" source="../media/news-monitoring-step-types.png" alt-text="Diagram shows flowchart for shoe company news monitoring app." border="false":::

## Map your steps to components

To decide which prebuilt component to use, you need clarity about the component types. Let's get more specific about the definitions of the component types:

- A *trigger* is an event that happens when a specific condition is met. Triggers automatically activate or *fire* when the condition is satisfied. For example, when a timer expires or data becomes available. Every workflow must start with a trigger. In our example, you want to trigger the workflow when a new article about athletic shoes comes available.

- An *action* is an operation that executes a specific task in your workflow. Actions run after a trigger activates or another action completes. Your news monitoring app has three actions: analyze sentiment, insert database row, and send email.

- *Control actions* are special "built-in" operations that are native to Azure Logic Apps. A control action lets you add decisions and loops to your workflow. This example uses a control action to branch based on the sentiment.

A *connector* is a group with all related triggers and actions. This group is associated with a single service, system, or other grouping. Conceptually, you can think of a connector as a component that lets you access a service or system.

For example, the **Bing Search** connector lets your workflow interact with the Bing Search service. Your news monitoring app can use a trigger from the **Bing Search** connector to determine when new relevant articles are available. The following diagram shows the **Bing Search** connector with its trigger and actions:

:::image type="content" source="../media/bing-search-connector-operations.png" alt-text="Diagram shows triggers and actions in the Bing Search connector." border="false":::

As another example, the Outlook connector lets your workflow manage your email, calendar, and contacts by also providing triggers and actions.

Now, you need to map each task in your flowchart to the triggers and actions available in Azure Logic Apps. The following diagram shows the connectors that you use in the news monitoring app with the relevant triggers and actions, which are highlighted:

:::image type="content" source="../media/news-design-process.png" alt-text="Diagram shows operations available in connectors used by news monitoring app." border="false":::

## Define your workflow with the designer

The workflow designer in Azure Logic Apps is a graphical tool for creating workflows. You can pick from a gallery of connectors that contain the triggers and actions that you can use in your workflow. You use the designer to arrange the trigger, actions, and control actions. The following screenshot shows the designer with the completed workflow:

:::image type="content" source="../media/news-app-designer-view.png" alt-text="Screenshot shows workflow designer with finished news monitoring app.":::

After you save your workflow, Azure automatically publishes your logic app resource to production. The workflow runs whenever the trigger activates.
