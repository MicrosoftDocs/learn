In this exercise, we'll create our social media monitoring logic app using the Azure portal. We'll add a Twitter trigger using the workflow designer. The following diagram shows a conceptual view for the app and highlights the part that we'll work on.

:::image type="complex" source="../media/exercise-add-trigger.png" alt-text="Diagram shows triggers and actions in the social media monitoring logic app." lightbox="../media/exercise-add-trigger.png" border="false":::
The first step is a Twitter trigger named "When a new tweet is posted. This trigger is highlighted to show the completed part in this exercise.
:::image-end:::

## Create the logic app resource

First, we need to create the logic app resource in Azure. For this task, we need to find the **Logic App** resource type in the Azure portal.

1. With the same account that you used to activate the sandbox, sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).

   [!INCLUDE [](../../../includes/azure-sandbox-regions-first-mention-note-friendly.md)]

1. On the Azure portal home page, select **Create a resource**. On the **Create a resource** menu, select **Integration** > **Logic App**.

   The **Create Logic App** page appears.

1. Now configure the resource's basic settings, such as subscription, resource group, name, and location.

   1. On the **Basics** tab, provide the following values for each setting:

      | Setting | Value |
      |---------|-------|
      | **Project Details** |
      | **Subscription** | Concierge Subscription |
      | **Resource Group** | From the list, select <rgn>[Sandbox resource group]</rgn> |
      | **Instance Details** |
      | **Logic app name** | **ShoeTracker** |
      | **Region** | Select a location nearest you. |
      | **Type** | Consumption |
  
   1. Select **Review + create**, and then select **Create**.

   The deployment pane appears and shows the deployment progress with the resources that Azure creates.
      
1. Wait for deployment to successfully finish. 

1. After deployment for your logic app resource completes, select **Go to resource**.

   The page with the common trigger and template galleries now appears.

## Select a template for your logic app workflow

After you create and deploy a new logic app resource in the Azure portal, you can select a starter template. Let's select the blank template so that we can build our logic app workflow from scratch.

On the page with the common trigger and template galleries, scroll down to the **Templates** section, and select the **Blank Logic App** template.

The workflow designer surface opens for you to add a trigger.

## Add a Twitter trigger

Now, you'll add the Twitter trigger and provide values for all required parameters. If you don't have a Twitter account and prefer not to create one, follow the steps that substitute the RSS trigger instead. The downside to using the RSS trigger is that new articles appear infrequently in RSS feeds, so you might have to wait a while before this trigger activates.

1. On the designer, in the search box, enter **twitter**. From the triggers list, select the trigger named **When a new tweet is posted**.

   *Substitution*: In the search box, enter **RSS**. From the triggers list, select the RSS trigger named **When a feed item is published**.
   
1. Provide the following information for creating a connection to your Twitter account. When you're done, select **Sign in**.

   | Property | Required | Value | Description |
   |----------|----------|-------|-------------|
   | **Connection name** | Yes | ShoeTrackerTwitterConnection | The name to give your Twitter connection |
   | **Authentication Type** | Yes | Use default shared application | The authentication type for your connection |

   *Substitution*: This step doesn't apply to the RSS trigger.

1. When the Twitter **When a new tweet is posted** trigger information box appears, you've created a valid connection.

1. When the authorization box appears, sign in with your Twitter account and password, select **Authorize app**, and authenticate your credentials if prompted.

   This step authorizes and establishes the connection to your Twitter account.

   *Substitution*: This step doesn't apply to the RSS trigger.

   After you create a valid connection, the trigger information box reappears. 

1. Provide the following trigger information:

   | Property | Required | Value | Description |
   |----------|----------|-------|-------------|
   | **Search text** | Yes | Shoe | The text to find in the tweet. To search for hashtags, include a hashtag (**#**) at the start of the search text. |
   | (Interval) | Yes | 1 | The number of time units to wait until the next check. For example, an interval of **3** and a frequency of **Hour** checks for new tweets every three hours. |
   | (Frequency) | Yes | Minute | The time unit to use for the polling interval, for example, **Second**, **Minute**, **Hour**, **Day**, **Week**, or **Month**. |
   | **Add a new parameter** | No | None | Any parameters to add to the trigger. |

   *Substitution*: For the RSS trigger, provide the following information:

   | Property | Required | Value | Description |
   |----------|----------|-------|-------------|
   | **RSS feed URL** | Yes | **`https://rss2.feedspot.com/https://www.reuters.com/technology`** | The URL for the RSS feed to check |
   | **Chosen property** | No | UpdatedOn | The property to use for determining which articles to return |
   | (Interval) | Yes | 1 | The number of time units to wait until the next check. For example, an interval of **3** and a frequency of **Hour** checks for new articles every three hours. |
   | (Frequency) | Yes | Minute | The time unit to use for the polling interval, for example, **Second**, **Minute**, **Hour**, **Day**, **Week**, or **Month**. |
   | **Add a new parameter** | No | None | Any parameters to add to the trigger. |

1. When you're done, on the designer toolbar, select **Save**.

1. Enter the name for your logic app resource with a unique identifier, which is **ShoeTracker*NNN*** where *NNN* represents a unique ID, such as your initials and a number.

   When you save your workflow, Azure automatically publishes your changes to your deployed logic app resource, which is live and running. You can either wait for the trigger to fire, or you can manually activate the trigger.

   1. If you choose to wait, on the **Overview** pane, find section labeled **Trigger history** and the text that looks something like **Evaluated 12 times, fired 3 times in the last 24 hours**. The term *evaluated* means the condition in your trigger was checked. You should see this number increase once per minute since you're polling every minute. The term *fired* indicates the number of times the trigger conditions were satisfied. In our case, this number represents how many times the trigger found matching tweets.

   1. To manually activate the trigger, on the designer toolbar, select **Run Trigger** > **Run**.

      Your logic app workflow now checks Twitter every minute for tweets that contain your search text. If the workflow runs correctly and finishes successfully, a page similar to the designer opens but shows the status and time taken for each step in the workflow run. We'll review this page in more detail later.

Now we'll review the trigger outputs and workflow's run history.

## Review the output from the Twitter trigger

1. Open the logic app resource's main menu, and select **Overview**.

   You might have to scroll to the left to find the main menu, or you can use your browser's search to find the word **overview** on the page.

1. On the **Oveview** pane toolbar, select **Refresh** every minute until the **Runs history** section shows at least one completed run.

1. While you wait, you can review the trigger history. On the **Overview** pane, find the **Trigger history** section.

   The **Fired** column shows whether the trigger activated because the trigger condition was met. In this example, the condition that trigger finds a matching tweet. So, the trigger fires for each matching tweet.

1. Return to **Runs history** section. If at least one completed run appears, select a row for any successful run.

   A page named **Logic app run** opens to show the status for each step in the workflow and the time taken to run each step. From this view, you can also review the data that flowed through each step.

1. To view the trigger's inputs and outputs, select the Twitter trigger.

   The trigger shape expands to show the **INPUTS** and **OUTPUTS** sections.
   
1. In the **OUTPUTS** section, under **Body**, find the text for the matching tweet. To review the complete response in JSON format, select **Show raw outputs**.
