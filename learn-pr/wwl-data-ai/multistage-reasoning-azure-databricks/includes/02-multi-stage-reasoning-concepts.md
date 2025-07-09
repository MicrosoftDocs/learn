Multi-stage reasoning systems are designed to solve complex problems by breaking them down into a series of manageable steps or stages. When you use such a system, your AI application generates more accurate responses by handling each part of a complex task systematically rather than trying to solve everything at once.

## Understand the need for multi-stage reasoning

Let's explore an example to illustrate the need for multi-stage reasoning systems. Imagine you have the following setup:

:::image type="content" source="../media/overloaded-llm.png" alt-text="Diagram showing a single complex prompt being sent to a language model, illustrating how the LLM can become overwhelmed when trying to handle multiple tasks simultaneously.":::

1. Your objective is: `Analyze the sentiment for a Japanese customer review.`
1. You send the prompt to an LLM.
1. The response is the overall sentiment.

When you send this complex prompt to a Large Language Model (LLM), the output can be inaccurate because the objective contains multiple intents: translation, analysis, and sentiment classification. When you have an objective with multiple intents, the LLM can get overwhelmed by the complexity and produce unreliable results.

Instead, you can break down the problem and send a prompt to an LLM for each specific intent:

:::image type="content" source="../media/multiple-intents.png" alt-text="Diagram showing the same objective broken down into three sequential steps: translation, summarization, and sentiment analysis, with each step feeding into the next.":::

1. Your initial objective is: `Analyze the sentiment for a Japanese customer review.`
2. Ask an LLM to translate the Japanese customer review to English.
3. The output is the full review translated to English.
4. You then ask an LLM to summarize the translated text.
5. The output is a summary of the English review.
6. You ask an LLM to analyze the sentiment of the summary.
7. The output is the overall sentiment of the Japanese customer review.

The core idea of multi-stage reasoning systems is that by dividing a problem into distinct stages with each stage focusing on a specific aspect of the problem, you enhance the overall reasoning capability and reliability of the system.

## Design a multi-stage reasoning system

When you think your solution will benefit from implementing a multi-stage reasoning system, you need to map your requirements to the necessary tools and components.

To design a multi-stage reasoning system, you break down your problem into multiple steps, or tasks. As shown in the sentiment analysis example, you can reuse the output of a previous task as input for a new task, by **chaining** LLM interactions.

When you want to build a multi-stage reasoning system, you need to:

1. **Identify intents**: Define the possible intents based on sample user queries and identify the dependencies between intents. Determine whether you have sequential or parallel tasks.
2. **Identify tools**: Determine which tools you need to accomplish each task.
3. **Build the workflow**: Create a workflow based on the identified tasks and design the overall architecture.

The tools you need depend on the tasks you need to perform. For example, you can retrieve customer data from a SQL database to provide necessary context, search a vector store to retrieve context based on semantic similarity, or use a fine-tuned LLM to generate output in a specific tone or format.

By breaking up your problem and designing a multi-stage reasoning system, you create AI solutions that handle more manageable tasks. As you design individual tasks and chain them together, you create a more flexible design. Each task, or stage, can be optimized individually, and you can reuse tasks across systems to speed up development of new solutions.

## Choose a library

After your initial design is complete, you can choose one of the popular Python libraries to build your multi-stage reasoning system. Understanding multiple frameworks is valuable because:

- **Different approaches**: Each framework takes a unique approach to solving multi-stage reasoning challenges
- **Project requirements**: Your specific use case may favor one framework's strengths over others
- **Team expertise**: Your organization may already have experience with a particular framework
- **Integration needs**: Some frameworks integrate better with existing systems or data sources

Azure Databricks provides access to several frameworks designed for multi-stage reasoning:

- **[LangChain](https://python.langchain.com/v0.2/docs/introduction/)**: An open-source framework that provides tools for building applications with LLMs, focusing on chains, prompts, retrievers, and tools. Best for general-purpose LLM applications and complex workflows.
- **[LlamaIndex](https://docs.llamaindex.ai/en/stable/)**: A framework designed for integrating LLMs with your data sources, whether through APIs or databases like SQL. Excels at data-centric applications and retrieval-augmented generation (RAG).
- **[Haystack](https://docs.haystack.deepset.ai/docs/intro)**: An open-source framework for building multi-stage systems that include document retrieval, text generation, and summarization. Strong for search and question-answering systems.
- **[DSPy](https://dspy.ai/)**: A declarative framework that focuses on programming rather than prompting, allowing you to optimize prompts and weights automatically. Ideal for optimizing and fine-tuning multi-stage systems.

In the following units, you'll explore each library's key components and understand how they approach multi-stage reasoning. This knowledge will help you make informed decisions about which framework best fits your specific project requirements.
