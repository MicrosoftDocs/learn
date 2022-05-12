Let's explore the capabilities of the **Translator** service.

## Language detection

You can use the **detect** REST function to detect the language in which text is written.

For example, you could submit the following request.

```JSON
{ 'Text' : 'こんにちは' }
```

The response to this request looks like this, indicating that the text is written in Japanese:

```JSON
[
  {
    "isTranslationSupported": true,
    "isTransliterationSupported": true,
    "language": "ja",
    "score": 1.0
   }
]
```

## Translation

To translate text from one language to another, use the **translate** function; specifying a single **from** parameter to indicate the source language, and one or more **to** parameters to specify the languages into which you want the text translated.

For example, you could submit the same JSON we previously used to detect the language, specifying a **from** parameter of **ja** (Japanese) and two **to** parameters with the values **en** (English) and **fr** (French). This would produce the following result:

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

To accomplish this, we can submit the Japanese text to the **transliterate** function with a **fromScript** parameter of **Jpan** and a **toScript** parameter of **Latn** to get the following result:

```JSON
[
    {
        "script": "Latn",
        "text": "Kon'nichiwa"
    }
]
```
