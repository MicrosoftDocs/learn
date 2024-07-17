Foundation models, such as GPT-4, are state-of-the-art natural language processing models designed to understand, generate, and interact with human language. To understand the significance of foundation models, it's essential to explore their origins, which stem from advancements in the field of natural language processing.

## Understand natural language processing

Natural language processing (NLP) is a type of artificial intelligence (AI) that focuses on understanding, interpreting, and generating human language. Some common NLP use cases are:

- **Speech-to-text and text-to-speech conversion**. For example, generate subtitles for videos.
- **Machine translation**. For example, translate text from English to Japanese.
- **Text classification**. For example, label an email as spam or not spam.
- **Entity extraction**. For example, extract keywords or names from a document.
- **Text summarization**. For example, generate a short one-paragraph summary from a multi-page document.
- **Question answering**. For example, provide answers to questions like "What is the capital of France?"

> [!Note]
> In this module, you focus on exploring foundation models used for question answering. The foundation models you explore can be used for chat applications in which you use a language model to generate a response to a user's question.

### Understand the importance of the Transformer architecture

The latest breakthrough in **Natural Language Processing** (**NLP**) is owed to the development of the **Transformer** architecture.

Transformers were introduced in the [*Attention is all you need* paper by Vaswani, et al. from 2017](https://arxiv.org/abs/1706.03762?azure-portal=true). The Transformer architecture provided two innovations to NLP that resulted in the emergence of foundation models:

- Instead of processing words sequentially, Tranformers process each word independently and in parallel by using **attention**.
- Next to the semantic similarity between words, Transformers use **positional encoding** to include the information about the position of a word in a sentence.

Foundation models designed for NLP use cases are often referred to as Large Language Models (LLMs) or language models. In this module, you explore the available language models, how to select a model for your use case, and how to use a language model with the Azure AI Studio. You focus on language models that help you to develop custom copilots that serve as chat applications that do question answering, answering questions to your users.
