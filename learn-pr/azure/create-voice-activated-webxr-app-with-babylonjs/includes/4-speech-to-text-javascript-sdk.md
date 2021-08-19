Azure Speech Services provides software development kits (SDKs) in multiple languages to help developers integrate the service into their applications. Speech-to-text is available in the SDKs for the following languages: C++, C#, Java, JavaScript, Python, Swift, Objective-C, and Go.

Recall that the amusement park application needs to be served on the web, and your team is using Babylon.js to create the application. To integrate Azure Speech-to-text into the amusement park application, we will need to use Azure Speech's JavaScript SDK.

Here, we'll go through the important classes and functions (from the SDK) for setting up and using the Azure Speech-to-text service in the amusement park application.

## SpeechConfig

The SpeechConfig class contains the necessary configuration data needed to connect to the Speech service in Azure. For example, you can create a SpeechConfig instance through the following code:

```typescript
const speechConfig = SpeechConfig.fromSubscription(SUBSCRIPTION_KEY, REGION);
```

The fromSubscription() method allows us to create an instance of SpeechConfig that contains the subscription key and the region of your Azure Speech service instance. Recall that you have retrieved the values for both of these values at the end of the last exercise.

While it is also possible to create a SpeechConfig using other types of configuration values, we will be using the combination of subscription key and region in this module.

## AudioConfig

The AudioConfig class contains the configuration data for the audio input source. Specifically, it allows us to specify whether the input is coming from a microphone, file, or stream.

The line below creates a AudioConfig instance for the microphone:

```typescript
const audioConfig = AudioConfig.fromDefaultMicrophoneInput();
```

## SpeechRecognizer

The SpeechRecognizer class performs the speech-to-text transcription action. To create an instance of the SpeechRecognizer, pass in the SpeechConfig and AudioConfig instances to the constructor:

```typescript
const recognizer = new SpeechRecognizer(speechConfig, audioConfig);
```

After the SpeechRecognizer instance is initialized, we can start to perform speech-to-text on the audio input by calling `startContinuousRecognitionAsync()`:

```typescript
recognizer.startContinuousRecognitionAsync();
```

The SpeechRecognizer will continue to listen for input until `stopContinuousRecognitionAsync()` is called:

```typescript
recognizer.stopContinuousRecognitionAsync();
```

While the SpeechRecognizer is listening for input, we can retrieve the transcribed text by defining the event handler of the *recognized* event:

```typescript
recognizer.recognized = async (s: Recognizer, e: SpeechRecognitionEventArgs) => {
    if (e.result.reason == ResultReason.RecognizedSpeech) {
        console.log(e.result.text); // e.result.text contains the transcription as a string (includes punctuation)
    }
};
```

The *recognized* event handler is triggered when the recognition result, or the transcribed text, is finalized. To handle the case that an error occurred during the recognition, we can implement the *canceled* event handler:

```typescript
recognizer.canceled = (s: Recognizer, e: SpeechRecognitionCanceledEventArgs) => {
    if (e.reason == CancellationReason.Error) {
        console.log(`"CANCELED: ErrorCode=${e.errorCode}`);
        console.log(`"CANCELED: ErrorDetails=${e.errorDetails}`);
    }
};
```

## PhraseListGrammar

The PhraseListGrammar class allows us to add specific phrases to improve speech recognition accuracy. For example, if you have "Move to" as a voice command in your application and "Ward" is a location, adding the phrase "Move to Ward" to the list will lower the chances of the audio being transcribed as "Move toward" by mistake.

Here's how to create a PhraseListGrammar instance and add a phrase:

```typescript
const phraseList = PhraseListGrammar.fromRecognizer(recognizer);
phraseList.addPhrase("Move to Ward");
```
