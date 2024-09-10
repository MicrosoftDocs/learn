Organizations and developers can train their own language models from scratch, but in most cases it’s more practical to use an existing foundation model, and optionally fine-tune it with your own training data. There are many sources of model that you can use.

On Microsoft Azure, you can find foundation models in the Azure OpenAI service and in the Model Catalog. The Model Catalog is a curated source of models for data scientists and developers using Azure AI Studio and Azure Machine Learning. This offers the benefit of cutting-edge language models like the generative pre-trained transformer (GPT) collection of models (on which ChatGPT and Microsoft's own generative AI services are based)  as well as the DALL-E model for image generation. Using these models from the Azure OpenAI service means that you also get the benefit of a secure, scalable Azure cloud platform in which the models are hosted.

In addition to the Azure OpenAI models, the model catalog includes the latest open-source models from Microsoft and multiple partners, including:
- OpenAI
- HuggingFace
- Mistral
- Meta and others.

## Large and small language models
There are many language models available that you can use to power generative AI applications. In general, language models can be considered in two categorize: *Large Language Models* (LLMs) and *Small Language models* (SLMs).

|Large Language Models (LLMs)|Small Language Models (SLMs)|
|-|-|
|LLMs are trained with vast quantities of text that represents a wide range of general subject matter – typically by sourcing data from the Internet and other generally available publications.| SLMs are trained with smaller, more subject-focused datasets|
|When trained, LLMs have many billions (even trillions) of parameters (weights that can be applied to vector embeddings to calculate predicted token sequences).|Typically have fewer parameters than LLMs.|
|Able to exhibit comprehensive language generation capabilities in a wide range of conversational contexts.|This focused vocabulary makes them very effective in specific conversational topics, but less effective at more general language generation.|
|Their large size can impact their performance and make them difficult to deploy locally on devices and computers.|The smaller size of SLMs can provide more options for deployment, including local deployment to devices and on-premises computers; and makes them faster and easier to fine-tune.|
|Fine-tuning the model with additional data to customize its subject expertise can be time-consuming, and expensive in terms of the compute power required to perform the additional training.|Fine-tuning can potentially be less time-consuming and expensive.|
