In the previous exercise, you learned how to create an application that used single-shot recognition to transcribe brief audio files. This application worked well for the brief audio memos that your medical clients provided, but your company needs an application you can use to transcribe your clients' longer dictation files.

With that in mind, in the next exercise, you'll modify your existing application to use continuous recognition, which works for both the brief memos and longer dictations. Continuous recognition gives you greater control over the speech-recognition process, but it requires more code to implement in your application.

## Creating an application using continuous recognition to transcribe audio files

To create an application that will convert speech to text using Azure AI Speech continuous recognition, your application will have to accomplish all of the following tasks:

- Include the `Microsoft.CognitiveServices.Speech` package.

- Create a `SpeechConfig` class using the API key from your Azure AI services account.

- Create a `AudioConfig` class using a WAVE file as the source.

- Create a `SpeechRecognizer` class using the `SpeechConfig` and `AudioConfig` classes.

- Subscribe to the following events of the `SpeechRecognizer` class:

  - The `Recognized` event detects whether text has been recognized.
  - The `Canceled` event detects whether the recognition has been canceled, which might be due to error.
  - The `SessionStopped` event detects when recognition has stopped.

- Create a `StreamWriter` class to write the converted text to a file.

- Invoke the `StartContinuousRecognitionAsync()` method of the `SpeechRecognizer` class to start recognition, and the `StopContinuousRecognitionAsync()` method to stop recognition.

In the next exercise, we'll look at all of those steps in detail.
