Now that the database is ready with embeddings and vector indexes, it’s time to turn retrieval into a working application. The goal is simple: take a user question, retrieve the most relevant chunks from PostgreSQL, and generate an answer grounded in those chunks using *Azure OpenAI* through *LangChain*.

In this unit, you learn the basics of building a RAG application in *Python*. The application connects to the database, runs a similarity search on the database, and passes the search results to a model with clear instructions to avoid hallucinations. Since the model receives a well defined context based on the database data, it can generate more accurate and relevant answers grounded in that context.

## Retrieval-Augmented Generation with PostgreSQL and LangChain

Remember from our previous units, the RAG flow is a set of steps that combines retrieval and generation. Let’s break it down:

1. User asks a question.  
1. Database computes an embedding for the question and uses the vector index to find the closest matches in the database (top chunks).  
1. Top chunks are passed to the model with a prompt that says: *"Answer only from this context. If you don’t know, say so."*  
1. Model returns a natural language answer based on the context provided.

*LangChain* provides a framework for building applications with language models. It simplifies the process of connecting to various data sources, managing prompts, and handling responses. By combining *Azure Database for PostgreSQL* with *Python* and *LangChain*, you can create a powerful RAG application that retrieves relevant information and generates accurate responses. While your RAG application might evolve, these core principles guide its development.

In this application, you use the *LangChain AzureChatOpenAI* wrapper to interact with the *Azure OpenAI* service.

For the following *Python* examples, you use the following table structure:

```sql
CREATE TABLE company_policies (
    id SERIAL PRIMARY KEY,
    title TEXT,
    policy_text TEXT,
    embedding VECTOR(1536)
);
```

In this table, you assume a vector index is created on the `embedding` column to enable efficient similarity searches.

Let's review the *Python* code snippets for each step. Most RAG applications follow a similar structure.

### Connect to the database

Keep connections short-lived and secure. In this example, secrets are in environment variables and passed to the connection.

```python
import os, psycopg2
from contextlib import contextmanager

@contextmanager
def get_conn():
    conn = psycopg2.connect(
        host=os.getenv("PGHOST"),
        user=os.getenv("PGUSER"),
        password=os.getenv("PGPASSWORD"),
        dbname=os.getenv("PGDATABASE"),
        connect_timeout=10
    )
    try:
        yield conn
    finally:
        conn.close()
```

This script sets up a context manager for database connections, ensuring they're properly closed after use. Time to move to the actual retrieval.

### Retrieve the relevant chunks

Since the user is asking a question, you need a function to query the database with that question. That function should return the relevant chunks based on the question. This example assumes that the vector index is ranked using *cosine distance*, so you use the respective operator class (<=>) for querying.

```python
def retrieve_chunks(question, top_k=5):
    sql = """
    WITH q AS (
        SELECT azure_openai.create_embeddings(%s, %s)::vector AS qvec
    )
    SELECT id, title, policy_text
    FROM company_policies, q
    ORDER BY embedding <=> q.qvec
    LIMIT %s;
    """
    params = (os.getenv("OPENAI_EMBED_DEPLOYMENT"), question, top_k)
    with get_conn() as conn, conn.cursor() as cur:
        cur.execute(sql, params)
        rows = cur.fetchall()
    return [{"id": r[0], "title": r[1], "text": r[2]} for r in rows]
```

So this function retrieves relevant chunks from the database based on the user's question. These chunks are then used to generate a context-aware answer in a subsequent step.

### Generate an answer with LangChain

Now that you have a function to retrieve relevant chunks, you need to generate an answer using those chunks. The model should only use the retrieved context and cite policy titles. Time to create the answer generation function.

```python
from langchain_openai import AzureChatOpenAI

SYSTEM_PROMPT = """
You are a helpful assistant. Answer using ONLY the provided context.
If the answer is not in the context, say you don’t have enough information.
Cite policy titles in square brackets, e.g., [Vacation policy].
"""

def format_context(chunks):
    return "\n\n".join([f"[{c['title']}] {c['text']}" for c in chunks])

def generate_answer(question, chunks):
    llm = AzureChatOpenAI(
        azure_deployment=os.getenv("OPENAI_CHAT_DEPLOYMENT"),
        api_key=os.getenv("AZURE_OPENAI_API_KEY"),
        azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
        api_version=os.getenv("AZURE_OPENAI_API_VERSION"),
        temperature=0
    )
    context = format_context(chunks)
    messages = [
        ("system", SYSTEM_PROMPT),
        ("human", f"Question: {question}\nContext:\n{context}")
    ]
    return llm.invoke(messages).content
```

> [!NOTE]
> To use *AzureChatOpenAI*:
> - Pass messages as a list of (role, content) tuples (or message objects).  
> - Provide Azure settings via env vars and constructor: `AZURE_OPENAI_API_KEY`, `AZURE_OPENAI_ENDPOINT`, and `azure_deployment`, `api_version`.  
> - Keep `temperature=0` for factual answers. Larger values increase creativity but might reduce accuracy.

This function is the core of the RAG application, handling the interaction with the language model. Notice how retrieved chunks are formatted and included in the context. Additionally, the system prompt is designed to ensure the model adheres to the context provided and reduces hallucination. Finally, the messages are processed by the language model to generate a response using the *LangChain* **invoke** method. The `invoke` method is called with the formatted messages, and the model's response is returned as natural language text.

### Tie it together

The last thing you need is a simple function to run the full flow:

```python
def answer_question(question):
    chunks = retrieve_chunks(question)
    if not chunks:
        return "I couldn’t find relevant content in the policy store."
    return generate_answer(question, chunks)

# Quick test
print(answer_question("How many vacation days do employees get?"))
```

In this example, you retrieve the relevant chunks from the database and use them to generate a context-aware answer. This function call demonstrates the complete flow from question to answer generation. First it calls the `retrieve_chunks` function to get the relevant context (basically the rows returned from the database). This function then passes that context to the `generate_answer` function that interacts with the language model to produce the final answer (using the rows as part of the context) as a natural language response. The full flow ensures that the answer is grounded in the retrieved data, providing a more accurate and reliable response.

## Key takeaways

A practical RAG application takes a user question, creates an embedding in SQL, uses a vector index to fetch the closest passages in the database, and hands only that context to the model. To reduce hallucination, the model is also instructed to stay within the provided context and admit when information is missing. Keep the connections short-lived, parameterize queries, and pass secrets through environment variables. Use a low temperature for factual answers and include lightweight citations (titles or IDs) so responses are traceable.

You should now have a solid understanding of how to build a Retrieval Augmented Generation (RAG) application using *Azure Database for PostgreSQL* and *Python*. While your RAG application might be much more complex in a real-world scenario, the core principles remain the same.
