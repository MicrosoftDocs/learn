In Unity, displaying the result from an API integration within a mixed reality app requires adding and configuring UI elements to the scene. To display speech translation from the Azure Cognitive Services Speech Translation service, you must add a quad, text, and a button to the scene and assign them to their respective properties in the corresponding C# script. Also, your Azure credentials must be validated to use the Speech service.

Here, you'll add Mixed Reality Toolkit (MRTK) UI elements to a Unity scene. You'll then create a script that uses the Cognitive Services Speech SDK for translation.

## Create UI

You create a parent object called **TranslationUI** to store the UI elements inside the object as its children. Storing the UI elements as the children of **TranslationUI** helps keep the project hierarchy organized. It also enables the UI elements to inherit properties from the parent, such as the transform.

The UI consists of a quad, which serves as a flat surface for the text. Displayed on top of the quad is text. The top portion of the quad contains the recognized text, and the bottom displays the translated speech. The UI text elements are similar in setup. After you create and configure one text element, you can duplicate it to save time in creating the others.

:::image type="content" source="../media/translator-ui-final.png" alt-text="Screenshot of the complete translator UI. The label Recognized Speech is at the top, followed by the label Translation at the bottom. There's blank space after each label to provide room for the Azure result.":::

### Create a Translation UI GameObject to store the UI

1. In the **Hierarchy** window, select the **+** icon and select **Create Empty**.

    :::image type="content" source="../media/create-empty.png" alt-text="Screenshot of the hierarchy window. The plus icon and Create Empty menu option are highlighted.":::

1. Select the **GameObject** object in the **Hierarchy** window. The **GameObject** properties appear in the **Inspector** window.

    :::image type="content" source="../media/gameobject-properties.png" alt-text="Screenshot of the Hierarchy and Inspector windows. The Game Object object is highlighted in the Hierarchy window. The object's properties are highlighted in the Inspector window.":::

1. In the **Inspector** window, name the GameObject **Translation UI**. Change **Transform Position** to **0**, **0**, **0.8**. This setting moves the object away from the user, which later helps to display the UI elements in front of the user.

    :::image type="content" source="../media/translation-ui-properties.png" alt-text="Screenshot of the Translation UI object's properties. The name of the property and the transform position values are highlighted. The x value is 0. The y value is 0. The z value is 0 point 8.":::

### Add a Quad GameObject

1. To add the object as a child of **Translation UI**, in the **Hierarchy** window, select the **Translation UI** object. Next, right-click the object and select **3D Object** > **Quad**.

    :::image type="content" source="../media/add-quad-object.png" alt-text="Screenshot of the Hierarchy window with the Translation UI object highlighted. The menu is open with the 3 D Object and Quad selections highlighted.":::

1. Adjust the Scene view camera by using the Scene gizmo to view the front of the quad.

    :::image type="content" source="../media/scene-gizmo.png" alt-text="Screenshot of the Scene window in the Unity editor. The Play gizmo is highlighted.":::

1. Select the **Quad** object in the **Hierarchy** window. The quad's properties appear in the **Inspector** window.
1. In the **Inspector** window, change the quad's **Transform Scale** to **0.8**, **0.5**, **0.1**. This setting will make the quad rectangular.

    :::image type="content" source="../media/quad-properties.png" alt-text="Screenshot of the Quad object's properties. In the Hierarchy window, the Quad object is highlighted. In the Inspector window, the scale values are highlighted. The x value is 0 point 8. The y value is 0 point 5. The z value is 0 point 1.":::

1. The **Quad** object's material should be a color that will make the text UI legible. MRTK is equipped with materials that can be applied to GameObjects. In the **Project** window, enter **MRTK_Standard_White** in the search bar to find the color white.

    :::image type="content" source="../media/mrtk-standard-white.png" alt-text="Screenshot of the Project window. The search bar is highlighted. The phrase M R T K underscore Standard underscore White is entered in the search bar.":::

