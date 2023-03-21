Integrating various LUIS models into your Azure Health Bot instance enables you to provide a wide range of services that are personalized for your users.

## Import the Booking appointments template scenario

When you finish integrating the LUIS app that you created into your health bot later, you have to map it to a scenario. For this purpose, you use a pre-existing template scenario, **Booking appointments**.

1. Go to the home page of your health bot. In the pane on the left, under **Scenarios** select **Template catalog**.

1. Scroll down to **Popular Templates**, and select **Booking appointments**.

   :::image type="content" source="../media/6-health-bot-select-template.png" alt-text="Screenshot that shows selecting a Scenario template.":::

   In the **Import Booking appointments template** pane on the right, select **Import template**. After it's imported, you'll see a message in the upper-right corner of the page that says *Import completed successfully*. You're redirected to the scenario editor.

   :::image type="content" source="../media/6-health-bot-import-template.png" alt-text="Screenshot that shows importing a template.":::

1. Go back to the home page of your health bot. In the pane on the left, under **Scenarios** select **Manage**.

1. You should see your appointment scheduling scenario under **Scenario Management**.

## Copy the required keys from the LUIS portal

At the top of the **Language Understanding** page for your app, select the **MANAGE** tab. You need two keys to export your LUIS model to your health bot. The first one you need is an app ID. In the pane on the left, select **Settings**. Then under **Application Settings**, look for a value in **App ID**.

   :::image type="content" source="../media/5-app-id.png" alt-text="Screenshot that shows App ID." lightbox="../media/5-app-id.png":::

The other key you need is the primary key of your app. In the **Settings** pane on the left, select **Azure Resources**. There are two tabs, **Prediction Resources** and **Authoring Resource**. To export your app to your health bot, make sure you use the **Primary Key** value from the **Prediction Resources** tab so that Health Bot can make endpoint queries to your app.

   :::image type="content" source="../media/5-primary-key.png" alt-text="Screenshot that shows Primary Key." lightbox="../media/5-primary-key.png":::

You must specify these two keys during the creation of the language model in your health bot.

## Create a new language model in your health bot

1. Go to the home page of your health bot. In the pane on the left, under **Language** select **Models**. At the top of the **Language models** page, select **New** to create a new language model.

   :::image type="content" source="../media/6-health-bot-new-language-model.png" alt-text="Screenshot that shows the Language models New button.":::

   In the **New model** pane on the right, you need to enter details about your new language model, which is the conversation app that you created in LUIS.

1. Enter the appropriate details for the name and description of your new language model. Under **Method**, make sure you choose **LUIS (NLP)** because you're exporting your LUIS app to your health bot. Fill in the other boxes:

   * **Region**: Make sure that the selected region is the same as the region of your prediction resource. To check, go back to the LUIS portal and look in **Azure Resources** on the **MANAGE** tab.
   * **Application ID**: Go back to the LUIS portal. Select the **MANAGE** tab, and then select **Settings** in the pane on the left. Copy your **App ID**. Go back to the language model creation menu in your health bot and paste it in the **Application ID** box.
   * **Subscription key**: Go back to the LUIS portal. Select the **MANAGE** tab, and then select **Azure Resources** in the pane on the left. Copy the **Primary Key** from the **Prediction Resource** tab. Go back to the language model creation menu in the Health Bot portal and paste it in the **Subscription key** box.
   * **Bing Speller subscription key**, **Use staging model**, and **Verbose**: These boxes are for other features that you can enable for your LUIS application. For this tutorial, you can leave the defaults.

      :::image type="content" source="../media/5-language-model-details.png" alt-text="Screenshot that shows language model details.":::

## Fetch intents from LUIS and map them to a scenario

1. After you fill the **Application ID** and **Subscription key** boxes, scroll down to the bottom of the menu and select **Fetch LUIS intents**.

   :::image type="content" source="../media/5-fetch-luis-intents.png" alt-text="Screenshot that shows the Fetch LUIS intents button.":::

1. Your intents from the **BookAppointment** LUIS app have been exported to your health bot. Map it to the **Booking appointments** scenario that you imported earlier by selecting it from the dropdown menu. Select **Create**.

   :::image type="content" source="../media/5-map-intents.png" alt-text="Screenshot that shows mapping intents to a scenario.":::

You've now successfully imported your LUIS app into your health bot.

## Test your language model in Web Chat

Now test your new language model in Web Chat.

:::image type="content" source="../media/6-health-bot-test-model.png" alt-text="Screenshot that shows testing the language model in Web Chat.":::
