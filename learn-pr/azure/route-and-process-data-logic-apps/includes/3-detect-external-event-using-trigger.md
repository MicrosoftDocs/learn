In Azure Logic Apps, a trigger always starts a workflow as the first step. To correctly run your workflow, you need to find the best trigger, and set up the trigger's properties for your scenario. For our example, we'll use an X trigger that runs our workflow when a tweet with our product name is posted.

In this unit, we'll examine trigger types plus the strengths and weaknesses around the most common options. We'll then show how to create a logic app workflow using the Azure portal, and how to add a trigger in the workflow designer.

## Trigger types

Consider the various trigger conditions that businesses might use to run their logic app workflows. Most examples that we've seen are triggers that detect whether data or an event in a service or system meets specific conditions. For example, when new tweet is posted, a new row is inserted into a database, a new email arrives, or a new file is uploaded to your cloud storage. Triggers that detect data or events can use either of the following techniques:

* Triggers that periodically *poll* or check a service or system for specific data or events that meet conditions
* Triggers that wait and receive *push* notifications from a service or system when specific data or events meet conditions

However, what if you need a trigger that's not bound to data or events in service or system? Suppose you want to run your workflow every Saturday at midnight or some other schedule. You can use the **Recurrence** trigger to schedule and run any actions in a workflow. For example, you can schedule workflows that perform administrative tasks, such as running backups or archiving old data. Suppose you want to run your workflow only when called from code or another source? You can use the **Request** or "manual" trigger to wait for requests, for example, sent from code in your web app or mobile app.

The following diagram summarizes the previously described trigger types:

:::image type="content" source="../media/trigger-types.png" alt-text="An illustration showing the four types of triggers: polling, push, recurrence, and manual." border="false":::

The following sections have more information about polling triggers and push triggers.

## What is a polling trigger?

A *polling* trigger periodically checks a service or system for data or an event that meets specific conditions. After this check, if the trigger finds data or an event that meets the conditions, the trigger starts a new workflow execution. For example, the RSS connector has a polling trigger that can regularly check for new posts in an RSS feed.

After you add a polling trigger to your workflow, you set the **Frequency** and an **Interval** to control how often the trigger runs. The frequency is a time unit, such as **Second**, **Minute**, **Hour**, **Day**, **Week**, or **Month**. The interval is the number of time units that lapse before the trigger checks again for data or an event. For example, a polling trigger with a frequency of **Minute** and an interval of **5** checks every five minutes.

Polling triggers require you to choose between how often the triggers run and how much they cost. Often, there's a delay between when new data or an event happens and when the trigger detects that data or event. For example, suppose a polling trigger checks for data every five minutes. New data is available after seven minutes. The trigger doesn't detect the new data until the next poll, which happens at 10 minutes. The following diagram shows how this polling works:

:::image type="content" source="../media/polling-trigger.png" alt-text="Diagram shows a timeline and a polling trigger checking for new data every five minutes. New data becomes available after seven minutes. The trigger doesn't detect the new data until the next poll, which happens at 10 minutes." border="false":::

In the worst case, the potential delay when detecting new data is equal to the polling interval. So why not use a smaller interval? To check for new data, the Azure Logic Apps execution engine needs to run your workflow, which incurs a cost. Generally, the shorter the interval, the higher the cost, but the trigger responds faster to new data or events. The best polling interval for your trigger depends on your business process and tolerance for delay.

## What is a push trigger?

A *push* trigger waits for notifications from a service or system when data or an event meets specific conditions. The trigger subscribes to an endpoint on an external service or system. When new data or an event meets the conditions, the service or system notifies the trigger, which immediately starts a new workflow execution. For example, the Azure Service Bus connector has a push trigger that detects when a message is added to an Azure Service Bus queue.

> [!NOTE]
> Push triggers use *webhooks*, which allow triggers to subscribe to the external service or system. At subscription time, 
> Azure Logic Apps generates a callback URL for the trigger and registers the URL with the external service or system. 
> Similarly, Azure Logic Apps unsubscribes and deregisters the callback URL when you don't need the subscription anymore, 
> for example, if you disable or delete your workflow.

