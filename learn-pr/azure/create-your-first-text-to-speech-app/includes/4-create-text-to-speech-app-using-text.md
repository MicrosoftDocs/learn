In the previous exercise, you learned how to create an Azure Cognitive Services account using the Azure Command Line Interface (CLI).

Now that you have an Azure Cognitive Services account with which to work, you can begin working on your text-to-speech application.

In this module, we're going to focus on two ways to pass text to Azure Cognitive Services's text to speech engine:

| Text Format | Description |
|---|---|
| Plain text | Easier to produce, but inflexible if you want to customize your text to speech conversion. |
| Speech Synthesis Markup Language (SSML) | An XML format that requires a bit of learning to produce, but is powerful when you want to customize your text to speech conversion. |

In the unit after the next exercise, we'll take an in-depth look at working with SSML; but for now, we'll concentrate on working with plain text.

## Creating a text to speech application for text files

To create an application that will convert text to speech using Azure Cognitive Services, your application will have to accomplish all of the following tasks:

- Include the `Microsoft.CognitiveServices.Speech` package.

- Read text from a file.

- Create a `SpeechConfig` class using the API key from your Azure Cognitive Services account.

- Create a `SpeechSynthesizer` class using the `SpeechConfig` class.

- Invoke the `SpeakTextAsync()` method of the `SpeechSynthesizer` class to convert the text to speech.

- Create an `AudioDataStream` class using the results of the `SpeakTextAsync()` method.

- Invoke the `SaveToWaveFileAsync()` method of the `AudioDataStream` class to save the audio to a WAVE file.

In the next exercise, we'll look at all of those steps in detail.
