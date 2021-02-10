Let’s look at how we can use LUIS to add natural language capabilities to a picture-management bot. LUIS enables you to map natural language *utterances* to *intents*. In other words, LUIS maps the user's words, phrases, or sentences to tasks or actions the user wants to do.

Our application might have several intents: finding pictures, sharing pictures, and ordering prints of pictures. We'll give LUIS a few example utterances of ways users might ask for each of these things. LUIS will then map additional new utterances to each intent based on what it learns over time.

> [!NOTE]
> This is an optional exercise. To use a LUIS service that's tied to your Azure account, follow these steps to create the LUIS service. To use a test environment only, go to the "Create a LUIS app" exercise later on this page.

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the left pane, select **+ Create a resource**.

1. In the **Search the Marketplace** box, enter **LUIS**, and then press <kbd>Enter</kbd>.

1. In the search results, select **Language Understanding**, and then select **Create**. The **Create** page appears for **Luis all in one**.

1. On the **Basics** tab, enter the following values.

    | Setting | Value |
    | --- | --- |
    | Create options | **Both** |
    | **Project details** |
    | Subscription | Concierge Subscription |
    | Resource group | Select **Create new**, and enter **LearnRG** |
    | Name | Enter a unique name |
    | **Authoring Resource** |
    | Authoring location | Select location nearest to you |
    | Authoring pricing tier | **Free F0** |
    | **Prediction Resource** |
    | Prediction location | Use the same location you selected for *Authoring location* |
    | Prediction pricing tier | **Free F0** |

1. Select **Review + create**, and then select **Create**.

1. After the deployment has successfully completed, select **Go the resource** for the service. The **Quick start** page appears for LUIS Cognitive Services.

1. You'll need one of the displayed subscription keys for later exercises. In the left nav bar, under **RESOURCE MANAGEMENT**, select **Keys and Endpoint**. You'll see the two keys you created.

## Create a LUIS app

Azure requires you to create the LUIS app in the same geographic location where you created the service. If you didn't create the service in the previous optional exercise, use the location closest to you.

1. Select one of the following URLs, and open it in a new browser window.

   - **North America:** [https://www.luis.ai/](https://www.luis.ai/)
   - **Europe:** [https://eu.luis.ai/](https://eu.luis.ai/)
   - **Australia:** [https://au.luis.ai/](https://au.luis.ai/)

    > [!NOTE]
    > There are three LUIS websites, based on location. You must author and publish in the same location. Select the location closest to you.

1. Select the **Sign in** link in the upper-right corner.

1. Sign in with your Microsoft account.

1. If a **Welcome** page appears, select **Create a LUIS app now**.

1. Select **+ New app**.

    >[!Note]
    >The portal pages are updated resulting in different titles for the options and actions. You are creating a new app so select that option.

1. Enter a name for your LUIS app, for example, **PictureBotLUIS**.

1. For **Culture**, select the appropriate choice.

1. Provide your LUIS app a description to clearly define its purpose.

1. Select the **Prediction resource** dropdown, and select the resource you created earlier in this exercise.

1. Select **Done**. The newly created app opens on the Dashboard.

1. To switch to the Build view for editing your app, on the top menu bar, select **Build**.
