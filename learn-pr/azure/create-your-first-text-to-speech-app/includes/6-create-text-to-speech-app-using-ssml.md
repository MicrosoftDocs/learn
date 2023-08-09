In the previous exercise, you learned how to create an application that read a text file, converted the contents to speech, and then created an audio file with the results. The results worked well for your company's video needs, but your manager would like to know if there's some way to exert greater control over the results of your application's text-to-speech operations. For example, your video team would like to have multiple virtual speakers in a single audio file, and they'd like to alter some of the playback parameters, such as the speaking rate and the pitch.

Fortunately for you, Azure Cognitive Services' text-to-speech features work with Speech Synthesis Markup Language (SSML), which you can use to customize the speech your application creates.

There's a wealth of information about SSML in the [Improve synthesis with Speech Synthesis Markup Language (SSML)](/azure/cognitive-services/speech-service/speech-synthesis-markup) article, and far too much information to include in this unit. With that in mind, this unit contains a brief overview of SSML to help you get started.

## Creating SSML files

### Starting a new SSML file

SSML files use XML syntax, and the root element for an SSML file is a `<speak>` element. When you add that element to a new file, it should look like the following excerpt:

```xml
<speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
   
</speak>
```

### Specifying different voices

To specify different voices, you'd wrap text within different `<voice>` elements that are contained with the parent `<speak>` element, and you'd specify the voice to use by adding a `name` attribute to the `<voice>` element, which might resemble the following excerpt:

```xml
<speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
  <voice name="en-AU-NatashaNeural">
    Hello world!
    This is Natasha!
  </voice>
  <voice name="en-IN-NeerjaNeural">
    Hello world!
    This is Neerja!
  </voice>
  <voice name="en-CA-LiamNeural">
    Hello world!
    This is Liam!
  </voice>
  <voice name="en-US-JennyNeural">
    Hello world!
    This is Jenny!
  </voice>
</speak>
```

> [!NOTE]
> For a list of voices you can use, see the **Text to speech** section of [Language and voice support for the Speech service](/azure/cognitive-services/speech-service/language-support?tabs=tts#prebuilt-neural-voices).

### Adjusting the speaking rate and pitch

To specify a different speaking rate or pitch, you'd enclose text within a `<prosody>` element, and you'd specify the rate or pitch by those respective attributes, as demonstrated in the following example:

```xml
<speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
  <voice name="en-AU-NatashaNeural">
    <prosody rate="-5" pitch="5%">
      Hello world!
      This is Natasha!
    </prosody>
  </voice>
  <voice name="en-IN-NeerjaNeural">
    <prosody rate="-10%" pitch="0%">
      Hello world!
      This is Neerja!
    </prosody>
  </voice>
  <voice name="en-CA-LiamNeural">
    <prosody rate="-10%" pitch="-5%">
      Hello world!
      This is Liam!
    </prosody>
  </voice>
  <voice name="en-US-JennyNeural">
    <prosody rate="-5%" pitch="0%">
      Hello world!
      This is Jenny!
    </prosody>
  </voice>
</speak>
```

### Adding pauses in the speech

The `<break>` element is excellent for controlling when a voice should speak, which you can use to adjust the overall timing of your narration. The `<break>` element has a `time` attribute you can use to specify the amount of delay, as shown in the following example:

```xml
<speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
  <voice name="en-AU-NatashaNeural">
    Hello world!
    <break time="1s" />
    This is Natasha!
  </voice>
  <voice name="en-IN-NeerjaNeural">
    <break time="1s" />
    Hello world!
    This is Neerja!
  </voice>
  <voice name="en-CA-LiamNeural">
    Hello world!
    This is Liam!
    <break time="1s" />
  </voice>
  <voice name="en-US-JennyNeural">
    <prosody rate="-5%" pitch="0%">
      Hello world!
      <break time="1s" />
      This is Jenny!
    </prosody>
  </voice>
</speak>
```

### Helping the speech synthesis engine with unfamiliar words

If your application requires words that Azure Cognitive Services' text to speech features have a difficult time pronouncing, you can enclose the difficult words within a `<phoneme>` element. Then, you can use the `ph` attribute to spell out the pronunciation using the appropriate phonetic alphabet, as specified by the `alphabet` attribute.

```xml
<speak xmlns="http://www.w3.org/2001/10/synthesis" version="1.0" xml:lang="en-US">
  <voice name="en-SG-WayneNeural">
    The Arizona State Flower is the <phoneme alphabet="sapi" ph="s aa w aa r o">Saguaro</phoneme> Cactus Blossom.
  </voice>
</speak>
```

> [!NOTE]
> For more information about working with phonetic alphabets, see [Speech service phonetic sets](/azure/cognitive-services/speech-service/speech-ssml-phonetic-sets).

## Creating a text-to-speech application for SSML files

The process to create an application that converts SSML to speech using Azure Cognitive Services is similar to the text file that you created in the previous exercise. With that in mind, your application will have to accomplish all of the following tasks:

- Include the `Microsoft.CognitiveServices.Speech` package.

- Read SSML from a file.

- Create a `SpeechConfig` class using the API key from your Azure Cognitive Services account.

- Create a `SpeechSynthesizer` class using the `SpeechConfig` class.

- Invoke the `SpeakSsmlAsync()` method of the `SpeechSynthesizer` class to convert the SSML to speech.

- Create an `AudioDataStream` class using the results of the `SpeakSsmlAsync()` method.

- Invoke the `SaveToWaveFileAsync()` method of the `AudioDataStream` class to save the audio to a WAVE file.

In the next exercise, we'll look at all of those steps in detail.
