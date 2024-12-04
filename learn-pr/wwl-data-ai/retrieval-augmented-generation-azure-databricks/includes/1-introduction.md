Language models are growing in popularity as they create impressive coherent answers to a user’s questions. Especially when a user interacts with a language model through chat, it provides an intuitive way to get the information they need.

One prevalent challenge when implementing language models through chat is the so-called **groundedness**, which refers to whether a response is rooted, connected, or anchored in reality or a specific context. In other words, groundedness refers to whether the response of a language model is based on *factual information* to avoid *hallucinations* or incorrect information.

When you want a language model to learn specific knowledge, there are three main approaches:

:::image type="content" source="../media/learn-knowledge.png" alt-text="Diagram of three approaches for language models to learn knowledge.":::

1. **Model pretraining**: Train a language model from scratch, which requires large datasets consisting of billions to trillions of tokens.
2. **Model fine-tuning**: Adapt a pretrained language model to specific datasets or domains, which requires thousands of domain-specific or instruction examples.
3. **Passing contextual information**: Combine a language model with external knowledge retrieval, which requires an external knowledge base.

Passing contextual information can be achieved through a strategy known as **Retrieval Augmented Generation** (**RAG**). RAG is the least complex strategy, requires less compute, and ensures a language model is grounded on specific data to provide factually accurate responses.

In this module, you learn where and how RAG can be used to improve the quality, reliability, and accuracy of language models. You explore how vectors are used to search and provide relevant context to language models.
