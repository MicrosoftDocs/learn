Prompt engineering helps guide how a model responds, but it can't give the model knowledge it doesn't already have. Language models are trained on large datasets, but that training data has a cutoff date and doesn't include your organization's private information. When a model lacks relevant context, it might generate responses that sound plausible but are factually incorrect.

To address this challenge, you can **ground** the model by providing it with relevant, factual data to base its responses on. **Retrieval Augmented Generation (RAG)** is the most common technique for grounding a language model.

## Understand grounding

When you use a language model without grounding, the only information it has comes from its training data. The result might be grammatically correct and logically structured, but it can be inaccurate or include fabricated details. For example, asking "Which hotels do you offer in Paris?" without grounding data might return fictional hotel names.

:::image type="content" source="../media/ungrounded.png" alt-text="Diagram showing an ungrounded model returning an uncontextualized response based only on training data.":::

When you **ground** a prompt, you provide relevant data from a trusted source along with the user's question. The model then generates a response based on that data, producing more accurate and contextually relevant answers.

Consider the difference:

- **Ungrounded**: The model relies only on its training data and might invent hotel names or details.
- **Grounded**: The model receives your actual hotel catalog data as context and responds with real hotel names, prices, and availability.

:::image type="content" source="../media/grounded.png" alt-text="Diagram comparing an ungrounded model returning generic responses versus a grounded model returning data-backed responses.":::

Grounding improves the factual accuracy of responses by connecting the model to information that is specific, current, and relevant to the user's needs.

## How RAG works

RAG is a pattern that retrieves relevant information from a data source and includes it in the prompt before the model generates a response. The process follows three steps:

:::image type="content" source="../media/rag-pattern.png" alt-text="Diagram showing the three-step RAG pattern: retrieve grounding data, augment the prompt with that data, and generate a grounded response.":::

1. **Retrieve**: Search a data source for information that is relevant to the user's question.
1. **Augment**: Add the retrieved information to the prompt as context.
1. **Generate**: Send the augmented prompt to the language model to generate a grounded response.

By retrieving context from a specified data source, you ensure that the model uses relevant, up-to-date information instead of relying solely on its training data.

## Create embeddings for search

A critical component of RAG is the ability to efficiently find the most relevant information in your data source. This is where **embeddings** and **vector search** come in.

An **embedding** is a mathematical representation of text as a vector — a list of floating-point numbers that captures the meaning of words, sentences, or documents. You create embeddings by sending your content to an embedding model, such as an Azure OpenAI embedding model available in Microsoft Foundry.

For example, imagine two documents:

- *"The children played joyfully in the park."*
- *"Kids happily ran around the playground."*

These sentences use different words but have similar meanings. When you create embeddings for each, their vectors are close together in multidimensional space, reflecting their semantic similarity.

:::image type="content" source="../media/vector-embeddings.jpg" alt-text="Diagram showing text keywords plotted as vectors in multidimensional space, with the distance between vectors representing semantic similarity.":::

**Cosine similarity** measures how close two vectors are by calculating the angle between them. A value near 1 means the vectors are very similar. This mathematical approach enables you to find relevant documents even when the exact words don't match.

## Use Azure AI Search for retrieval

**Azure AI Search** provides the retrieval component for RAG solutions in Microsoft Foundry. It allows you to bring your own data, create a searchable index, and query it to retrieve relevant information.

:::image type="content" source="../media/index.png" alt-text="Diagram showing an Azure AI Search index being queried to retrieve grounding data for a user question.":::

To use Azure AI Search with RAG, you:

1. **Add your data** to Microsoft Foundry from sources like Azure Blob Storage, Azure Data Lake Storage Gen2, or Microsoft OneLake. You can also upload files directly.
1. **Create an index** using an embedding model to generate vector representations of your content. The index is stored in Azure AI Search.
1. **Query the index** when a user asks a question. The system converts the question to an embedding, searches for the most similar content, and returns the relevant results.

Azure AI Search supports several search techniques:

- **Keyword search**: Matches exact terms in the query to text in the index.
- **Semantic search**: Uses semantic models to match the meaning of the query rather than exact keywords.
- **Vector search**: Uses embeddings to find semantically similar content.
- **Hybrid search**: Combines keyword, semantic, and vector search for the most accurate results. Hybrid search is recommended for generative AI applications.

## Implement RAG with the Azure AI Foundry SDK

After you create an Azure AI Search index, you can connect it to a model through your Microsoft Foundry project. The `azure-ai-projects` SDK lets you get an authenticated OpenAI client and use the Responses API to generate grounded answers.

The following Python code shows a basic implementation:

```python
from azure.ai.projects import AIProjectClient
from azure.identity import DefaultAzureCredential

project = AIProjectClient(
    endpoint=os.environ["PROJECT_ENDPOINT"],
    credential=DefaultAzureCredential(),
)

client = project.get_openai_client()

response = client.responses.create(
    model="gpt-4o",
    input=[
        {"role": "system", "content": "You are a helpful travel advisor. "
         "Use the following hotel data to answer: " + retrieved_context},
        {"role": "user", "content": "Which hotels do you offer in Paris?"},
    ],
)

print(response.output_text)
```

In this example, `retrieved_context` represents the documents returned from your Azure AI Search index. By injecting those results into the system message, the model's response is grounded in your actual data rather than its general training knowledge.

## When to use RAG

RAG is most effective when:

- **The model needs domain-specific knowledge**: Your organization has private data that the model wasn't trained on, like a product catalog, policy documents, or internal knowledge base.
- **Information changes frequently**: Your data is updated regularly, such as inventory, pricing, or news. RAG retrieves current data at query time without retraining.
- **Factual accuracy is critical**: You need responses grounded in real data rather than the model's general knowledge.
- **The base model's training data has a cutoff**: Events or information that occurred after the model's training cutoff date need to be accessible.

For the travel agency scenario, RAG allows customers to ask questions about specific hotels, destinations, and booking policies, all grounded in the agency's actual catalog data.

> [!TIP]
> If you're building agents that need grounded knowledge without managing your own search infrastructure, consider **Foundry IQ** — a managed knowledge store that simplifies grounding for AI agents. To learn more, see [Build knowledge-enhanced AI agents with Foundry IQ](/training/modules/introduction-foundry-iq/?azure-portal=true).
