In this exercise, we'll create our social-media monitor app using the Azure portal. We'll add a Twitter trigger using the Logic Apps Designer. The following illustration shows a conceptual view of the app with the part that we'll work on highlighted.

![An illustration showing the triggers and actions in the social-media monitor logic app. The first step is a Twitter trigger labeled **When a new tweet is posted**. This trigger is highlighted to indicate that is the part of the app that will be completed in this exercise.](../media/exercise-add-trigger.png)

## Locate the Azure logic app resource

The first thing we need to do is create an Azure logic app. In order to do that, we need to locate the Azure Logic Apps resource type in the Azure portal.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.

1. On the Azure portal menu or from the home page, select **Create a resource**.

1. In the search box, type **Logic app**.

1. Select the **Logic App** template.

1. Click **Create**.

## Configure your Azure Logic Apps resource

Now that the Azure Logic Apps resource was located, let's configure basic settings like it's resource group and location.

1. For the name of the logic app, enter **ShoeTracker**.

1. Select the **Concierge** subscription to host the app.

1. Select the existing **Resource group** <rgn>[Sandbox resource group name]</rgn>.

1. Select a **Location** from the available list below.

    [!INCLUDE [](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Create** and wait until the resource is created.

## Use a template for your Azure logic app

When you create an Azure logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch.

1. In the left navigation bar, select **Resource groups**.

1. Select the existing **Resource group** <rgn>[sandbox resource group name]</rgn>.

1. Select the **ShoeTracker** logic app.

1. Scroll down to the **Templates** section and select **Blank Logic App**.

## Create a Twitter trigger

> [!NOTE]
> If you do not have a Twitter account and prefer not to create one, you can substitute the **When a feed item is published** trigger from the RSS connector. Set the **RSS feed URL** to `https://blog.feedspot.com/reuters_rss_feeds/`, the **Interval** to `1`, and the **Frequency** to `Minute`. The disadvantage of this approach is that new articles appear infrequently in RSS feeds so you may have to wait a while before this trigger activates.

Now that we have our logic app created, we need to add a trigger. We're going to use the **When a new tweet is posted** polling trigger from the Twitter connector. There are three required parameters:

- **Search text:** Text to look for in the tweet text. You can include a hashtag character at the beginning of the search text to search for hashtags.
- **Frequency:** Unit of time for search frequency. For example, `Second`, `Minute`, `Hour`, or `Day`.
- **Interval:** How often to search. For example, an interval of `3` and a frequency of `Hour` would check for new tweets every three hours.

Let's now create the trigger and provide values for all required parameters.

1. In the connectors search box, type **Twitter**.

1. Select the **When a new tweet is posted** trigger.

1. Sign in with your existing Twitter account.

1. In the **Search text**, enter a name of a product. Use the name of a product that is new and popular so that you get results quickly.

1. Enter **1** for **Interval**.

1. Select **Minute** for **Frequency**.

1. Click **Save**. Your app will be live as soon as you save it.

## Examine the results of your Twitter trigger

At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the **Runs history** table.

1. Select **Overview** in the navigation menu. You may need to scroll horizontally to see the navigation menu or you can use your browser's search function to find the word "overview" on the page.

1. Select **Refresh** once a minute until you see a row in the **Runs history** table.

1. While you are waiting, locate the section in **Overview** labeled **EVALUATION**. Notice the text that looks something like **Evaluated 12 times, fired 3 times in the last 24 hours**. The term *evaluated* means the condition in your trigger was checked; you should see this increase once per minute since you're polling every minute. The term *fired* indicates the number of times the trigger conditions were satisfied; in our case, this number represents how many times the trigger found matching tweets.

1. Once you see a row appear, select the row. Selecting a row will navigate your view to something that looks like the designer you used to create the trigger. This view lets you see the data that flowed through each step of this run of your app.

1. Select the Twitter trigger.

1. Examine the data in the **OUTPUTS** section. For example, locate the text of the matching tweet.
    > [!NOTE]
    > Select **Show raw outputs** if you would like to see the entire response in JSON.
