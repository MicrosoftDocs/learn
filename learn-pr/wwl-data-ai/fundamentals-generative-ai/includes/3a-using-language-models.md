Generative AI applications are powered by *language models*, which are a specialized type of machine learning model that you can use to perform *natural language processing* (NLP) tasks, including:

- Determining *sentiment* or otherwise classifying natural language text.
- Summarizing text.
- Comparing multiple text sources for semantic similarity.
- Generating new natural language.

There are many language models available that you can use to power generative AI applications. In general, language models can be considered in two categorize: *Large Language Models* (LLMs) and *Small Language models* (SLMs).

LLMs are trained with vast quantities of text that represents a wide range of general subject matter – typically by sourcing data from the Internet and other generally available publications. When trained, LLMs have many billions (even trillions) of parameters (weights that can be applied to vector embeddings to calculate predicted token sequences), enabling them to exhibit comprehensive language generation capabilities in a wide range of conversational contexts. However, their large size can impact their performance and make them difficult to deploy locally on devices and computers. Additionally, if you want to fine-tune the model with additional data to customize its conversational subject expertise, the process can be time-consuming, and expensive in terms of the compute power required to perform the additional training.

Conversely, SLMs are trained with smaller, more subject-focused datasets and typically have fewer parameters than LLMs. This focused vocabulary makes them very effective in specific conversational topics, but less effective at more general language generation. The smaller size of SLMs can provide more options for deployment, including local deployment to devices and on-premises computers; and makes them faster and easier to fine-tune.
