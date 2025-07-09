LangChain is an open-source Python library designed to simplify building applications with Large Language Models (LLMs). LangChain provides tools to chain together multiple LLM interactions in a structured workflow. Use this framework when you want to build complex workflows or need access to many pre-built tools and integrations.

LangChain abstracts the complexity of connecting different steps in your reasoning pipeline, allowing you to focus on designing the logic rather than managing the technical details of how components communicate.

## Explore the main components of LangChain

When you build a multi-stage reasoning system with LangChain, you work with four main components as shown in the diagram:

:::image type="content" source="../media/chain-components.png" alt-text="Diagram showing a LangChain workflow with four numbered components: 1) Chain (user input), 2) Prompt (structured text input), 3) Retriever (relevant context), and 4) Tool (functionality or resource)." lightbox="../media/chain-components.png":::

1. **Chain**: A sequence of connected operations that starts with user input and processes information step by step.
2. **Prompt**: A structured text input that guides the language model's response.
3. **Retriever**: A component that finds relevant information from sources outside the language model's training data.
4. **Tool**: External functionality that extends the system's capabilities.

Let's explore how each component enables multi-stage reasoning.

### Define your chain

A **chain** connects multiple operations in sequence, where the output of one step becomes the input for the next. This is the core of multi-stage reasoning - instead of asking an LLM to handle a complex task all at once, you break it into manageable steps.

For example, you might create a chain that first retrieves relevant documents, then uses those documents to generate an answer. Each step focuses on a specific task, making the overall process more reliable and easier to debug.

### Design your prompt

A **prompt** is the structured text input that guides how an LLM processes information at each stage. In multi-stage systems, you often use different prompts for different stages - one prompt might instruct the LLM to summarize documents, while another asks it to answer questions based on that summary.

Well-designed prompts ensure each stage of your reasoning process produces the right type of output for the next stage.

### Find context with a retriever

A **retriever** finds and returns relevant information from external sources like documents or databases. In multi-stage reasoning, retrievers typically gather context that subsequent language model operations will use to generate responses.

Retrievers often work with **vector indices** and **embeddings** to find semantically similar content. Embeddings convert text into numerical vectors that capture meaning, while vector indices enable fast similarity searches across large datasets.

For example, when answering a question about company policies, a retriever might first find the relevant policy documents using vector similarity, then pass them to a language model that generates the answer.

### Integrate external resources with a tool

A **tool** represents functionality outside of the language model that can be invoked within your multi-stage reasoning system. Tools might query databases, call web APIs, perform mathematical calculations, or access file systems. While not always necessary, tools can be valuable when your reasoning process needs to interact with systems beyond text generation or perform specific operations that require external data or services.

> [!Tip]
> Explore the [LangChain documentation](https://python.langchain.com/v0.2/docs/introduction/?azure-portal=true).

## Use LangChain in Azure Databricks

To use LangChain in Azure Databricks, you need to ensure the library is installed on your compute cluster. You can install LangChain in a notebook by running:

```python
%pip install langchain
```

Once installed, you can use LangChain to build multi-stage reasoning systems. Here's how you can structure a simple multi-stage workflow:

### Conceptual Example: Question Answering with Document Search

Instead of asking an LLM to "answer my question using only your training data," you can create a multi-stage system that finds relevant information first:

```text
Stage 1: Find Relevant Information
├── Input: User question
├── Process: Search through your documents for relevant content
├── Retriever Processing  
└── Output: Relevant document chunks

Stage 2: Generate Answer
├── Input: Found documents + User question
├── Prompt: "Use this context to answer the question: {context}"
├── LLM Processing
└── Output: Answer based on your documents

Stage 3: Create Social Media Post (Optional)
├── Input: Generated answer
├── Prompt: "Create a social media post based on this: {answer}"
├── LLM Processing
└── Output: Social media content
```

In LangChain, you create this workflow by:

1. **Setting up document storage** with embeddings to make documents searchable
2. **Creating chains** that combine document search and answer generation
3. **Connecting multiple steps** using the pipe operator (|) to link stages together
4. **Running the complete workflow** with your input question

This approach is more accurate than asking the LLM to answer from memory alone. Each stage has a clear job: find information, generate an answer, then optionally enhance the content.

> [!TIP]
> Learn more about using [LangChain on Azure Databricks for LLM development](/azure/databricks/large-language-models/langchain).
