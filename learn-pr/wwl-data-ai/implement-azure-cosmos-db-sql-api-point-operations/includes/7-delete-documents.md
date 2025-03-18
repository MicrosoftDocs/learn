Deleting a document is similar, in process, to reading an item. You need the id and the value of the partition key path.

::: zone pivot="csharp"

```csharp
string id = "027D0B9A-F9D9-4C96-8213-C8546C4AAE71";
string categoryId = "26C74104-40BC-4541-8EF5-9892F7F03D72";
PartitionKey partitionKey = new (categoryId);
```

Once you have both of those values, you invoke the asynchronous **DeleteItemAsync\<\>** method in a manner similar to the **ReadItemAsync\<\>** method.

```csharp
await container.DeleteItemAsync<Product>(id, partitionKey);
```

Azure Cosmos DB also supports deleting all documents contained within a single value for a partition key.

```csharp
string categoryId = "26C74104-40BC-4541-8EF5-9892F7F03D72";
PartitionKey partitionKey = new (categoryId);
```

With the partition key value, you invoke the asynchronous **DeleteAllItemsByPartitionKeyStreamAsync\<\>** method.

```csharp
await container.DeleteAllItemsByPartitionKeyStreamAsync<(partitionKey);
```

The delete by partition key feature is an asynchronous, background operation that allows you to delete all documents with the same logical partition key value, using the Cosmos SDK. The delete by partition key operation is constrained to consume at most 10% of the total available RU/s on the container each second. This helps in limiting the resources used by this background task.

> [!NOTE]
> The delete all items by partition key operation is disabled by default and requires special activation by Azure Support.

::: zone-end

::: zone pivot="python"

```python
item_id = "027D0B9A-F9D9-4C96-8213-C8546C4AAE71"
partition_key_value = "26C74104-40BC-4541-8EF5-9892F7F03D72"
```

Once you have these values, you invoke the **delete_item** method in a manner similar to the **read_item** method.

```python
container.delete_item(item=item_id, partition_key=partition_key_value)
```

Azure Cosmos DB also supports deleting all items contained within a single value for a partition key.

Store the partition key value in a variable:

```python
partition_key_value = "26C74104-40BC-4541-8EF5-9892F7F03D72"
```

With the partition key value, you invoke the **delete_all_items_by_partition_key** method.

```python
container.delete_all_items_by_partition_key(partition_key=partition_key_value)
```

The delete by partition key feature is an asynchronous, background operation that allows you to delete all documents with the same logical partition key value, using the Cosmos SDK. The delete by partition key operation is constrained to consume at most 10% of the total available RU/s on the container each second. This helps in limiting the resources used by this background task.

> [!NOTE]
> The delete all items by partition key operation is disabled by default and requires special activation by Azure Support.

::: zone-end

::: zone pivot="node"

```javascript
const itemId = "027D0B9A-F9D9-4C96-8213-C8546C4AAE71";
const partitionKeyValue = "26C74104-40BC-4541-8EF5-9892F7F03D72";
```

Once you have these values, you invoke the **delete** method in a manner similar to the **read** method.

```javascript
await container.item(itemId, partitionKeyValue).delete();
```

::: zone-end