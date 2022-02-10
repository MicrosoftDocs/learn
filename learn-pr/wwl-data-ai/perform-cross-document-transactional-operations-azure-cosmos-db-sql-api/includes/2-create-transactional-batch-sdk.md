Consider a fictional scenario where two used bicycle accessories will be created in a container, a **worn saddle,** and a **rusty handlebar**. For simplicity's sake, they have short unique identifiers and category identifiers.

```csharp
Product saddle = new("0120", "Worn Saddle", "accessories-used");
Product handlebar = new("012A", "Rusty Handlebar", "accessories-used");
```

For this example, we have also opted to use a public record definition.

```csharp
public record Product(string id, string name, string categoryId);
```

The **Microsoft.Azure.Cosmos.Container** class has a **CreateTransactionalBatch** member method that will create a new instance of type **TransactionalBatch** that supports the fluent syntax. This batch and the fluent **CreateItem** methods can be used to build a two-step transaction that inserts two items within the same partition key value.

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

The transactional batch supports operations with the **same logical partition key**. Operations with different logical partition keys will fail. In the example below, the transactional batch will fail with a bad request due to having a different logical partition key.

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
