In this unit, you will train a conversation app in LUIS which will take in examples of various queries that might be asked to the Health Bot and then trigger the appropriate response or scenario. Before you get started, please make sure that you have already created an Azure Health Bot through the Azure portal.

Creating a LUIS App with language understanding consists of two main tasks:

1. Defining entities, intents, and utterances with which to train the language model - referred to as *authoring* the model.
2. Publishing the model so that client applications can use it for intent and entity prediction based on user input.
  
## Azure resources for Language Understanding

For each of the authoring and prediction tasks, you need a resource in your Azure subscription. You can use the following types of resources:

- **Language Understanding:** A dedicated resource for Language Understanding, which can be either an *authoring* or a *prediction* resource.
- **Cognitive Services:** A general cognitive services resource that includes Language Understanding along with many other cognitive services. You can only use this type of resource for *prediction*.  

The separation of authoring and prediction resources is useful when you want to track resource utilization for language model training separately from client applications using the model to generate predictions.
  
If you choose to create a Language Understanding resource, you will be prompted to choose *authoring, prediction*, or *both* - and it's important to note that if you choose "both", then **two** resources are created - one for authoring and one for prediction.
  
Alternatively, you can use a dedicated Language Understanding resource for authoring, but deploy your model to a generic Cognitive Services resource for prediction. When your client application uses other cognitive services in addition to Language Understanding, this approach enables you to manage access to all of the cognitive services being used, including the Language Understanding prediction service, through a single endpoint and key.
  
In this module, we'll be using the **Language Understanding** resource.

## Sign into the LUIS portal

1. Open your browser and go to luis.ai. Select the 'Sign In' option on the top right corner of the page and then sign into LUIS with your Microsoft account.

   :::image type="content" source="../media/4-sign-in-luis.png" alt-text="Sign in to LUIS" lightbox="../media/4-sign-in-luis.png":::  

2. You will then be redirected to the following page where you will have to select your subscription in the pop-up window that appears.

   :::image type="content" source="../media/4-select-subscription.png" alt-text="Select subscription" lightbox="../media/4-select-subscription.png":::

   > [!NOTE]
   > Make sure you are using the same Azure Directory as the one which you used to create the Azure Health Bot Instance.

3. Once you are done selecting your Azure subscription, click on the blue button which appears.

   :::image type="content" source="../media/4-select-authoring.png" alt-text="Select authoring resource":::  

1. You will then be given an option to either select or create an authoring resource for your LUIS App. If you already have an authoring resource, you can select it from the 'Authoring Resource' dropdown menu.  

   To create a new authoring resource, select the text 'Create a new authoring resource' which is highlighted in blue.  

   :::image type="content" source="../media/4-new-authoring.png" alt-text="New authoring resource":::

1. Under the 'Create new Azure Cognitive Services account' menu that appears, select the subscription in which want to create your authoring resource and then select the resource group that you provisioned while creating your Azure Health Bot earlier.

   Select the location where you want to create this resource and then click on the blue 'Done' button.

   :::image type="content" source="../media/4-authoring-resource.png" alt-text="Authoring resource details":::

   Next time, when you log into LUIS, you can select the same authoring resource that you've created.

   > [!NOTE]
   > Make sure that the 'Azure resource name' field does not contain the name of an authoring resource that you have already created.
  
You have now finished creating your authoring resource for LUIS. You can now begin creating a new LUIS conversation app which you will later integrate into the Azure Health Bot.  

## Create your LUIS Conversation App

1. Select the 'New App' button under Conversation apps.  

   :::image type="content" source="../media/4-new-luis-app.png" alt-text="New LUIS App":::

1. On the popup menu that appears, fill in appropriate details about the app that you want to create. For example, to create an app to book appointments, you will fill in the details as shown in the image below. For the 'Prediction resource' option, you will need to select the cognitive services resource that you created earlier while provisioning your Azure Health Bot on the Azure portal.

   :::image type="content" source="../media/4-luis-app-details.png" alt-text="LUIS app details":::  

   Once you are done filling in details about your conversation app, click on 'Done'.

1. Once your conversation app is created, you will be able to access it from the LUIS home page.

   :::image type="content" source="../media/4-app-details.png" alt-text="Fill in app details" lightbox="../media/4-app-details.png":::

## Add Entities to your Conversation App

An entity is a word in your utterance that your LUIS app can identify and do something with. In this case, your LUIS app will be used to book an appointment with a doctor; so, you'll create a *doctor_type* entity that includes a list of the different types of doctors that your customer might want to make an appointment with.

