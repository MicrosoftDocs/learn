**Multi-stage reasoning systems** are designed to solve complex problems by breaking them down into a series of manageable steps or stages. When you use such a system, your AI application generates more accurate responses.

## Understand the need for multi-stage reasoning

Let's explore an example to illustrate the need for multi-stage reasoning systems. Imagine you have the following setup:

:::image type="content" source="../media/overloaded-llm.png" alt-text="Diagram of a single prompt being sent to a language model.":::

1. Your objective is: `Analyze the sentiment for a Japanese customer review.`
1. You send the prompt to an LLM.
1. The response is the overall sentiment.

You can send this prompt to a Large Language Model (LLM) to get a response. The LLM's output can be inaccurate as the objective has multiple **intents**. When you have an objective with multiple intents, the LLM can get overwhelmed by the complexity of the prompt and the input length. Instead, you can break down the problem and send a prompt to an LLM for each intent you have:

:::image type="content" source="../media/multiple-intents.png" alt-text="Diagram of multiple intents being sent to a language model.":::

1. Your initial objective is: `Analyze the sentiment for a Japanese customer review.`
1. You first ask an LLM to **translate** the Japanese customer review.
1. The output is the full review translated to English.
1. You then ask an LLM to **summarize** the translated text.
1. The output is a summary of the English review.
1. You finally ask an LLM to analyze the **sentiment** of the summary.
1. The output is the overall sentiment of the Japanese customer review.

Though you can directly call an LLM with this prompt, and get a response, the LLM can get overwhelmed by the complexity of the prompt and the input length.

The core idea of multi-stage reasoning systems is that by dividing a problem into distinct stages - each stage focusing on a specific aspect of the problem - you enhance the overall reasoning capability of the system.

## Design a multi-stage reasoning system

When you think your solution benefits from implementing a multi-stage reasoning system, you need to map your requirements to the necessary tools components.

To design a multi-stage reasoning system, you break down your problem into multiple steps, or tasks. As shown in the sentiment analysis example, you can reuse the output of a previous task as input for a new task, by **chaining** together LLM interactions.

When you want to build a multi-stage reasoning system, you have to:

1. **Identify intents**: Define the possible intents based on sample user queries and define the dependencies between intents. Identify whether you have sequential or parallel tasks.
1. **Identify tools**: Identify which tools you need to accomplish the tasks.
1. **Build the chain**: Build a workflow based on the identified tasks and design the compound architecture.

The tools you need depend on the tasks you need to perform. For example, you can retrieve customer data from a SQL Database to have the necessary context, you can search a vector store if you want to retrieve context based on semantic similarity, or you can use a fine-tuned LLM if you need to enforce an LLM to generate output in a specific tone or format.

By breaking up your problem and designing a multi-stage reasoning system, you create AI solutions that include more tractable tasks. As you design individual tasks, and chain the tasks together, you create a more flexible design. Each task, or stage, can be optimized individually, and you can reuse tasks across systems to speed up the development of new systems.

## Choose a library

After your initial design is complete, you can choose one of the popular composition libraries like [LangChain](https://python.langchain.com/v0.2/docs/introduction/?azure-portal=true), [LlamaIndex](https://docs.llamaindex.ai/en/stable/?azure-portal=true), [Haystack](https://docs.haystack.deepset.ai/docs/intro?azure-portal=true), or [DSPy](https://dspy-docs.vercel.app/intro/?azure-portal=true), to build your system.

To choose a library, you can consider the following factors:

- **Library features**: Research if the library supports your use case requirements. Evaluate the ease of integrating with external data sources and knowledge bases.
- **Performance and scalability**: Evaluate the performance and scalability of each library, especially if your application handles large volumes of data or require high throughput.
- **Stability and complexity**: Research whether a library is stable enough for your use case. Evaluate whether your developers might find some libraries challenging to understand and use.

Keep these considerations in mind when you explore the composition libraries you can use.
