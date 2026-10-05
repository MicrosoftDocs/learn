A hybrid query that returns the right items can still be the wrong query. Retrieval runs on every request a search feature serves, so its request charge and its latency are recurring costs, and relevance that arrives too late or too expensively doesn't reach the user. In this unit, you account for where a hybrid query spends its budget, narrow what gets ranked without undoing the fusion, and measure relevance as deliberately as you measure cost.

## Account for both halves of a hybrid query

A hybrid query performs a keyword retrieval, a vector retrieval, and a fusion. Its request charge isn't either component's charge, and when the charge moves, you can't tell which half moved it by looking at the total.

Measure the components separately. Run the keyword query on its own, run the similarity query on its own, then run the fused query, and read the request charge from each response rather than estimating any of them. Three numbers tell you where the budget goes; one number tells you only whether it's over.

One cost can sit outside the database entirely. When the application needs a new query embedding from a separate service, the call has its own latency, throttling, and quota. It happens before Azure Cosmos DB sees the query, so no request charge reports it, and in a latency budget, it's frequently the largest single item. Measure it alongside the query rather than assuming the database accounts for the whole pipeline. Reusing an available query embedding avoids that generation call.

A measurement taken on a small container also needs a caveat attached to it. The `quantizedFlat` and `diskANN` index types take effect only once at least 1,000 vectors are indexed; otherwise, the engine runs a full scan instead. Charges collected on a few hundred items are real numbers about a scan, not a preview of what the index does at scale.

## Filter the eligible results

A `WHERE` clause defines which items are eligible for the final results. An equality filter on the full partition key can route the query to one physical partition instead of every partition. Other filters can reduce work, but DiskANN can apply filtering during or after vector candidate traversal rather than as a separate prefilter. Measure the request charge and recall of the filtered query.

The full-text functions offer a filtering form and a scoring form. `FullTextContains`, `FullTextContainsAll`, and `FullTextContainsAny` return a boolean and belong in a `WHERE` clause, while `FullTextScore` returns a rank and belongs in `ORDER BY RANK`. Filtering on terms first and scoring second is a documented pattern for a pure keyword query.

> [!IMPORTANT]
> Think twice before carrying that pattern into a hybrid query. A `WHERE FullTextContains(...)` clause removes every item that lacks the term, including the items the semantic half exists to find. Applied to the fused query, a keyword filter reimposes the limitation the vector half was added to escape.

The distinction worth holding is between rules and relevance. A `WHERE` clause is the right place for a rule: which items a user is allowed to see, which are in stock, which belong to the selected category or tenant. Relevance belongs in the ranking, where `RRF` can weigh evidence instead of discarding items.

When a filter and a vector search compete, the `filterPriority` option on `VectorDistance` weighs the `WHERE` clause against the vector search inside a DiskANN traversal. It sits in the same options object as the recall and data-type overrides you already know from configuring vector queries.

## Measure relevance, not just request charge

Request charge is easy to measure, so it tends to become the only quantity measured, and a cheaper query that answers worse looks like an improvement. Relevance needs a measurement of its own before any tuning starts.

Build a fixed evaluation set: a list of queries that represent what users type, and for each query the items a person judges relevant. 20 queries chosen from real logs are worth more than 200 invented ones, because invented queries tend to describe the corpus rather than the users. Every tuning change is then a comparison between two runs of the same set rather than an impression formed from one search.

### Establish a ground truth with brute force

The third argument to `VectorDistance` forces a brute-force comparison when it's `true`. Every stored vector is compared against the query vector, so the result is the provably exact set of nearest neighbors.

```sql
SELECT TOP 10 c.id, c.name
FROM c
ORDER BY VectorDistance(c.embedding, @queryVector, true)
```

That query costs far more than the indexed form, which is exactly why it belongs in an offline evaluation rather than in a request path. Run the evaluation set once with brute force to record what perfect recall looks like, and then run it against the index and count how many of those items the index returned. The difference is the recall the approximate index gives up, expressed as a number rather than a worry.

Two properties of approximate search shape how you write those comparisons. A `diskANN` index can return a slightly different ordering for the same query across runs, because each replica builds its own copy of the index and any replica can answer. Assert that an expected item appears in the top results rather than asserting a fixed ordered list, or the evaluation reports failures that are only variance. When recall is genuinely short, `searchListSizeMultiplier` widens the search list and trades latency and request charge for it.

No index setting recovers meaning the embedding never captured. If a measurement shows poor relevance across the whole evaluation set rather than on a few queries, look at the text being embedded and the model embedding it before reaching for a dial.

## Change one dial at a time

Tuning is a sequence, and the simplest query changes come first. Even a smaller `TOP N` or a more restrictive filter can remove relevant results, so rerun the evaluation set after each change.

1. Size `TOP N` to what the consumer needs. A chat feature grounding an answer needs a handful of passages, and a results page needs a page.
1. Project the properties the caller uses instead of `SELECT *`. Embeddings are large, and returning one to a caller that ignores it pays transfer cost for nothing.
1. Add the filters that express rules, including the partition key whenever the application knows it.
1. Adjust the `RRF` weights, one step at a time, and rerun the evaluation set after each step.
1. Only then, reach for query options such as `searchListSizeMultiplier`, or for a different vector index type.

Record both numbers for every step, the evaluation score and the request charge. A change that improves relevance and doubles the charge is a decision for the product to make rather than an improvement to adopt silently.

Repeat the measurement as the corpus grows. BM25 scores depend on how rare a term is across the container, so term rarity shifts as items are added, and the vector index behaves differently once the corpus crosses the thresholds that make an approximate index worthwhile. Weights tuned against 10,000 items are a hypothesis about 1,000,000 of them.

In this unit, you learn how to optimize the performance of full-text and vector search in Azure Cosmos DB for NoSQL. You see how to establish a ground truth with brute-force queries, tune query parameters methodically, and balance relevance against request charge. The next unit covers advanced strategies for measuring and adjusting these optimizations in a production environment.
