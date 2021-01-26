The Language Detection API evaluates text input and, for each document submitted, returns language identifiers with a score indicating the strength of the analysis. Text Analytics recognizes up to 120 languages.

This capability is useful for content stores that collect arbitrary text, where language is unknown. Another scenario could involve a chat bot.  If a user starts a session with the chat bot, language detection can be used to determine which language they are using and allow you to configure your bot responses in the appropriate language.

You can parse the results of this analysis to determine which language is used in the input document. The response also returns a score, which reflects the confidence of the model (a value between 0 and 1).

Language detection can work with documents or single phrases. It's important to note that the document size must be under 5,120 characters.  The size limit is per document and each collection is restricted to 1,000 items (IDs).  A sample of a properly formatted JSON payload that you might submit to the service in the request body is shown here.

```JSON

{
     "documents": [
         {
             "id": "1",
             "text": "This document is in English."
         },
         {
             "id": "2",
             "text": "Este documento está en inglés."
         },
         {
             "id": "3",
             "text": "Ce document est en anglais."
         },
         {
             "id": "4",
             "text": "本文件为英文"
         },
         {
             "id": "5",
             "text": "Этот документ на английском языке."
         }
     ]
 }

```

The service will return a JSON response that contains the IDs provided in the request body along with a value indicating the confidence level of the detected language.  The confidence level is a value ranging from 0 to 1 with values closer to 1 being a higher confidence level.  The JSON response is also formatted a little differently that what you saw in the sentiment analysis.  The reason is that your document may contain a mix of languages.  Let's evaluate that with a standard JSON response that maps to the above request JSON.

```JSON
{
    "documents": [
        {
            "id": "1",
            "detectedLanguages": [
                {
                    "name": "English",
                    "iso6391Name": "en",
                    "score": 1
                }
            ]
        },
        {
            "id": "2",
            "detectedLanguages": [
                {
                    "name": "Spanish",
                    "iso6391Name": "es",
                    "score": 1
                }
            ]
        },
        {
            "id": "3",
            "detectedLanguages": [
                {
                    "name": "French",
                    "iso6391Name": "fr",
                    "score": 1
                }
            ]
        },
        {
            "id": "4",
            "detectedLanguages": [
                {
                    "name": "Chinese_Simplified",
                    "iso6391Name": "zh_chs",
                    "score": 1
                }
            ]
        },
        {
            "id": "5",
            "detectedLanguages": [
                {
                    "name": "Russian",
                    "iso6391Name": "ru",
                    "score": 1
                }
            ]
        }
    ],
```

Note how the response is formulated in this JSON file.  The file is composed of a *documents* array that contains the IDs of the documents that were sent in the request but also note that there are nested arrays of "detected languages" for each ID.  In this case, there is only one language in the detectedLanguages array.  Each detected language is identified using a name, and ISO code with the letter designator, and a confidence score.  In our sample, all of the languages show a confidence of 1, mostly because the text is relatively simple and easy to identify the language for.

If we pass in a document that had mixed content, from a language perspective, the service will behave a bit differently.  Mixed language content within the same document returns the language with the largest representation in the content, but with a lower positive rating, reflecting the marginal strength of that assessment. In the following example, the input is a blend of English, Spanish, and French. The analyzer counts characters in each segment to determine the predominant language.

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

The service counts the number of characters in each segment. Spanish will have the most in terms of characters and as a result, it would be the "predominant" language in the text.  The following sample shows a response for this multi-language example.

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

The last condition to consider is when there is ambiguity as to the language content.  The scenario might happen if you submit textual content that the analyzer is not able to parse.  As a result, the response for the language name and ISO code will indicate (unknown).   The following example shows how the response would look.

```JSON
{
      "id": "5",
      "detectedLanguages": [
        {
          "name": "(Unknown)",
          "iso6391Name": "(Unknown)",
          "score": "0.0"
        }
      ]
```

## Learning objectives

In this module, you will learn:

- How to prepare a JSON document for the API
- How to structure the request
- How to evaluate the results that are returned