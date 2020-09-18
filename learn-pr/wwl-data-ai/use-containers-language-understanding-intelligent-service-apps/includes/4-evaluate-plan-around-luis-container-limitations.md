There are specific limitations around containerizing LUIS. Limitations revolve around dependencies and language support. Before containerizing your LUIS app, review the content in this article to ensure you will have a successful LUIS app in the container environment.

## Supported dependencies

LUIS supports some of the new prebuilt domains in a container environment.  The prebuilt domains are enterprise-focused and include entities, example utterances, and patterns that can be included in your LUIS app. For the complete list of supported pre-built domains, including language support for those pre-built domains, visit the [pre-built domain reference page](https://docs.microsoft.com/azure/cognitive-services/luis/luis-reference-prebuilt-domains).

## Unsupported dependencies

When you select the **Export for container** option in the LUIS portal, a report is generated that will list unsupported features that exist in your LUIS app.  These unsupported features will need to be removed. A list of unsupported app features is presented here.

- Cultures - currently Dutch (nl-NL), Japanese (ja-JP), and Germany (de-DE) languages are only supported if using the 1.0.2 tokenizer. Tokenizers aid in splitting words in composite words to form their single components.
- KeyPhrase prebuilt entity for all cultures
- GeographyV2 prebuilt entity for the English (en-US) language
- Speech priming is not supported
- Sentiment Analysis is not supported
- Bing Spell Check is not supported

## Language support

LUIS containers only support a subset of the overall language support in LUIS apps. Language support in containers focuses on the utterances used in the LUIS app.  There are various considerations for supported languages such as support for:

- Locale
- Prebuilt domains
- Phrase list recommendations
- Text Analytics, specifically sentiment analysis and keyword detection

For a complete list of the supported language features, refer to the **Languages Supported** section on the [LUIS container limitations](https://docs.microsoft.com/azure/cognitive-services/luis/luis-container-limitations) page.