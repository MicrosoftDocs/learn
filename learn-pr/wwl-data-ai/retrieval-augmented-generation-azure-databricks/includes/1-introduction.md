Retrieval Augmented Generation (RAG) is a technique in natural language processing that makes LLMs more effective by giving them access to external information. Instead of relying only on their training data like traditional models do, RAG allows LLMs to search through databases, documents, or websites to find relevant facts before creating a response. This combination of searching for information and then generating text helps produce more accurate and up-to-date answers.

Language models have become incredibly popular because they can generate impressive, well-structured answers to user questions. When people interact with these models through chat interfaces, it feels like a natural and intuitive way to get information.

However, there's a challenge: ensuring the AI's responses are accurate and factual. This challenge is called **groundedness** - which simply means whether the AI's answer is based on real, reliable information rather than made-up or incorrect details. Without proper groundedness, language models might confidently state things that aren't true. Another challenge is that traditional models use only information they were trained on that can be outdated or incomplete.

When you want a language model to have access to specific knowledge, you have three main options:

:::image type="content" source="../media/learn-knowledge.png" alt-text="Diagram of three approaches for language models to learn knowledge.":::

- **Model pretraining**: Build a language model from the ground up, which requires massive datasets with billions or trillions of text pieces or tokens. This is extremely expensive and time-consuming.

- **Model fine-tuning**: Take an existing language model and train it further on your specific data or industry, which requires thousands of specialized examples. This is moderately expensive and complex.

- **Passing contextual information**: Connect a language model to external databases or documents so it can look up information in real-time. This is a strategy known as Retrieval Augmented Generation (RAG). This requires setting up a knowledge base but is much simpler than the other options.

RAG is most practical when you need an AI system with access to current, verifiable information. It's easier to implement and uses less computing power than retraining entire models.

In this module, you'll learn when and how to use RAG to make language models more reliable and accurate. You'll also discover how vector search technology helps AI quickly find the most relevant information to include in its responses.