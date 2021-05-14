Being able to integrate various LUIS models into your Azure Health Bot enables you to provide a wide range of services that are personalized for your end users.

## Import the 'Booking appointments' template scenario

When you finish integrating the LUIS App that you have created into the Azure Health Bot later on, you will need to map it to a scenario. For this purpose, you will use an already existing template scenario, 'Booking appointments'.

1. Navigate to the home page of your Azure Health Bot. In the pane on the left, select 'Template catalog' under 'Scenarios'.

2. Scroll down to 'Popular Templates' and select 'Booking appointments'

   :::image type="content" source="../media/5-create-template.png" alt-text="Create Scenario template":::

   A pane appears on the right side with the heading, 'Import Booking appointments template'. Click on 'Import template'. Once it is imported, you will see a message on the top right corner of the page saying, 'Import completed successfully' and you will be redirected to the scenario editor.

   :::image type="content" source="../media/5-import-template.png" alt-text="Import template":::

3. Click on the 'Save' button on the top left corner of the editor.

   :::image type="content" source="../media/5-save-template.png" alt-text="Save template":::

4. Once the scenario has been saved, navigate back to the home page of your Azure Health Bot. In the pane on the left, select 'Manage' under 'Scenarios'.

5. You should see your appointment scheduling scenario under Scenario Management.

## Copy the required keys from the LUIS Portal

At the top of the Language Understanding page for your app, click on 'MANAGE'. You will need 2 keys to export our LUIS model to the Azure Health Bot. The first one is the App ID. In the pane on the left, select 'Settings'. You will then see an App ID under Application Settings.

   :::image type="content" source="../media/5-app-id.png" alt-text="App ID" lightbox="../media/5-app-id.png":::  

The other key that you will need is the primary key of your app. In the pane on the left, select 'Azure Resources'. You will then see 2 tabs, 'Prediction Resources' and 'Authoring Resource'. To export your app to the Azure Health Bot, make sure you use the 'Primary Key' from the 'Prediction Resources' tab so that the Azure Health Bot can make endpoint queries to your app.

   :::image type="content" source="../media/5-primary-key.png" alt-text="Primary key" lightbox="../media/5-primary-key.png":::  

You will need to specify these two keys during the creation of the language model in the Azure Health Bot.

## Create a new language model in your Azure Health Bot

1. Navigate to the home page of your Azure Health Bot. In the pane on the left, select 'Models' under 'Language'. At the top of the 'Language models' page that appears, click on 'New' to create a new language model.

   :::image type="content" source="../media/5-new-language-model.png" alt-text="New Language Model":::

   A pane appears at the right side with the heading, 'New model'. Here, you will need to enter details about your new language model which is the conversation app that you created in LUIS.

2. Enter the appropriate details for the name and description of your new language model. Under 'Method', make sure you choose 'LUIS (NLP)' since we are exporting our LUIS app to the Azure Health Bot.  

   Under 'Region', make sure that the selected region is the same as the region of your prediction resource (You can check this by navigating back to the LUIS portal and checking it in 'Azure Resources' under the 'MANAGE' tab at the top of the page).  

   For your Application ID, navigate back to the LUIS portal. Click on the 'MANAGE' tab at the top of the page and then select 'Settings' in the pane on the left. Copy your App ID. Then navigate back to the language model creation menu in your Azure Health Bot and paste it in the 'Application ID' field.  

   For your Subscription ID, navigate back to the LUIS portal. Click on the 'MANAGE' tab at the top of the page and then select 'Azure Resources' in the pane on the left. Copy the Primary Key from the Prediction Resource tab. Then navigate back to the language model creation menu in the Azure Health Bot portal and paste it in the 'Subscription key' field.  

   The Bing, Staging and Verbose fields are additional features that you can enable for your LUIS application. For this tutorial you can leave the defaults.

   :::image type="content" source="../media/5-language-model-details.png" alt-text="Language model details":::

## Fetch intents from LUIS and map them to a scenario

1. Once you fill the Application ID and Subscription Key fields, scroll down to the bottom of the menu and click on 'Fetch LUIS intents'.

   :::image type="content" source="../media/5-fetch-luis-intents.png" alt-text="Fetch LUIS intents":::

2. You will see that your intents from the 'BookAppointment' LUIS app have been exported to the Azure Health Bot. Map it to the 'Booking appointments' scenario that we imported earlier by selecting it from the drop-down menu. Click on 'Create' once done.

   :::image type="content" source="../media/5-map-intents.png" alt-text="Map intents to scenario":::

You have now successfully imported your LUIS app into the Azure Health Bot.

## Test out your new language model in the Web Chat

:::image type="content" source="../media/5-test-model.png" alt-text="Test language model on webchat" lightbox="../media/5-test-model.png":::
