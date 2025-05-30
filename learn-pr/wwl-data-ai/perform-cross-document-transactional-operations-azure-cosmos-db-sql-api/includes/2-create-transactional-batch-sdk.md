Transactional batch requests enable you to perform multiple operations simultaneously within the same partition key. All operations are executed in the specified order, and the transaction is committed only if every operation succeeds. If any operation fails, the entire transaction is reverted. Consider a fictional scenario where two used bicycle accessories are created in a container, a **worn saddle,** and a **rusty handlebar**. For simplicity's sake, they have short unique identifiers and category identifiers.

::: zone pivot="csharp"

```csharp
Product saddle = new("0120", "Worn Saddle", "accessories-used");
Product handlebar = new("012A", "Rusty Handlebar", "accessories-used");
```

For this example, we also opted to use a public record definition.

```csharp
public record Product(string id, string name, string categoryId);
```

The **Microsoft.Azure.Cosmos.Container** class has a **CreateTransactionalBatch** member method that creates a new instance of type **TransactionalBatch** that supports the fluent syntax. This batch and the fluent **CreateItem** methods can be used to build a two-step transaction that inserts two items within the same partition key value.

```csharp
PartitionKey partitionKey = new ("accessories-used");
TransactionalBatch batch = container.CreateTransactionalBatch(partitionKey)
    .CreateItem<Product>(saddle)
    .CreateItem<Product>(handlebar);
```

To execute the batch, asynchronously invoke the **ExecuteAsync** method. Add a using statement to immediately ensure the object is disposed of correctly after the current application scope.

```csharp
using TransactionalBatchResponse response = await batch.ExecuteAsync();
```

The transactional batch supports operations with the **same logical partition key**. Operations with different logical partition keys fail. In the following example, the transactional batch fails with a bad request due to having a different logical partition key.

```csharp
Product saddle = new("0120", "Worn Saddle", "accessories-used");
Product handlebar = new("012C", "Pristine Handlebar", "accessories-new");
PartitionKey partitionKey = new ("accessories-used");
TransactionalBatch batch = container.CreateTransactionalBatch(partitionKey)
    .CreateItem<Product>(saddle)
    .CreateItem<Product>(handlebar);
```

Transactional batch also supports a wide variety of operations using the fluent syntax including, but not limited to:

| **Method** | **Description** |
| ---: | :--- |
| ``CreateItemStream()`` | Create item from existing stream |
| ``DeleteItem()`` | Delete an item  |
| ``ReadItem()`` | Read an item  |
| ``ReplaceItem()`` &amp; ``ReplaceItemStream()`` | Update an existing item or stream |
| ``UpsertItem()`` &amp; ``UpsertItemStream()`` | Create or update an existing item or stream based on the item's unique identifier |

::: zone-end

::: zone pivot="python"

```python
saddle = ("create", (
    {"id": "0120", "name": "Worn Saddle", "categoryId": "accessories-used"},
))
handlebar = ("create", (
    {"id": "012A", "name": "Rusty Handlebar", "categoryId": "accessories-used"},
))
```

Transactional Batch operations look similar to the singular operations APIs, and are tuples containing (`operation_type_string`, `args_tuple`, `batch_operation_kwargs_dictionary`), with the kwargs dictionary being optional.

The `operation_type_string` is a string that represents the operation type, such as "create", "upsert", "replace", "read", "patch", or "delete".

To execute the batch, use the `execute_item_batch` method of the container object. The first argument is a list of the operations to be executed in the batch. In our example, we have two operations to create items within the same partition key value.

```python
# Partition key
partition_key = "accessories-used"

batch = [
    saddle,
    handlebar
]

try:
    # Execute the batch
    batch_response = container.execute_item_batch(batch, partition_key=partition_key)

    # Check the response and print results
    for result in batch_response:
        print(result.get("resourceBody"))
except exceptions.CosmosHttpResponseError as e:
    print(f"Failed to execute batch: {e.message}")
```

The transactional batch supports operations with the **same logical partition key**. Operations with different logical partition keys fail. In the following example, the transactional batch fails with a bad request due to having a different logical partition key.

```python
partition_key = "accessories-used"

batch = [
    ("create", ({"id": "0120", "name": "Worn Saddle", "categoryId": "accessories-used"},)),
    ("create", ({"id": "012C", "name": "Pristine Handlebar", "categoryId": "accessories-new"},))
]
batch_response = container.execute_item_batch(batch, partition_key=partition_key)
```

::: zone-end

::: zone pivot="node"

```javascript
const saddle = { id: "0120", name: "Worn Saddle", categoryId: "accessories-used" };
const handlebar = { id: "012A", name: "Rusty Handlebar", categoryId: "accessories-used" };
```

The partition key value for both items is the same: **accessories-used**.

```javascript
const partitionKey = "accessories-used";
```

The JavaScript SDK provides the `BulkOperationType` enumeration to specify operations like `Create`. Create an array of objects that represent the operations to be executed in the batch.

```javascript
const { BulkOperationType } = require("@azure/cosmos");

const batch = [
    { operationType: BulkOperationType.Create, resourceBody: saddle },
    { operationType: BulkOperationType.Create, resourceBody: handlebar },
];
```

Use the `container.items.batch` method to execute the batch.

```javascript
const response = await container.items.batch(batch, partitionKey);
```

If all operations succeed, the response includes details of the committed transaction. If any operation fails, the entire transaction is rolled back.

The transactional batch supports operations with the **same logical partition key**. Operations with different logical partition keys fail. In the following example, the transactional batch fails with a bad request due to having a different logical partition key.

```javascript
const saddle = { id: "0120", name: "Worn Saddle", categoryId: "accessories-used" };
const handlebar = { id: "012C", name: "Pristine Handlebar", categoryId: "accessories-new" };

const partitionKey = "accessories-used";

const batch = [
    { operationType: BulkOperationType.Create, resourceBody: saddle },
    { operationType: BulkOperationType.Create, resourceBody: handlebar },
];
const response = await container.items.batch(batch, partitionKey);
```

::: zone-end
