
They don't need to create language models from scratch - most people use an off-the-shelf foundation model (which you can use as-is or fine-tune with your own additional natural language training data)

## Large and small language models
There are many language models available that you can use to power generative AI applications. In general, language models can be considered in two categorize: *Large Language Models* (LLMs) and *Small Language models* (SLMs).

|Large Language Models (LLMs)|Small Language Models (SLMs)|
|-|-|
|LLMs are trained with vast quantities of text that represents a wide range of general subject matter – typically by sourcing data from the Internet and other generally available publications.| SLMs are trained with smaller, more subject-focused datasets|
|When trained, LLMs have many billions (even trillions) of parameters (weights that can be applied to vector embeddings to calculate predicted token sequences).|Typically have fewer parameters than LLMs.|
|Able to exhibit comprehensive language generation capabilities in a wide range of conversational contexts.|This focused vocabulary makes them very effective in specific conversational topics, but less effective at more general language generation.|
|Their large size can impact their performance and make them difficult to deploy locally on devices and computers.|The smaller size of SLMs can provide more options for deployment, including local deployment to devices and on-premises computers; and makes them faster and easier to fine-tune.|
|Fine-tuning the model with additional data to customize its subject expertise can be time-consuming, and expensive in terms of the compute power required to perform the additional training.|Fine-tuning can potentially be less time-consuming and expensive.|

## In Azure

In Azure, you can find foundation models in the Azure OpenAI service and in the Model Catalog (in AI Studio and Azure ML Studio)
