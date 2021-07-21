Babylon.js is a 3D rendering engine that provides various WebXR features and support within its framework.

Recall that the amusement park company wanted the application to be a Virtual Reality/Augmented Reality application accessible through the public web. In this exercise, you will add WebXR support and features to the Babylon.js application built so far.

Here, you have a choice of adding WebXR support in the Virtual Reality mode or the Augmented Reality mode based on your preference. Make sure to select the tab of the path that you prefer before continuing to the exercise.

## Enable WebXR support

::: zone pivot="vr"

Let's enable WebXR support for the immersive Virtual Reality mode in the amusement park application.

1. If you have closed it, open your project folder from the previous exercise in Visual Studio Code.
1. Navigate to *src/index.ts* in your project folder.
1. In the `createScene()` function, add the following code before the function's return statement:

    ```typescript
    const xr = await scene.createDefaultXRExperienceAsync({});
    ```

::: zone-end

::: zone pivot="ar"

Let's enable WebXR support for the immersive Augmented Reality mode in the amusement park application.

1. Open your project folder from the previous exercise in Visual Studio Code.
1. Navigate to *src/index.ts* in your project folder.
1. In the `createScene()` function, add the following code before the function's return statement:

    ```typescript
    const xr = await scene.createDefaultXRExperienceAsync({
        uiOptions: {
            sessionMode: "immersive-ar",
        },
    });
    ```

## Add background remover

When users enter the Augmented Reality session, we want them to use their own surroundings as the background for the dragon-summoning activity. Let's enable the background remover feature to remove the ground and sky meshes only during an Augmented Reality session.

Below the `scene.createDefaultXRExperienceAsync()` function call, add this line to enable the background remover feature:

```typescript
xr.baseExperience.featuresManager.enableFeature(BABYLON.WebXRBackgroundRemover, 'latest', {
    backgroundMeshes: [env.skybox, env.ground]
});
```

::: zone-end

## Limit speech recognition to WebXR sessions

Currently, users can summon the dragon without entering a WebXR session. However, the amusement park company wants the experience to be shown through Virtual Reality/Augmented Reality in order to simulate the true park activity.

Let's restrict the summoning activity to only the Virtual Reality/Augmented Reality mode. To do so, we will start the speech recognition session after users enter a WebXR session.

1. In the `createScene()` function, find and delete the `recognizer.startContinuousRecognitionAsync();` line.
1. Right before the createScene() function's return statement, add this line of code:

    ```typescript
    xr.baseExperience.sessionManager.onXRSessionInit.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        recognizer.startContinuousRecognitionAsync();
    });
    ```

1. Let's also stop the recognition when the users exit the session, just in case they leave without summoning the dragon. Add the code below right before `createScene()` function's return statement:

    ```typescript
    xr.baseExperience.sessionManager.onXRSessionEnded.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        recognizer.stopContinuousRecognitionAsync();
    });
    ```

1. With the current code, if a user summons the dragon, leave the WebXR session, and then go back to the session, the speech recognition session will start again. Let's create a flag to check if a dragon has been summoned. Change the *recognizer.recognized* event handler and the *onXRSessionInit* handler to the following code snippets:

    ```typescript
    var isSummoned = false;
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech 
            && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
                env.magicCircle.fadeIn(true);
                setTimeout(() => {
                    env.dragon.fadeIn(true);
                }, 500);
                isSummoned = true;
                recognizer.stopContinuousRecognitionAsync();
        }
    };
    ```

    ```typescript
    xr.baseExperience.sessionManager.onXRSessionInit.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        if (!isSummoned) {
            recognizer.startContinuousRecognitionAsync();
        }
    })
    ```

    With the updated logic, the speech recognition session will only start if the dragon has not been summoned.

## Position the dragon

Currently, the dragon and the magic circle always fade in at the same position. However, in a WebXR session, if a user faces another direction when summoning the dragon, the meshes might appear next to them or even behind them. Let's make sure that the dragon would always appear in front of the user.

