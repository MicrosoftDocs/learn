A conversation log answers *what was said*. Long-term memory answers *what's true about this person*, and nothing in the log is in that shape. In this unit, you distill turns into individual memory records, store them so a later session finds them by meaning, and decide when to hand the loop to the Agent Memory Toolkit instead of writing it.

## Distill turns into facts

Distillation is a model call that reads recent turns and returns assertions. Its output quality depends almost entirely on how narrowly you constrain it.

```python
EXTRACTION_PROMPT = """Extract durable facts about the user from the conversation.

A durable fact is a preference, constraint, requirement, or decision that stays
true after this conversation ends. Skip anything about the current task, anything
the user asked rather than stated, and anything you inferred rather than read.

Return JSON: {"facts": [{"text": "...", "category": "preference|requirement|biographical|other", "confidence": 0.0}]}
Return an empty list when the conversation contains no durable fact."""

def extract_facts(openai_client, chat_deployment, turns):
    transcript = "\n".join(
        f"{message['role']}: {message['content']}"
        for turn in turns for message in turn["messages"]
    )

    response = openai_client.chat.completions.create(
        model=chat_deployment,
        messages=[
            { "role": "system", "content": EXTRACTION_PROMPT },
            { "role": "user", "content": transcript },
        ],
        response_format={ "type": "json_object" },
        reasoning_effort="none",
        max_completion_tokens=800,
    )
    return json.loads(response.choices[0].message.content)["facts"]
```

Four constraints in that prompt each prevent a specific failure.

**Durable, not situational.** Without the distinction, the extractor writes *the user is comparing two headlights* as a fact, and the assistant opens next month's session by referring to a comparison nobody remembers.

**Stated, not inferred.** An extractor allowed to infer produces confident sentences the user never said. Everything downstream trusts a memory store, so a fabricated entry is worse than a missing one.

**Categorized.** A category is what lets retrieval and retention treat records differently later. A requirement outranks a preference when the two conflict.

**An empty list is a valid answer.** An extractor that must produce something produces something, and most conversations contain no durable fact at all.

Run distillation on a cadence rather than on every turn. Every turn re-reads the same conversation repeatedly and pays for it each time. A processing schedule lets cheaper derivations run more often than expensive ones. The toolkit configuration section gives the default thresholds.

:::image type="content" source="../media/memory-over-time.png" alt-text="Diagram of a four-stage timeline showing conversation turns expiring after 30 days while the facts distilled from them remain searchable." lightbox="../media/memory-over-time.png":::

## Store a memory that can be found again

A memory item is small, so the fields around the text are most of the design.

```python
def store_fact(container, embeddings_client, embedding_deployment, user_id, thread_id, fact):
    vector = embeddings_client.embeddings.create(
        input=fact["text"],
        model=embedding_deployment,
    ).data[0].embedding

    container.upsert_item({
        "id": str(uuid.uuid4()),
        "userId": user_id,
        "type": "fact",
        "content": fact["text"],
        "category": fact["category"],
        "confidence": fact["confidence"],
        "sourceThreadId": thread_id,
        "createdAt": datetime.now(timezone.utc).isoformat(),
        "supersededBy": None,
        "embedding": vector,
    })
```

`content` is the text you embed and the text you later put in a prompt, and using the same string for both is deliberate. A fact is one sentence, so it needs no separation between what makes it findable and what makes it useful.

`userId` is the partition key. Long-term memory is read across threads for one person, so partitioning on the thread would scatter it.

`sourceThreadId` and `createdAt` are provenance. When a memory turns out to be wrong, the question is always where it came from and when, and neither is recoverable afterward if you don't record it.

`confidence` and `supersededBy` are the two fields that make the store correctable. The first lets retrieval ignore weak entries. The second lets a contradiction retire a record without deleting the audit trail. Unit 6 uses both.

The container carries a vector policy on `/embedding` and a full-text policy on `/content`, so the same item supports similarity search, keyword search, and the hybrid fusion of the two.

## Search memory by meaning

Recall is a vector query filtered to the user, ordered by distance.

