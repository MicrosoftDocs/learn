The Azure AI Language Detection API evaluates text input and, for each document submitted, returns language identifiers with a score indicating the strength of the analysis. The Azure AI Language service recognizes up to 120 languages.

This capability is useful for content stores that collect arbitrary text, where language is unknown. Another scenario could involve a chat bot.  If a user starts a session with the chat bot, language detection can be used to determine which language they are using and allow you to configure your bot responses in the appropriate language.

You can parse the results of this analysis to determine which language is used in the input document. The response also returns a score, which reflects the confidence of the model (a value between 0 and 1).

Language detection can work with documents or single phrases. It's important to note that the document size must be under 5,120 characters.  The size limit is per document and each collection is restricted to 1,000 items (IDs).  A sample of a properly formatted JSON payload that you might submit to the service in the request body is shown here, including a collection of **documents**, each containing a unique **id** and the **text** to be analyzed. Optionally, you can provide a **countryHint** to improve prediction performance.

```JSON

{
  "documents": [
    {
      "countryHint": "US",
      "id": "1",
      "text": "Hello world"
    },
    {
      "id": "2",
      "text": "Bonjour tout le monde"
    }
  ]
}
```

The service will return a JSON response that contains a result for each **document** in the request body, including the predicted language and a value indicating the confidence level of the prediction.  The confidence level is a value ranging from 0 to 1 with values closer to 1 being a higher confidence level.  Here's an example of a standard JSON response that maps to the above request JSON.

```JSON
{
  "documents": [
   {
     "id": "1",
     "detectedLanguage": {
       "name": "English",
       "iso6391Name": "en",
       "confidenceScore": 1
     },
     "warnings": []
   },
   {
     "id": "2",
     "detectedLanguage": {
       "name": "French",
       "iso6391Name": "fr",
       "confidenceScore": 1
     },
     "warnings": []
   }
  ],
  "errors": [],
  "modelVersion": "2020-04-01"
}
```

In our sample, all of the languages show a confidence of 1, mostly because the text is relatively simple and easy to identify the language for.

If you pass in a document that has multilingual content, the service will behave a bit differently.  Mixed language content within the same document returns the language with the largest representation in the content, but with a lower positive rating, reflecting the marginal strength of that assessment. In the following example, the input is a blend of English, Spanish, and French. The analyzer uses statistical analysis of the text to determine the *predominant* language.

```JSON
{
  "documents": [
    {
      "id": "1",
      "text": "Hello, I would like to take a class at your University. ¿Se ofrecen clases en español? Es mi primera lengua y más fácil para escribir. Que diriez-vous des cours en français?"
    }
  ]
}
```

The following sample shows a response for this multi-language example.

```JSON
{
  "documents": [
    {
      "id": "1",
      "detectedLanguages": [
        {
          "name": "Spanish",
          "iso6391Name": "es",
          "score": 0.9375
        }
      ]
    }
  ],
  "errors": []
}
```

The last condition to consider is when there is ambiguity as to the language content.  The scenario might happen if you submit textual content that the analyzer is not able to parse, for example because of character encoding issues when converting the text to a string variable.  As a result, the response for the language name and ISO code will indicate (unknown) and the score value will be returned as NaN, or Not a Number.   The following example shows how the response would look.

```JSON
{
      "id": "5",
      "detectedLanguages": [
        {
          "name": "(Unknown)",
          "iso6391Name": "(Unknown)",
          "score": "NaN"
        }
      ]
```