1. Drag the **MRTK_Standard_White** material from the **Project** window to the **Quad** object. The color of the **Quad** object in the **Scene** window should now be white.

    :::image type="content" source="../media/scene-white-quad.png" alt-text="Screenshot of the Scene window. A white rectangular Quad object is in the middle of the scene.":::

### Add text to display on the Quad GameObject

1. To add the text object as child of **Translation UI**, in the **Hierarchy** window, select the **Translation UI** object. Next, right-click the object and select **3D Object** > **Text - TextMeshPro**.

    :::image type="content" source="../media/add-text-object.png" alt-text="Screenshot of the Hierarchy window. The Translation U I object is highlighted. A menu is shown with the selections 3 D object and Text dash Text Mesh Pro highlighted.":::

1. Select the **Text - TextMeshPro** object in the **Hierarchy** window. The **Text - TextMeshPro** properties appear in the **Inspector** window.
1. In the **Inspector** window, name the **Text - TextMeshPro** object **Recognition (Label)** and change the following **Rect Transform** properties:
    - **Pos X** = 0, **Pos Y** = 0.1, **Pos Z** = 0
    - **Width** = 0.74
    - **Height** = 0.2

    :::image type="content" source="../media/recognition-label-transform-properties.png" alt-text="Screenshot of the recognition label properties. The recognition label object is highlighted in the Hierarchy window. In the Inspector window, the object and rect transform position, width, and height values are highlighted.":::

1. With the **Recognition (Label)** object still selected, in the **Inspector** window, change the remaining properties:
    - **Text** = Recognized Speech:
    - **Font Size** = 0.3
    - **Face Color** = 000000

    :::image type="content" source="../media/text-name-size-color-properties.png" alt-text="Screenshot of the Inspector window for the recognition label object. The text, font size, and face color properties are highlighted.":::

1. You can duplicate the **Recognition (Label)** object to create the remaining text UI. The **Pos Y** and **Text** properties will be changed for each object to position the text appropriately against the **Quad** object. With the **Recognition (Label)** object still selected, use the keyboard shortcut **Ctrl+D** to duplicate the object three times.

    :::image type="content" source="../media/recognition-label-duplicated.png" alt-text="Screenshot of the Hierarchy window. There are three duplicated objects for the recognition label.":::

1. In the **Hierarchy** window, rename each object as follows:
    - Recognition (Label)
    - Recognition Output
    - Translation (Label)
    - Translation Output

    :::image type="content" source="../media/duplicated-object-names.png" alt-text="Screenshot of the Hierarchy window with the duplicated objects highlighted.":::

1. For each duplicated object, change the **Pos Y** and **Text** properties as follows:
    - *Recognition Output*: **Pos Y** = 0.03, **Text** = Recognized speech from Azure
    - *Translation (Label)*: **Pos Y** = -0.1, **Text** = Translation:
    - *Translation Output*: **Pos Y** = -0.17, **Text** = Translated speech from Azure

### Add a button to display on the Quad GameObject

1. An MRTK button prefab is used for the microphone. In the **Project** window, search for **PressableButtonHoloLens2Circular_32x32**.

    :::image type="content" source="../media/search-pressable-button.png" alt-text="Screenshot of the Project window. The search bar is highlighted. The text in the search bar reads pressable button HoloLens 2 circular underscore 32 x 32.":::

1. To add the button prefab as a child of **Translation UI**, drag the button from the **Project** window to the **Translation UI** object.

    :::image type="content" source="../media/button-child-of-translation-ui.png" alt-text="Screenshot of the Hierarchy window. The button object is highlighted. The button object is a child of the Translation U I object.":::

1. Select the **PressableButtonHoloLens2Circular_32x32** object in the **Hierarchy** window. The button properties appear in the **Inspector** window.
1. In the **Inspector** window, name the button object **Mic** and change the following **Transform** properties:
    - *Position*: **0.3**, **-0.17**, **-0.1**
    - *Scale*: **2**, **2**, **1**

    :::image type="content" source="../media/mic-properties.png" alt-text="Screenshot of the Mic object's properties. The Mic object is highlighted in the Hierarchy window. The Mic object's name, transform position, and transform scale are highlighted in the Inspector window.":::

