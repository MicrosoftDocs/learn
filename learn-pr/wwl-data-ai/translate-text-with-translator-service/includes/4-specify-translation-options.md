The **translate** function supports numerous parameters that affect the output.

## Word alignment

In written English (using Latin script), spaces are used to separate words. However, in some other languages (and more specifically, scripts) this is not always the case.

For example, translating "Cognitive Services" from **en** (English) to **zh** (Simplified Chinese) produces the result "认知服务", and it's difficult to understand the relationship between the characters in the source text and the corresponding characters in the translation. To resolve this problem, you can specify the **includeAlignment** parameter with a value of **true** to produce the following result:

```JSON
[
  {"translations": 
    [
      {"text": "认知服务", "to": "zh-Hans",
       "alignment": {"proj": "0:8-0:1 10:17-2:3"}
      }
    ]
  }
]
```

These results tell us that characters 0 to 8 in the source correspond to characters 0 to 1 in the translation (), while characters 10 to 17 in the source correspond to characters 2 to 3 in the translation.

## Sentence length

Sometimes it might be useful to know the length of a translation, for example to determine how best to display it in a user interface. You can get this information by setting the **includeSentenceLength** parameter to **true**.

For example, specifying this parameter when translating the English (**en**) text "Hello world!" to French (**fr**) produces the following results:

```JSON
[
  {"translations": 
    [
      {"text": "Salut tout le monde!", "to": "fr",
       "sentLen":{"srcSentLen":[12], "transSentLen":[20]}
      }
    ]
  }
]
```

## Profanity filtering

Sometimes text contains profanities, which you might want to obscure or omit altogether in a translation. You can handle profanities by specifying the **profanityAction** parameter, which can have one of the following values:

- **NoAction**: Profanities are translated along with the rest of the text.
- **Deleted**: Profanities are omitted in the translation.
- **Marked**: Profanities are indicated using the technique indicated in the **profanityMarker** parameter (if supplied). The default value for this parameter is **Asterisk**, which replaces characters in profanities with "*". As an alternative, you can specify a **profanityMarker** value of **Tag**, which causes profanities to be enclosed in XML tags.

For example, translating the English (**en**) text "JSON is &#x2587;&#x2587;&#x2587;&#x2587; great!" (where the blocked out word is a profanity) to French (**fr**) with a **profanityAction** of **Marked** and a **profanityMarker** of **Asterisk** produces the following result:

```JSON
[
  {"translations": 
    [
      {"text": "JSON est *** génial!", "to": "fr"}
    ]
  }
]
```

> [!NOTE]
> To learn more about the translation options, including some not described here, see the [Azure AI Translator service documentation](/azure/cognitive-services/translator/reference/v3-0-translate).
