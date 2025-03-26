Generative AI applications are built on *language models*. The development process usually starts with an exploration and comparison of available *foundation* models to find the one that best suits the particular needs of your application. After selecting a suitable model, you deploy it to an endpoint where it can be consumed by a client application or AI agent.

In some cases, you might seek to optimize model responses for your application by applying *prompt engineering* techniques, implementing a *retrieve, augment, and generate (RAG)* solution that uses your own data to contextualize prompts, or by *fine-tuning* your chosen model with example prompts and responses that represent the conversational behavior you need. But it all begins with choosing the right model to start with.

## Foundation models

Foundation models, such as the GPT family of models, are state-of-the-art language models designed to understand, generate, and interact with natural language. Some common use cases for models are:

- **Speech-to-text and text-to-speech conversion**. For example, generate subtitles for videos.
- **Machine translation**. For example, translate text from English to Japanese.
- **Text classification**. For example, label an email as spam or not spam.
- **Entity extraction**. For example, extract keywords or names from a document.
- **Text summarization**. For example, generate a short one-paragraph summary from a multi-page document.
- **Question answering**. For example, provide answers to questions like "What is the capital of France?"
- **Reasoning**. For example, solve a mathematical problem.

In this module, you focus on exploring foundation models used for question answering. The foundation models you explore can be used for chat applications in which you use a language model to generate a response to a user's question.

> [!NOTE]
> The latest breakthrough in generative AI models is owed to the development of the **Transformer** architecture. Transformers were introduced in the [*Attention is all you need* paper by Vaswani, et al. from 2017](https://arxiv.org/abs/1706.03762?azure-portal=true). The Transformer architecture provided two innovations to NLP that resulted in the emergence of foundation models:
>
> - Instead of processing words sequentially, Transformers process each word independently and in parallel by using **attention**.
> - Next to the semantic similarity between words, Transformers use **positional encoding** to include the information about the position of a word in a sentence.

