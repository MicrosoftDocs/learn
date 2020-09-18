Text-to-speech is sometimes known as voice synthesizing. Typically a collection of synthesized voices are available for users to choose from.  The text that is used for input, is evaluated and then passed to the synthesizer to generate the spoken words. Synthesized speech has improved over time and now sound less like a computer-generated representation.

## Speech synthesis

The Speech Services speech synthesis process generates artificial reproductions of human speech, including the incorporation of modeled vocal tracts (and other human voice characteristics) to create a completely "synthetic" voice output. In plain English (pun intended), speech synthesis **converts language text into speech**.

![Text to speech](../media/mod01-text-speech-header.png)

### Text to speech

In and of itself, generating human-sounding reproductions from text is pretty amazing. The Speech Service takes this process leaps and bounds into the future, by providing the ability to providing a set of vocal tracts—or voices—to use during synthesis.

Scenarios in which speech synthesis is being adopted include:

* **Improving accessibility**: text-to-speech technology enables content owners and publishers to respond to the different ways people interact with their content. People with visual impairment or reading difficulties appreciate being able to consume content aurally. Voice output also makes it easier for people to enjoy textual content, such as newspapers or blogs, on mobile devices while commuting or exercising.

* **Responding in multitasking scenarios**: text-to-speech enables people to absorb important information quickly and comfortably while driving or otherwise outside a convenient reading environment. Navigation is a common application in this area.

* **Enhancing learning with multiple modes**: Different people learn best in different ways. Online learning experts have shown that providing voice and text together can help make information easier to learn and retain.

* **Delivering intuitive bots or assistants**: The ability to talk can be an integral part of an intelligent chat bot or a virtual assistant. More and more companies are developing chat bots to provide engaging customer service experiences for their customers. Voice adds another dimension by allowing the bot's responses to be received aurally (for example, by phone).

## Voices

For true human voice reproduction, it's not enough to just "mimic" and pronounce words correctly. Human voices are driven by, among other things, language, culture, tone, and emphasis. Even the ubiquitous phrase "Hello world!" would sound different if being spoken by a native of Australia, Canada, or the United States. This is where the concept of voices, in the Speech Services API, come to the rescue.


With the text-to-speech features of the Speech Services, your applications can convert text to human-like synthesized speech.  The service provides standard and neural voices for use but also allows customization to meet your unique needs. The 75 included standard voices support over 45 languages and locales while the neural voices are only available in a select number of languages and locales. You can view the list of available languages on the [supported languages page.](https://docs.microsoft.com/azure/cognitive-services/speech-service/language-support#text-to-speech)

### Standard voices

Standard voices provide natural sounding voices that are intelligible. The supported languages page shows the style of voice available for each language, which includes male and female sounding voices for many languages. Standard voices offer support for abbreviations and acronym expansions, and can perform appropriate date/time interpretations.

### Neural voices

The neural voice capabilities are enhanced through deep neural networks and improve on the standard voices by adding the ability to utilize stress and intonation in the spoken language. Some common scenarios where neural voices would be a better choice are:

- voice assistants and chat bots for more natural interactions
- audio book scenarios where e-books are converted to audio format
- the previously mentioned GPS navigation systems found in automobiles

### Additional core features

Two additional features of the text-to-speech service are the ability to handle long audio files and customization of speech output using the Speech Synthesis Markup Language (SSML). If your application will need to perform text-to-speech synthesis of audio content, longer than 10 minutes, consider using the Long Audio API.  This API works in an asynchronous fashion so don't use it for real time synthesis.  The service will perform the necessary work on the audio and then save the content to a file that you can download.

The SSML feature permits customization of the audio output by allowing you to adjust pitch, add pauses in the audio, improve on pronunciation, change the speaking rate, adjust volume, and attribute multiple voices to a single document that will be synthesized.