1. With the **Mic** object still selected, in the **Inspector** window, change **Icon** to a microphone.

    :::image type="content" source="../media/mic-icon.png" alt-text="Screenshot of the Mic object's icon set. The microphone icon is highlighted.":::

## Create the Translation.cs script

> [!NOTE]
> This script has additional helper code to help debug any potential issues that might occur when you run the Unity scene.

1. In the **Project** window, select the **Assets** folder. This folder will be used to store the **Translation.cs** script.
1. In the **Project** window, select the **+** icon and select **C# Script**. Name the script **Translation.cs**.

    :::image type="content" source="../media/create-translation-script.png" alt-text="Screenshot of the Project window. The plus icon in the upper-left corner is highlighted. The translation script in the Assets section is also highlighted.":::

1. In the **Project** window, double-click the script to open it in Visual Studio.
1. In Visual Studio, replace the default code provided in the template with the following script:
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

1. The script is written to recognize English (`en-US`) and translate to French (`fr`). You can change the recognition language by modifying the value for the `SpeechRecognitionLanguage` property. You can change the target language by modifying the parameter for the `AddTargetLanguage` method.
    ```csharp
    translationConfig.SpeechRecognitionLanguage = "<assign a locale>";
    translationConfig.AddTargetLanguage("<assign a language code>");
    ```

1. Save the file and return to Unity.

## Add the Translation.cs script to a GameObject

1. In the **Hierarchy** window, select the **Translation UI** object. The **Translation UI** properties appear in the **Inspector** window.
1. In the **Inspector** window, select **Add Component**. In the **Search** window that appears, enter **translation** and select the **Translation.cs** script.

    :::image type="content" source="../media/search-translation-script.png" alt-text="Screenshot of the Translation U I properties. The Translation U I object is highlighted in the Hierarchy window. The search bar in the Inspector window is highlighted. The word translation is entered in the search bar.":::

1. With the **Translation UI** object still selected, in the **Inspector** window, expand the **Translation.cs** script properties.
1. In the **Inspector** window, assign the following objects to their respective properties:
    - **Recognized Text**: Recognition Output
    - **Translated Text**: Translation Output
    - **Mic Button**: Mic

    :::image type="content" source="../media/translation-script-ui-elements.png" alt-text="Screenshot of the translation script properties. The recognized text, translated text, and mic button properties are highlighted.":::

1. With the **Translation UI** object still selected, in the **Inspector** window, enter the **Speech Service Subscription Key** and **Speech Service Region** information created with the Azure Speech resource.

    :::image type="content" source="../media/translation-script-azure-credentials.png" alt-text="Screenshot of the translation script properties. The subscription key and region properties for the Speech service are highlighted.":::

## Try speech translation in play mode

1. In the Unity toolbar, select the **Play** icon to enter play mode.

    :::image type="content" source="../media/play-mode.png" alt-text="Screenshot of the Unity editor in play mode. The play icon is highlighted.":::

1. Using the Unity in-editor input simulation, press the Spacebar on your keyboard to simulate hand input with the right hand.

    :::image type="content" source="../media/simulated-hand.png" alt-text="Screenshot of the game window. The translation U I is in the middle of the screen. A simulated right hand is at the lower-right side of the screen.":::

1. While pressing the Spacebar, use your mouse scroll wheel to scroll forward to press the mic button. Then say "Hello" into your microphone.

    :::image type="content" source="../media/press-button.gif" alt-text="Animation of a simulated hand pressing the microphone button in the game scene.":::

1. The recognized speech and the translation will appear in the scene. You can press the button again to translate more phrases.

    :::image type="content" source="../media/recognition-results.png" alt-text="Screenshot of the game window. The recognized speech and translation speech results appear on the quad. The recognized speech is hello. The translation is bonjour.":::