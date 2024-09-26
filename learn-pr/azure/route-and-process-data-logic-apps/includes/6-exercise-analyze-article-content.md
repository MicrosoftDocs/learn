In this exercise, continue working on the news monitoring app. You want the workflow to analyze whether news articles about the athletic shoe market are positive or some other ranking, such as negative or neutral. You can use the **Azure Cognitive Services for Language** connector, which includes the **Sentiment** action. The output from this action includes a sentiment ranking for the action's content input. The following diagram shows a conceptual view of the workflow and highlights the part that you work on:

:::image type="content" source="../media/exercise-detect-sentiment.png" alt-text="Diagram shows triggers and actions in the workflow for the news monitoring logic app." border="false" lightbox="../media/exercise-detect-sentiment-big.png":::

> [!TIP]
>
> If you have Microsoft Copilot installed, you can ask Copilot these questions:
>
> - *Tell me about Azure Cognitive Services for Language?*
> - *What's the difference between Azure Cognitive Services for Language and Azure AI Language?*

<a name='get-key-and-endpoint-for-azure-ai-services'></a>

## Get API key and endpoint for Azure AI Service for Language

The Azure AI Service for Language API, previously Azure Cognitive Services, provides natural language processing for text and includes capabilities such as sentiment analysis, key phrase extraction, language detection, and entity linking.

For this exercise, you need an API key and endpoint to call the API and get back sentiment rankings.

