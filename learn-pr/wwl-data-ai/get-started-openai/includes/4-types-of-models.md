To begin building with Azure OpenAI, you need to choose a base model and deploy it. Microsoft provides base models and the option to create customized base models. This module will cover the currently available out-of-the-box base models.   

## Model families 

Azure OpenAI's generative AI models are grouped by family and capability. The family groupings are by workload. The base models within the families are distinguished how well they can complete the workload.

|Family|Description|Base models within the Family|
|:--------|:-------------------------------------|:---------------|
|**GPT-4**|Models that generate natural language *and* code. These models are currently in preview. For access, existing Azure OpenAI customers can apply by [filling out this form](https://aka.ms/oai/get-gpt4).|gpt-4, gpt-4-32k|
|**GPT-3**|Models that can understand and generate natural language.|text-davinci-003, text-curie-001, text-babbage-001, text-ada-001, gpt-35-turbo|
|**Codex**|Models that can understand and generate code, including translating natural language to code.|code-davinci-002, code-cushman-001|
|**Embeddings**| Embeddings are further broken down into three families of models for different functionalities: similarity, text search, and code search.| [See the list](/azure/cognitive-services/openai/concepts/models#embeddings-models?portal=true) | 

>[!NOTE]
>The underlying generative AI capabilities in OpenAI's ChatGPT are in the **gpt-35-turbo** model, which belongs to the GPT-3 family. This model is in preview. You can learn more in the [documentation](/azure/cognitive-services/openai/how-to/chatgpt?pivots=programming-language-chat-completions?portal=true). 

## Choosing a model 
The models within the family differ by speed, cost, and how well they complete tasks. In general, models with the name `davinci` are stronger than models with the name `curie`, `babbage`, and `ada`, but may be slower. You can learn more about the differences and latest models offered in the [documentation](/azure/cognitive-services/openai/concepts/models?portal=true).

>[!NOTE]
>Pricing is determiend by tokens and by model type. Learn more about the latest [pricing here](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). 

## Azure OpenAI Studio navigation

In the Azure OpenAI Studio, the **Models** page lists the available base models and provides an option to create customized models. The models that have a `succeeded` status mean they are successfully trained and can be selected for deployment.

![Screenshot of the Azure OpenAI Studio portal's out-of-the-box generative AI models.](../media/studio-models.png) 

   
