In this unit, you'll train a conversation app in LUIS that takes in examples of queries that might be asked in the Azure Health Bot instance. These queries then trigger the appropriate response or scenario. Before you get started, make sure that you've already created a Health Bot instance by using the Azure portal.

Creating a LUIS app with Language Understanding consists of two main tasks:

1. Defining entities, intents, and utterances that are used to train the language model. This step is referred to as *authoring* the model.
1. Publishing the model so that client applications can use it for intent and entity prediction based on user input.

## Azure resources for Language Understanding

For each of the authoring and prediction tasks, you need a resource in your Azure subscription. You can use the following types of resources:

- **Language Understanding**: A dedicated resource for Language Understanding, which can be either an *authoring* or a *prediction* resource.
- **Azure AI services**: A general Azure AI services resource that includes Language Understanding along with many other Azure AI services. You can only use this type of resource for prediction.

The separation of resources is useful to track resource utilization for language model training separately from client applications that use the model to generate predictions.

If you choose to create a Language Understanding resource, you're prompted to choose authoring, prediction, or both. If you choose both, *two* resources are created, one for authoring and one for prediction.

Alternatively, you can use a dedicated Language Understanding resource for authoring, but deploy your model to a generic Azure AI services resource for prediction. When your client application uses other Azure AI services in addition to Language Understanding, you can manage access to all the Azure AI services being used through a single endpoint and key.

In this module, you're using the Language Understanding resource.

## Create a LUIS resource in Azure

1. Go to the Azure portal. Select the hamburger button on the top left corner of the screen and then choose **Create a resource**.

   :::image type="content" source="../media/4-create-resource.png" alt-text="Screenshot that shows creating the LUIS resource group." lightbox="../media/4-create-resource.png":::

1. In the search bar, type **Language Understanding** and select the Language Understanding resource that appears. Choose the **Create** option in the resource page.

   :::image type="content" source="../media/4-create-luis.png" alt-text="Screenshot that shows creating a LUIS resource." lightbox="../media/4-create-luis.png":::

1. For **Create options**, select **Both**. Make sure you select the same **resource group** where you created your Azure Health Bot earlier and then enter a name for your **LUIS** resource. Select your **location** and **pricing tier** of choice for both Authoring and Prediction resources. Use the location of the Prediction resource when you integrate your LUIS application into the Azure Health Bot later. Once done, select **Review + create.**

   :::image type="content" source="../media/5-health-bot-create-luis-app.png" alt-text="Screenshot that shows reviewing the LUIS resources created.":::

1. Select the **Create** option once the review is done.

   :::image type="content" source="../media/5-health-bot-create-luis-final.png" alt-text="Screenshot that shows selecting the review and create LUIS service.":::

   > [!NOTE]
   > Alternatively, you can create Prediction and Authoring resources on the LUIS portal after creating your LUIS app.

## Sign in to the LUIS portal

