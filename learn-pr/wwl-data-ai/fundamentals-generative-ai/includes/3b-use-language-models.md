Different models exist today which mostly differ by the specific data they've been trained on, or by how they implement attention within their architectures. 

Today, importantly, developers do not need to train models from scratch. To build a generative AI application, you can use pre-trained models. Some language models are open-source and publicly available through communities like Hugging Face. Others are offered in proprietary catalogs. For example, Azure offers the most commonly used language models as *foundation models* in the Azure AI Foundry *model catalog*. Foundation models are pretrained on large texts and can be fine-tuned for specific tasks with a relatively small dataset.

You can deploy a foundation model to an endpoint without any extra training. If you want the model to be specialized in a task, or perform better on domain-specific knowledge, you can also choose to fine-tune a foundation model.

Foundation models can be used for various tasks, including:

- Text classification
- Token classification
- Question answering
- Summarization
- Translation

To choose the foundation model that best fits your needs, you can test out different models. You can also review the data the models are trained on and possible biases and risks a model may have.

## Large and small language models
In general, language models can be considered in two categories: *Large Language Models* (LLMs) and *Small Language models* (SLMs).

|Large Language Models (LLMs)|Small Language Models (SLMs)|
|-|-|
|LLMs are trained with vast quantities of text that represents a wide range of general subject matter – typically by sourcing data from the Internet and other generally available publications.| SLMs are trained with smaller, more subject-focused datasets|
|When trained, LLMs have many billions (even trillions) of parameters (weights that can be applied to vector embeddings to calculate predicted token sequences).|Typically have fewer parameters than LLMs.|
|Able to exhibit comprehensive language generation capabilities in a wide range of conversational contexts.|This focused vocabulary makes them very effective in specific conversational topics, but less effective at more general language generation.|
|Their large size can impact their performance and make them difficult to deploy locally on devices and computers.|The smaller size of SLMs can provide more options for deployment, including local deployment to devices and on-premises computers; and makes them faster and easier to fine-tune.|
|Fine-tuning the model with additional data to customize its subject expertise can be time-consuming, and expensive in terms of the compute power required to perform the additional training.|Fine-tuning can potentially be less time-consuming and expensive.|
