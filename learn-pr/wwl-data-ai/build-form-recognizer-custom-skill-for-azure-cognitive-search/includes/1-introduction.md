Azure Cognitive Search can index content in many different formats to ensure users can locate the information they need to do their jobs. It's also extensible - skills can be added to add extra processing during indexing. If you add a skill that calls Azure AI Document Intelligence, you can use your Azure AI Document Intelligence models to enrich your Cognitive Search index. 

You work for a company that conducts polls for private companies and political parties. Participants submit their responses as paper forms or as online PDFs. Using Azure AI Document Intelligence, you've built a successful response analysis service that can obtain data from poll responses, which your users scan with their mobile devices. You've also deployed an Azure Cognitive Search service to help your users locate documents. Now, you'd like to ensure that your search solution can extract the key-value pairs that your polling models are trained to recognize.

In this module, you'll learn how to create a Cognitive Search custom skill that calls a model in Azure AI Document Intelligence to help index documents.

## Learning objectives

- Describe how a custom skill can enrich content passed through an Azure Cognitive Search pipeline.
- Build a custom skill that calls an Azure AI Document Intelligence solution to index data from forms.