A Contoso order isn't one document. When a customer checks out, the service writes the order header and decrements the reserved stock counter that lives alongside it. If the header lands and the counter update fails, the warehouse ships goods that inventory still believes are available. In this unit, you group those writes into a transactional batch so they either all succeed or all fail together.

## What a transactional batch guarantees

A **transactional batch** sends multiple point operations to Azure Cosmos DB in a single request, scoped to a single logical partition key. The service applies them in the order you specify, and the transaction commits only when every operation succeeds. If any operation fails, the service rolls back the whole batch and the container stays exactly as it was.

Three properties define the feature:

- **Atomic.** All operations commit or none do. There's no partially applied batch.
- **Ordered.** Operations execute in the order you add them, so you can create an item and then patch it in the same batch.
- **Single partition.** Every operation must target the same logical partition key value.

That last constraint is the one that shapes your data model. A transactional batch can't span logical partitions, so the items you need to write atomically have to share a partition key. In the Contoso design, an order header and its stock reservation both use `customerId` as the partition key value, which is what makes the batch possible. Grouping items that change together into the same logical partition is a data-modeling decision you make well before you write the batch code.

## Building and executing a batch

The Contoso checkout batch creates the order header, creates a payment record, and patches a running order count on the customer's summary document. All three share the partition key value `cust-2043`.

::: zone pivot="csharp"

`Container.CreateTransactionalBatch` returns a `TransactionalBatch` that supports fluent chaining:

```csharp
PartitionKey partitionKey = new PartitionKey("cust-2043");

TransactionalBatch batch = container.CreateTransactionalBatch(partitionKey)
    .CreateItem<Order>(order)
    .CreateItem<Payment>(payment)
    .PatchItem("summary-cust-2043", new[]
    {
        PatchOperation.Increment("/orderCount", 1)
    });

using TransactionalBatchResponse response = await batch.ExecuteAsync();
```

The `using` declaration disposes the response when it leaves scope, which releases the underlying stream.

Batches accept the same operations you use individually: `CreateItem`, `ReadItem`, `ReplaceItem`, `UpsertItem`, `PatchItem`, and `DeleteItem`, along with stream variants that skip serialization.

::: zone-end

::: zone pivot="python"

Each operation is a tuple of an operation name, its arguments, and an optional keyword dictionary:

```python
batch_operations = [
    ("create", (order,)),
    ("create", (payment,)),
    ("patch", ("summary-cust-2043", [
        {"op": "incr", "path": "/orderCount", "value": 1}
    ])),
]

response = container.execute_item_batch(
    batch_operations=batch_operations,
    partition_key="cust-2043",
)
```

The operation names mirror the individual methods: `create`, `read`, `replace`, `upsert`, `patch`, and `delete`.

::: zone-end

Every operation in a batch counts toward the request unit (RU) charge, and the charge for the batch is the sum of its individual operations. A batch isn't a discount. It's a correctness guarantee.

### Reviewing the results

A batch response reports both an overall outcome and a per-operation outcome, positioned in the same order you added the operations.

::: zone pivot="csharp"

```csharp
if (response.IsSuccessStatusCode)
{
    Order created = response.GetOperationResultAtIndex<Order>(0).Resource;
}
else
{
    for (int i = 0; i < response.Count; i++)
    {
        TransactionalBatchOperationResult result = response[i];
        Console.WriteLine($"Operation {i}: {(int)result.StatusCode}");
    }
}
```

::: zone-end

::: zone pivot="python"

A successful batch returns a list of per-operation results, in the order you added the operations. Each result carries a `statusCode`, a `requestCharge`, an `eTag`, and a `resourceBody` holding the item body for operations that return one. A failure raises `CosmosBatchOperationError`, which reports which operation failed and why:

```python
from azure.cosmos import exceptions

try:
    response = container.execute_item_batch(
        batch_operations=batch_operations,
        partition_key="cust-2043",
    )
    for index, result in enumerate(response):
        print(f"Operation {index}: status {result.get('statusCode')}")
except exceptions.CosmosBatchOperationError as e:
    print(f"Operation {e.error_index} failed with status {e.status_code}")
```

::: zone-end

Reading the per-operation status is what makes a failed batch diagnosable. The operation that failed carries a real status code, such as 409 Conflict for a duplicate `id` or 412 Precondition Failed for a rejected conditional operation. Every other operation reports **424 Failed Dependency**, which means "this operation was fine, but the transaction rolled back." Scan for the status that isn't 424 to find the cause.

## Working within the limits

| Limit | Value |
|:---|:---|
| Operations per batch | 100 |
| Request payload size | 2 MB |
| Maximum execution time | 5 seconds |
| Partition key values per batch | 1 |

Exceeding the operation count or payload size returns an error rather than splitting the work, so chunk large workloads yourself. Mixing partition key values fails the batch with 400 Bad Request:

::: zone pivot="csharp"

```csharp
// Fails: the batch is scoped to "cust-2043" but the payment belongs to another customer.
TransactionalBatch batch = container.CreateTransactionalBatch(new PartitionKey("cust-2043"))
    .CreateItem<Order>(orderForCustomer2043)
    .CreateItem<Payment>(paymentForCustomer7781);
```

::: zone-end

::: zone pivot="python"

```python
# Fails: the batch is scoped to "cust-2043" but the payment belongs to another customer.
batch_operations = [
    ("create", (order_for_customer_2043,)),
    ("create", (payment_for_customer_7781,)),
]

container.execute_item_batch(batch_operations, partition_key="cust-2043")
```

::: zone-end

When related items genuinely can't share a partition key, a transactional batch isn't available and the application has to reach for a different pattern, such as processing the change feed to bring the second item into line after the first write commits.

## Combining batches with concurrency control

Batch operations take per-operation request options, a narrower set than individual operations accept. The ETag precondition from the previous unit is among them. Adding an ETag to one operation in a batch makes the entire transaction conditional on that item being unchanged.

::: zone pivot="csharp"

```csharp
TransactionalBatchItemRequestOptions options = new()
{
    IfMatchEtag = summaryEtag
};

TransactionalBatch batch = container.CreateTransactionalBatch(partitionKey)
    .CreateItem<Order>(order)
    .ReplaceItem<CustomerSummary>(summary.id, summary, options);
```

::: zone-end

::: zone pivot="python"

```python
batch_operations = [
    ("create", (order,)),
    ("replace", (summary["id"], summary), {"if_match_etag": summary_etag}),
]
```

The third element of the tuple is the optional keyword dictionary that carries per-operation request options.

::: zone-end

If the summary changed since you read it, the whole batch fails with 412 and the service writes nothing, including the order. That combination gives you a compare-and-swap across several documents at once.

---

> **Synthesis prompt:** The Contoso team also needs to write an audit record for every order. Audit records are queried by date across all customers, so partitioning them by `customerId` would be a poor fit for their read pattern. Including the audit write in the checkout batch would force that partitioning choice. Weigh atomicity against query efficiency: what does the team give up with each option, and what would you recommend?
