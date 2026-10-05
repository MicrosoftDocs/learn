A memory store that only accumulates becomes slower, more expensive, and less accurate at the same time. Old records crowd retrieval. Contradictions sit side by side, and a deletion request has nowhere obvious to land. In this unit, you set retention per memory type, retire contradictions without losing the audit trail, and make erasure an operation the design supports rather than a project.

## Set retention by memory type

Retention isn't one policy. Each record type has a different production cost and a different rate of going stale, so each gets its own answer.

| Type | Typical retention | Why |
| :--- | :--- | :--- |
| `turn` | 30 days | Highest volume, lowest density. Its lasting value is whatever distillation already extracted |
| `episodic` | 90 days | Useful while an interaction is still recent enough to inform the next one |
| `thread_summary` | Indefinite | Small, and the only cheap record of a conversation once its turns expire |
| `fact` | Indefinite, with decay | Cheap to keep, expensive to lose. Correct it rather than expire it |
| `user_summary` | Indefinite, rebuilt | 1 item per user, replaced on a cadence rather than expired |
| `procedural` | Indefinite | Derived behavioral rules persist until corrected or erased |

The Agent Memory Toolkit ships those defaults, and the shape generalizes: the raw material expires, and the derivations persist.

Implement it with [time to live](/azure/cosmos-db/time-to-live) rather than a cleanup job. Set `DefaultTimeToLive` to `-1` on the containers holding derived memory, which enables expiry while expiring nothing by default, and set an explicit `ttl` on the record types that should expire. Set a positive `DefaultTimeToLive` on the turns container so every turn expires whether or not the writer remembered to set one.

Two properties of that mechanism are worth knowing before you rely on it. Expired items vanish from query results the moment they expire, ahead of the background deletion, so retrieval never returns a record past its date even under load. And on a provisioned-throughput account, the deletion runs on leftover request units.

Expiry handles volume. It doesn't handle wrongness, which is a separate problem with a separate mechanism.

:::image type="content" source="../media/memory-record-lifecycle.png" alt-text="Diagram showing three paths out of an active memory record: expired by time to live, superseded by a newer record, or erased on request." lightbox="../media/memory-record-lifecycle.png":::

## Reconcile contradictions rather than accumulating them

People change their minds, and an extractor that ran six months ago has no idea. A store that appends every extracted fact ends up holding *the shopper's minimum light runtime is eight hours per charge* alongside *the shopper's minimum light runtime is 12 hours per charge*, both with high confidence, both matching the same query, and retrieval picks whichever happens to score higher.

Reconciliation is a scheduled pass that reads a pool of a user's active facts, asks a model which pairs conflict or duplicate, and retires the fact selected for replacement.

Retire, not delete. Set `supersededBy` on the older record to the identifier of the newer one and leave the record in place.

```python
def supersede(container, user_id, old_id, new_id):
    old = container.read_item(item=old_id, partition_key=user_id)
    old["supersededBy"] = new_id
    old["supersededAt"] = datetime.now(timezone.utc).isoformat()
    container.replace_item(item=old_id, body=old)
```

Three consequences follow from that choice. Retrieval already filters superseded records, so a retired fact stops competing immediately. The chain of `supersededBy` pointers reconstructs how a belief changed, which is the only way to answer *why did the assistant think that* after the fact. And a bad reconciliation is reversible, which matters because reconciliation is itself a model call and model calls are wrong sometimes.

Duplication and contradiction need different handling even though the same pass finds both. Two records saying the same fact in different words waste budget, so keep the one with higher confidence. Two records that genuinely conflict are a change of state, so keep the newer one regardless of confidence, because recency is the evidence.

Run reconciliation on a cadence that reflects its cost. Comparing every active fact against every other is quadratic in the number of facts, which is why the toolkit's default is one reconciliation sweep for every several extractions rather than one per extraction, over a bounded pool rather than the whole store.

## Make erasure a supported operation

A deletion request is where a memory design either holds up or doesn't, and the reason it usually doesn't is that memory is derived. Deleting a person's conversation turns leaves the facts extracted from them, the thread summaries built over those turns, the user profile built from those facts, and an embedding of every one of those strings. Each derivation is a copy of the information in a different shape.

Erasure therefore has to be a cascade over every container, and what makes it cheap or expensive is the partition key. When every memory record for a person shares a partition key value, or a hierarchical prefix, deletion is a partition-scoped operation instead of a cross-partition scan.

```python
for container in (turns, memories, summaries):
    container.delete_all_items_by_partition_key(user_id)
```

> [!NOTE]
> Delete by partition key value is in preview and is provided without a service-level agreement. It's an account capability rather than a default, so the call fails until you add `DeleteAllItemsByPartitionKey` to the account's capability list. It also runs as a background operation limited to about 10 percent of the container's request units per second, so it isn't instantaneous, and a request that has to complete within a deadline needs a query-and-delete loop instead.

Three requirements sit around that call, and the call itself satisfies none of them.

**Cover the derived layers.** Enumerate every container the memory design writes to, including summaries and any counters or leases a processing pipeline maintains, and treat the list as part of the design rather than something rediscovered during an incident.

**Record the erasure.** A deletion that leaves no trace can't be demonstrated. Write an audit record to a separate store, keyed on the request rather than on the person, holding what was deleted and when but not the content.

**Stop the pipeline first.** If a background processor is mid-extraction over the turns you're deleting, it writes new facts derived from them after the deletion finishes. Suspend the processing for that user, delete, then confirm the store is empty before resuming.

Design for erasure at the same time as you design for retrieval. The partition key that makes a user's memory cheap to recall is the one that makes it cheap to remove, so the two requirements point the same way, and discovering later that retrieval and erasure share a partition key costs a data migration.
