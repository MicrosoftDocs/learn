In Azure Logic Apps, a trigger always starts a workflow as the first step. To correctly run your workflow, you need to find the best trigger, and set up the trigger's properties for your scenario. For our example, we'll use a Twitter trigger that runs our workflow when a tweet with our product name is posted.

In this unit, we'll examine trigger types plus the strengths and weaknesses around the most common options. We'll then show how to create a logic app workflow using the Azure portal, and how to add a trigger in the workflow designer.

## Trigger types

Consider the various trigger conditions that businesses might use to run their logic app workflows. Most examples that we've seen are triggers that detect whether data or an event in a service or system meets specific conditions. For example, when new tweet is posted, a new row is inserted into a database, a new email arrives, or a new file is uploaded to your cloud storage. Triggers that detect data or events can use either of the following techniques:

* Triggers that periodically *poll* or check a service or system for specific data or events that meet conditions
* Triggers that wait and receive *push* notifications from a service or system when specific data or events meet conditions

However, what if you need a trigger that's not bound to data or events in service or system? Suppose you want to run your workflow every Saturday at midnight or some other schedule. You can use the **Recurrence** trigger to schedule and run any actions in a workflow. For example, you can schedule workflows that perform administrative tasks, such as running backups or archiving old data. Suppose you want to run your workflow only on request from any source or location? You can use the **Request** or "manual" trigger to wait for inbound requests to arrive.

The following diagram summarizes these trigger types:

:::image type="content" source="../media/trigger-types.png" alt-text="An illustration showing the four types of triggers: polling, push, recurrence, and manual." border="false":::

## What is a polling trigger?

A *polling* trigger runs on a schedule and sends an outbound call that checks for data or an event that meets specific conditions. Whenever data or an event meets the conditions, the trigger starts a new workflow execution. For example, the RSS connector has a polling trigger that can regularly check for new posts in an RSS feed.

When you add a polling trigger to your workflow, you set the **Frequency** and an **Interval** to control how often the trigger runs. The frequency is a time unit, such as **Second**, **Minute**, **Hour**, **Day**, **Week**, or **Month**. The interval is the number of time units that lapse before the trigger checks again for data or an event. For example, a polling trigger with a frequency of **Minute** and an interval of **5** checks every five minutes.

Polling triggers require you to choose between how often the triggers run and how much they cost. Often, there's a delay between when new data or an event happens and when the trigger detects that data or event. For example, suppose a polling trigger checks for data every five minutes. New data is available after seven minutes. The trigger doesn't detect the new data until the next poll, which happens at 10 minutes. The following diagram shows how this polling works:

:::image type="content" source="../media/polling-trigger.png" alt-text="Diagram shows a timeline and a polling trigger checking for new data every five minutes. New data becomes available after seven minutes. The trigger doesn't detect the new data until the next poll, which happens at 10 minutes." border="false":::

In the worst case, the potential delay when detecting new data is equal to the polling interval. So why not use a smaller interval? To check for new data, the Azure Logic Apps execution engine needs to run your workflow, which incurs a cost. Generally, the shorter the interval, the higher the cost, but the trigger responds faster to new data or events. The best polling interval for your trigger depends on your business process and tolerance for delay.

## What is a push trigger?

A *push* trigger waits for data or an event that meets specific conditions. The trigger subscribes to an endpoint on an external service or system. When new data or an event meets the conditions, the service or system notifies the trigger, which starts a new workflow execution. For example, the Azure Service Bus connector has a push trigger that detects when a message is added to an Azure Service Bus queue.

> [!NOTE]
> Push triggers use *webhooks*, which allow triggers to subscribe to the external service or system. At subscription time, 
> Azure Logic Apps generates a callback URL for the trigger and registers the URL with the external service or system. 
> Similarly, Azure Logic Apps unsubscribes and deregisters the callback URL when you don't need the subscription anymore, 
> for example, if you disable or delete your workflow.

On the positive side, push triggers don't run when no data or events are available. So, they don't incur costs for polling. These triggers also immediately respond immediately when new data or events are available. The following diagram shows how this push process works:

