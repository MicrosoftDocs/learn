Various tools are available to foster collaboration across a global workforce. Although most tools are available in a 2D platform, collaboration across immersive environments provides the feeling of existing in the same room without the need to occupy the same physical space. 

However, collaboration across a global workforce presents its challenges when participants don't share a common language. Rather than conform to the use of a single language, providing the ability to communicate in a person's native language helps to create an inclusive and communicative work environment.  

To accommodate differences in language, the integration of speech translation in immersive collaboration tools has the potential to ensure that participants can communicate and understand one another in their preferred language. For example, a participant can speak in French to their Japanese colleague. In real time, the output is translated as text through a UI in kanji (Japanese characters).

## Speech translation on Azure

Azure Cognitive Services Speech Translation uses neural machine translation (NMT) technology to translate audio in real time from more than 30 languages. Translation support is available for both speech to speech and speech to text. 

When speech audio is streamed, the service returns a result of the recognized text in the source language and its translation in the target language. The service is trained to normalize speech output for better translation. Verbal fillers ("um," "uh," and coughs) and repeated words are removed. The service also adds proper punctuation and capitalization and excludes profanities.

## Customize speech recognition and translation

Do you want to include industry-specific or organization-specific terminology in your speech translation? You can train and deploy a custom translation system to recognize domain-specific terminology and unique speaking styles. 

Microsoft Custom Translator enables developers to build customized NMT systems without the need for machine learning expertise. The translation system can be trained through parallel documents (pairs of documents where one is the translation of the other) or dictionary data.

## Security

The Speech service in Cognitive Services is certified by SOC, FedRAMP, PCI, HIPAA, HITECH, and ISO. Audio input and translation data aren't logged during audio processing. As for custom translator data, the data is encrypted while it's in storage. You can also view or delete any of your custom translator data and models.
