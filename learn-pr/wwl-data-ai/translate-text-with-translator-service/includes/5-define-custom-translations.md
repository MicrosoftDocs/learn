
While the default translation model used by Azure AI Translator is effective for general translation, you may need to develop a translation solution for businesses or industries in that have specific vocabularies of terms that require custom translation.

To solve this problem, you can create a custom model that maps your own sets of source and target terms for translation. To create a custom model, use the Custom Translator portal to:

1. [Create a workspace](/azure/ai-services/translator/custom-translator/quickstart) linked to your Azure AI Translator resource.
1. [Create a project](/azure/ai-services/translator/custom-translator/quickstart).
1. [Upload training data files](/azure/ai-services/translator/custom-translator/quickstart) and [train a model](/azure/ai-services/translator/custom-translator/quickstart).
1. [Test your model](/azure/ai-services/translator/custom-translator/quickstart) and [publish your model](/azure/ai-services/translator/custom-translator/quickstart).
1. Make translation calls to the API.

:::image type="content" source="../media/custom-translator-new-small.png" alt-text="Screenshot showing the Custom Translator portal." lightbox="../media/custom-translator-new.png":::

Your custom model is assigned a unique **category Id** (highlighted in the screenshot), which you can specify in **translate** calls to your Azure AI Translator resource by using the **category** parameter, causing translation to be performed by your custom model instead of the default model.

## How to call the API

To initiate a translation, you send a **POST** request to the following request URL:

```http
https://api.cognitive.microsofttranslator.com/translate?api-version=3.0
```

Your request needs to include a couple of parameters:

- `api-version`: The required version of the API.
- `to`: The target language to translate to. For example: `to=fr` for French.
- `category`: Your **category Id**.

Your request must also include a number of required headers:

- `Ocp-Apim-Subscription-Key`. Header for your client key.  For example: `Ocp-Apim-Subscription-Key=<your-client-key>`.
- `Content-Type`. The content type of the payload. The required format is: `Content-Type: application/json; charset=UTF-8`.

The request body should contain an array that includes a JSON object with a `Text` property that specifies the text that you want to translate:

```json
[
    {"Text":"Where can I find my employee details?"}
]
```

There are different ways you can send your request to the API, including using the C#, Python, and curl. For instance, to make a quick call, you can send a POST request using curl:

```bash
curl -X POST "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=nl&category=<category-id>" -H "Ocp-Apim-Subscription-Key: <your-key" -H "Content-Type: application/json; charset=UTF-8" -d "[{'Text':'Where can I find my employee details?'}]"
```

The request above makes a call to translate a sentence from English to Dutch.

### Response returned

The response returns a response code of `200` if the request was successful. It also returns a response body that contains the translated text, like this:

```json
[
    {
        "translations":[
            {"text":"Waar vind ik mijn personeelsgegevens?","to":"nl"}
        ]
    }
]
```

If the request wasn't successful, then a number of different status codes may be returned depending on the error type, such as `403` (missing or invalid query parameters). See [Response status codes](/azure/ai-services/translator/reference/v3-0-translate?tabs=curl) for a full list of codes and their explanation.

> [!NOTE]
> For more information about custom translation, see [Quickstart: Build, publish, and translate with custom models](/azure/ai-services/translator/custom-translator/quickstart).