1. In the [Azure portal](https://portal.azure.com) search box, enter **language**, and select **Language**.

1. On the **Language service** page, select **Create** **>** **Continue to create your resource**.

1. Provide the following information about your language resource:

   | Property | Value | Description |
   |----------|-------|-------------|
   | **Subscription** | <*Azure-subscription*> | Select your Azure subscription. |
   | **Resource group** | <*resource-group*> | Select the same resource group that you're using across this module. |
   | **Region** | <*Azure-region*> | Select an Azure region that offers the free tier. This example selects **West US**. |
   | **Name** | <*Language-resource*> | Enter unique name for your Language resource. This example uses **My-Language-Resource**. |
   | **Pricing tier** | **Free F0 (5K Transactions per 30 days)** | This tier provides 5,000 transactions every month. For pricing information, see [Bing Search API pricing](https://azure.microsoft.com/pricing/details/cognitive-services/language-service/#pricing). |
   | **By checking this box, I certify that I have reviewed and acknowledge the terms in the Responsible AI Notice.** | N/A | Select this option to confirm your acknowledgment. |

1. When you finish, select **Review + create**.

1. After deployment completes, select **Go to resource**.

1. On the resource menu, under **Resource Management**, select **Keys and Endpoint**.

1. Copy and save the following values somewhere safe:

   * **Key 1** or **Key 2**
   * **Endpoint**

   :::image type="content" source="../media/language-api-key-endpoint.png" alt-text="Screenshot shows Language API key and endpoint." lightbox="../media/language-api-key-endpoint.png":::

## Add the **Sentiment** action

1. In the [Azure portal](https://portal.azure.com), return to your logic app resource and workflow from the previous exercise.

   To open the designer, on the logic app menu, under **Development Tools**, selects **Logic app designer**.

1. Under the **Bing Search** trigger, select the plus icon (**+**) **>** **Add an action**.

1. In the **Add an action** pane search box, enter **cognitive services**.

1. From the results list, in the **Azure Cognitive Services for Language** connector section, select the action named **Sentiment (V3.0)**.

   > [!TIP]
   >
   > If you don't see this operation, next to the connector name, select **See more**.

1. In the connection information box that appears, provide the following information:

   | Parameter | Required | Value | Description |
   |-----------|----------|-------|-------------|
   | **Connection Name** | Yes | **CognitiveServicesConnection** | The name to give your connection. |
   | **Authentication Type** | Yes | **Api Key** | The authentication to use for accessing Azure AI services. |
   | **Account Key** | Yes | <*your-saved-API-key*> | The key to use for accessing Azure AI services. |
   | **Site URL** | No | <*your-saved-endpoint*> | The endpoint URL or address for your language resource. |

   > [!IMPORTANT]
   >
   > For optimal security, Microsoft recommends that you use [Microsoft Entra ID](/entra/identity/authentication/overview-authentication) 
   > with [managed identities](/entra/identity/managed-identities-azure-resources/overview) 
   > for authentication when possible. This option provides superior security without having to provide 
   > credentials. Azure manages this identity and helps keep authentication information secure so that 
   > you don't have to manage this sensitive information. To set up a managed identity for Azure Logic Apps, 
   > see [Authenticate access and connections to Azure resources with managed identities in Azure Logic Apps](/azure/logic-apps/authenticate-with-managed-identity).

1. When you finish, select **Create new**.

   The **Sentiment** action and parameters now appear.

## Set up the **Sentiment** action

Next, set up the **Sentiment** action's parameters to pass in the article description from the **Bing Search** trigger.

1. For easier identification, in the **Sentiment** information pane, you can optionally rename the action to **Detect sentiment**.

1. On the **Parameters** tab, in the **Documents** field, select **Add new item**.

   The **id**, **Text**, and **Language** parameters appear. 

1. Provide the values for these parameters:

   | Parameter | Required | Value | Description |
   |-----------|----------|-------|-------------|
   | **id** | Yes | <*document-ID*> | Provide a unique ID to assign your document. For this exercise, follow these steps: <br><br>1. Under **Documents**, select inside the **Id** field. <br><br>2. Select the dynamic content list option (lightning icon). <br><br>3. From the **On new news article** section, select the **URL** trigger output. <br><br>*Substitution*: If you're using the RSS trigger named **When a feed item is published**, select **Primary feed link**. |
   | **Text** | Yes | <*document-content*> | Provide the document content to use. For this exercise, follow these steps: <br><br>1. Under **Documents**, select inside the **Text** field. <br><br>2. Select the dynamic content list option (lightning icon). <br><br>3. From the **On new news article** section, select the **Description** trigger output. <br><br>*Substitution*: If you're using the RSS trigger named **When a feed item is published**, select **Feed summary**. |
   | **Language** | No | <*none*> | Leave empty. |

   The finished action looks like the following example:

   :::image type="content" source="../media/sentiment-action-bing-search.png" alt-text="Screenshot shows Sentiment action with Bing Search trigger outputs." lightbox="../media/sentiment-action-bing-search.png":::

   *Substitution*: If you're using the RSS trigger, the finished action looks like the following example:

   :::image type="content" source="../media/sentiment-action-rss.png" alt-text="Screenshot shows Sentiment action with RSS trigger outputs." lightbox="../media/sentiment-action-rss.png":::

   The RSS trigger output is an array, so the designer automatically adds a **For each** loop around the **Sentiment** action.

1. Save your workflow.

   This step automatically pushes your saved changes to your deployed logic app resource. Azure AI services process article descriptions that contain the specified search term and gives each description a sentiment ranking. Recall that the sentiment ranking can be **Negative**, **Neutral**, **Positive**, or **Mixed**.

1. Test the workflow. To manually activate the trigger, on the designer toolbar, select **Run** > **Run**.

   The trigger checks the **Bing Search** service for any news articles that contain your search text and are available at the current time. The **Sentiment** action then sends any matching results to the Azure AI Services API to get a sentiment ranking.

   > [!IMPORTANT]
   >
   > If you use an Azure subscription that incurs charges, your subscription might incur a 
   > small charge when you run the **Bing Search** trigger and other actions in your workflow, 
   > such as the **Sentiment**  action. The **Consumption** plan specifies that metering and 
   > billing apply as described:
   > 
   > - **Built-in (in-app) operations**: The first X number of executions are free. Afterwards, pay-per-execution pricing applies.
   > - **Managed (shared) operations**: Pay-per-execution pricing applies.
   >
   > To minimize charges, make sure to delete your resources after you finish this module.
   >
   > For more information, see the following resources:
   >
   > - [Trigger and action operations in the Consumption model](/azure/logic-apps/logic-apps-pricing#trigger-and-action-operations-in-the-consumption-model)
   > - [Azure Logic Apps pricing](https://azure.microsoft.com/pricing/details/logic-apps/). 
   > Select your region, currency, and then the **Consumption Plan (Mutlitenant)** tab.

Let's review the workflow run history.

## Review workflow run history

This section shows how to monitor your logic app workflow's execution and view the data flowing through each step. This capability helps you confirm whether your app works correctly.

1. On the logic app menu, select **Overview**.

1. On the **Overview** page, select the **Runs history** tab.

   > [!TIP]
   >
   > If no recent results appear, on the **Overview** page toolbar, select **Refresh**.

   Each item in the **Runs history** list represents a separate article description that contains the search text that you specified in the trigger.

1. Select the row for a successful workflow run.

   The workflow's run details page opens and shows the status and time taken for each operation to run. From this view, you can also review the data that flowed through each operation.

1. To view the action's inputs and outputs, select the **Sentiment** action on the run details page.

   A pane opens to show the action's **INPUTS** and **OUTPUTS** sections.

1. In the **OUTPUTS** section, in the **body** field, find the **text** content and the **sentiment** label, which is assigned by Cognitive Services. To review the complete response in JSON format, select **Show raw outputs**.

The next unit introduces control actions, which change the execution path in a workflow.
