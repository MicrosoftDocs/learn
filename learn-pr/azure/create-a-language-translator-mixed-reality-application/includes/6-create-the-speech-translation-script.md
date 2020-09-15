Scripting is necessary to use APIs in Unity projects. In the collaboration tools example, the Cognitive Services Speech SDK is used for translation. Here, you'll learn the basic structure of a C# script that can be used for speech recognition and translation in a Unity Mixed Reality project.

> [!NOTE]
> When a new C# script is created in Unity, a template is provided which includes default namespaces in addition to a `start()` and `update()` method. The `start()` method is the first method called on the frame when the script is enabled.  The `update()` method is then called for every subsequent frame.

## Dependencies

To use the Cognitive Services Speech SDK and MRTK UI elements, the following namespaces are required:

```csharp
using Microsoft.CognitiveServices.Speech
using Microsoft.CognitiveServices.Speech.Translation
using Microsoft.MixedReality.Toolkit.UI;
using TMPro;
```

> [!NOTE]
> The `TMPro` namespace is necessary to use TextMesh Pro. Some MRTK prefabs and assets require TextMesh Pro.

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

Any public variable created in the script can be accessed through the Unity editor. This is helpful for assigning UI elements to the property. At a minimum, the translation app should include both a button UI to activate the microphone and a text UI element for the translation.

In a production version of the app, the Azure credentials created by the Speech resource would be stored as environment variables. However, as you complete the exercises for this module, you can manage your Azure credentials through the Unity editor by creating public variables for both the **Subscription Key** and **Location**. Creating these variables as public variables enables you to change the value through the Unity editor.

Any private variable created in the script cannot be access through the Unity editor. These variables are used throughout the script in the methods that are necessary to run the speech recognition task. For instance, when the speech translation service returns the translated string, the result is stored in a private variable `translatedString`. The string returned is passed as a string for the `translatedText` UI element which displays the translation in the app's UI.

For Mixed Reality apps that require voice input from a microphone, it is recommended to require permission from the user to access their microphone. Whether the user has granted permission can be stored in a Boolean variable `micPermissionGranted`. The initial Boolean value for `micPermissionGranted` should be set to `false` and only changed to `true` if the user grants permission to access their microphone.

A `threadLocker` object is created to synchronize access to data. Thread coordination is a concept used in asynchronous programming to make UI responsive to the end user.

## ButtonClick() Method

The logic for managing speech translation is stored inside a method that is called after the user presses the microphone button. This method is referred to as `ButtonClick()`. 

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

The `ButtonClick()` method contains two objects that are created to perform speech translation: `SpeechTranslationConfig` and `TranslationRecognizer`.

### SpeechTranslationConfig object

The `SpeechTranslationConfig` class in the Cognitive Services Speech SDK is used to create a `SpeechTranslationConfig` object. The Speech resource created for speech translation contains the subscription key and region (referred to as **Location** in the Azure portal) that must be included as parameters of the `SpeechTranslationConfig` class.  


In addition, the recognition language and target language must be specified. The recognition language is the language in which the translation service uses to recognize the utterance. The recognition language is set by assigning the locale to the `SpeechRecognitionLanguage` property. The target language is the language in which the translation service uses to translate the utterance. The target language is set using the `AddTargetLanguage` method and the language code.

> [!NOTE]
> The recognition and target languages must be [one of the supported locales and/or language codes](https://aka.ms/speech/sttt-languages) for Speech Translation.

### TranslationRecognizer object

The `TranslationRecognizer` class in the Cognitive Services SDK performs speech recognition from either a microphone, file, or other audio input stream, and gets the translated string as a result. This class is used to create a `TranslationRecognizer` object. The `TranslationRecognizer` class takes the `SpeechTranslationConfig` as an argument to create an instance of a translation recognizer.

The `TranslationRecognizer` object is then used to start speech recognition and return the speech translation. After speech recognition starts, it returns after a single utterance is recognized. The end of a single utterance is determined by listening for silence at the end of the utterance or until a maximum of 15 seconds of audio is processed. The task returns the recognition text translated into the target language as a dictionary. The key reflects the target language and the value reflects the translation. To display the translation in the Unity UI, assign the value of the dictionary to the `translatedString` variable.


> [!NOTE]
> Since `RecognizeOnceAsync()` returns only a single utterance, it is suitable only for single shot recognition such a command or query. For long-running multi-utterance recognition, use `StartContinuousRecognitionAsync()` instead.

## Start() method

The `Start()` method is used to confirm whether microphone permission has been granted by the user. Once microphone permission is granted, the Boolean value for `micPermissionGranted` is changed to `True`. In addition, the `Start()` method listens for a button click. If the user presses the button assigned to the `micButton` property, the `ButtonClick()` method is executed.

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