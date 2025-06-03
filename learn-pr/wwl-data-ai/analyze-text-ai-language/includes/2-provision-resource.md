Azure AI Language is designed to help you extract information from text. It provides functionality that you can use for tasks like:

- *Language detection* - determining the language in which text is written.
- *Key phrase extraction* - identifying important words and phrases in the text that indicate the main points.
- *Sentiment analysis* - quantifying how positive or negative the text is.
- *Named entity recognition* - detecting references to entities, including people, locations, time periods, organizations, and more.
- *Entity linking* - identifying specific entities by providing reference links to Wikipedia articles.

    :::image type="content" source="../media/text-analytics-resource.png" alt-text="Diagram showing an Azure AI Language resource performing language detection, key phrase extraction, sentiment analysis, named entity recognition, and entity linking.":::

## Azure resources for text analysis

To use Azure AI Language to analyze text, you must provision a resource for it in your Azure subscription. You can provision a resource through Azure AI Foundry portal

After you have provisioned a suitable resource in your Azure subscription, you can use its **endpoint** and one of its **keys** to call the Azure AI Language APIs from your code. You can call the Azure AI Language APIs by submitting requests in JSON format to the REST interface, or by using any of the available programming language-specific SDKs.

> [!NOTE]
> The code examples in the subsequent units in this module show the JSON requests and responses exchanged with the REST interface. When using an SDK, the JSON requests are abstracted by appropriate objects and methods that encapsulate the same data values. You'll get a chance to try the SDK for C# or Python for yourself in the exercise later in the module.