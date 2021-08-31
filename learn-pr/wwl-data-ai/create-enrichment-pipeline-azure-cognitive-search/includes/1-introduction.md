You can use the predefined skills in Azure Cognitive Search to greatly enrich an index by extracting additional information from the source data. However, there may be occasions when you have specific data extraction needs that cannot be met with the predefined skills and require some custom functionality.

For example:

- Integrate the Form Recognizer service to extract data from forms
- Consume an Azure Machine Learning model to integrate predicted values into an index
- Any other custom logic

To support these scenarios, you can implement custom skills as web-hosted services (such as Azure Functions) that support the required interface for integration into a skillset.

![A skillset in an Azure Cognitive Search solution connects to an Azure function to integrate a custom skill.](../media/enrichment-pipeline.png)

In this module, you'll learn how to implement a custom skill as an Azure Function, and integrate it into an Azure Cognitive Search skillset.

> [!NOTE]
> This module assumes you already know how to create and use an Azure Cognitive Search solution that includes built-in skills. If not, complete the [Create an Azure Cognitive Search solution](/learn/modules/create-azure-cognitive-search-solution/) module first.