1. Modify the *recognizer.recognized* event handler:

    ```typescript
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech 
            && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
                const position = xr.baseExperience.camera.getFrontPosition(3);
                position.y = 0;
                // magicMeshes is the parent of both dragon and magicCircle
                env.magicMeshes.position = position;
                env.magicCircle.fadeIn(true);
                setTimeout(() => {
                    env.dragon.fadeIn(true);
                }, 500);
                isSummoned = true;
                recognizer.stopContinuousRecognitionAsync();
        }
    };
    ```

    Here, we are using `xr.baseExperience.camera.getFrontPosition(3)` to retrieve the position that is 3 meters in front of the camera in the virtual space. Then, the y-coordinate of the position is set to 0 so that the meshes can look aligned with the ground.

1. Move the *recognizer.recognized* event handler code to after the `scene.createDefaultXRExperienceAsync()` function call since we need to use the *xr* object to retrieve the camera.

1. Make sure to save your edits so far by selecting **Save** under the **File** menu, or by using Ctrl+S/Cmd+S.

    :::image type="content" source="../media/save-file.png" alt-text="Screenshot of the Visual Studio Code File menu with the Save button surrounded by a red box.":::

## Check your work

At this point, the `createScene()` function should look like this:

::: zone pivot="vr"

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

    const xr = await scene.createDefaultXRExperienceAsync({});
    
    var isSummoned = false;
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech 
            && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
                const position = xr.baseExperience.camera.getFrontPosition(3);
                position.y = 0;
                // magicMeshes is the parent of both dragon and magicCircle
                env.magicMeshes.position = position;
                env.magicCircle.fadeIn(true);
                setTimeout(() => {
                    env.dragon.fadeIn(true);
                }, 500);
                isSummoned = true;
                recognizer.stopContinuousRecognitionAsync();
        }
    };

    xr.baseExperience.sessionManager.onXRSessionInit.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        if (!isSummoned) {
            recognizer.startContinuousRecognitionAsync();
        }
    });

    xr.baseExperience.sessionManager.onXRSessionEnded.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        recognizer.stopContinuousRecognitionAsync();
    });
    
    return scene;
};
```

::: zone-end

::: zone pivot="ar"

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

    const xr = await scene.createDefaultXRExperienceAsync({
        uiOptions: {
            sessionMode: "immersive-ar",
        },
    });
    
    var isSummoned = false;
    recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
        if (e.result.reason == ResultReason.RecognizedSpeech 
            && e.result.text.toLowerCase().replace(/[^a-zA-Z0-9]+/g, " ").trim() === spell) {
                const position = xr.baseExperience.camera.getFrontPosition(3);
                position.y = 0;
                // magicMeshes is the parent of both dragon and magicCircle
                env.magicMeshes.position = position;
                env.magicCircle.fadeIn(true);
                setTimeout(() => {
                    env.dragon.fadeIn(true);
                }, 500);
                isSummoned = true;
                recognizer.stopContinuousRecognitionAsync();
        }
    };

    xr.baseExperience.featuresManager.enableFeature(BABYLON.WebXRBackgroundRemover, 'latest', {
        backgroundMeshes: [env.skybox, env.ground]
    });

    xr.baseExperience.sessionManager.onXRSessionInit.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        if (!isSummoned) {
            recognizer.startContinuousRecognitionAsync();
        }
    });

    xr.baseExperience.sessionManager.onXRSessionEnded.add((eventData: XRSession, eventState: BABYLON.EventState) => {
        recognizer.stopContinuousRecognitionAsync();
    });
    
    return scene;
};
```

::: zone-end

Since most browsers on computers cannot open WebXR sessions without an external device which supports WebXR, we can't see the updated code in action yet. In the next exercise, you'll deploy this application to the web and verify its functionalities on any device that supports Virtual Reality or Augmented Reality.
