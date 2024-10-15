**LlamaIndex** is a framework designed for building multi-reasoning systems that integrate with *your data*.

Whether your data is accessible through APIs, or stored in SQL databases, you can use LlamaIndex to integrate your data with your AI system.

LlamaIndex simplifies the process of content augmentation by providing you with tools to index, query, and interact with your data.

## Explore the main components of LlamaIndex

When you build a multi-reasoning system with LlamaIndex, you need to be familiar with the main components:

:::image type="content" source="../media/llama-index-overview.png" alt-text="Diagram of the main components for LlamaIndex." lightbox="../media/llama-index-overview.png":::

1. **Models**: A large Language Model (LLM) to generate responses or embedding model to represent your documents with vectors.
1. **Prompt**: A structured text input to a language model.
1. **Query engine**: An interface that allows you to ask questions over your data.
1. **Agent**: A LLM-powered knowledge worker that can perform tasks.

Let's explore each of these components in more detail.

### Use LLMs and embedding models

When you build a multi-reasoning system with LlamaIndex, you use **LLMs** to generate responses. You can use the built-in interface to use models from Azure OpenAI, Hugging Face, or LangChain for natural language tasks like text completion and chat.

> [!Tip]
> Learn how to integrate LlamaIndex with [Azure OpenAI models](https://docs.llamaindex.ai/en/stable/examples/llm/azure_openai/?azure-portal=true).

You can also customize an LLM by selecting a specific model you want to use, or by specifying model parameters like the number of output tokens.

Next to LLMs you use to generate responses, LlamaIndex also allows you to use **embedding models**. These models convert your queries and documents into vectors, making it possible to find semantically similar contexts.

> [!Tip]
> Learn more about [using LLMs](https://docs.llamaindex.ai/en/stable/module_guides/models/llms/?azure-portal=true) and [using embeddings](https://docs.llamaindex.ai/en/stable/module_guides/models/embeddings/?azure-portal=true) in LlamaIndex.

### Interact with your models through prompts

In LlamaIndex, prompts play a critical role in guiding the behavior of language models. A prompt is essentially a structured input that frames the context and desired outcome of a model's response.

LlamaIndex provides tools for designing and managing prompts, ensuring that they effectively capture the nuances of the task at hand.

Whether it's for generating coherent text, answering complex questions, or retrieving context, prompts are central to achieving precise and relevant results.

> [!Tip]
> Explore how to [use prompt with LlamaIndex](https://docs.llamaindex.ai/en/stable/module_guides/models/prompts/?azure-portal=true).

LlamaIndex also offers advanced prompt techniques, including partial formatting to work with variables, templates to reuse prompts, and function mappings to dynamically inject variable values.

> [!Tip]
> Learn more about [how to use advanced prompt techniques with LlamaIndex](https://docs.llamaindex.ai/en/stable/examples/prompts/advanced_prompts/?azure-portal=true).

### Ask questions over your data with query engines

One of the core features of LlamaIndex is its indexing and storing capabilities. You can index your data, store the indexed data, and query the stored indexes to retrieve relevant context for Retrieval Augmented Generation (RAG).

> [!Tip]
> Learn more about [query engines](https://docs.llamaindex.ai/en/stable/module_guides/deploying/query_engine/?azure-portal=true). If you want to have stateful conversations with your data, you can also use [chat engines](https://docs.llamaindex.ai/en/stable/module_guides/deploying/chat_engines/?azure-portal=true).

### Perform intelligent tasks with agents

Agents in LlamaIndex are autonomous entities that interact with language models and data to perform specific tasks.

These agents are programmable and can be customized to handle various scenarios, from automating routine processes to managing complex interactions.

Agents are more advanced than query engines because they can read from and write to your data source. They include a reasoning loop that continuously assesses and reassesses the data, allowing them to adapt their actions dynamically to achieve specific goals or optimize outcomes.

LlamaIndex provides a flexible framework for creating and deploying agents, allowing them to operate within defined parameters or adapt to dynamic environments. Agents can work alone, or together with other agents, making them flexible tools for boosting productivity and achieving complex goals in your multi-stage reasoning systems.

> [!Tip]
> Learn more about [how to work with agents](https://docs.llamaindex.ai/en/stable/module_guides/deploying/agents/?azure-portal=true).
