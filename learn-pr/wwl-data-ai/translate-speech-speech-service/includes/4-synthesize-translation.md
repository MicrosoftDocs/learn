
The **TranslationRecognizer** returns translated transcriptions of spoken input - essentially translating audible speech to text.

You can also synthesize the translation as speech to create speech-to-speech translation solutions. There are two ways you can accomplish this.

## Event-based synthesis

When you want to perform 1:1 translation (translating from one source language into a single target language), you can use event-based synthesis to capture the translation as an audio stream. To do this, you need to:

Specify the desired voice for the translated speech in the **TranslationConfig**.
Create an event handler for the **TranslationRecognizer** object's **Synthesizing** event.
In the event handler, use the **GetAudio**() method of the **Result** parameter to retrieve the byte stream of translated audio.
The specific code used to implement an event handler varies depending on the programming language you're using. See the [C#](/azure/ai-services/speech-service/get-started-speech-translation?pivots=programming-language-csharp) and [Python](/azure/ai-services/speech-service/get-started-speech-translation?pivots=programming-language-python) examples in the Speech SDK documentation.

## Manual synthesis

Manual synthesis is an alternative approach to event-based synthesis that doesn't require you to implement an event handler. You can use manual synthesis to generate audio translations for one or more target languages.

Manual synthesis of translations is essentially just the combination of two separate operations in which you:

1. Use a **TranslationRecognizer** to translate spoken input into text transcriptions in one or more target languages.
1. Iterate through the **Translations** dictionary in the result of the translation operation, using a **SpeechSynthesizer** to synthesize an audio stream for each language.