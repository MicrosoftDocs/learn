In this module, you explore the Azure Speech Service's intent recognition. The intent recognition allows you to equip your application with AI-powered speech commands, where users can say non-specific speech commands and still have their intent understood by the system.

## Prepare the scene

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Intent Recognizer (Script)** component to the Lunarcom object:

    :::image type="content" source="../media/intent-recognizer.png" alt-text="Screenshot of Add the Lunarcom Intent Recognizer (Script) component." lightbox="../media/intent-recognizer.png":::

2. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.GettingStarted** > **Prefabs** > **RocketLauncher** folder, drag the **RocketLauncher_Complete** prefab into your Hierarchy window, and place it at a suitable location in front of the camera, for example:

    * Transform **Position** X = 0, Y = -0.4, Z = 1
    * Transform **Rotation** X = 0, Y = 90, Z = 0

    :::image type="content" source="../media/rocket-launcher-prefab.png" alt-text="Screenshot of Add the RocketLauncher_Complete prefab." lightbox="../media/rocket-launcher-prefab.png":::

3. In the Hierarchy window, select the **Lunarcom** object again, then expand the **RocketLauncher_Complete** > **Button** object and assign each of the **Buttons** object's child objects to the corresponding **Lunar Launcher Buttons** field:

    :::image type="content" source="../media/assign-buttons.png" alt-text="Screenshot of Assigning each of the buttons." lightbox="../media/assign-buttons.png":::

## Create the Azure language understanding resource

In this section, you'll create an Azure prediction resource for the Language Understanding Intelligent Service (LUIS) app you'll create in the next section.