For this entity, you'll create a sublist that identifies the type of doctor (for example *dermatologist*) and any synonyms that might be used to refer to that type of doctor (for example *skin doctor*). You will also be creating a prebuilt time entity to recognize the time at which to book the appointment.

1. From the LUIS homepage, click on your conversation app.

1. In the language understanding page for your app, in the pane on the left, select 'Entities'. Click on the 'Create' button to create a new entity for your conversation app. Name your entity as 'doctor_type' and select 'List' as your entity type. Once you are done, click on 'Create'.

   :::image type="content" source="../media/4-create-entity.png" alt-text="Create entity":::

1. You will then be directed to the page of your newly created entity. Under 'List items', start typing in values of different types of doctors that your customers might want to go to and add their respective synonyms (For example, add the synonym *skin doctor* for *dermatologist*)

   :::image type="content" source="../media/4-add-list-items.png" alt-text="Add list items" lightbox="../media/4-add-list-items.png":::

1. In the pane on the left, select 'Entities'. Select the 'Add prebuilt entity' option and type 'datetime' in the search bar. Select its latest version and click on 'Done'.

   :::image type="content" source="../media/4-add-datetime-entity.png" alt-text="Add datetime entity":::

## Create Intents for your Conversation App

An *intent* is an action you want to perform on one or more *entities*. In this case, you'll define an intent to book appointments and then you'll specify sample *utterances* that indicate the kind of language used to indicate the intent.

1. In the language understanding page for your app, in the pane on the left, select 'Intents'. Click on the 'Create' button to create an intent.

   :::image type="content" source="../media/4-create-intent.png" alt-text="Create Intent":::

   > [!TIP]
   > If you want to add a prebuilt intent from LUIS instead of creating your own, select the 'Add prebuilt domain' intent option instead. You will then be able to choose an intent from the numerous inbuilt intents in LUIS.

1. Give your intent a name. Since you are making an appointment booking conversation app, name it as 'BookAppointment'. Once you finish naming your intent, click on the blue 'Done' button.

   :::image type="content" source="../media/4-name-intent.png" alt-text="Name your intent":::

   > [!NOTE]
   > Make sure that the name of your intent has neither spaces nor dots in it. Your intent will later turn into a language model for the Azure Health Bot where spaces and dots aren't allowed in language model names.

1. You will then be redirected to your intent's homepage. In the 'Example user input' section under 'Examples', start adding utterances that your user is likely to ask your conversation app like the following in the case of appointment booking:  

   - I would like to book an appointment  
   - How do you make a booking?  
   - I need to schedule some time with a doctor  
  
   You might have noticed that some of the words, specifically those that have to do with the type of doctors, location and time are underlined. This shows that LUIS has successfully recognized the entities that we had created earlier from the utterances that we just entered.

   :::image type="content" source="../media/4-enter-example.png" alt-text="Enter example intents" lightbox="../media/4-enter-example.png":::

> [!TIP]
> If you aren't able to see your underlined entities, then make sure that the respective options to view your entities are selected under 'View options' on the right side of the page under 'Examples'.

## Train, test and publish your conversation app

Now you're ready to use the data you've provided in the form of entities, intents, and utterances to train your LUIS app.

1. At the top of the Language Understanding page for your app, click on 'Train' to train your LUIS app. This process might take some time to finish.

   :::image type="content" source="../media/4-train-model.png" alt-text="Train language model":::

1. Once the model is trained, click on 'Test' and use the Test pane to view the predicted intent for the following phrases:

   - I wish to go to a movie
   - I would like to book an appointment
   - Could you book me an appointment with the skin specialist at 3 PM tomorrow?

   > [!NOTE]
   > You might initially see that all these test utterances are classified as having a  BookAppointment intent. This happens if you haven't trained the app on enough samples.

1. On the test pane, select the wrongly classified test utterances. You will see a pane open on the right. Select 'Assign to a new intent' under 'Top-scoring intent'. In the dropdown box that appears, assign your test utterance to the correct intent.

   :::image type="content" source="../media/4-correct-model.png" alt-text="Correct model" lightbox="../media/4-correct-model.png":::

   You can keep improving your LUIS app by training and testing it with more sample utterances.

1. Once you are satisfied with the performance of your app, go ahead and publish it.  
At the top of the Language Understanding page for your app, click on 'Publish'.  On the pop-up menu that appears, select 'Production Slot' and then click on 'Done'. It might take a few minutes for your app to get published.

   :::image type="content" source="../media/4-publish-app.png" alt-text="Publish App":::

Once your app is published, you can move on to the process of integrating it into the Azure Health Bot.
