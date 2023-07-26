In the previous exercise, you learned how to create an Azure Cognitive Services account using the Azure Command Line Interface (CLI). Now that you have an Azure Cognitive Services account with which to work, you can begin working on your speech-to-text application.

Your first challenge is to create an application that your company can use to transcribe the brief memos from your medical clients. Azure Cognitive Services provides two different types of speech recognition that you can use for your development:

- **Single-shot recognition**

  - Single-shot recognition listens for a break in the audio and then stops recognizing, and will only process a maximum of 15 seconds of audio.

  - This type of recognition will work well for the brief memos that your company's medical clients provide, but it won't work for the longer dictations.

  - Single-shot recognition is easier to implement in your application, but you have less control.

- **Continuous recognition**

  - Continuous recognition will continue to listen until recognition is stopped.

  - This type of recognition will work well for both the brief memos and longer dictations.

  - Continuous recognition requires more code to implement in your application, but you have more control.

In the next exercise, you'll use single-shot recognition to create an application that you can use to transcribe the brief memos from your company's medical clients. Later in this module, you'll use continuous recognition to create an application that you can use to transcribe both the brief memos and longer dictations.

## Creating an application using single-shot recognition to transcribe audio files

To create an application that will convert speech to text using Azure Cognitive Services' single-shot recognition, your application will have to accomplish all of the following tasks:

- Include the `Microsoft.CognitiveServices.Speech` package.

- Create a `SpeechConfig` class using the API key from your Azure Cognitive Services account.

- Create an `AudioConfig` class using a WAVE file as the source.

- Create a `SpeechRecognizer` class using the `SpeechConfig` and `AudioConfig` classes.

- Invoke the `RecognizeOnceAsync()` method of the `SpeechRecognizer` class to convert the speech to text.

- Create a `StreamWriter` class to write the converted text to a file.

In the next exercise, we'll look at all of those steps in detail.
