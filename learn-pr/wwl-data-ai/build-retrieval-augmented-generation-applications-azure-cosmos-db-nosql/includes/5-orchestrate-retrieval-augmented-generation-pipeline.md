One grounded answer is a demonstration. An assistant is a pipeline that runs the same stages for every question, survives the second question in a conversation, and knows which questions one retrieval pass can't reach. In this unit, you assemble the stages into replaceable functions, handle the follow-up question that breaks naive retrieval, and decide when a question earns a multi-step pass.

## Assemble the stages as replaceable functions

The pipeline is five steps, and writing them as five functions rather than one is what makes the system measurable.

| Stage | Input | Output | What you change when quality drops |
| :--- | :--- | :--- | :--- |
| Resolve | The raw question and the conversation so far | A standalone question | How much history it considers |
| Embed | The standalone question | A query vector | The model, and it has to match the one that embedded the corpus |
| Retrieve | The vector and the caller's authorization | Ranked candidates | The query, the filters, `TOP N`, the retrieval method |
| Select | Candidates | The grounding set | Reranking, the budget, deduplication |
| Generate | The grounding set and the question | The answer and its citations | The system prompt and the model |

::: zone pivot="python"

```python
def answer(question, history, tenant_id):
    standalone = resolve_question(question, history)
    vector = embed(standalone)
    candidates = retrieve(vector, tenant_id, top_n=20)
    grounding = select(candidates, standalone, limit=5)
    return generate(standalone, grounding)
```

::: zone-end

::: zone pivot="csharp"

```csharp
async Task<GroundedAnswer> AnswerAsync(
    string question,
    IReadOnlyList<Turn> history,
    string tenantId)
{
    string standalone = await ResolveQuestionAsync(question, history);
    float[] vector = await EmbedAsync(standalone);
    IReadOnlyList<RetrievalItem> candidates =
        await RetrieveAsync(vector, tenantId, topN: 20);
    IReadOnlyList<RetrievalItem> grounding =
        Select(candidates, standalone, limit: 5);

    return await GenerateAsync(standalone, grounding);
}
```

::: zone-end

Each stage is independently testable, which is the point. When answers get worse, a fixed set of representative questions run against `retrieve` alone tells you whether the right evidence is being found, which separates a retrieval problem from a prompt problem before anyone spends a day rewriting a system message. Each stage is also independently replaceable, so adding a reranker or switching retrieval from vector to hybrid changes one function rather than the pipeline.

## Resolve a follow-up question before retrieving it

A shopper asks *which headlight is brightest*, gets an answer, then asks *does it come in a cheaper version*. The second question contains no retrievable content. Embed it as written and the vector describes cheapness in the abstract, not the product the conversation is about, and retrieval returns items that have nothing to do with the answer the shopper just read.

This defect is the most common in a retrieval-augmented generation (RAG) application that worked in the demonstration, because a demonstration asks one question. The repair is a stage of its own: rewrite the question into a standalone form using the conversation, and retrieve on the rewrite.

::: zone pivot="python"

```python
RESOLVE_PROMPT = """Rewrite the user's latest question so it stands alone,
using the conversation for any reference it depends on.
Return only the rewritten question. Add nothing that the conversation
doesn't support."""

def resolve_question(question, history):
    if not history:
        return question

    transcript = "\n".join(f"{turn['role']}: {turn['content']}" for turn in history[-4:])

    response = openai_client.chat.completions.create(
        model=CHAT_DEPLOYMENT,
        messages=[
            {"role": "system", "content": RESOLVE_PROMPT},
            {"role": "user", "content": f"CONVERSATION\n{transcript}\n\nQUESTION\n{question}"},
        ],
        reasoning_effort="none",
        max_completion_tokens=300,
    )
    return response.choices[0].message.content.strip()
```

::: zone-end

::: zone pivot="csharp"

