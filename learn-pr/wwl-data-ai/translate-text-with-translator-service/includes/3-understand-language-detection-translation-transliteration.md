Let's explore the capabilities of **Azure AI Translator**. These capabilities include:

## Language detection

You can use the **Detect** function of the REST API to detect the language in which text is written.

For example, you could submit the following text to the `https://api.cognitive.microsofttranslator.com/detect?api-version=3.0` endpoint using curl.

Here's the text we want to translate:

```JSON
{ 'Text' : 'こんにちは' }
```

Here's a call using curl to the endpoint to detect the language of our text:

```bash
curl -X POST "https://api.cognitive.microsofttranslator.com/detect?api-version=3.0" -H "Ocp-Apim-Subscription-Region: <your-service-region>" -H "Ocp-Apim-Subscription-Key: <your-key>" -H "Content-Type: application/json" -d "[{ 'Text' : 'こんにちは' }]
```

The response to this request looks as follows, indicating that the text is written in Japanese:

```JSON
[
  {
    "language": "ja",
    "score": 1.0,
    "isTranslationSupported": true,
    "isTransliterationSupported": true
    
    
   }
]
```

## Translation

To translate text from one language to another, use the **Translate** function; specifying a single **from** parameter to indicate the source language, and one or more **to** parameters to specify the languages into which you want the text translated.

For example, you could submit the same JSON we previously used to detect the language, specifying a **from** parameter of **ja** (Japanese) and two **to** parameters with the values **en** (English) and **fr** (French). To do this, you'd call:

```bash
curl -X POST "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=ja&to=fr&to=en" -H "Ocp-Apim-Subscription-Key: <your-key>" -H "Ocp-Apim-Subscription-Region: <your-service-region>" -H "Content-Type: application/json; charset=UTF-8" -d "[{ 'Text' : 'こんにちは' }]"
```

 This would produce the following result:

```JSON
[
  {"translations": 
    [
      {"text": "Hello", "to": "en"},   
      {"text": "Bonjour", "to": "fr"}
    ]
  }
]
```

## Transliteration

Our Japanese text is written using Hiragana script, so rather than translate it to a different language, you may want to transliterate it to a different script - for example to render the text in Latin script (as used by English language text).

To accomplish this, we can submit the Japanese text to the **Transliterate** function with a **fromScript** parameter of **Jpan** and a **toScript** parameter of **Latn**:

```bash
curl -X POST "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&fromScript=Jpan&toScript=Latn" -H "Ocp-Apim-Subscription-Key: <your-key>" -H "Ocp-Apim-Subscription-Region: <your-service-region>" -H "Content-Type: application/json" -d "[{ 'Text' : 'こんにちは' }]"
```

The response would give you the following result:

```JSON
[
    {
        "script": "Latn",
        "text": "Kon'nichiwa"
    }
]
```
