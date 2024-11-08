
The pattern for speech translation using the Azure AI Speech SDK is similar to speech recognition, with the addition of information about the source and target languages for translation:

:::image type="content" source="../media/translate-speech-small.png" alt-text="A TranslationRecognizer object is created from a SpeechConfig, TranslationConfig, and AudioConfig; and its RecognizeOnceAsync method is used to call the Speech API." lightbox="../media/translate-speech.png":::

1. Use a **SpeechTranslationConfig** object to encapsulate the information required to connect to your Azure AI Speech resource. Specifically, its location and key.

1. The **SpeechTranslationConfig** object is also used to specify the speech recognition language (the language in which the input speech is spoken) and the target languages into which it should be translated.

1. Optionally, use an **AudioConfig** to define the input source for the audio to be transcribed. By default, this is the default system microphone, but you can also specify an audio file.

1. Use the **SpeechTranslationConfig**, and **AudioConfig** to create a **TranslationRecognizer** object. This object is a proxy client for the Azure AI Speech translation API.

1. Use the methods of the **TranslationRecognizer** object to call the underlying API functions. For example, the **RecognizeOnceAsync**() method uses the Azure AI Speech service to asynchronously translate a single spoken utterance.

1. Process the response from Azure AI Speech. In the case of the **RecognizeOnceAsync**() method, the result is a **SpeechRecognitionResult** object that includes the following properties:

    - Duration
    - OffsetInTicks
    - Properties
    - Reason
    - ResultId
    - Text
    - Translations

If the operation was successful, the **Reason** property has the enumerated value **RecognizedSpeech**, the **Text** property contains the transcription in the original language. You can also access a **Translations** property which contains a dictionary of the translations (using the two-character ISO language code, such as "en" for English, as a key).