```python
MEMORY_SEARCH = """
SELECT TOP @k c.id, c.content, c.category, c.confidence, c.createdAt,
       VectorDistance(c.embedding, @queryVector) AS score
FROM c
WHERE c.userId = @userId
  AND c.type = 'fact'
  AND IS_NULL(c.supersededBy)
ORDER BY VectorDistance(c.embedding, @queryVector)
"""

def recall(container, embeddings_client, embedding_deployment, user_id, query_text, k=5):
    query_vector = embeddings_client.embeddings.create(
        input=query_text,
        model=embedding_deployment,
    ).data[0].embedding

    return list(container.query_items(
        query=MEMORY_SEARCH,
        parameters=[
            { "name": "@k", "value": k },
            { "name": "@userId", "value": user_id },
            { "name": "@queryVector", "value": query_vector },
        ],
        partition_key=user_id,
    ))
```

The `WHERE` clause does three jobs, and each is a rule rather than a relevance judgment. It scopes to one user, so no similarity score can reach another person's memory. It selects a type. And it excludes superseded records, so a retired fact stays queryable for audit without competing for a place in the prompt.

Matching by meaning is the whole point of the vector. A shopper who says *I need something that survives rain* leaves a fact about weather resistance, and the catalog's `Headlights - Weatherproof` never contains the word *rain*. Keyword search over that memory finds nothing. Vector search finds it.

The inverse case is why the container also carries a full-text index. Exact tokens, a model number or an order reference, are precisely what similarity search blurs. Rank the two together with reciprocal rank fusion when recall matters more than the cost of a slightly larger query.

## Decide whether to run the loop yourself

Everything so far is roughly 100 lines: extract, embed, store, search. The [Agent Memory Toolkit](/azure/cosmos-db/gen-ai/agent-memory-toolkit) packages the same loop, adding scheduled extraction, thread and user summaries, episode boundary detection, procedural rules, and reconciliation of contradictory facts, over the container layout described in the previous unit.

The trade is the usual one. The toolkit gives you the derivations that are tedious to build and easy to build badly, and it costs you a preview dependency whose surface is still moving. Its own package notes that the public surface may change in backward-incompatible ways before a 1.0 release and recommends pinning a version.

Write the loop yourself when facts are the only derived type you need and the extraction prompt is the part you want to control. Take the toolkit when you want summaries, episodes, and reconciliation without owning the scheduling, and pin the version you tested against.

### Configure toolkit processing

The toolkit separates fact extraction, episode segmentation, and procedural synthesis. Extraction and segmentation read the conversation. To derive behavioral rules, procedural synthesis reads stored facts and episode lessons. These operations call language models, so their schedule affects cost and how soon new memory becomes available.

In `azure-cosmos-agent-memory` version `0.3.0b2`, the default in-process backend runs in your application and needs no separate function app. It checks turn-count thresholds as writes arrive: fact extraction every 2 turns, thread summaries every 10, user summaries every 20, and contradiction resolution every fifth extraction. You can configure each threshold, and a value of 0 disables its step. A turn count schedules an episode boundary check, but an episode closes on an idle gap or a size cap, with optional topic-change detection. Automatic procedural synthesis follows the contradiction-resolution cadence when enabled.

For background processing, the toolkit exposes `DurableFunctionProcessor` from `azure.cosmos.agent_memory`. Pass `processor=DurableFunctionProcessor()` when constructing `CosmosMemoryClient` and deploy the corresponding Durable Functions processor. The application writes turns to `memories_turns`, and a sibling function app processes them through the Azure Cosmos DB change feed. The application doesn't invoke the function app directly. This arrangement moves model processing off the request path, but retrieval can run before the new derived memory is ready.

Select one processing backend for the store. The SDK's in-process trigger runs unless `MEMORY_PROCESSOR_OWNER` is `durable`; the function app processes changes only when that value is `durable`. Set it consistently in the application and function app environments. For example, set both to `durable` when the function app owns processing. Enabling the function app while leaving the application on its default can process the same turns twice and duplicate model costs. The setting is advisory, not an enforced lock.

:::image type="content" source="../media/agent-memory-pipeline.png" alt-text="Diagram showing conversation turns flowing through the processing pipeline into memory and summary containers, then back out through search." lightbox="../media/agent-memory-pipeline.png":::

In this unit, you learn how to implement semantic memory for an agent using Azure Cosmos DB, including how to extract, embed, store, and search facts, and how to configure the Agent Memory Toolkit for background processing.
