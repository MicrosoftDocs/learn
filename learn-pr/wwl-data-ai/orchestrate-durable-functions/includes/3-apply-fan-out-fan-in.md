::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=cbfae64e-1470-4edc-a999-769fc97ebe2f]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

AI document and media pipelines often contain independent operations that don't need to run in sequence. The Durable Functions fan-out/fan-in pattern schedules those operations concurrently, waits for the group to finish, and then combines the results. This pattern can reduce batch latency while keeping coordination and checkpoints inside the durable runtime.

> [!NOTE]
> The code examples in this unit are patterns to adapt to your application. They focus on durable coordination and don't define the model client, storage implementation, or production concurrency controls.

## Identify independent work

Fan-out/fan-in works best when each work item can complete without changing the inputs of another item. Common AI examples include extracting text from several documents, classifying images, generating embeddings for separate chunks, or moderating independent content items. The fan-out phase distributes these tasks across activity executions, while the fan-in phase gives the orchestrator a complete result set for the next decision.

Sequential processing awaits each activity before scheduling the next one. This approach can be appropriate when order matters or one result becomes the next input, but it adds the latency of every item. For 20 independent documents that each require 5 seconds, sequential execution takes about 100 seconds before coordination overhead. Parallel execution can approach the duration of the slowest item when enough worker and downstream capacity is available.

Parallel scheduling doesn't guarantee unlimited concurrency. Azure Functions scales activity execution according to the hosting plan, worker settings, and available resources. The model endpoint, database, or storage account can impose lower throughput limits than the function app. You should select a concurrency strategy that respects the most constrained downstream dependency.

## Schedule tasks before awaiting results

The Python Durable Functions SDK represents activity calls as durable tasks. To fan out, the orchestrator creates one task for each compact work-item reference and stores the tasks in a list without yielding each call immediately. It then yields `context.task_all(tasks)` to wait for every scheduled activity and receive the ordered results.

The following fragment schedules one activity per document reference. Each activity can read its source blob, call the required AI model, and write detailed output to storage. The orchestrator receives compact fields that it can aggregate without placing large model responses in orchestration history.

```python
# Code fragment - focus on fan-out/fan-in coordination
import azure.durable_functions as df


def orchestrator(
    context: df.DurableOrchestrationContext,
):
    batch = context.get_input()
    tasks = []

    for document in batch["documents"]:
        tasks.append(
            context.call_activity(
                "process_document",
                {
                    "batch_id": batch["batch_id"],
                    "document_id": document["document_id"],
                    "blob_url": document["blob_url"],
                },
            )
        )

    results = yield context.task_all(tasks)

    return {
        "batch_id": batch["batch_id"],
        "processed": len(results),
        "requires_review": [
            item["document_id"]
            for item in results
            if item["confidence"] < 0.80
        ],
    }
```

The order of the returned list matches the task list, even when activities finish in a different order. A failed activity causes the `task_all` operation to surface a task failure to the orchestrator. The orchestrator can catch that failure and choose whether to fail the batch, compensate completed work, or route the batch for investigation.

## Design compact fan-in results

Fan-in executes inside one orchestrator instance, so aggregation should remain deterministic and lightweight. You can count statuses, select documents below a confidence threshold, or build a compact summary from activity outputs. Expensive transformations and external writes belong in another activity.

A document-processing activity might return the following fields:

- **Document ID:** Correlates the result with the original work item.
- **Status:** Indicates success, validation failure, or another business outcome.
- **Confidence:** Supports deterministic routing to an approval step.
- **Result URL:** Points to the full output stored in Blob Storage or a database.
- **Operation ID:** Supports idempotent updates and trace correlation.

Avoid returning extracted text, full model prompts, large arrays of embeddings, or complete model responses. These values expand orchestration history, and Durable Functions must load them during replay. Write large results from the activity to an external store and return a reference.

If aggregation itself requires substantial CPU, memory, or input/output, schedule an `AggregateResults` activity after `task_all`. The orchestrator can pass compact result references to that activity and await one final summary. This design preserves a small orchestration history while allowing the aggregation work to use normal function execution.

## Bound parallel work

A batch with thousands of documents can schedule a large number of activities at once. The durable runtime can record those tasks, but the resulting history and fan-in work can become expensive. A sudden activity burst can also exceed model rate limits or saturate a downstream data service.

You can divide large inputs into bounded batches and process one batch at a time. Each batch still runs its items in parallel, but the workflow waits before scheduling the next group. Choose the batch size from observed model quotas, average item duration, function concurrency, and acceptable replay history rather than from an arbitrary maximum.

The following fragment adds bounded batches to the same pattern. The code keeps the batch loop deterministic because it derives each slice from stable orchestration input.

```python
# Code fragment - focus on bounded fan-out
batch_size = 20
all_results = []

for start in range(0, len(documents), batch_size):
    current_batch = documents[start : start + batch_size]
    tasks = [
        context.call_activity("process_document", document)
        for document in current_batch
    ]
    batch_results = yield context.task_all(tasks)
    all_results.extend(batch_results)
```

Bounded batches limit scheduled work but don't provide a precise requests-per-second limit. If a model deployment enforces a strict rate, combine batching with client-side retry guidance and a workload design that controls request admission. Avoid adding language-native sleeps to an orchestrator. Use durable timers when the workflow must pause between batches.

## Scale aggregation with sub-orchestrations

One orchestrator performs the fan-in step on one worker at a time. A single flat fan-in can become a bottleneck when it must load and aggregate many results. Sub-orchestrations let you create a hierarchy in which child orchestrations process separate partitions and a parent combines their compact summaries.

For example, a parent orchestration can divide a large claim archive by policy or month. Each child orchestration fans out its own document activities and returns counts plus result locations. The parent then aggregates those summaries instead of every individual document result. This approach reduces the amount of state handled by one orchestration and gives each partition an independent status.

Sub-orchestrations add coordination and history records, so they aren't necessary for small batches. Start with a direct fan-out/fan-in pattern, measure execution and replay behavior, and introduce partitioning when batch size or aggregation cost justifies the added structure. For storage-provider and concurrency settings, see [Performance and scale in Durable Functions](/azure/azure-functions/durable/durable-functions-perf-and-scale).

::: zone-end

## Additional resources

These resources explain the fan-out/fan-in pattern and the scale characteristics that influence partitioning decisions. You can use them when you need to move from a small batch to a production workload.

- [Fan-out/fan-in pattern](/azure/durable-task/common/durable-task-fan-in-fan-out)
- [Sub-orchestrations in Durable Functions](/azure/durable-task/common/durable-task-sub-orchestrations)
- [Performance and scale in Durable Functions](/azure/azure-functions/durable/durable-functions-perf-and-scale)
