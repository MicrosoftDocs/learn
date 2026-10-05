Conversation state is the memory every agent needs and the one most demonstrations skip, because a demonstration only asks one question. In this unit, you model a turn, write it to Azure Cosmos DB for NoSQL, read back the recent history a follow-up question depends on, and expire the log on a schedule instead of pruning it by hand.

## Model a turn as one item

The [recommended data model](/azure/cosmos-db/gen-ai/agentic-memories) for chat history stores one item per turn, where a turn is a complete exchange: the user's message and the agent's reply, or a tool call and its result.

```json
{
    "id": "thread-1042-7",
    "threadId": "thread-1042",
    "userId": "shopper-88",
    "turnIndex": 7,
    "messages": [
        { "role": "user", "content": "Does it come in a cheaper version?" },
        { "role": "agent", "content": "The dual-beam headlight is $34.99..." }
    ],
    "timestamp": "2026-09-07T10:14:27Z",
    "ttl": 2592000
}
```

A turn is a natural unit for four operations at once. It's small enough that writing it costs a handful of request units. It carries a monotonic `turnIndex`, so *the last six turns* is an ordered query rather than a sort in application code. It embeds cleanly if you decide later that turns should be semantically searchable. And it expires on its own, because time to live applies per item.

The alternative model, one item per thread with the turns in an array, reads the whole conversation in a single point read, and the documentation marks it as not recommended for a reason worth internalizing. Appending a turn means replacing the item, so the write cost grows with the length of the conversation, and a long-running thread eventually approaches the 2-MB item limit. A model that gets more expensive the more successful the conversation is has the wrong cost curve.

Partition the container on `threadId`. Every read a live conversation performs then lands in one logical partition, which is the access pattern this store exists to serve.

## Write and read conversation state

Writing is an upsert against the thread's partition.

```python
from datetime import datetime, timezone

TURN_TTL_SECONDS = 60 * 60 * 24 * 30  # 30 days

def append_turn(container, thread_id, user_id, turn_index, messages):
    container.upsert_item({
        "id": f"{thread_id}-{turn_index}",
        "threadId": thread_id,
        "userId": user_id,
        "turnIndex": turn_index,
        "messages": messages,
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "ttl": TURN_TTL_SECONDS,
    })
```

Deriving the item `id` from the thread and the turn index makes the write idempotent. A retry after a timeout replaces the turn rather than adding a duplicate, which matters because a duplicated turn corrupts every summary and every fact distilled from that thread afterward.

Reading is a single-partition query with an explicit partition key, so it never fans out.

```python
RECENT_TURNS = """
SELECT TOP @k c.turnIndex, c.messages
FROM c
WHERE c.threadId = @threadId
ORDER BY c.turnIndex DESC
"""

def recent_turns(container, thread_id, k=6):
    results = container.query_items(
        query=RECENT_TURNS,
        parameters=[
            { "name": "@k", "value": k },
            { "name": "@threadId", "value": thread_id },
        ],
        partition_key=thread_id,
    )
    return list(reversed(list(results)))
```

Two details carry weight. The query orders descending and the function reverses the result, because the model needs the turns in the order they happened while the database needs to find the newest ones first. And `k` is bounded rather than open, because history is the part of the prompt that grows without limit if nothing stops it.

That bound is a budget decision, not a correctness one. Six turns resolve most follow-up questions. Beyond roughly 12, the older turns rarely change the answer and reliably cost tokens on every request.

## Persist state across sessions

A session ends when the browser closes. A thread ends when the conversation is genuinely over, and those moments aren't the same. Resuming means keeping the thread identifier somewhere the next session can find it, and that place has to be trusted application storage tied to the authenticated user, not the client.

The reason is direct: `threadId` is the partition key of the conversation container, so a client that supplies its own thread identifier chooses which partition to read. Derive the identifier from the authenticated identity, or store the mapping server-side and look it up.

A thread that resumes after a long gap raises a second question. The turns are still there, and reading the last six of them injects a conversation the user no longer remembers. Compare the timestamp of the newest turn against the current time, and treat a gap beyond an hour or so as a new thread that inherits long-term memory rather than as a continuation. To decide where one episode ends and the next begins, the Agent Memory Toolkit uses the same signal, with a default idle gap of 1,800 seconds.

## Expire the log rather than pruning it

Conversation state is the highest-volume data an agent writes and the lowest-value data it keeps. [Time to live](/azure/cosmos-db/time-to-live) removes it without a cleanup job.

Set `DefaultTimeToLive` on the container to enable expiry, then let individual items override it. A container value of `-1` enables time to live while expiring nothing by default, so an item that carries a `ttl` expires and an item that doesn't never does. A positive container value sets the default and an item's `-1` exempts it. The one configuration that surprises people is the absent one: with `DefaultTimeToLive` unset, a `ttl` on an item has no effect at all.

Expired items disappear from query results the moment they expire, even before the background deletion runs. On a provisioned-throughput account, that deletion uses leftover request units, so it doesn't compete with the agent. On a serverless account, it's billed at the delete rate, which is a real line item when the deletions are conversation turns.

30 days is a defensible default for turns because it covers the window in which a user might resume a conversation and reference something specific. It's also the point where the log's only remaining value is what a distillation step already extracted from it, which is the subject of the next unit.