1. Sign in to [Azure portal](https://portal.azure.com) and select **Create a resource**. Then search for and select **Language Understanding**:

    :::image type="content" source="../media/azure-prediction-resource.png" alt-text="Screenshot of Azure prediction resource." lightbox="../media/azure-prediction-resource.png":::

2. Select the **Create** button to create an instance of this service:

    :::image type="content" source="../media/instance-service.png" alt-text="Screenshot of create an instance of this service." lightbox="../media/instance-service.png":::

3. On the Create page, select the **Prediction** option and enter the following values:

    * For **Subscription**, select **Free Trail** if you have a trial subscription. If you don't have a trial subscription, select one of your other subscriptions.
    * For the **Resource group**, select the **Create new** link, enter a suitable name, for example: *MRKT-Tutorials*. Select **OK**.

    :::image type="content" source="../media/prediction-option.png" alt-text="Screenshot of Configure the prediction option." lightbox="../media/prediction-option.png":::

    > [!NOTE]
    > As of the time of this writing, you do not need to create an authoring resource, because an authoring trial key will automatically be generated within LUIS when you create the Language Understanding Intelligent Service (LUIS) in the next section.
    > [!TIP]
    > If you already have another suitable resource group in your Azure account, you may use this resource group instead of creating a new one.

4. While still on the Create page, enter the following values:

    * For **Name**, enter a suitable name for the service, for example: *MRTK-Tutorials-AzureSpeechServices*
    * For **Prediction location**, choose a location close to your app users' physical location, for example: *(US) West US*
    * For **Prediction pricing tier**, in this tutorial, select **F0 (5 Calls per second, 10K Calls per month)**

    :::image type="content" source="../media/create-page.png" alt-text="Screenshot of Configure the create page." lightbox="../media/create-page.png":::

5. Next, select **Review + create**, review the details, and then select the **Create** button at the bottom of the page to create the resource (and the new resource group if you configured one to be created):

    :::image type="content" source="../media/review-details.png" alt-text="Screenshot of Review the details." lightbox="../media/review-details.png":::

    > [!NOTE]
    > Creating your new resources might take a few minutes.

6. Once the resource creation process is completed, you'll see the message **Your deployment is complete**:

    :::image type="content" source="../media/message-display.png" alt-text="Screenshot of Message display." lightbox="../media/message-display.png":::

## Create the language understanding intelligent service (LUIS)

In this section, you create a LUIS app, configure and train its prediction model, and connect it to the Azure prediction resource you created in the previous step.

Specifically, you create an intent that if the user says an action should be taken, the app triggers the `Interactable. OnClick()` event on one of the three red buttons in the scene, depending on which button the user references.

For example, if the user says **go ahead and launch the rocket**, the app predicts that **go ahead** means some **action** should be taken, and that the `Interactable. OnClick()` event to **target** is on the **launch** button.

The main steps you'll take to achieve this are:

1. Create a LUIS app
2. Create intents
3. Create example utterances
4. Create entities
5. Assign entities to the example utterances
6. Train, test, and publish the app
7. Assign an Azure prediction resource to the app

## 1. Create a LUIS app

Using the same user account you used when creating the Azure resource in the previous section, sign in to [LUIS](https://www.luis.ai), select your country/region, and agree to the terms of use. In the next step, when asked to **Link your Azure account**, choose **Continue using your trial key**, to use an Azure authoring resource instead.

> [!NOTE]
> If you've already signed up for LUIS and your authoring trial key has expired, you can refer to the [Migrate to an Azure resource authoring key](/azure/ai-services/luis/luis-migration-authoring) documentation to switch your LUIS authoring resource to Azure.

1. Once signed in, select **New app** and enter the following values in the **Create new app** popup window:

    * For **Name**, enter a suitable name, for example: *MRTK Tutorials - AzureSpeechServices*
    * For **Culture**, select **English**
    * For **Description**, optionally enter a suitable description
    * For **Prediction resource**, select the prediction resource by dropdown list that had been created Azure portal.

2. Select **Done** to create the new app:

    :::image type="content" source="../media/done-button.png" alt-text="Screenshot representing Select the done button." lightbox="../media/done-button.png":::

3. When the new app has been created, you are taken to that app's **Dashboard** page:

    :::image type="content" source="../media/apps-dashboard-page.png" alt-text="Screenshot of App's dashboard page." lightbox="../media/apps-dashboard-page.png":::

## 2. Create intents

1. From the Dashboard page, navigate to the Build > App Assets > **Intents** page, then select **Create** and enter the following value in the **Create new intent** popup window:

    * For **Intent name**, enter **PressButton**

2. Select **Done** to create the new intent:

    :::image type="content" source="../media/new-intent.png" alt-text="Screenshot of Create a new intent." lightbox="../media/new-intent.png":::

    > [!CAUTION]
    > For the purpose of this tutorial, your Unity project will reference this intent by its name (`PressButton`). It is extremely important that you name your intent exactly the same.

3. When the new intent has been created, you are taken to that intent's page:

    :::image type="content" source="../media/intent-page.png" alt-text="Screenshot of Intent's page." lightbox="../media/intent-page.png":::

## 3. Create example utterances

1. To the **PressButton** intent's **Example utterance** list, add the following example utterances:

    * activate launch sequence
    * show me a placement hint
    * initiate the launch sequence
    * press placement hints button
    * give me a hint
    * push the launch button
    * i need a hint
    * press the reset button
    * time to reset the experience
    * go ahead and launch the rocket

2. When you have added all the example utterances, your PressButton intent page should look like this:

    :::image type="content" source="../media/button-intent-page.png" alt-text="Screenshot of PressButton intent page." lightbox="../media/button-intent-page.png":::

    > [!CAUTION]
    > For the purpose of this tutorial, your Unity project will reference the words "hint", "hints", "reset", and "launch". It is extremely important that you spell these words in the exact same way in all instances.

## 4. Create entities

1. From the PressButton intent page, navigate to the Build > App Assets > **Entities** page, then select **Create** and enter the following values in the **Create new entity** popup window:

    * For **Entity name**, enter **Action**
    * For **Entity type**, select **Machine learned**

2. Select **Create** to create the new entity:

    :::image type="content" source="../media/create-intent.png" alt-text="Screenshot of Create a new entity." lightbox="../media/create-intent.png":::

3. Repeat the previous step to create another entity named **Target**, so you have two entities named *Action* and *Target*:

    :::image type="content" source="../media/target-entity.png" alt-text="Screenshot of Create a target entity." lightbox="../media/target-entity.png":::

    > [!CAUTION]
    > For the purpose of this tutorial, your Unity project will reference these entities by their names, `Action` and `Target`. It is extremely important that you name your entities exactly the same.

## 5. Assign entities to the example utterances

From the Entities page, navigate back to the **PressButton** intent page.

1. Once back on the PressButton intent page, select the word **go** and then on the word **ahead**, then select **Action (Simple)** from the contextual popup menu to label **go ahead** as an **Action** entity value:

    :::image type="content" source="../media/label-action.png" alt-text="Screenshot of Label go ahead as an action entity value." lightbox="../media/label-action.png":::

2. The **go ahead** phrase is now defined as an **Action** entity value. There's now an action entity value under the words "go ahead":

    :::image type="content" source="../media/notice-action.png" alt-text="Screenshot of Notice the action entity value." lightbox="../media/notice-action.png":::

    > [!NOTE]
    > The red line you see under the label in the image indicates that the entity value has not been predicted; this will be resolved when you train the model in the next section.

3. Next, select the word **launch**, then select **Target (Simple)** from the contextual popup menu to label **launch** as a **Target** entity value:

    :::image type="content" source="../media/word-launch.png" alt-text="Screenshot of select the word launch." lightbox="../media/word-launch.png":::

4. The **launch** word is now defined as a **Target** entity value. There's now a Target entity value under the word "launch":

    :::image type="content" source="../media/notice-target.png" alt-text="Screenshot of Notice the Target entity value under the word launch." lightbox="../media/notice-target.png":::

5. The PressButton intent example utterance `go ahead and launch the rocket` is now configured to be predicted as follows:

    * Intent: PressButton
    * Action entity: go ahead
    * Target entity: launch

6. Repeat the previous process to assign an Action and a Target entity label to each of the example utterances, keeping in mind that the following words should be labeled as **Target** entities:

    * **hint** (targets the HintsButton in the Unity project)
    * **hints** (targets HintsButton in the Unity project)
    * **reset** (targets the ResetButton in the Unity project)
    * **launch** (targets the LaunchButton in the Unity project)

7. When you have labeled all the example utterances, your PressButton intent page should look like this:

    :::image type="content" source="../media/utterances-label.png" alt-text="Screenshot of All the example utterances have been labeled." lightbox="../media/utterances-label.png":::

## 6. Train, test and publish the app

1. To train the app, select the **Train** button and wait for the training process to complete:

    :::image type="content" source="../media/train-app.png" alt-text="Screenshot of Train the app." lightbox="../media/train-app.png":::

    > [!NOTE]
    > As you can see in the image above, the red lines under all the labels have been removed, indicating that all the entity values are predicted. Also, notice that the status icon to the left of the Train button has changed color from red to green.

2. When the training is finished processing, select the **Test** button, then type in **go ahead and launch the rocket** and press the Enter key:

    :::image type="content" source="../media/click-test-button.png" alt-text="Screenshot of select the test button." lightbox="../media/click-test-button.png":::

3. When the test utterance has been processed, select **Inspect** to see the test result:

    * Intent: PressButton (with a 98.5% certainty)
    * Action entity: go ahead
    * Target entity: launch

    :::image type="content" source="../media/inspect-test-results.png" alt-text="Screenshot of select inspect to see the test results." lightbox="../media/inspect-test-results.png":::

4. To publish the app, select the **Publish** button in the top right, then in the **Choose your publishing slot and settings** popup window, select **Production** and select the **Done** button:

    :::image type="content" source="../media/publish-app.png" alt-text="Screenshot of Publish the app." lightbox="../media/publish-app.png":::

5. Wait for the publishing process to complete:

    :::image type="content" source="../media/publish-process.png" alt-text="Screenshot of Wait for the publishing process to complete." lightbox="../media/publish-process.png":::

6. Navigate to the Manage > Application Settings > **Azure Resources** page. Your Azure Resources page should look similar to this:

    :::image type="content" source="../media/azure-resources-page.png" alt-text="Screenshot of Azure resources page." lightbox="../media/azure-resources-page.png":::

## Connect the unity project to the LUIS app

1. On the Manage > Application Settings > **Azure Resources** page, select the **Copy** icon to copy the **Example Query**:

    :::image type="content" source="../media/connecting-unity-project.png" alt-text="Screenshot of Connecting the unity project." lightbox="../media/connecting-unity-project.png":::

2. Back in your Unity project, in the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, locate the **Lunarcom Intent Recognizer (Script)** component and configure it as follows:

    * In the **LUIS Endpoint** field, pass the **Example Query** you copied in the previous step. Make sure to remove `YOUR_QUERY_HERE` from the URL:

    :::image type="content" source="../media/example-query.png" alt-text="Screenshot of Pass the example query you copied." lightbox="../media/example-query.png":::

## Test and improve the intent recognition

1. To use intent recognition directly in the Unity editor, you must allow your development computer to use dictation. To verify this setting, open Windows Settings, then choose **Privacy** > **Speech** and ensure **Online speech recognition** is turned on:

    :::image type="content" source="../media/intent-recognition.png" alt-text="Screenshot of Testing the intent recognition." lightbox="../media/intent-recognition.png":::

2. If you enter Game mode, you can test the intent recognition by first pressing the rocket button. Then, assuming your computer has a microphone, when you say the first example utterance, **go ahead and launch the rocket**, you'll see the LunarModule launch into space:

    :::image type="content" source="../media/press-rocket-button.png" alt-text="Screenshot of Enter the game mode." lightbox="../media/press-rocket-button.png":::

3. Try all the example utterances, then some variation of the example utterances, and a few random utterances.

4. Next, return to [LUIS](https://www.luis.ai) and navigate to Build > Improve app performance > **Review endpoint utterances** page. Use the **toggle** button to switch from the default Entities View to **Tokens View**, and then review the utterances:

    * In the **Utterance** column, change and remove the assigned labels as needed so they align with your intent
    * In the **Aligned intent** column, verify that the intent is correct
    * In the **Add/Delete** column, select the green check mark button to add the utterance or the red x button to delete it.

5. When you have reviewed as many utterances as you like, select the **Train** button to retrain the model, then the **Publish** button to republish the updated app:

    :::image type="content" source="../media/retrain-model.png" alt-text="Screenshot of Retrain the model." lightbox="../media/retrain-model.png":::

    > [!NOTE]
    > If an endpoint utterance does not align with the PressButton intent, but you would like your model to know that the utterance has no intent, you can change the Aligned intent to None.

6. **Repeat** this process as many times as you like to improve your app model.