:::image type="content" source="../media/push-trigger.png" alt-text="Diagram shows a timeline where a marker indicates when new data becomes available. The push trigger detects the data and immediately responds." border="false":::

Why not use push triggers all the time when they respond faster and cost less than polling triggers? Unfortunately, not every connector offers a push trigger. The external service might not support push triggers, or maybe the connector author didn't choose to implement a push trigger. Generall, a connector offers either push triggers or polling triggers, but not both. In rare cases where a connector offers both options, consider using the push trigger due to better efficiency.

In this module, we're going to focus on polling triggers. These triggers are the most common and are perfect for the "route and process data" scenarios that we've been discussing.

## Trigger parameters and return values

You can think of trigger operations as function calls that have parameters and return values.

Trigger *parameters* let you configure the operation. The Twitter **When-a-new-tweet-is-posted** trigger has a parameter called **Search text** that it uses to select matching tweets for us. Some operations have a mix of required and optional parameters. The SQL Server **When an item is created** trigger has one required parameter named **Table name** and several optional parameters like **Order By** and **Select Query**.

Trigger *return values* are the results of the operation. The bitbucket connector has a **When a pull request is merged** trigger. The trigger returns an object containing things like the identity of the **Repository** and the **Actor** who approved the merge. Most triggers actually return a collection instead of a single object. The Twitter **When a new tweet is posted** trigger returns an array of **TweetModel** objects. Each object contains values like the **Tweet text**, **User name**, and **Followers count**. The following illustration shows a collection being returned from a trigger.

:::image type="content" source="../media/trigger-returning-a-collection.png" alt-text="An illustration showing the Twitter trigger interacting with Twitter. The trigger sends the search text to Twitter and Twitter returns an array of objects. Each object in the array contains information about one of the matching tweets." border="false":::

You can use a loop to process each item or you can ask the trigger to split the array up for you. The default behavior for most triggers, including the Twitter trigger, is to automatically split the array. The Logic Apps execution engine will create one instance of your logic app for each data item and the instances will run in parallel. The following illustration shows how each item in the returned array is sent to a different instance of the logic app.

:::image type="content" source="../media/trigger-splitting-an-array.png" alt-text="An illustration showing three tweets returned from the Twitter trigger and three instances of the social media monitor logic app. An arrow connects each tweet in the array with one of the instances of the logic app." border="false":::

## How to create a logic app in the Azure portal

You can use the Azure portal to create a logic app. You select the **Logic App** resource type and enter the standard resource properties **Name**, **Subscription**, **Resource group**, and **Location**. After deployment completes, you can navigate to the Logic Apps resource that you created.

The Logic Apps team has created several *templates* for common application types. For example, there are templates for apps like **Post to Slack if a new tweet matches with some hashtag** and **Get daily reminders emailed to you**.

When you first navigate to your newly deployed logic app, you'll find a getting-started page. This page can add a common trigger to your app or generate an entire app for you from one of the templates. If any of these templates matches what you're working on, they can save you some time in getting your app set up. To do all the work yourself, there's also a **Blank Logic App** template.

After you select a starting template, you'll automatically navigate to the Logic Apps Designer.

## How to add a trigger using the designer

The Logic Apps Designer lets you pick from a gallery of connectors that contain the triggers and actions you can use in your app. The typical strategy is to use the search feature to locate the connector you are interested in. Then you look through the triggers supplied by the connector to find the one you want. In our case, we will use Twitter's **When-a-new-tweet-is-posted** trigger.

Once you've added the trigger, the Designer displays a GUI to set the trigger properties. We'll set the **Search text**, **Frequency**, and **Interval** parameters. The following screenshot shows the social media monitor logic app displayed in the designer; notice that it begins with the Twitter trigger.

:::image type="content" source="../media/social-media-complete-in-the-designer.png" alt-text="Screenshot showing an example logic app in the Logic Apps Designer. The app is displayed using rectangular areas to represent the starting trigger and each of the actions. Arrows connect the rectangles to show the execution flow through the app." border="false":::
