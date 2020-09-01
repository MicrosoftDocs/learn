In Unity, displaying the result from an API integration within a Mixed Reality app requires adding and configuring UI elements to the scene. To display speech translation from the Azure Cognitive Services Speech Translation service, a quad, text and button must be added to the scene and assigned to their respective properties in the corresponding C# script. In addition, your Azure credentials must be validated to use the Speech service. Here, you'll add MRTK UI elements to a Unity scene and create a script that uses the Cognitive Services Speech SDK for translation.

## Create UI

A parent object **TranslationUI** is created to store the UI elements inside the object as it's children. Storing the UI elements as the children of **TranslationUI** not only helps keep the project hierarchy organized but also enables the UI elements to inherit properties from the parent such as the Transform.

The UI consists of a quad which serves as a flat surface for the text. Displayed on top of the quad is text. The top portion of the quad contains the recognized text whereas the bottom displays the translated speech.

[insert picture]

### Create a Translation UI GameObject to store the UI

1. In the **Hierarchy** window, click the **+** icon and select **Create Empty**.
1. Select the **GameObject** object in the **Hierarchy** window. The **GameObject** properties will display in the **Inspector** window.
1. In the **Inspector** window, name the GameObject **Translation UI** and change the **Transform Scale** to **.0**, **0**, **.8**. This moves the object away from the user which later helps to display the UI elements in front of the user.

### Add a Quad GameObject

1. To add the object as child of **Translation UI**, in the **Hierarchy** window, select the **Translation UI** object. Next, right click the object and select **3D Object** > **Quad**.
1. Adjust the Scene view camera using the Scene Gizmo to view the front of the quad.
1. Select the **Quad** object in the **Hierarchy** window. The Quad's properties will display in the **Inspector** window.
1. In the **Inspector** window, change the Quad's **Transform Scale** to **.8**, **.5**, **.1**. This will make the quad rectangular.

### Add text to display on the Quad GameObject

1. To add the text object as child of **Translation UI**, in the **Hierarchy** window, select the **Translation UI** object. Next, right click the object and select **3D Object** > **Text - TextMeshPro**.
1. Select the **Text - TextMeshPro** object in the **Hierarchy** window. The **Text - TextMeshPro** properties will display in the **Inspector** window.
1. In the **Inspector** window, name the Text - TextMeshPro object **Recognition (Label)** and change the following **Rect Transform** properties:
    - **Pos X** = 0, **Pos Y** = 0.1, **Pos Z** = 0
    - **Width** = 0.74
    - **Height** = 0.2
1. With the **Recognition (Label)** object still selected, in the **Inspector** window, change the remaining properties:
    - **Text** = Recognized Speech:
    - **Font Size** = 0.3
    - **Face** = #000000
1. The **Recognition (Label)** object can be duplicated to create the remaining text UI. The **Pos Y** and **Text** properties will be changed for each object to position the text appropriately against the quad. With the **Recognition (Label)** object still selected, use the keyboard short-cut **Ctrl+D** to duplicate the object 3 times.
1. In the **Hierarchy** window, rename each object as follows:
1. For each duplicated object, change the **Pos Y** and **Text** properties as such:
    - *Recognition Output*: **Pos Y** = 0.03, **Text** = Recognized speech from Azure
    - *Translation (Label)*: **Pos Y** = -0.1, **Text** = Translation:
    - *Translation Output*: **Pos Y** = -0.17, **Text** = Translated speech from Azure

### Add a button to display on the Quad GameObject

1. A MRTK button prefab is used for the microphone. In the **Project** window, search for **PressableButtonHoloLens2Circular_32x32**.
1. To add the button prefab as a child of **Translation UI**, drag the button from the **Project** window to the **Translation UI** object.
1. Select the **PressableButtonHoloLens2Circular_32x32** object in the **Hierarchy** window. The button properties will display in the **Inspector** window.
1. In the **Inspector** window, name the button object **Mic** and change the following **Transform** properties:
    - *Position*: **0.3**, **-0.17**, **-0.1**
    - *Scale*: **2**, **2**, **1**
1. With the **Mic** object still selected, in the **Inspector** window, change **Icon** to a microphone.

## Create the translation.cs script

> [!NOTE]
> Additional helper code has been added to this script to help debug any potential issues which may occur when you run the Unity scene.

1. In the **Project** window, select the **Assets** folder. This will be the folder used to store the **translation.cs** script.
1. In the **Project** window, click the **+** icon and select **C# Script**. Name the script **translation.cs**.
1. In the **Project** window, double click on the script to open in Visual Studio Code.
1. In Visual Studio Code, replace the default code provided in the template with the following:
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
    
        private object threadLocker = new object();
        private bool waitingforReco;
        private string recognizedString;
        private string translatedString;
    
        private bool micPermissionGranted = false;
    
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
1. With the **Translation UI** object still selected, in the **Inspector** window, expand the **translation.cs** script properties.
1. In the **Inspector** window, assign the following objects to their respective properties:
    - **Recognized Text**: Recognition Output
    - **Translated Text**: Translation Output
    - **Mic Button**: Mic
1. With the **Translation UI** object still selected, in the **Inspector** window, enter the **Subscription Key** and **Location** (Speech Service Region) created with the Azure Speech resource.

## Try speech translation in play mode

1. In the Unity toolbar, click the **Play** icon to enter play mode.
1. Using the Unity in-editor input simulation, press the **space bar** on your keyboard to simulate hand input with the right hand.
1. While pressing the space bar, use your mouse scroll wheel to scroll forward to press the mic button. Once the mic button has been pressed, say "Hello" into the your microphone.
1. The recognized speech and the translation will display in the scene. You can press the button again to translate additional phrases.