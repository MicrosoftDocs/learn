In Unity, displaying the result from an API integration within a Mixed Reality app requires adding and configuring UI elements to the scene. To display speech translation from the Azure Cognitive Services Speech Translation service, a quad, text and button must be added to the scene and assigned to their respective properties in the corresponding C# script. In addition, your Azure credentials must be validated to use the Speech service. Here, you'll add MRTK UI elements to a Unity scene and create a script that uses the Cognitive Services Speech SDK for translation.

## Create UI

A parent object **TranslationUI** is created to store the UI elements inside the object as it's children. Storing the UI elements as the children of **TranslationUI** not only helps keep the project hierarchy organized but also enables the UI elements to inherit properties from the parent such as the Transform.

The UI consists of a quad which serves as a flat surface for the text. Displayed on top of the quad is text. The top portion of the quad contains the recognized text whereas the bottom displays the translated speech. The UI text elements are similar in setup. Once one text element is created and configured, you can duplicate to save time creating the others.

:::image type="content" source="../media/translator-ui-final.png" alt-text="A screenshot of the complete translator UI. The label Recognized Speech is at the top followed by the label Translation at the bottom. There is blank space after each label to provide room for the Azure result.":::

### Create a Translation UI GameObject to store the UI

1. In the **Hierarchy** window, click the **+** icon and select **Create Empty**.

    :::image type="content" source="../media/create-empty.png" alt-text="A screenshot of the hierarchy window. The plus icon and create empty menu option are highlighted.":::

1. Select the **GameObject** object in the **Hierarchy** window. The **GameObject** properties will display in the **Inspector** window.

    :::image type="content" source="../media/gameobject-properties.png" alt-text="A screenshot of the hierarchy and inspector windows. The Game Object object is highlighted in the hierarchy window. The object's properties is highlighted in the inspector window.":::

1. In the **Inspector** window, name the GameObject **Translation UI** and change the **Transform Position** to **.0**, **0**, **.8**. This moves the object away from the user which later helps to display the UI elements in front of the user.

    :::image type="content" source="../media/translation-ui-properties.png" alt-text="A screenshot of the Translation UI object's properties. The name of the property is highlighted in addition to the transform position values. The x value is 0. The y value is 0. The z value is 0 point 8.":::

### Add a Quad GameObject

1. To add the object as child of **Translation UI**, in the **Hierarchy** window, select the **Translation UI** object. Next, right click the object and select **3D Object** > **Quad**.

    :::image type="content" source="../media/add-quad-object.png" alt-text="A screenshot of the Hierarchy window with the translation UI object highlighted. The menu is open with two selections highlighted. The first highlighted selection is 3 D object. The second highlighted selection is quad.":::

1. Adjust the Scene view camera using the Scene Gizmo to view the front of the quad.

    :::image type="content" source="../media/scene-gizmo.png" alt-text="A screenshot of the Unity editor Scene window. The play gizmo is highlighted.":::

1. Select the **Quad** object in the **Hierarchy** window. The Quad's properties will display in the **Inspector** window.
1. In the **Inspector** window, change the Quad's **Transform Scale** to **.8**, **.5**, **.1**. This will make the quad rectangular.

    :::image type="content" source="../media/quad-properties.png" alt-text="A screenshot of the quad object's properties. In the hierarchy window, the quad object is highlighted. In the inspector window, the scale values are highlighted. The x value is 0 point 8. The y value is 0 point 5. The z value is 0 point 1.":::

1. The Quad object's material should be a color that will make the text UI legible. MRTK is equipped with materials that can be applied to GameObjects. In the **Project** window, enter **MRTK_Standard_White** into the search bar to find the color white.

    :::image type="content" source="../media/mrtk-standard-white.png" alt-text="A screenshot of the Project window. The search bar is highlighted. The phrase M R T K underscore Standard underscore White is entered into the search bar.":::

1. Drag the **MRTK_Standard_White** material from the **Project** window to the **Quad** object. The color of the Quad object in the **Scene** window should now be white.

    :::image type="content" source="../media/scene-white-quad.png" alt-text="A screenshot of the Scene window. A white rectangular quad object is in the middle of the scene.":::

### Add text to display on the Quad GameObject

1. To add the text object as child of **Translation UI**, in the **Hierarchy** window, select the **Translation UI** object. Next, right click the object and select **3D Object** > **Text - TextMeshPro**.

    :::image type="content" source="../media/add-text-object.png" alt-text="A screenshot of the Hierarchy window. The translation U I object is highlighted. A menu is shown with the selections 3 D object and Text dash Text Mesh Pro highlighted.":::

