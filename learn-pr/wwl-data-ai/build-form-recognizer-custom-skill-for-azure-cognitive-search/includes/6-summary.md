Cognitive Search is a flexible search solution that can index many different types of content. However, if your content includes scanned or photographed forms, Cognitive Search may not be able to index fields from those forms. You can address this issue by adding a custom skill to the Cognitive Search indexing pipeline that calls Azure AI Document Intelligence. Scanned forms will then be sent to your Azure AI Document Intelligence models, which can extract the fields they've been trained to recognize and return their values for inclusion in the index. 

The result of this integration is that users can locate the completed forms they need by searching for the values of fields in them.

Now that you've completed this module, you can:

- Describe how a custom skill can enrich content passed through an Azure Cognitive Search pipeline.
- Build a custom skill that calls an Azure AI Document Intelligence solution to index data from forms.

## Learn more

- [What is Azure Cognitive Search?](/azure/search/search-what-is-azure-search)
- [Attach an Azure AI Services resource to a skillset in Azure Cognitive Search](/azure/search/cognitive-search-attach-cognitive-services)
- [Built-in skills for text and image processing during indexing (Azure Cognitive Search)](/azure/search/cognitive-search-predefined-skills)
- [Custom Web API skill in an Azure Cognitive Search enrichment pipeline](/azure/search/cognitive-search-custom-skill-web-api)
- [Example: Create an Azure AI Document Intelligence custom skill](/azure/search/cognitive-search-custom-skill-form)
- [Add a custom skill to an Azure Cognitive Search enrichment pipeline](/azure/search/cognitive-search-custom-skill-interface)
- [Postman](https://www.postman.com)
- [Create a skillset in Azure Cognitive Search](/azure/search/cognitive-search-defining-skillset)
- [Form Analyzer custom skill sample code](https://github.com/Azure-Samples/azure-search-power-skills/tree/main/Vision/AnalyzeFormV2)