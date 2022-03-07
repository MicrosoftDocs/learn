Using Text-to-speech requires an Azure account and a Speech service resource. The subscription has free and standard pricing tiers, and provides an endpoint and subscription key for you to access the service. Using the free tier, you can test Text-to-speech to determine if it’s the right choice for your organization.

You can access the service through REST, Speech CLI, or through a software development kit (SDK). Languages with an SDK available are:

* C#
* C++
* Go
* Java (Android and JRE)
* JavaScript
* Objective-C / Swift
* Python

## Choosing a voice

You can synthesize a string of text into audio with a single method. Text-to-speech will return audio in a .wav format that can be saved to a file or used as an in-memory stream. You specify the language by choosing an appropriate voice and locale when calling the method. The service can send a list of voices and locales to your program so the desired output can be selected. You’re also able to customize audio output attributes including:

* Audio file type
* Sample-rate
* Bit-depth

You can choose between standard and neural voices by changing the voice attribute of the method. You can use Text-to-speech with other services, such as translator to improve accessibility. For example, flight information announcements can be translated into multiple languages using translator and announced in the appropriate language with accurate pronunciation of words and numbers. Overall resulting in more confidence and clarity for passengers.

## Granular speech control

**Speech Synthesis Markup Language** (SSML) allows you to fine-tune the pitch, pronunciation, speaking rate, volume, and more of the Text-to-speech output by submitting your requests with XML. The following example is using a **neural voice named Aria** - an **English voice** with **US locale**.

```XML
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US">
    <voice name="en-US-AriaNeural">
        This is the text that is spoken by Aria.
    </voice>
</speak>
```

**xml:lang** specifies the language of the text to be synthesized to audio, in this case it’s en-US – an English voice with US locale. The markup vocabulary is specified by xmlns. Within the example, it uses World Wide Web Consortium (W3C), which is the main international standards organization for the World Wide Web, and should be used by default.

## Adjust speaking styles

With **neural voices**, you're able to change the speaking style to express emotions like sadness, calmness, and seriousness. You can also use specific voice types, such as customer service, news casting, and voice assistant, using the **mstts:express-as** element within **SSML**. In the example below, the style of the neural voice ‘Aria’ is changed to cheerful, which alters pitch and timbre.

```XML
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="en-US">
  <voice name="en-US-AriaNeural">
    <mstts:express-as style="cheerful">
      This is awesome!
    </mstts:express-as>
  </voice>
</speak>
```

## Custom voices

You can create a custom neural voice by using Speech Studio, a customization portal for the Azure Speech Service. There you're provided with instructions on how to create the audio and matching transcript. When you upload the files, the service creates the custom voice and provides a custom endpoint for you to access it.

Microsoft has an ongoing commitment to Responsible AI use, and with the rising concerns around deepfake voices, custom neural voices aren't available by default. To gain access to a custom neural voice, you must apply and provide a disclosure for voice talent. A hyperlink to the documentation for access to custom neural voice is provided in Unit 7 – Summary.
