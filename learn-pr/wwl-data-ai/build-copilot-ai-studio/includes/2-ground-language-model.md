Language models excel in generating engaging text, and are ideal as the base for copilots. Copilots provide users with an intuitive chat-based application to receive assistance in their work. When designing a copilot for a specific use case, you want to ensure your language model is grounded and uses factual information that is relevant to what the user needs.

Though language models are trained on a vast amount of data, they may not have access to the knowledge you want to make available to your users. To ensure that a copilot is grounded on specific data to provide accurate and domain-specific responses, you can use **Retrieval Augmented Generation** (**RAG**).

## **Understanding RAG**

RAG is a technique that you can use to ground a language model. When you build a chat application with the Azure AI Studio, you can use **prompt flow** to create a chat that uses only a language model, or one that uses a language model with RAG.

To understand the added value of RAG, let’s compare the two types of chat flows you can create with the Azure AI Studio’s prompt flow.

:::image type="content" source="../media/standard-grounded-chat.jpg" alt-text="Diagram of two types of chat flows; standard and grounded.":::

When you create a standard chat flow, the flow contains the following elements:

- **Input**: The user’s question.
- **LLM node:** The prompt sent to the language model.
- **Output**: The application’s answer.

> [!Note]
> An LLM node is a tool used in prompt flow to call a Large Language Model (LLM).

When you want to add RAG to your application, you can create a flow that grounds the model by adding your data. A flow with RAG contains the following elements:

- **Input**: The user’s question.
- **Context**: Query a database to retrieve context.
- **Prompt node**: The prompt to send to the language model, including the retrieved context.
- **LLM node:** Send the constructed prompt to the language model.
- **Output**: The application’s answer.

In both flows, you need to construct the prompt that is sent to the language model. When creating a simple standard chat, you can configure the prompt in the LLM node. When adding RAG to your flow however, you need to retrieve the necessary context first, and add it to your prompt, before sending it to the language model.

## Retrieve the context

The key added value of RAG is the retrieval of relevant context before using a language model to generate a response. The question then remains how the context is retrieved.

The information you want a copilot to use for grounding answers should be stored in a database. The flow then needs to query the database to retrieve the relevant information. There are several ways that information can be queried or **searched** from a database:

- **Keyword search**: Identifies relevant documents or passages based on specific keywords or terms provided as input.
- **Semantic search**: Retrieves documents or passages by understanding the meaning of the query and matching it with semantically related content rather than relying solely on exact keyword matches.
- **Vector search**: Uses mathematical representations of text (vectors) to find similar documents or passages based on their semantic meaning or context.
- **Hybrid search**: Combines any or all of the other search techniques. Queries are executed in parallel and are returned in a unified result set.

Now that you understand the added value of RAG in a language model application, let’s explore how you can use Azure AI Search to retrieve the relevant context by searching your data.