1. Select the **Text - TextMeshPro** object in the **Hierarchy** window. The **Text - TextMeshPro** properties will display in the **Inspector** window.
1. In the **Inspector** window, name the Text - TextMeshPro object **Recognition (Label)** and change the following **Rect Transform** properties:
    - **Pos X** = 0, **Pos Y** = 0.1, **Pos Z** = 0
    - **Width** = 0.74
    - **Height** = 0.2

    :::image type="content" source="../media/recognition-label-transform-properties.png" alt-text="A screenshot of the recognition label properties. The recognition label object is highlighted in the hierarchy window. In the inspector window, the object and rect transform position, width, and height values are highlighted.":::

1. With the **Recognition (Label)** object still selected, in the **Inspector** window, change the remaining properties:
    - **Text** = Recognized Speech:
    - **Font Size** = 0.3
    - **Face** = #000000

    :::image type="content" source="../media/text-name-size-color-properties.png" alt-text="A screenshot of the inspector window for the Recognition label object. The text, font size and face color properties are highlighted.":::

1. The **Recognition (Label)** object can be duplicated to create the remaining text UI. The **Pos Y** and **Text** properties will be changed for each object to position the text appropriately against the Quad object. With the **Recognition (Label)** object still selected, use the keyboard short-cut **Ctrl+D** to duplicate the object 3 times.

    :::image type="content" source="../media/recognition-label-duplicated.png" alt-text="A screenshot of the hierarchy window. There are 3 duplicated objects for the recognition label.":::

1. In the **Hierarchy** window, rename each object as follows:
    - Recognition (Label)
    - Recognition Output
    - Translation (Label)
    - Translation Output

    :::image type="content" source="../media/duplicated-object-names.png" alt-text="A screenshot of the Hierarchy window with the duplicated objects highlighted.":::

1. For each duplicated object, change the **Pos Y** and **Text** properties as such:
    - *Recognition Output*: **Pos Y** = 0.03, **Text** = Recognized speech from Azure
    - *Translation (Label)*: **Pos Y** = -0.1, **Text** = Translation:
    - *Translation Output*: **Pos Y** = -0.17, **Text** = Translated speech from Azure

### Add a button to display on the Quad GameObject

1. A MRTK button prefab is used for the microphone. In the **Project** window, search for **PressableButtonHoloLens2Circular_32x32**.

    :::image type="content" source="../media/search-pressable-button.png" alt-text="A screenshot of the project window. The search bar is highlighted. The text in the search bar reads pressable button hololens 2 circular underscore 32 x 32.":::

1. To add the button prefab as a child of **Translation UI**, drag the button from the **Project** window to the **Translation UI** object.

    :::image type="content" source="../media/button-child-of-translation-ui.png" alt-text="A screenshot of the Hierarchy window. The button object is highlighted. The button object is a child of the translation u i object.":::

1. Select the **PressableButtonHoloLens2Circular_32x32** object in the **Hierarchy** window. The button properties will display in the **Inspector** window.
1. In the **Inspector** window, name the button object **Mic** and change the following **Transform** properties:
    - *Position*: **0.3**, **-0.17**, **-0.1**
    - *Scale*: **2**, **2**, **1**

    :::image type="content" source="../media/mic-properties.png" alt-text="A screenshot of the mic object's properties. The mic object is highlighted in the hierarchy window. The mic object's name, transform position and transform scale are highlighted in the inspector window.":::

1. With the **Mic** object still selected, in the **Inspector** window, change **Icon** to a microphone.

    :::image type="content" source="../media/mic-icon.png" alt-text="A screenshot of the mic object's icon set. The microphone icon is highlighted.":::

## Create the translation.cs script

> [!NOTE]
> Additional helper code has been added to this script to help debug any potential issues which may occur when you run the Unity scene.

1. In the **Project** window, select the **Assets** folder. This will be the folder used to store the **translation.cs** script.
1. In the **Project** window, click the **+** icon and select **C# Script**. Name the script **translation.cs**.

    :::image type="content" source="../media/create-translation-script.png" alt-text="A screenshot of the project window. The plus icon in the top left corner is highlighted. The translation script within the assets section is highlighted.":::

