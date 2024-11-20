If you've created and trained custom models in Azure AI Document Intelligence, you can combine them into a single composite model and publish that as a single service. Composite models help when there are multiple versions of a form in use or when users find it difficult to keep track of the correct model for each form. They can also assist when you want customers to upload different types of documents to a single location for analysis and you don't know which type was uploaded.

You work for a company that conducts polls for private companies and political parties. Participants submit their responses as paper forms or as online PDFs. For each poll you conduct, respondents may complete up to three different form types but you want to analyze them with a single service. You want to create an AI service that can recognize these three form types and apply a different analysis to each. The three form types each have a different set of fields that you want to extract. 

Here, you'll learn how to use composite models to handle multiple form types and analyze them with different custom models in a single service.

## Learning objectives

At the end of this module, you'll be able to:

- Describe business problems that you would use composed models to solve.
- Create a composed model that can analyze forms in multiple formats.
