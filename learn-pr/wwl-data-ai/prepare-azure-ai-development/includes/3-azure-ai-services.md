While generative AI models and agents tend to be the focus of most modern AI solution development projects, it can often be useful to leverage "off-the-shelf" functionality for common AI tasks.

Microsoft Foundry includes *Foundry Tools*; a set of out-of-the-box prebuilt APIs and models that you can integrate into your applications. Using these tools can help you create a more cost-effective and predictable solution than relying on generative AI based agents alone.

| Tool | Description |
| ---- | ----------- |
| ![Azure Language icon.](../media/azure-language.png)<br>**Azure Language**  | Azure Language in Foundry Tools provides models and APIs that you can use to analyze natural language text and perform tasks such as entity extraction, sentiment analysis, and summarization. Azure Language also provides functionality to help you build conversational language models and question answering solutions. |
| ![Azure Speech icon.](../media/azure-speech.png)<br>**Azure Speech**  | Azure Speech in Foundry Tools provides APIs that you can use to implement *text to speech* and *speech to text* transformation, as well as real-time live speech for conversational apps and agents. |
| ![Azure Translator icon.](../media/azure-translator.png)<br>**Azure Translator**  | Azure Translator in Foundry Tools uses state-of-the-art language models to translate text between a large number of languages. |
| ![Azure Document Intelligence icon.](../media/azure-document-intelligence.png)<br>**Azure Document Intelligence**  | With Azure Document Intelligence in Foundry Tools, you can use pre-built or custom models to extract fields from complex documents such as invoices, receipts, and forms. |
| ![Azure Content Understanding icon.](../media/azure-content-understanding.png)<br>**Azure Content Understanding**  | Azure Content Understanding in Foundry Tools provides multi-modal content analysis capabilities that enable you to build models to extract data from forms and documents, images, videos, and audio streams. |

To use Foundry Tools, you create client applications that connect to the tool-specific endpoint in your Microsoft Foundry resource, specifying the project authentication key or using token-based authentication. You can then use the tool-specific APIs and SDKs to use the provided functionality.

Some tools provide a user interface for configuration and test in the Foundry portal.

> [!NOTE]
> Azure tools were previously called *Azure AI Services*, and prior to that *Azure Cognitive Services*. These names are still reflected in some APIs and SDKs; and you can still provision some tools as individual Azure resources outside of a Foundry resource. For new projects, you should use the tools provided in a Microsoft Foundry resource.