1. In the **Project** window, double click on the script to open in Visual Studio.
1. In Visual Studio, replace the default code provided in the template with the following:
    ```csharp
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using Microsoft.CognitiveServices.Speech;
    using Microsoft.CognitiveServices.Speech.Translation;
    using Microsoft.MixedReality.Toolkit.UI;
    using TMPro;
    
    public class Translation : MonoBehaviour
    {
    
        public TextMeshPro recognizedText;
        public TextMeshPro translatedText;
        public PressableButton micButton;
    
        public string SpeechServiceSubscriptionKey = "";
        public string SpeechServiceRegion = "";
    
        private bool waitingforReco;
        private string recognizedString;
        private string translatedString;
    
        private bool micPermissionGranted = false;

        private object threadLocker = new object();
    
        public async void ButtonClick()
        {
            var translationConfig = SpeechTranslationConfig.FromSubscription(SpeechServiceSubscriptionKey, SpeechServiceRegion);
            translationConfig.SpeechRecognitionLanguage = "en-US";
            translationConfig.AddTargetLanguage("fr");
    
            using (var recognizer = new TranslationRecognizer(translationConfig))
            {
                lock (threadLocker)
                {
                    waitingforReco = true;
                }
    
                var result = await recognizer.RecognizeOnceAsync().ConfigureAwait(false);
                
                if (result.Reason == ResultReason.TranslatedSpeech)
                {
                    recognizedString = result.Text;
                    foreach (var element in result.Translations)
                    {
                        translatedString = element.Value;
                    }
                }
                else if (result.Reason == ResultReason.NoMatch)
                {
                    recognizedString = "NOMATCH: Speech could not be recognized.";
                }
                else if (result.Reason == ResultReason.Canceled)
                {
                    var cancellation = CancellationDetails.FromResult(result);
                    recognizedString = $"CANCELED: Reason={cancellation.Reason} ErrorDetails={cancellation.ErrorDetails}";
                }
    
                lock (threadLocker)
                {
                    waitingforReco = false;
                }
    
            }
        }
        
        
        // Start is called before the first frame update
        void Start()
        {
            if (translatedText == null)
            {
                UnityEngine.Debug.LogError("translatedText property is null! Assign a UI TextMeshPro Text element to it.");
            }
            else if (micButton == null)
            {
                UnityEngine.Debug.LogError("micButton property is null! Assign a MRTK Pressable Button to it.");
            }
            else
            {
                micPermissionGranted = true;
                micButton.ButtonPressed.AddListener(ButtonClick);
            }
        }
    
        // Update is called once per frame
        void Update()
        {
            lock (threadLocker)
            {
                recognizedText.text = recognizedString;
                translatedText.text = translatedString;
            }
        }
    }
    ```

1. The script is written to recognize English (`en-US`) and translate to French (`fr`). You can change the recognition language by modifying the value for the `SpeechRecognitionLanguage` property. The target language can be changed by modifying the parameter for the `AddTargetLanguage` method.
    ```csharp
    translationConfig.SpeechRecognitionLanguage = "<assign a locale>";
    translationConfig.AddTargetLanguage("<assign a language code>");
    ```

1. Save the file and return to Unity.

## Add the translation.cs script to a GameObject

1. In the **Hierarchy** window, select the **Translation UI** object. The **Translation UI** properties will display in the **Inspector** window.
1. In the **Inspector** window, select **Add Component**. In the **Search** window that appears, enter **translation** and select the **translation.cs** script.

    :::image type="content" source="../media/search-translation-script.png" alt-text="A screenshot of the translation u i properties. The translation u i object is highlighted in the hierarchy window. The search bar in the inspector window is highlighted. The word translation is entered into the search bar.":::

1. With the **Translation UI** object still selected, in the **Inspector** window, expand the **translation.cs** script properties.
1. In the **Inspector** window, assign the following objects to their respective properties:
    - **Recognized Text**: Recognition Output
    - **Translated Text**: Translation Output
    - **Mic Button**: Mic

    :::image type="content" source="../media/translation-script-ui-elements.png" alt-text="A screenshot of the translation script properties. The recognized text, translated text, and mic button properties are highlighted.":::

1. With the **Translation UI** object still selected, in the **Inspector** window, enter the **Subscription Key** and **Location** (Speech Service Region) created with the Azure Speech resource.

    :::image type="content" source="../media/translation-script-azure-credentials.png" alt-text="A screenshot of the translation script properties. The speech service subscription key and speech service region properties are highlighted.":::

## Try speech translation in play mode

1. In the Unity toolbar, click the **Play** icon to enter play mode.

    :::image type="content" source="../media/play-mode.png" alt-text="A screenshot of the Unity editor in play mode. The play icon is highlighted.":::

1. Using the Unity in-editor input simulation, press the **space bar** on your keyboard to simulate hand input with the right hand.

    :::image type="content" source="../media/simulated-hand.png" alt-text="A screenshot of the game window. The translation ui is in the middle of the screen. A simulate right hand is at the lower right side of the screen.":::

1. While pressing the space bar, use your mouse scroll wheel to scroll forward to press the mic button. Once the mic button has been pressed, say "Hello" into the your microphone.

    :::image type="content" source="../media/press-button.gif" alt-text="A gif of the simulated hand pressing the microphone button in the game scene.":::

1. The recognized speech and the translation will display in the scene. You can press the button again to translate additional phrases.

    :::image type="content" source="../media/recognition-results.png" alt-text="A screenshot of the game window. The recognized speech and translation speech results display on the quad. The recognized speech is hello. The translation is bonjour.":::