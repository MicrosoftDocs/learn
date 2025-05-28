Today, importantly, developers don't need to train models from scratch. To build a generative AI application, you can use pretrained models. Some language models are open-source and publicly available. Others are offered in proprietary catalogs. Different models exist today which mostly differ by the specific data used to train them, or by how they implement attention within their architectures. 

## Large and small language models
In general, language models can be considered in two categories: *Large Language Models* (LLMs) and *Small Language models* (SLMs).

|Large Language Models (LLMs)|Small Language Models (SLMs)|
|-|-|
|LLMs are trained with vast quantities of text that represents a wide range of general subject matter – typically by sourcing data from the Internet and other generally available publications.| SLMs are trained with smaller, more subject-focused datasets|
|When trained, LLMs have many billions (even trillions) of parameters (weights that can be applied to vector embeddings to calculate predicted token sequences).|Typically have fewer parameters than LLMs.|
|Able to exhibit comprehensive language generation capabilities in a wide range of conversational contexts.|This focused vocabulary makes them effective in specific conversational topics, but less effective at more general language generation.|
|Their large size can impact their performance and make them difficult to deploy locally on devices and computers.|The smaller size of SLMs can provide more options for deployment, including local deployment to devices and on-premises computers; and makes them faster and easier to fine-tune.|
|Fine-tuning the model with more data to customize its subject expertise can be time-consuming, and expensive in terms of the compute power required to perform the extra training.|Fine-tuning can potentially be less time-consuming and expensive.|