```csharp
#pragma warning disable OPENAI001

const string ResolvePrompt = """
    Rewrite the user's latest question so it stands alone,
    using the conversation for any reference it depends on.
    Return only the rewritten question. Add nothing that the conversation
    doesn't support.
    """;

async Task<string> ResolveQuestionAsync(string question, IReadOnlyList<Turn> history)
{
    if (history.Count == 0) { return question; }

    string transcript = string.Join("\n",
        history.TakeLast(4).Select(turn => $"{turn.Role}: {turn.Content}"));

    ChatCompletion completion = await chatClient.CompleteChatAsync(
        new ChatMessage[]
        {
            new SystemChatMessage(ResolvePrompt),
            new UserChatMessage($"CONVERSATION\n{transcript}\n\nQUESTION\n{question}")
        },
        new ChatCompletionOptions
        {
            ReasoningEffortLevel = new("none"),
            MaxOutputTokenCount = 300
        });

    return completion.Content[0].Text.Trim();
}
```

::: zone-end

Three details make the difference between a rewrite that helps and one that causes its own failures. Bound the history you pass, because an unbounded transcript grows the prompt without improving the rewrite. Skip the stage on the first turn, where there's nothing to resolve and the call is pure latency. And instruct the rewrite to add nothing the conversation doesn't support, because a model asked to make a question standalone happily invents the missing noun.

Conversation state belongs in Azure Cosmos DB, in a container partitioned on the conversation identifier. Every read and write for one conversation then hits a single logical partition, and a time-to-live setting expires old conversations without a cleanup job.

## Decide between one pass and several

A one-shot pipeline retrieves once. It's the right default. It's what these stages implement, and it answers most questions correctly at the cost of one embedding call, one query, and one or two model calls.

:::image type="content" source="../media/one-shot-vs-multi-step.png" alt-text="Diagram of a one-shot retrieval path beside a multi-step path that detects gaps and retrieves again before answering." lightbox="../media/one-shot-vs-multi-step.png":::

Some questions defeat it structurally rather than by being hard. A question comparing two subjects needs evidence about both, and a similarity search against the whole sentence returns items resembling the sentence rather than items answering either half. A question whose answer depends on something the question doesn't name needs a second retrieval that only becomes possible after the first one lands.

Multi-step retrieval answers those questions by iterating: retrieve, draft an answer, identify what's missing, generate narrower follow-up questions, retrieve for those questions, and synthesize a final answer from everything gathered. The Agentic Retrieval Toolkit for Azure Cosmos DB implements that loop as a reference architecture over vector search, full-text search, and Azure OpenAI, and it adds a diversity selection step that trims redundant chunks before they reach the prompt.

> [!NOTE]
> The Agentic Retrieval Toolkit is in preview and is provided without a service-level agreement. Treat it as a reference implementation to read and adapt rather than as a supported dependency.

The trade is plain enough to decide on. A multi-step pass costs several model calls and several retrievals per answer, so latency and cost rise with the number of iterations. Use it where questions genuinely span several sources and the answer is worth the wait, and use one shot everywhere else. The way to find out which you have is to measure a one-shot pipeline on real questions and look at what it gets wrong, rather than to reach for the more capable pattern first.

### Choose whether a framework earns its place

Orchestration frameworks such as LangChain, LangGraph, Semantic Kernel, and LlamaIndex package these stages behind a common interface, and Azure Cosmos DB for NoSQL has connectors for several of them.

Check the language before you choose, because coverage isn't symmetric. The Python connector for LangChain provides a vector store, a semantic cache, and chat message history in one package, while LangChain has no .NET connector for Azure Cosmos DB for NoSQL at all. Semantic Kernel has connectors for both Python and .NET, and the .NET one is in preview. A framework decision made on the framework's reputation rather than on its connector table is a decision you discover halfway through.

What a framework gives you is breadth: swapping models or stores without rewriting call sites, prebuilt splitters and retrievers, and tracing across a chain. What it costs is a layer between your code and the behavior you're debugging, and a release cadence you don't control.

The five functions this unit defines are the whole pipeline, and they call two software development kits. That amount of code is reasonable to own directly, which is why the decision deserves to be made rather than defaulted to. Adopt a framework when you're integrating several stores or several model providers and want one abstraction over them. Write the stages yourself when the pipeline is one store and one provider and you want the retrieval behavior in front of you.

In this unit, you learn how to orchestrate a RAG pipeline in a real application scenario. You see how to decide between one-shot and multi-step retrieval, evaluate whether a framework suits your needs, and understand the trade-offs involved in owning the pipeline versus adopting an abstraction layer.
