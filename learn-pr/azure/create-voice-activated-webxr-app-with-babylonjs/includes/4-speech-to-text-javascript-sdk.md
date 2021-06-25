Azure Speech Services provides software development kits (SDKs) in multiple languages to help developers integrate the service into their applications. Speech-to-text is available in the SDKs for these languages: C++, C#, Java, JavaScript, Python, Swift, Objective-C, and Go.

Recall that the amusement park application needs to be served on the web, and your team is using Babylon.js to create the application. To integrate Azure Speech-to-text into the amusement park application, we will need to use Azure Speech's JavaScript SDK.

Here, we'll go through the important classes and functions (from the SDK) for setting up and using the Azure Speech-to-text service in the amusement park application.

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=master)
-->

## SpeechConfig

The SpeechConfig class contains the necessary configuration data needed to connect to the Speech service in Azure. For example, you can create a SpeechConfig instance through the following code:

```javascript
const speechConfig = SpeechConfig.fromSubscription(SUBSCRIPTION_KEY, REGION);
```

The fromSubscription() method allows us to create an instance of SpeechConfig that contains the subscription key and the region of your Azure Speech service instance. Recall that you have retrieved the values for both of these values at the end of the last exercise.

While it is also possible to create a SpeechConfig using other types of configuration values, we will be using the combination of subscription key and region in this module.

## AudioConfig

The AudioConfig class contains the configuration data for the audio input source. Specifically, it allows us to specify whether the input is coming from a microphone, file, or stream.

The line below creates a AudioConfig instance for the microphone:

```javascript
const audioConfig = AudioConfig.fromDefaultMicrophoneInput();
```

## SpeechRecognizer

The SpeechRecognizer class 

## PhraseListGrammar

The PhraseListGrammar class allows us to add specific phrases to improve speech recognition accuracy. For example, adding the phrase "for Ward" to the list will lower the chances of the audio being transcribed as "forward" by mistake.

Here's how to create a PhraseListGrammar instance and add a phrase to it:

```javascript
const phraseList = PhraseListGrammar.fromRecognizer(recognizer);
phraseList.addPhrase("for Ward");
```
