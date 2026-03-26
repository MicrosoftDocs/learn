The *file_search* tool lets your model retrieve relevant information from your own uploaded documents during a response.

## What is the file_search tool?

The file_search tool helps a model answer questions using private or domain-specific files, such as policy documents, manuals, contracts, and internal knowledge bases. Instead of relying only on general training data, the model can search indexed file content and return grounded answers.

This is especially useful when you need accurate responses from trusted internal documents.

Key features include:

- **Document-grounded answers** - Responses are based on your uploaded files
- **Semantic retrieval** - Finds relevant passages by meaning, not only exact keyword matches
- **Vector store integration** - Search across one or more indexed document collections
- **Citations and transparency** - Include matched results for debugging and traceability
- **Better enterprise relevance** - Use organization-specific knowledge in model outputs

## Common use cases

| Use Case | Example |
|----------|---------|
| **Policy Q&A** | Answer employee questions from HR policy PDFs |
| **Support Assistants** | Retrieve product steps from internal troubleshooting guides |
| **Legal Review** | Locate specific clauses across contract documents |
| **Knowledge Discovery** | Summarize answers from technical documentation sets |

## A simple example

Here's an example using the OpenAI Responses API with file_search enabled:

```python
from openai import OpenAI

client = OpenAI(
    base_url={openai_endpoint},
    api_key={auth_key_or_token}
)

# Create vector store and upload a file
vector_store = client.vector_stores.create(name="policy-docs")
client.vector_stores.files.upload_and_poll(
    vector_store_id=vector_store.id,
    file=open("expenses_policy.pdf", "rb")
)

# Get response using the file_search tool
response = client.responses.create(
    model=model_deployment,
    instructions="You are an AI assistant that provides information from HR policy documents.",
    input="What's the maximum amount I can claim for a taxi ride?",
    tools=[{
        "type": "file_search",
        "vector_store_ids": [vector_store.id]
    }],
    include=["file_search_call.results"]
)
print(response.output_text)
```

In this flow, the model searches the indexed policy file and uses the retrieved passages to produce a grounded answer.

## How the file_search tool works

The general process for using the file_search tool is:

1. **You prepare files** - Upload documents to a vector store.
2. **You send a request** - Include file_search in the tools array with vector store IDs.
3. **Model performs retrieval** - It searches indexed chunks for relevant content.
4. **Results are injected** - Matching passages are provided to the model.
5. **Response is generated** - The model answers using retrieved document context.

## Best practices

- **Use high-quality source files** - Clean, current documents improve retrieval accuracy
- **Write focused prompts** - Ask specific questions to reduce ambiguous matches
- **Scope vector stores carefully** - Separate domains (HR, legal, finance) when helpful
- **Include retrieval results in development** - Use response includes for troubleshooting
- **Review answers for critical workflows** - Keep human validation in high-stakes scenarios

## Limitations to know about

- Answer quality depends on document quality, coverage, and chunk relevance
- Very large or mixed-domain stores can return less focused context
- Updated source files may require re-indexing before new content is searchable
- Retrieval improves grounding but doesn't replace human review for sensitive decisions

Used well, file_search turns a general-purpose model into a domain-aware assistant that can answer from the documents your team actually uses.

> [!TIP]
> The file_search tool is a great way to ground a model in a specific set of documents or data files. However, for enterprise-scale agents that need to access large quantities of data in multiple data stores, you should consider using the *Foundry IQ* knowledge store solution with a Microsoft Foundry agent. To learn more, see [Build knowledge-enhanced AI agents with Foundry IQ](/training/modules/introduction-foundry-iq?azure-portal=true)
