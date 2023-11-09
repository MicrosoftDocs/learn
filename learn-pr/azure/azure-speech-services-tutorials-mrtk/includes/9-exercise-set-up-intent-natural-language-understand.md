In this module, you explore the Azure Speech Service's intent recognition. The intent recognition allows you to equip your application with AI-powered speech commands, where users can say nonspecific speech commands and still have their intent understood by the system.

## Prepare the scene

1. In the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, use the **Add Component** button to add the **Lunarcom Intent Recognizer (Script)** component to the Lunarcom object:

    :::image type="content" source="../media/intent-recognizer.png" alt-text="Screenshot of Add the Lunarcom Intent Recognizer (Script) component." lightbox="../media/intent-recognizer.png":::

2. In the Project window, navigate to the **Assets** > **MRTK.Tutorials.GettingStarted** > **Prefabs** > **RocketLauncher** folder, drag the **RocketLauncher_Complete** prefab into your Hierarchy window, and place it at a suitable location in front of the camera, for example:

    * Transform **Position** X = 0, Y = 1, Z = 1.5
    * Transform **Rotation** X = 0, Y = 90, Z = 0

    :::image type="content" source="../media/rocket-launcher-prefab.png" alt-text="Screenshot of Add the RocketLauncher_Complete prefab." lightbox="../media/rocket-launcher-prefab.png":::

3. In the Hierarchy window, select the **Lunarcom** object again, then expand the **RocketLauncher_Complete** > **Buttons** object and assign each of the **Buttons** object's child objects to the corresponding **Lunar Launcher Buttons** field:

    :::image type="content" source="../media/assign-buttons.png" alt-text="Screenshot of Assigning each of the buttons." lightbox="../media/assign-buttons.png":::

## Create the Azure language service resource

In this section, you'll create an Azure language service resource for the Conversational language understanding (CLU) app you'll create in the next section.