1. Open your browser, and go to the [Language Understanding](https://luis.ai) page. Select the **Sign in** option in the upper-right corner, and then sign in to LUIS with your Microsoft account.

   :::image type="content" source="../media/4-sign-in-luis.png" alt-text="Screenshot that shows signing in to LUIS." lightbox="../media/4-sign-in-luis.png":::

1. In the pop-up window that appears, select your subscription.

   :::image type="content" source="../media/4-select-subscription.png" alt-text="Screenshot that shows selecting a subscription." lightbox="../media/4-select-subscription.png":::

   > [!NOTE]
   > Make sure you're using the same Azure directory as the one you used to create the health bot.

1. After you select your Azure subscription, choose **Select or create an authoring resource**.

   :::image type="content" source="../media/4-select-authoring.png" alt-text="Screenshot that shows selecting an authoring resource.":::

1. You're then given an option to either select or create an authoring resource for your LUIS app. If you already have an authoring resource, select it from the **Authoring Resource** dropdown menu.

   To create a new authoring resource, select **Create a new authoring resource**.

   :::image type="content" source="../media/4-new-authoring.png" alt-text="Screenshot that shows creating a new authoring resource.":::

1. Under the **Create a new authoring resource** menu that appears, select the subscription where you want to create your authoring resource. Select the resource group that you provisioned when you created your health bot earlier, and then select your pricing tier.

   Select the location where you want to create this resource, and then select **Done**.

   :::image type="content" source="../media/5-health-bot-authoring-resource.png" alt-text="Screenshot that shows authoring resource details.":::

   The next time you sign in to LUIS, you can select the same authoring resource that you've created.

   > [!NOTE]
   > Make sure that the **Azure resource name** box doesn't contain the name of an authoring resource that you've already created.
  
You've finished creating your authoring resource for LUIS. Now you can begin to create a new LUIS conversation app, which you'll later integrate into your health bot.

## Create your LUIS conversation app

1. Under **Conversation apps**, select **New app**.

   :::image type="content" source="../media/4-new-luis-app.png" alt-text="Screenshot that shows the New app option.":::

1. On the pop-up menu that appears, fill in appropriate details about the app that you want to create. For example, to create an app to book appointments, fill in the details as shown in the following image. For the **Prediction resource** option, select the LUIS resource you created earlier.

   :::image type="content" source="../media/4-luis-app-details.png" alt-text="Screenshot that shows LUIS app details.":::

   After you've filled in details about your conversation app, select **Done**.

1. After your conversation app is created, you can access it from the LUIS home page.

   :::image type="content" source="../media/5-health-bot-app-details.png" alt-text="Screenshot that shows filling in app details." lightbox="../media/5-health-bot-app-details.png":::

## Add entities to your conversation app

An *entity* is a word in your utterance that your LUIS app can identify and do something with. In this case, your LUIS app is used to book an appointment with a doctor. You're creating a *doctor_type* entity that includes a list of the different types of doctors that your customer might want to make an appointment with.

For this entity, create a sublist that identifies the type of doctor. An example is *dermatologist*. You'll also add synonyms that might be used to refer to that type of doctor. An example is *skin doctor*. Then you'll create a prebuilt time entity to recognize the time to book the appointment.

1. From the LUIS home page, select your conversation app.

1. On the **Language Understanding** page for your app, in the pane on the left, select **Entities**. Select **Create** to create a new entity for your conversation app. Name your entity **doctor_type**, and select **List** as your entity type. Select **Create**.

   :::image type="content" source="../media/4-create-entity.png" alt-text="Screenshot that shows the creating an entity.":::

1. You're then directed to the page of your newly created entity. Under **List items**, enter values for different types of doctors that your customers might want to see. Also add their respective synonyms. For example, add the synonym *skin doctor* for *dermatologist*.

   :::image type="content" source="../media/4-add-list-items.png" alt-text="Screenshot that shows adding list items." lightbox="../media/4-add-list-items.png":::

1. In the pane on the left, select **Entities**. Select the **Add prebuilt entity** option, and enter **datetime** in the search bar. Select its latest version, and select **Done**.

   :::image type="content" source="../media/4-add-datetime-entity.png" alt-text="Screenshot that shows adding a prebuilt entity.":::

## Create intents for your conversation app

An *intent* is an action you want to perform on one or more entities. In this case, you're defining an intent to book appointments. Then specify sample utterances that indicate the kind of language used to indicate the intent.

1. On the **Language Understanding** page for your app, in the pane on the left, select **Intents**. Select **Create** to create an intent.

   :::image type="content" source="../media/4-create-intent.png" alt-text="Screenshot that shows creating an intent.":::

   > [!TIP]
   > If you want to add a prebuilt intent from LUIS instead of creating your own, select the **Add prebuilt domain** intent option instead. Then you can choose an intent from the numerous built-in intents in LUIS.

1. Give your intent a name. Because you're making an appointment booking conversation app, name it **BookAppointment**. After you've named your intent, select **Done**.

   :::image type="content" source="../media/4-name-intent.png" alt-text="Screenshot that shows naming your intent.":::

   > [!NOTE]
   > Make sure that the name of your intent doesn't have spaces or dots in it. Your intent will later turn into a language model for Health Bot where spaces and dots aren't allowed in language model names.

1. You're redirected to your intent's home page. Under **Examples** in the **Example user input** section, add utterances that your user is likely to ask your conversation app about appointment booking. For example:

   - I would like to book an appointment.
   - How do you make a booking?
   - I need to schedule some time with a doctor.
  
   You'll see that some of the words, specifically words that have to do with the type of doctors, location, and time, are underlined. Underlining shows that LUIS has successfully recognized the entities that you created earlier from the utterances that you just entered.

   :::image type="content" source="../media/4-enter-example.png" alt-text="Screenshot that shows entering example intents." lightbox="../media/4-enter-example.png":::

> [!TIP]
> If you can't see your underlined entities, make sure that the respective options to view your entities are selected under **View options** on the right side of the page under **Examples**.

## Train, test, and publish your conversation app

Now you're ready to use the data you've provided in the form of entities, intents, and utterances to train your LUIS app.

1. At the top of the **Language Understanding** page for your app, select **Train** to train your LUIS app. This process might take some time to finish.

   :::image type="content" source="../media/4-train-model.png" alt-text="Screenshot that shows the Train button.":::

1. After the model is trained, select **Test**. Use the **Test** pane to view the predicted intent for the following phrases:

   - I wish to go to a movie.
   - I would like to book an appointment.
   - Could you book me an appointment with the skin specialist at 3 PM tomorrow?

   > [!NOTE]
   > You might initially see that all these test utterances are classified as having a BookAppointment intent. This situation happens if you haven't trained the app on enough samples.

1. On the **Test** pane, select the incorrectly classified test utterances. You'll see a pane open. Under **Top-scoring intent**, select **Assign to a new intent**. In the dropdown box that appears, assign your test utterance to the correct intent.

   :::image type="content" source="../media/4-correct-model.png" alt-text="Screenshot that shows assigning an utterance to a new intent." lightbox="../media/4-correct-model.png":::

   To improve your LUIS app, train and test it with more sample utterances.

1. After you're satisfied with the performance of your app, go ahead and publish it.
At the top of the **Language Understanding** page for your app, select **Publish**. On the pop-up menu that appears, select **Production Slot**. Then select **Done**. It might take a few minutes for your app to be published.

   :::image type="content" source="../media/4-publish-app.png" alt-text="Screenshot that shows selecting the Production Slot option.":::

After your app is published, move on to the process of integrating it into your Health Bot instance.
