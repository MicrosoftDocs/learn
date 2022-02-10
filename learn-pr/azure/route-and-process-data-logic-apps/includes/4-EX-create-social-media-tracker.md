In this exercise, we'll create our social media logic app using the Azure portal. We'll add a Twitter trigger using the Logic Apps Designer. The following illustration shows a conceptual view of the app with the part that we'll work on highlighted.

:::image type="complex" source="../media/exercise-add-trigger.png" alt-text="An illustration showing the triggers and actions in the social media monitor logic app." lightbox="../media/exercise-add-trigger.png" border="false"::: 
   The first step is a Twitter trigger labeled **When a new tweet is posted**. This trigger is highlighted to indicate that is the part of the app that will be completed in this exercise.
:::image-end:::  

## Locate the Azure logic app resource

The first thing we need to do is create an Azure logic app. To do that, we need to locate the Azure Logic Apps resource type in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the same account you used to activate the sandbox.

1. On the Azure portal menu, select **All Services**, and in the **All services** menu, under **Integration**, select **Logic apps**. The **Logic apps** pane appears.

1. In the top menu bar, select **Add**. The **Create Logic App** pane appears.

## Configure your Azure Logic App resource

Let's configure basic settings, like resource group and location.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---|---|
    | **Project Details** |
    | Subscription | Concierge Subscription |
    | Resource group | From the dropdown list, select <rgn>[Sandbox resource group]</rgn> |
    | **Instance Details** |
    | Type | Consumption |
    | Logic app name | Enter *ShoeTracker* |
    | Region | Select a location closest to you from the dropdown list. |

    [!INCLUDE [](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. Select **Review + create** and then select **Create**. The Deployment pane displays the resources that are created. Wait for deployment to succeed.

## Use a template for your Azure logic app

When you create a logic app in the Azure portal, you have the option of selecting a starter template. Let's select a blank template so that we can build our logic app from scratch.

1. After deployment completes, select **Go to resource**. The **Logic Apps Designer** appears for your *ShoeTracker* logic app.

1. Scroll down to the *Templates* section, and select the **Blank Logic App**  

## Create a Twitter trigger

Now, let's create the trigger and provide values for all required parameters.
 
> [!NOTE]
> If you do not have a Twitter account and prefer not to create one, use the following substitutions. Substitute the **When a feed item is published** in the search field, and then Select the RSS trigger in the bottom box. Set the **RSS feed URL** to `https://rss2.feedspot.com/https://www.reuters.com/technology`, the **Chosen property** to `UpdatedOn`, the **How often to check for items** to `1`, and the **Frequency** to `Minute`. The disadvantage of this approach is that new articles appear infrequently in RSS feeds so you may have to wait a while before this trigger activates.

1. In the *Search connectors and triggers* field, enter *When a new tweet is posted*. In the lower dialog box, select the Twitter **When a new tweet is posted**.

1. A **Twitter** dialog box prompts you to enter:

    | Setting | Value |
    |---|---|
    | Connection name | ShoeTrackerTwitterConnection |
    | Authentication Type | Accept default (Use default shared application)|

1. Select **Sign in**. Sign in with your existing Twitter account and password, and select **Authorize app**. This action establishes the log in connection to your Twitter account.

1. When the Twitter **When a new tweet is posted** dialog box reappears you have created a valid connection. The dialog box has three required parameters:

   - **Search text:** Text to look for in the tweet text. You can include a hashtag character at the beginning of the search text to search for hashtags.
   - **Frequency:** Unit of time for search frequency. For example, `Second`, `Minute`, `Hour`, or `Day`.
   - **Interval:** How often to search. For example, an interval of `3` and a frequency of `Hour` would check for new tweets every three hours.

1. Enter the following values:

    | Setting | Value |
    |---|---|
    | Search text | Shoe |
    | How often do you want to check for new items? | 1 |
    | (Frequency) | Minute |
    | Add new parameter | Accept default (blank). |

1. In the command bar, select **Save**.

1. Enter the name of your logic app (ShoeTrackerNNN where NNN represents a unique ID, such as your initials and a number to provide a unique identifier.

1. Select **Run Trigger**.

## Examine the results of your Twitter trigger

At this point, our logic app is scanning Twitter every minute for tweets containing the search text. To verify the app is running and working correctly, we'll look at the **Runs history** table.

1. Scroll to the left, and then in the Logic App  menu, select **Overview**. You may need to scroll to the left to see the navigation menu or you can use your browser's search function to find the word "overview" on the page.

1. Select **Refresh** once a minute until you see a row in the **Runs history** table.

1. While you are waiting, locate the section in **Overview** labeled **Trigger history**. Notice the text that looks something like **Evaluated 12 times, fired 3 times in the last 24 hours**. The term *evaluated* means the condition in your trigger was checked; you should see this increase once per minute since you're polling every minute. The term *fired* indicates the number of times the trigger conditions were satisfied; in our case, this number represents how many times the trigger found matching tweets.

1. Go back to **Runs history**. After you see a row appear, select the row. Selecting a row will navigate your view to something that looks like the designer you used to create the trigger. This view lets you see the data that flowed through each step of this run of your app.

1. Select the Twitter trigger.

1. Examine the data in the **OUTPUTS** section. For example, locate the text of the matching tweet.

    > [!NOTE]
    > Select **Show raw outputs** if you would like to see the entire response in JSON.
