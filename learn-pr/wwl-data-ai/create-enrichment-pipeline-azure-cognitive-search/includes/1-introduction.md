You can use the predefined skills in Azure AI Search to greatly enrich an index by extracting additional information from the source data. However, there may be occasions when you have specific data extraction needs that cannot be met with the predefined skills and require some custom functionality.

For example:

- Integrate the Form Recognizer service to extract data from forms
- Consume an Azure Machine Learning model to integrate predicted values into an index
- Any other custom logic

To support these scenarios, you can implement custom skills as web-hosted services (such as Azure Functions) that support the required interface for integration into a skillset.

:::image type="content" source="../media/enrichment-pipeline.png" alt-text="A diagram showing how a skillset in an Azure AI Search solution connects to an Azure function to integrate a custom skill.":::

In this module you will learn how to:

- Implement a custom skill for Azure AI Search
- Integrate a custom skill into an Azure AI Search skillset

> [!NOTE]
> This module assumes you already know how to create and use an Azure AI Search solution that includes built-in skills. If not, complete the [Create an Azure AI Search solution](/training/modules/create-azure-cognitive-search-solution/) module first.
