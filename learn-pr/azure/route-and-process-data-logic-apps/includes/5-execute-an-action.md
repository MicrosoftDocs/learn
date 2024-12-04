Recall that a logic app workflow includes a trigger and actions. The trigger starts your workflow, and actions complete the remaining work. The news monitoring logic app uses actions to check whether an article is positive or negative, insert a row into a database, or send an email.

In this unit, we provide a quick overview for the action types. The unit then discuss how an action works by passing in parameters and processing returned values.

## Action types

The core goal behind Azure Logic Apps is to help you make services and systems work together. To support this goal, Azure Logic Apps provides actions for the following tasks:

- Access other services, systems, apps, and data.
- Process and manipulate data.
- Control how data flows through your workflow.

Let's examine each action type.

### Access services, systems, apps, and data

The most common action type helps you access and run specific tasks that work with services and systems outside your workflow in Azure Logic Apps. These actions are so common that most people mean this action type when they use the term *action* in reference to Azure Logic Apps. This action type provides access to 1,000+ products, including other Azure services, Microsoft services and products, Salesforce, SAP, Oracle, Dropbox, GitHub, Facebook, Twilio, Slack, Jira, and more. The following diagram shows a tiny fraction of the available actions:

:::image type="content" source="../media/external-services.png" alt-text="Diagram shows a small selection of available actions, which are organized into groups." border="false" lightbox="../media/external-services.png":::

When you use an action to connect from your workflow to an external service or system, you typically provide connection and authorization information. This information might include a username, a password, a connection string, or an account key. The details differ and vary for each service or system.

For example, to connect from your workflow to Azure Cognitive Services for Language, you provide a **Site URL** so that your workflow knows where to send the request to the service. You provide an **Account Key** to authorize your access to the service. You can get both values from your Azure AI account. Typically, when you add the **Sentiment** action to your workflow, you'll copy these values into the connection information box.

This action type helps your workflow send data for processing or pull data into your workflow. But how do you actually work with that data inside your workflow? The next action type helps with this task.

### Process and manipulate data

This action type helps you process data or run operations on data that you pull into your workflow. For example, you have actions that can concatenate multiple values into a single string, parse JSON data, select specific values from an array, and so on.

Let's examine an example. If you've used **Bing Search News**, you might be familiar with this URL pattern that links to a specific news article:

```language-plaintext
https://www.msn.com/en-us/news/<category-name>/<article-name>
```

You can use this link type in the workflow for your news monitoring logic app. For example, you might want to store the URL link in a database so that you can access the article later. Or, you might want to include the URL link in an email so that your coworkers can review the article.

:::image type="content" source="../media/compose-action.png" alt-text="Screenshot shows workflow designer with Compose action and outputs from Bing Search trigger combined with other strings." lightbox="../media/compose-action.png":::

### Control how data flows through your workflow

This action type helps you manage the way that data flows through your logic app workflow by using constructs such as conditions and loops. The news monitoring logic app workflow uses a control action that creates decision branches, based on whether the article sentiment is positive or negative. We show how this action type works and discuss all the control actions later in this module.

## Action parameters and return values

You can think of a trigger operation as a function call that has *parameters* (inputs) and *return values* (outputs). Action parameters let you pass values into the operation. Some operations use both required and optional parameters. For example, the Azure Cognitive Services for Language action named **Sentiment** has a required parameter called **Documents**. This parameter represents the string that you want to analyze. The **Sentiment** action also has an optional parameter named **Language** that lets you provide a hint about the language used for the **Documents** parameter.

Action return values are the results or outputs from the operation. For example, the **Sentiment** action returns a sentiment ranking that is **Negative**, **Neutral**, **Positive**, or **Mixed**. The following diagram summarizes the data flow for the **Sentiment** action as used by our example news monitoring logic app:

:::image type="content" source="../media/action-inputs-outputs.png" alt-text="Diagram shows a logic app workflow using the **Sentiment** action to call Azure Cognitive Services for Language. The action passes the article description to the service and receives a sentiment ranking." border="false" lightbox="../media/action-inputs-outputs.png":::

## Static versus dynamic parameters

Some parameters that you send to an action stay the same every time that your workflow runs. For example, you might want only articles in English, so you always pass **en** to the **Language** parameter in the **Sentiment** action. This type of static parameter is straightforward. You hardcode the value when you set up the action so that the action uses the same value every time that the action runs.

Other parameters that you send to an action can differ every time that your workflow runs. A good example is the **Documents** parameter in the **Sentiment** action. When you pass the article description into the **Documents** parameter, the description differs at every run. So, how do you get access to this dynamic value?

The article description that the workflow processes is the return value or output from the **On new news article** trigger. This article data is packaged into an object with several fields that contain the article's details. Azure Logic Apps automatically makes this object available to subsequent actions in your workflow. The workflow designer provides a visual way to easily add and configure actions in your workflow. The designer also helps you select available outputs that you want to use from the preceding trigger and actions in your workflow.

## Actions in the designer

The workflow designer includes a connector gallery that contains the triggers and actions you can use in your workflow. Typically, you use the connector gallery search box to find and select a connector for your scenario. Then, you review any actions that the connector provides. The following screenshot shows how the workflow designer presents connectors for you to select:

:::image type="content" source="../media/choose-connector-action.png" alt-text="Screenshot shows workflow designer with available connectors." lightbox="../media/choose-connector-action.png":::

After you select a connector, the actions available for that connector appear:

:::image type="content" source="../media/choose-action.png" alt-text="Screenshot shows workflow designer and selected connector with available actions." lightbox="../media/choose-action.png":::

You can add an action to the end of your workflow or between existing steps. After you add an action, you can configure the action's parameter values using the designer.

While you can manually add static parameter values, the designer provides a different way for you to enter dynamic parameter values. When you select inside an edit box, options appear to open either the dynamic content list or the expression editor. The dynamic content list shows any outputs available from the preceding steps. You can select the data that you need, and the designer automatically populates the edit box in your action with your selection. The designer makes adding dynamic content easy. You don't need to remember parameter names and return values, nor do you need to worry about syntax details.

The following screenshot shows how the designer presents the dynamic data from the **Bing Search** trigger:

:::image type="content" source="../media/dynamic-content-designer.png" alt-text="Screenshot shows the workflow designer and the dynamic content list." lightbox="../media/dynamic-content-designer.png":::

The next unit shows how to add and configure an action in the workflow designer.
