To begin building with Azure OpenAI, you need to choose a base model and deploy it. Microsoft provides base models and the option to create customized base models. This module will cover the currently available out-of-the-box base models. Microsoft's partnership with OpenAI means models that become availible with OpenAI can become available with Azure OpenAI.   

## Model families 

Azure OpenAI's models are grouped by family and capability. 

|Family|Description|Models within family|
|GPT-4|A set of models that improve on GPT-3.5 and can understand as well as generate natural language and code. These models are currently in preview. For access, existing Azure OpenAI customers can apply by [filling out this form](https://aka.ms/oai/get-gpt4).|--|
|GPT-3|A series of models that can understand and generate natural language. This includes the new ChatGPT model (preview).|--|
|Codex|A series of models that can understand and generate code, including translating natural language to code.|--|
|Embeddings|A set of models that can understand and use embeddings. An embedding is a special format of data representation that can be easily utilized by machine learning models and algorithms. The embedding is an information dense representation of the semantic meaning of a piece of text. Currently, we offer three families of Embeddings models for different functionalities: similarity, text search, and code search.|--|


## Choosing a model 
The models within the family differ in speed, cost, and capability. You can think of   

In the Azure OpenAI Studio, you can navigate to the models by creating a new deployment. 

![Screenshot of the Azure OpenAI Studio portal's out-of-the-box generative AI models.](../media/studio-models.png)

>[!NOTE]
>Pricing is determiend by tokens and by model type. Learn more from the latest [pricing documentation](https://azure.microsoft.com/pricing/details/cognitive-services/openai-service/). 