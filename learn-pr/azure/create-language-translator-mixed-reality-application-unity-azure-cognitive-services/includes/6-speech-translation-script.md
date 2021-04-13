Scripting is necessary to use APIs in Unity projects. In the example of collaboration tools, the Cognitive Services Speech SDK is used for translation. Here, you'll learn the basic structure of a C# script that you can use for speech recognition and translation in a Unity mixed reality project.

> [!NOTE]
> When you create a C# script in Unity, the provided template includes default namespaces in addition to `start()` and `update()` methods. The `start()` method is the first method called on the frame when the script is enabled. The `update()` method is then called for every subsequent frame.

## Dependencies

To use the Cognitive Services Speech SDK and Mixed Reality Toolkit (MRTK) UI elements, you need the following namespaces:

```csharp
using Microsoft.CognitiveServices.Speech
using Microsoft.CognitiveServices.Speech.Translation
using Microsoft.MixedReality.Toolkit.UI;
using TMPro;
```

> [!NOTE]
> The `TMPro` namespace is necessary to use TextMesh Pro. Some MRTK prefabs and assets require TextMesh Pro to display text-based UI.

## Variables

```csharp
public PressableButton micButton;
public TextMeshPro translatedText;
public string SpeechServiceSubscriptionKey = "";
public string SpeechServiceRegion = "";
private string translatedString;
private bool micPermissionGranted = false;
private object threadLocker = new object();
```

Any public variable created in the script can be accessed through the Unity editor. Accessing public variables through the Unity editor is helpful for assigning UI elements to the property. At a minimum, the translation app should include both a button UI to activate the microphone and a text UI element for the translation.

In a production version of the app, the Azure credentials that the Speech resource created would be stored as environment variables. However, as you complete the exercises for this module, you can manage your Azure credentials through the Unity editor by creating public variables for both **Subscription Key** and **Location**. Creating these variables as public variables enables you to change the values through the Unity editor.

Any private variable created in the script can't be accessed through the Unity editor. These variables are used throughout the script in the methods that are necessary to run the speech recognition task. For instance, when the Speech Translation service returns the translated string, the result is stored in the private variable `translatedString`. The returned string is passed as a string for the `translatedText` UI element, which displays the translation in the app's UI.

For mixed reality apps that require voice input from a microphone, we recommend that you require permission from the user to access their microphone. Whether the user has granted permission can be stored in the Boolean variable `micPermissionGranted`. The initial Boolean value for `micPermissionGranted` should be set to `false` and changed to `true` only if the user grants permission to access their microphone.

A `threadLocker` object is created to synchronize access to data. Thread coordination is a concept used in asynchronous programming to make the UI responsive to the user.

## ButtonClick() method

The logic for managing speech translation is stored inside a `ButtonClick()` method. It's called after the user presses the microphone button. 

```csharp
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

            foreach (var element in result.Translations)
            {
                translatedString = element.Value;
            }
        }
            lock (threadLocker)
            {
                waitingforReco = false;
            }

        }
    }
```

The `ButtonClick()` method contains two objects that are created to do speech translation: `SpeechTranslationConfig` and `TranslationRecognizer`.

### SpeechTranslationConfig object

You use the `SpeechTranslationConfig` class in the Cognitive Services Speech SDK to create a `SpeechTranslationConfig` object. The Speech resource created for speech translation contains the subscription key and region (called **Location** in the Azure portal) that must be included as parameters of the `SpeechTranslationConfig` class.  

Also, you must specify the recognition language and target language. The recognition language is the language that the translation service uses to recognize the utterance. You set the recognition language by assigning the locale to the `SpeechRecognitionLanguage` property. The target language is the language that the translation service uses to translate the utterance. You set the target language by using the `AddTargetLanguage` method and the language code.

> [!NOTE]
> The recognition and target languages must be [one of the supported locales and/or language codes](https://aka.ms/speech/sttt-languages?azure-portal=true) for the Speech Translation service.

### TranslationRecognizer object

The `TranslationRecognizer` class in the Cognitive Services SDK does speech recognition from a microphone, a file, or another audio input stream, and gets the translated string as a result. You use this class to create a `TranslationRecognizer` object. The `TranslationRecognizer` class takes `SpeechTranslationConfig` as an argument to create an instance of a translation recognizer.

You then use the `TranslationRecognizer` object to start speech recognition and return the speech translation. After speech recognition starts, it returns after a single utterance is recognized. The service determines the end of a single utterance by listening for silence at the end of the utterance or until it processes a maximum of 15 seconds. 

The task returns the recognition text translated into the target language as a dictionary. The key reflects the target language, and the value reflects the translation. To display the translation in the Unity UI, assign the value of the dictionary to the `translatedString` variable.

> [!NOTE]
> Because `RecognizeOnceAsync()` returns only a single utterance, it's suitable only for single-shot recognition, such as a command or query. For long-running multiple-utterance recognition, use `StartContinuousRecognitionAsync()` instead.

## Start() method

You use the `Start()` method to confirm whether the user has granted microphone permission. After the user grants microphone permission, the Boolean value for `micPermissionGranted` is changed to `True`. Also, the `Start()` method listens for a button click. If the user presses the button assigned to the `micButton` property, the `ButtonClick()` method is executed.

```csharp
Void Start()
{
  micPermissionGranted = true;
  micButton.ButtonPressed.AddListener(ButtonClick);
}
```

## Update() method

The `Update()` method assigns the result of the speech translation to the `translatedText` UI element.

```csharp
void Update()
    {
        lock (threadLocker)
        {
            recognizedText.text = recognizedString;
            translatedText.text = translatedString;
        }
    }
```
