Increasingly, we expect computers to be able to use AI in order to understand spoken or typed commands in natural language. For example, you might want to implement a home automation system that enables you to control devices in your home by using voice commands such as "switch on the light" or "put the fan on", and have an AI-powered device understand the command and take appropriate action.

To test the capabilities of the Conversational Language Understanding service, we'll use a simple command-line application that runs in the Cloud Shell. The same principles and functionality apply in real-world solutions, such as web sites or phone apps.

## Create a *Language* resource

You can use the Conversational Language Understanding service by creating a **Language** resource. 

If you haven't already done so, create a **Language** resource in your Azure subscription.

1. In another browser tab, open the Azure portal at [https://portal.azure.com](https://portal.azure.com?azure-portal=true), signing in with your Microsoft account.
2. Click the **&#65291;Create a resource** button, search for *Language*, and create a **Language** resource with the following settings:
    - Select additional features: *Keep the default features and click Continue to create your resource*  
    - **Subscription**: *Your Azure subscription*.
    - **Resource group**: *Select or create a resource group with a unique name*.
    - **Region**: *Choose any available region*:
    - **Name**: *Enter a unique name*.
    - **Pricing tier**: Standard S
    - **I confirm I have read and understood the notices**: Selected.

3. Review and create the resource, and wait for deployment to complete. Then go to the deployed resource.
4. View the **Keys and Endpoint** page for your Language resource. You will need the endpoint and keys to connect from client applications.

### Create a Conversational Language Understanding App

To implement natural language understanding with Conversational Language Understanding, you create an app; and then add entities, intents, and utterances to define the commands you want the app. 

1. In a new browser tab, open the Language Studio portal at [https://language.azure.com](https://language.azure.com/?azure-portal=true), and sign in using the Microsoft account associated with your Azure subscription. If this is the first time you have signed into the Language Studio, you may need to grant the app some permissions to access your account details. Then complete the *Welcome* steps by selecting the existing Language resource you just created in your Azure subscription. 
2. In the **Home** page, create a new **Conversational Language Understanding** app with the following settings:
    - **Choose project type**: *Conversation project*
    - **Name**: HomeAutomation 
        - Please use this exact name
    - **Description**: Simple home automation
    - **Utterances primary language**: English
    - **Enable multiple languages in project**: *Do not select*

3. On the *Review and finish* page, click **Create**. 

### Create intents and entities

An *intent* is an action you want to perform - for example, you might want to switch a light on, or turn a fan off. In this case, you'll define two intents: one to switch a device on, and another to switch a device off. For each intent, you'll specify sample *utterances* that indicate the kind of language used to indicate the intent.

1. In the **Build schema** pane on the left, ensure that **Intents** is selected Then click **Add**, and add an intent with the name **switch_on** (in lower-case) and click **Add intent**.
2. Click the **switch_on** intent. It will take you to the **Tag utterances** page. Next to the **switch_on** intent, type the utterance ***turn the light on*** and press **Enter** to submit this utterance to the list.
3. On the **Tagging** pane on the right hand side of the screen, select **Add entity** and type **device** (in lower-case) and select **Done**. 
4. In the *turn the light on* utterance, highlight the word "light". Then in the list that appears, in the *Search for an entity* box select **device**. 
5. Now create a second utterance for the **switch_on** intent. Type the phrase ***switch on the fan*** next to the **switch_on** intent. Then select the word "fan" and assign it to the **device** entity you created previously.
6. In the pane on the left, click **Build schema** and verify that your **switch_on** intent is listed. Then click **Add** and add a new intent with the name **switch_off** (in lower-case).
7. Click on the **switch_off** intent. It will take you to the **Tag utterances** page. Next to the **switch_off** intent, add the utterance ***turn the light off*** and assign the word "light" to the **device** entity.
8. Add a second utterance to the **switch_off** intent, with the utterance ***switch off the fan***. Then connect the word "fan" to the **device** entity.

### Train and Test the Conversational Language Model

Now you're ready to use the intents and entities you have defined to train the conversational language model for your app.

1. At the left of the Conversational Language Understanding page for your app, select **Train model**. Use the following settings: 
    - **Train a new model**: *Selected and choose a model name*
    - **Run evaluation with training**: *Enabled evaluation*
    - Click **Train** at the bottom of the page. 
2. When the model is trained, click **Test model** on the left hand side of the page, and use the test pane to view the predicted intent for the following phrases, noting the predicted intent: 
- *switch the light on*
- *turn off the fan*
- *put the light on*
- *put the fan off*

### Deploy the Model and Configure Endpoints

To use your trained model in a client application, you must publish it as an endpoint to which the client applications can send new utterances; from which intents and entities will be predicted.

1. On the left hand side of the Conversational Language Understanding page for your app, click **Deploy model**.
2. Select your model name and click **Deploy Model**.

## Run Cloud Shell 

Now let's try out your deployed model. To do so, we'll use a simple command-line application that runs in the Cloud Shell on Azure. 

1. In the Azure portal, select the **[>_]** (*Cloud Shell*) button at the top of the page to the right of the search box. This opens a Cloud Shell pane at the bottom of the portal. 

    ![Start Cloud Shell by clicking on the icon to the right of the top search box](../media/powershell-portal-guide-1.png)

2. The first time you open the Cloud Shell, you may be prompted to choose the type of shell you want to use (*Bash* or *PowerShell*). Select **PowerShell**. If you do not see this option, skip the step.  

3. If you are prompted to create storage for your Cloud Shell, ensure your subscription is specified and select **Create storage**. Then wait a minute or so for the storage to be created. 

    ![Create storage by clicking confirm.](../media/powershell-portal-guide-2.png)       

4. Make sure the the type of shell indicated on the top left of the Cloud Shell pane is switched to *PowerShell*. If it is *Bash*, switch to *PowerShell* by using the drop-down menu. 
    
    ![How to find the left hand drop down menu to switch to PowerShell](../media/powershell-portal-guide-3.png) 

5. Wait for PowerShell to start. You should see the following screen in the Azure portal:  

    ![Wait for PowerShell to start.](../media/powershell-prompt.png) 

## Configure and run a client application

Now let's open and edit a pre-written script which will run the client application. 

1. In the command shell, enter the following command to download the sample application and save it to a folder called ai-900.

    ```
    git clone https://github.com/MicrosoftLearning/AI-900-AIFundamentals ai-900
    ```

2. The files are downloaded to a folder named **ai-900**. Now we want to see all of the files in your Cloud Shell storage and work with them. Type the following command into the shell: 

     ```
    code .
    ```

    Notice how this opens up an editor like the one in the image below: 
 
    ![The code editor.](../media/powershell-portal-guide-4.png)

3. In the **Files** pane on the left, expand **ai-900** and select **home-devices.ps1**. This file contains some code that uses your Conversational Language Understanding model. 

4. Don't worry too much about the details of the code, the important thing is that it needs the key and endpoint from your Language resource. Copy these from your Language resource's **Keys and Endpoint** page in the Azure portal and paste them into the code editor, replacing the **YOUR_PRIMARY_KEY** and **YOUR_ENDPOINT_URL** placeholder values respectively.

    After pasting the key and endpoint values, the first lines of code should look similar to this:

    ```PowerShell
    $key = "1a2b3c4d5e6f7g8h9i0j...."
    $endpointUrl="https..."

    ```

5. At the top right of the editor pane, use the **...** button to open the menu and select **Save** to save your changes. Then open the menu again and select **Close Editor**.
6. In the PowerShell pane, enter the following command to run the code:

    ```
    cd ai-900
    ./home-devices.ps1 "Turn on the light"
    ``` 

7. Review the results. The app should have predicted that the intended action is to switch on the light.
8. Now try another command:

    ```
    ./home-devices.ps1 "Switch the fan off"
    ```

9. Review the results from this command. The app should have predicted that the intended action is to switch off the fan.

10. Experiment with a few more commands; including commands that the model was not trained to support, such as "Hello" or "switch on the oven". The app should generally understand commands for which its language model is defined, and fail gracefully for other input.

## Learn more

This simple app shows only some of the capabilities of the Conversational Language Understanding service. To learn more about what you can do with this service, see the [Conversational Language Understanding page](/azure/cognitive-services/language-service/conversational-language-understanding/overview).

