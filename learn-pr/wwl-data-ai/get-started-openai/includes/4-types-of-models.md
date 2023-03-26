To begin building with Azure OpenAI, you need to choose a base model and deploy it. Microsoft provides base models and the option to create customized base models. This module will cover the currently available out-of-the-box base models. Microsoft's partnership with OpenAI means models that become available with OpenAI can become available with Azure OpenAI.   

## Model families 

Azure OpenAI's generative AI models are grouped by family and capability. The family groupings are by workload. The base models within the families are distinguished how well they can complete the workload.

|Family|Description|Base models within the Family|
|:--------|:-------------------------------------|:---------------|
|**GPT-4**|A set of models that improve on GPT-3.5 and can understand as well as generate natural language and code. These models are currently in preview. For access, existing Azure OpenAI customers can apply by [filling out this form](https://aka.ms/oai/get-gpt4).|gpt-4, gpt-4-32k|
|**GPT-3**|A series of models that can understand and generate natural language. This includes the new ChatGPT model (preview).|text-davinci-003, text-curie-001, text-babbage-001, text-ada-001, gpt-35-turbo|
|**Codex**|A series of models that can understand and generate code, including translating natural language to code.|code-davinci-002, code-cushman-001|

**Embeddings** are a fourth series of models. An embedding is a special format of data representation that can be easily utilized by machine learning models and algorithms. The embedding is an information dense representation of the semantic meaning of a piece of text. 

Embeddings are further broken down into three families of Embeddings models for different functionalities: similarity, text search, and code search. 

|Embeddings Family|Description|Base models within the Family|
|:--------|:-------------------------------------|:---------------|
|Similarity embedding|Used for clustering, regression, anomaly detection, and visualization. This family of models capture semantic similarity between two or more pieces of text.|[See current list](https://learn.microsoft.com/azure/cognitive-services/openai/concepts/models#similarity-embedding)|
|Text search embedding|Used for search, context relevance, and information retrieval. This family of models measure whether long documents are relevant to a short search query. There are two input types supported by this family: **doc**, for embedding the documents to be retrieved, and **query**, for embedding the search query.|[See current list](https://learn.microsoft.com/azure/cognitive-services/openai/concepts/models#text-search-embedding)|
|Code search embedding|Used for code search and relevance. There are two input types supported by this family: **code**, for embedding code snippets to be retrieved, and **text**, for embedding natural language search queries.|[See current list](https://learn.microsoft.com/azure/cognitive-services/openai/concepts/models#code-search-embedding)|

## Choosing a model 
The models within the family differ by speed, cost, and how well they complete tasks.   

In the Azure OpenAI Studio, you can navigate to the models by creating a new deployment. You will be able to choose from a list of base models.  

![Screenshot of the Azure OpenAI Studio portal's out-of-the-box generative AI models.](../media/studio-models.png)

>[!NOTE]
>Pricing is determiend by tokens and by model type. Learn more from the latest [pricing documentation](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). 
   
