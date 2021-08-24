The Azure Speech JavaScript SDK allows developers to integrate Azure Speech services into their applications more efficiently.

In the amusement park application, we need to use a speech-to-text service to recognize a magical spell. Once the spell is recognized, the application needs to render the dragon 3D model to create the experience of "summoning the dragon."

Here, you will use the Azure Speech JavaScript SDK to integrate the Azure Speech-to-text service into the amusement park application.

## Clone the GitHub repository

Recall that your teammate has already set up a Babylon.js project with all of the necessary assets imported into the Babylon.js scene. Let's clone the repository that contains their work so far.

1. Go to [this GitHub repository](https://github.com/MicrosoftDocs/mslearn-create-voice-activated-webxr-app?azure-portal=true) and select the **Code** dropdown.

    :::image type="content" source="../media/github-repo.png" alt-text="Screenshot of the Learn module GitHub repository, with the Code dropdown button surrounded by a red box.":::

1. Copy the **URL of the repository** under the **HTTPS** tab.

    :::image type="content" source="../media/github-repo-url.png" alt-text="Screenshot of the dropdown view under the Code button, with the U R L copy button surrounded by a red box.":::

1. Open Visual Studio Code.
1. Select the Settings button in the bottom left of the window, and then select **Command Palette** from the options (or Ctrl+Shift+P/Cmd+Shift+P).

    :::image type="content" source="../media/vscode-settings-menu.png" alt-text="Screenshot of the settings menu in Visual Studio Code, with the settings button and the Command Palette selection surrounded by a red box respectively.":::

1. After the Command Palette pops up, type in "git" and select the **Git: Clone** command.

    :::image type="content" source="../media/command-palette-git.png" alt-text="Screenshot of the command palette with git in the input text box and the Git Clone option surrounded by a red box.":::

1. Paste the URL of the GitHub repository, then select **Clone from URL**.

    :::image type="content" source="../media/clone-learn-module-repo.png" alt-text="Screenshot of the command palette with the Learn module U R L in the input text box and the option Clone from URL surrounded by a red box.":::

1. Select the folder where you would like to save the repository. The root folder of the repository becomes a subdirectory in the folder you select.
1. Select **Open** from the popup window after cloning finishes.

    :::image type="content" source="../media/open-cloned-repository.png" alt-text="Screenshot of a popup window which asks if the user wants to open the cloned repository. ":::

## Install dependencies

Since we are using Node.js, all of the required dependencies are listed in the *package.json* file. Let's use *npm* to install all of them.

1. Select **Terminal** in the menu of Visual Studio Code, and then select **New Terminal** to create a new terminal.

    :::image type="content" source="../media/select-new-terminal.png" alt-text="Screenshot of the Terminal dropdown menu in Visual Studio Code. The New Terminal option is surrounded by a red box.":::

1. Within the terminal, run `cd starter-code` to change the directory into the **starter-code** folder.
1. Run `npm install` in the terminal to install all dependencies for the project.
1. After the command finishes running, you should see a folder named *node_modules* created within the *starter-code* folder.

## Import dependencies

The source files in the *src* folder have the *.ts* extension, which means that the files are written in TypeScript instead of JavaScript. While TypeScript and JavaScript are similar in nature, TypeScript requires types to be clearly defined for function parameters.

As a result, you'll need to import every class that will be used in a variable or a function parameter. In VSCode, navigate to *src/index.ts* and add the following import statement at the top of the file:

```typescript
import { 
    SpeechConfig, 
    AudioConfig, 
    Recognizer, 
    SpeechRecognizer, 
    PhraseListGrammar, 
    SpeechRecognitionEventArgs, 
    SpeechRecognitionCanceledEventArgs, 
    ResultReason, 
    CancellationReason, 
} from 'microsoft-cognitiveservices-speech-sdk';
```

## Create Speech Recognizer

Let's create a Speech Recognizer using the Azure Speech JavaScript SDK.

1. Find the `createScene()` function in *index.ts*.

    ```typescript
    const createScene = async function () {
        const scene = new BABYLON.Scene(engine);
        const env = await environment.setup(scene, theCanvas);
        
        return scene;
    };
    ```

1. Before the return statement, add these lines to create the speech recognizer:

    ```typescript
    const SUBSCRIPTION_KEY = "YOUR_AZURE_SPEECH_SUBSCRIPTION_KEY";
    const LOCATION = "YOUR_AZURE_SPEECH_INSTANCE_LOCATION";

    const speechConfig = SpeechConfig.fromSubscription(SUBSCRIPTION_KEY, LOCATION);
    speechConfig.speechRecognitionLanguage = 'en-US';
    const audioConfig = AudioConfig.fromDefaultMicrophoneInput();

    const recognizer = new SpeechRecognizer(speechConfig, audioConfig);
    ```

    Make sure to replace **YOUR_AZURE_SPEECH_SUBSCRIPTION_KEY** and **YOUR_AZURE_SPEECH_INSTANCE_LOCATION** with your Azure Speech instance's subscription key and location, which you obtained in the last exercise.

    > [!NOTE]
    > It is not the best practice to include secrets or keys in client side code due to security concerns.
    > In this exercise, we store the keys as constants in the client side code for convenience, as the keys become invalid after the sandbox is deactivated. However, generally, you should put the values of the keys in a backend service for any application deployed to the public web.

1. Add Phrase List support and include the text representation of the spell in the list. Here, we will use "go dragon" as the spell that we want the users to say.

    ```typescript
    const spell = "go dragon";
    const phraseList = PhraseListGrammar.fromRecognizer(recognizer);
    phraseList.addPhrase(spell);
    ```

1. If an error occurs during a speech recognition session, let's stop recognizing:

    ```typescript
    recognizer.canceled = (s: Recognizer, e: SpeechRecognitionCanceledEventArgs) => {
        if (e.reason == CancellationReason.Error) {
            console.log(`CANCELED: ErrorCode=${e.errorCode}`);
            console.log(`CANCELED: ErrorDetails=${e.errorDetails}`);
        }
    
        recognizer.stopContinuousRecognitionAsync();
    };
    ```

## Render dragon when spell is recognized

1. Let's set up the event handler for the *recognized* event, which signals that a final recognition result has been received:

    ```typescript
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech) {
            // take action here
        }
    };
    ```

1. Recall that we need to match the transcribed text against the spell to make sure if the user has said the spell. Expand the if-statement in the event handler to perform the text matching:

    ```typescript
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech 
            && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
            //take action here
        }
    };
    ```

    Since the transcribed text might contain uppercase letters and punctuation, we also had to transform the text (so that it only contains lowercase alphanumeric letters) before performing the comparison.

1. In addition to the dragon 3D model, we'll also render a magic circle 3D model for better visual effect. The 3D models for the dragon and the magic circle are stored in the *env* object. Let's add the code to have the magic circle and the dragon models fade in, one after another. Also, let's stop the speech recognition after the dragon has been summoned.

    ```typescript
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech 
            && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
                env.magicCircle.fadeIn(true);
                setTimeout(() => {
                    env.dragon.fadeIn(true);
                }, 500);
                recognizer.stopContinuousRecognitionAsync();
        }
    };
    ```

1. Finally, call recognizer.startContinuousRecognitionAsync() to start the speech recognition session. Here is what the entire `createScene()` function looks like at this step:

    ```typescript
    const createScene = async function () {
        const scene = new BABYLON.Scene(engine);
        
        const env = await environment.setup(scene, theCanvas);
    
        const SUBSCRIPTION_KEY = "YOUR_AZURE_SPEECH_SUBSCRIPTION_KEY";
        const LOCATION = "YOUR_AZURE_SPEECH_INSTANCE_LOCATION";
    
        const speechConfig = SpeechConfig.fromSubscription(SUBSCRIPTION_KEY, LOCATION);
        speechConfig.speechRecognitionLanguage = 'en-US';
        const audioConfig = AudioConfig.fromDefaultMicrophoneInput();
    
        const recognizer = new SpeechRecognizer(speechConfig, audioConfig);

        const spell = "go dragon";
        const phraseList = PhraseListGrammar.fromRecognizer(recognizer);
        phraseList.addPhrase(spell);

        recognizer.canceled = (s: Recognizer, e: SpeechRecognitionCanceledEventArgs) => {
            if (e.reason == CancellationReason.Error) {
                console.log(`"CANCELED: ErrorCode=${e.errorCode}`);
                console.log(`"CANCELED: ErrorDetails=${e.errorDetails}`);
            }
        
            recognizer.stopContinuousRecognitionAsync();
        };
            
        recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
            if (e.result.reason == ResultReason.RecognizedSpeech 
                && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
                    env.magicCircle.fadeIn(true);
                    setTimeout(() => {
                        env.dragon.fadeIn(true);
                    }, 500);
                    recognizer.stopContinuousRecognitionAsync();
            }
        };
    
        recognizer.startContinuousRecognitionAsync();
        
        return scene;
    }
    ```

1. Make sure to save your edits so far by selecting **Save** under the **File** menu, or by using Ctrl+S/Cmd+S.

    :::image type="content" source="../media/save-file.png" alt-text="Screenshot of the Visual Studio Code File menu with the Save button surrounded by a red box.":::

## Check the app in the browser

Now that the code is ready, it is time to verify that the web application works as intended. We will need to make sure that the dragon and magic circle models fade in when users say "go dragon" to the application.

1. In your VSCode terminal, run `npm start`.
1. Once the application finishes compiling, open your browser and head to **localhost:8080**.
1. If the app loads successfully, you will see an empty scene with a dark background.

    :::image type="content" source="../media/empty-scene.png" alt-text="An empty Babylon J S scene with only the background skybox is displayed in the browser.":::

    If it does not load successfully, you will see a white screen. Make sure your createScene() function matches the snippet given in the section above.

1. Your browser might ask for your permission to allow microphone usage on this page. Make sure to select **Allow** when the popup appears.

    :::image type="content" source="../media/allow-microphone.png" alt-text="A browser popup that asks for permission to allow microphone usage. The Allow button is surrounded by a red box.":::

1. After that, the speech recognition session starts. Say "go dragon" to your microphone and wait for the 3D models to fade in.

    :::image type="content" source="../media/dragon-magic-circle-fade-in.gif" alt-text="The dragon model and the magic circle model fades into an empty Babylon J S scene.":::

1. To stop the application, go back to the terminal where you ran `npm start` and type Ctrl+C. When prompted with whether or not to terminate batch jobs, make sure to respond with `Y`.