1. Sign in to [Azure portal](https://portal.azure.com) and select **Create a resource**. Then search for and select **Language Service**:

    :::image type="content" source="../media/azure-prediction-resource.png" alt-text="Screenshot of Azure language service resource." lightbox="../media/azure-prediction-resource.png":::

2. Select the **Create** button to create an instance of this service:

    :::image type="content" source="../media/instance-service.png" alt-text="Screenshot of create an instance of this service." lightbox="../media/instance-service.png":::

3. On the Create Language page, enter the following values:

    * For **Subscription**, select **Free Trial** if you have a trial subscription. If you don't have a trial subscription, select one of your other subscriptions.
    * For the **Resource group**, select the **Create new** link, enter a suitable name, for example: *MRTK-Tutorials*. Select **OK**.

    :::image type="content" source="../media/prediction-option.png" alt-text="Screenshot of Create Language screen." lightbox="../media/prediction-option.png":::

    > [!TIP]
    > If you already have another suitable resource group in your Azure account, you may use this resource group instead of creating a new one.

4. While still on the Create page, enter the following values:

    * For **Name**, enter a suitable name for the service, for example: *MRTK-Tutorials-AzureSpeechServices*
    * For **Region**, choose a location close to your app users' physical location, for example: *East US*
    * For **Pricing tier**, in this tutorial, select **F0 (5k transactions per 30 days)**

    :::image type="content" source="../media/create-page.png" alt-text="Screenshot of the configured Create Language form." lightbox="../media/create-page.png":::

5. Next, select **Review + create**, review the details, and then select the **Create** button at the bottom of the page to create the resource (and the new resource group if you configured one to be created):

    :::image type="content" source="../media/review-details.png" alt-text="Screenshot of Review + Create." lightbox="../media/review-details.png":::

6. Once the resource creation process is completed, you'll see the message **Your deployment is complete**:

    :::image type="content" source="../media/message-display.png" alt-text="Screenshot of Overview screen." lightbox="../media/message-display.png":::

## Create the Conversational language understanding app (CLU)

In this section, you create a CLU app, configure and train its prediction model, and connect it to the Azure language resource you created in the previous step.

Specifically, you'll create an intent that if the user says an action should be taken, the app triggers the `PressableButton.OnClicked()` event on one of the three blue buttons in the scene, depending on which button the user references.

For example, if the user says **go ahead and launch the rocket**, the app predicts that **go ahead** means some **action** should be taken, and that the `PressableButton.OnClicked()` event to **target** is on the **launch** button.

The main steps you'll take to achieve this are:

1. Create a CLU app
2. Create intents
3. Create example utterances
4. Create entities
5. Assign entities to the example utterances
6. Train, test, and publish the app

## 1. Create a CLU app

Using the same user account you used when creating the Azure resource in the previous section, sign in to [Language Studio](https://aka.ms/languageStudio).

1. Once signed in, you'll be prompted to select an Azure resource. Select the values you used when creating the Azure Language service resource and press **Done**.

    :::image type="content" source="../media/language-studio-azure.png" alt-text="Screenshot showing the Select an Azure resource popup." lightbox="../media/language-studio-azure.png":::

2. After having connected the Azure resource, select **Create new > Conversational Language Understanding** and enter the following values in the **Create a project** popup window:

    * For **Name**, enter a suitable name, for example: *MRTK-Tutorials-AzureSpeechServices*. Note down the name you selected, you'll need it later in the tutorial.
    * For **Utterances primary language**, select a language
    * For **Description**, optionally enter a suitable description

    :::image type="content" source="../media/create-project.png" alt-text="Screenshot of Create a project popup." lightbox="../media/create-project.png":::

3. Select **Next** to review the project configuration. Select **Create** to create the project.

    :::image type="content" source="../media/review-clu-app.png" alt-text="Screenshot of Review and finish screen." lightbox="../media/review-clu-app.png":::

4. When the new app has been created, you are taken to that app's **Schema definition** page:

    :::image type="content" source="../media/apps-dashboard-page.png" alt-text="Screenshot of App's dashboard page." lightbox="../media/apps-dashboard-page.png":::

## 2. Create intents

1. From the Schema definition page, select **Add** and enter the following value in the **Add an intent** popup window:

    * For **Intent name**, enter **PressButton**

2. Select **Add intent** to create the new intent:

    :::image type="content" source="../media/new-intent.png" alt-text="Screenshot of Add an intent." lightbox="../media/new-intent.png":::

    > [!CAUTION]
    > For the purpose of this tutorial, your Unity project will reference this intent by its name (`PressButton`). It is extremely important that you name your intent exactly the same.

3. When the new intent has been created, you'll be taken back to the Schema definition page. The **PressButton** intent will show up in the list of intents.

    :::image type="content" source="../media/intents-list.png" alt-text="Screenshot of the list of Intents." lightbox="../media/intents-list.png":::

## 3. Create example utterances

1. On the left-hand sidebar, select the **Data labeling** button. On the **Data labeling** screen, select **PressButton** from the **Select intent** drop-down:
    :::image type="content" source="../media/select-intent.png" alt-text="Screenshot of Data labeling page." lightbox="../media/select-intent.png":::

2. To the **PressButton** intent's **Utterances** list, add the following example utterances:

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

3. When you have added all the example utterances, your Data labeling page should look like this:

    :::image type="content" source="../media/button-intent-page.png" alt-text="Screenshot of the updated Data labeling page." lightbox="../media/button-intent-page.png":::

    > [!CAUTION]
    > For the purpose of this tutorial, your Unity project will reference the words "hint", "hints", "reset", and "launch". It is extremely important that you spell these words in the exact same way in all instances.

## 4. Create entities

1. While on the Data labeling page, select **Add entity** in the right-hand **Activity pane** and enter the following values in the **Add an entity** popup window:

    * For **Entity name**, enter **Action**

2. Select **Add entity** to create the new entity:

    :::image type="content" source="../media/add-entity.png" alt-text="Screenshot of Add a new entity." lightbox="../media/add-entity.png":::

3. Repeat the previous step to create another entity named **Target**, so you have two entities named *Action* and *Target*:

    :::image type="content" source="../media/target-entity.png" alt-text="Screenshot of Create a target entity." lightbox="../media/target-entity.png":::

    > [!CAUTION]
    > For the purpose of this tutorial, your Unity project will reference these entities by their names, `Action` and `Target`. It is extremely important that you name your entities exactly the same.

## 5. Assign entities to the example utterances

1. Select the word **go** and then on the word **ahead**, then select **Action (Simple)** from the contextual popup menu to label **go ahead** as an **Action** entity value:

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

7. Save your changes. When you have labeled all the example utterances, your PressButton intent page should look like this:

    :::image type="content" source="../media/utterances-label.png" alt-text="Screenshot of All the example utterances have been labeled." lightbox="../media/utterances-label.png":::

## 6. Train, test and publish the app

1. To train the app, select the **Train** button from the left-hand sidebar. You should see the Training jobs page:

    :::image type="content" source="../media/training-jobs.png" alt-text="Screenshot of Training jobs screen." lightbox="../media/training-jobs.png":::

2. Select **Start a training job** and select the following values:
    * Select **Train a new model** and enter a suitable name, for example: *MRTK-Tutorials-AzureSpeechServices*
    * Select **Standard training**
    * Select **Automatically split the testing set from training data**

3. Select **Train** to start the training process. When the training is finished processing, you will see a **Finished training** notification.

    :::image type="content" source="../media/train-app.png" alt-text="Screenshot of Finished training notification." lightbox="../media/train-app.png":::

4. To review the results of the training, select **Model Performance**:

    :::image type="content" source="../media/model-performance.png" alt-text="Screenshot of Model performance." lightbox="../media/model-performance.png":::

5. To deploy the app, select the **Deploying a model** button in the left-hand sidebar. You should see the Deploying a model page:

    :::image type="content" source="../media/deploy-model.png" alt-text="Screenshot of Deploying a model." lightbox="../media/deploy-model.png":::

6. Select **Add deployment** and enter the following values in the **Add deployment** popup:
    * Select **Create a new deployment name** and enter a suitable name. Note down the name you selected, you will need it later in the tutorial.
    * Select the model you have previously created from the **Select a trained model** from the dropdown

7. Select **Deploy** and wait for the publishing process to complete:

    :::image type="content" source="../media/publish-process.png" alt-text="Screenshot of Deployment completed notification." lightbox="../media/publish-process.png":::

8. Select the new deployment and press the **Get prediction URL** button:

    :::image type="content" source="../media/azure-resources-page.png" alt-text="Screenshot of Get Prediction URL page." lightbox="../media/azure-resources-page.png":::

## Connect the unity project to the CLU app

1. While on the **Get prediction URL** popup, select the **Copy** icon to copy the **Prediction URL**:

    :::image type="content" source="../media/prediction-url.png" alt-text="Screenshot of Get Prediction URL popup." lightbox="../media/prediction-url.png":::

2. Back in your Unity project, in the Hierarchy window, select the **Lunarcom** object, then in the Inspector window, locate the **Lunarcom Intent Recognizer (Script)** component and configure it as follows:

    * In the **CLU Endpoint** field, pass the **Prediction URL** you copied in the previous step.
    * In the **CLU Project Name** field, pass the **Project Name** you noted down when creating a CLU app.
    * In the **CLU Deployment** field, pass the **Deployment Name** you noted down when creating a new deployment.
    * In the **Language Service API Key** field, pass the API key (Key1 or Key2) for your **Language Service**

    :::image type="content" source="../media/example-query.png" alt-text="Screenshot of Pass the example query you copied." lightbox="../media/example-query.png":::

## Test the intent recognition

1. To use intent recognition directly in the Unity editor, you must allow your development computer to use dictation. To verify this setting, open Windows Settings, then choose **Privacy** > **Speech** and ensure **Online speech recognition** is turned on:

    :::image type="content" source="../media/intent-recognition.png" alt-text="Screenshot of Testing the intent recognition." lightbox="../media/intent-recognition.png":::

2. If you enter Game mode, you can test the intent recognition by first pressing the rocket button. Then, when you say the first example utterance, **go ahead and launch the rocket**, you'll see the LunarModule launch into space:

    :::image type="content" source="../media/press-rocket-button.png" alt-text="Screenshot of Enter the game mode." lightbox="../media/press-rocket-button.png":::

3. Try all the example utterances, then some variation of the example utterances, and a few random utterances.
