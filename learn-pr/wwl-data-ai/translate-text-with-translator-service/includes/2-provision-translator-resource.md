**Azure AI Translator** provides a multilingual text translation API that you can use for:

- Language detection.
- One-to-many translation.
- Script transliteration (converting text from its native script to an alternative script).

:::image type="content" source="../media/translator-resource.png" alt-text="An Azure AI Translator resource performing language detection, one-to-many translation and transliteration.":::

## Azure resource for Azure AI Translator

To use the Azure AI Translator service, you must provision a resource for it in your Azure subscription. You can provision a single-service Azure AI Translator resource, or you can use the Text Analytics API in a multi-service Azure AI Services resource.

After you have provisioned a suitable resource in your Azure subscription, you can use the **location** where you deployed the resource and one of its **subscription keys** to call the Azure AI Translator APIs from your code. You can call the APIs by submitting requests in JSON format to the REST interface, or by using any of the available programming language-specific SDKs.

> [!NOTE]
> The code examples in the subsequent units in this module show the JSON requests and responses exchanged with the REST interface. When using an SDK, the JSON requests are abstracted by appropriate objects and methods that encapsulate the same data values. You'll get a chance to try the SDK for C# or Python for yourself in the exercise later in the module.