On the positive side, push triggers don't run when no data or events are available. So, they don't incur costs for polling. These triggers also immediately respond when new data or events exist. The following diagram shows how this push process works:

:::image type="content" source="../media/push-trigger.png" alt-text="Diagram shows a timeline where a marker indicates when new data becomes available. The push trigger detects the data and immediately responds." border="false":::

Why not use push triggers all the time when they respond faster and cost less than polling triggers? Unfortunately, not every connector offers a push trigger. The external service might not support push triggers, or maybe the connector author didn't choose to implement a push trigger. Generally, a connector offers either push triggers or polling triggers, but not both. In rare cases where a connector offers both options, consider using the push trigger due to better efficiency.

In this module, we're going to focus on polling triggers. These triggers are the most common and are perfect for the "route and process data" scenarios that we've discussed.

## Trigger parameters and return values

Consider trigger operations as function calls that have *parameters* and *return values*. Trigger parameters let you configure the operation. The X trigger named **When a new tweet is posted** has a parameter called **Search text**. The trigger uses this parameter to select matching tweets for us. Some operations use both required and optional parameters. The SQL Server trigger named **When an item is created** has one required parameter called **Table name** and several optional parameters, such as **Order By** and **Select Query**.

Trigger return values are the results from the operation. For example, the Bitbucket connector has a trigger named **When a pull request is merged**. The trigger returns an object that contains data, such as the **Repository** identity and the **Actor** who approved the merge. Most triggers actually return an object collection, rather than a single object. For example, the X trigger named **When a new tweet is posted** returns an array of **TweetModel** objects. Each object contains values, such as **Tweet text**, **User name**, and **Followers count**. The following diagram shows a collection that's returned from a trigger:

:::image type="content" source="../media/trigger-returning-a-collection.png" alt-text="Diagram shows X trigger interacting with X. The trigger sends the search text to X, and X returns an object array. Each object in the array contains information about one of the matching tweets." border="false":::

You can use a loop to process each item, or you can set up the trigger to split up the array for processing. For most triggers, including the X trigger, the default behavior automatically splits up the array. The Azure Logic Apps engine creates one workflow instance for each item, and all the instances run in parallel. The following diagram shows how each item in the returned array goes to a different workflow instance for processing:

:::image type="content" source="../media/trigger-splitting-an-array.png" alt-text="Diagram shows three tweets returned from the X trigger and three workflow instances in the social media monitoring logic app. An arrow connects each tweet in the array with each workflow instance in the logic app." border="false":::

## Create a logic app workflow in the Azure portal

In the Azure portal, find and select the **Logic App** resource type, and provide information about the resource, such as **Name**, **Subscription**, **Resource group**, and **Location**. After deployment completes, you can go to the logic app resource.

When you open your new logic app resource, you'll find a "get started" page. This page includes commonly used triggers and a *template* gallery with common workflow patterns and app types. For example, you can find workflow templates such as **Post to Slack if a new tweet matches with some hashtag** and **Get daily reminders emailed to you**.

On the "get started" page, you can select a common trigger to add to your workflow, or you can select a template to generate a complete workflow. If any template fits your scenario, you can save some time in setting up your app. To do all the work yourself, you can select the **Blank Logic App** template.

After you select a template, the workflow designer automatically opens for you.

## Add a trigger using the designer

The workflow designer shows a connector gallery with the triggers and actions that you can use in your workflow. Typically, when you start with a blank workflow, you use the search box to find a connector that interests you. Then, you review any triggers that the connector provides. In our example, we select the X trigger named **When a new tweet is posted**. For X, we also have to create a connection by signing in our X account.

After you add a trigger, and create a connection to the service or system when necessary, the designer shows the trigger properties. For X, we'll set the **Search text**, **Frequency**, and **Interval** parameters. The following screenshot shows the social media monitoring logic app workflow in the designer where the X trigger appears as the first step.

:::image type="content" source="../media/social-media-complete-in-the-designer.png" alt-text="Screenshot shows example logic app workflow in the designer. A box for each step represents the trigger and each action. Arrows connect the boxes to show execution through the workflow." border="false":::
