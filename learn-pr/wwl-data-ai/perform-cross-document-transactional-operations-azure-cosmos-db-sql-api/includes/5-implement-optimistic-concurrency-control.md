Using the SDK to read an item and then update the same item in a subsequent operation carries some inherent risk. Another operation could potentially come in from a separate client and change the underlying document before the first client’s update operation is finalized. This conflict could create a "lost update" situation. Let’s illustrate this conflict with an example.

::: zone pivot="csharp"

Here's a typical C# code example with a separate read and update operation.

```csharp
string categoryId = "9603ca6c-9e28-4a02-9194-51cdb7fea816";
PartitionKey partitionKey = new (categoryId);

Product product = await container.ReadItemAsync<Product>("01AC0", partitionKey);

product.price = 50d;

await container.UpsertItemAsync<Product>(product, partitionKey);
```

Since read and write in this example are distinct operations, there's a latency between these operations. This latency is represented in this diagram as *n*.

![Diagram of the N latency between read and update.](../media/5-latency.png)

This latency can be as short as milliseconds or seconds in computer code but could still be catastrophic enough to lose potential updates. Some user-facing applications, where user input causes a longer latency between a read and update operation, can cause a longer *n* value and a higher potential for lost updates. This issue can be resolved by implementing **optimistic concurrency control**.

```csharp
ItemResponse<Product> response = await container.ReadItemAsync<Product>("01AC0", partitionKey);
```

Each item has an **ETag** value. This value is updated when the item is updated. You can retrieve the ETag value of the item by observing the response from the *read* operation of your request.

The **ItemResponse** class has an **ETag** property that contains the corresponding string value.

```csharp
Product product = response.Resource;
string eTag = response.ETag;
```

To prevent lost updates, you can use the **if-match** rule to see if the **ETag** still matches the current ETag header of the item server-side as part of your update request.

```csharp
ItemRequestOptions options = new ItemRequestOptions { IfMatchEtag = eTag };
await container.UpsertItemAsync<Product>(product, partitionKey, requestOptions: options);
```

If the **ETag** value doesn't match the current ETag header of the item server-side, the operation fails, and you need to re-read the item to get the latest version of the item before trying to update it again. The failure code is **412 Precondition Failed**.

The updates to the C\# code only required minor changes to implement optimistic concurrency control to ensure that your update operations didn't lose changes previously saved server-side by competing clients.

```csharp
string categoryId = "9603ca6c-9e28-4a02-9194-51cdb7fea816";
PartitionKey partitionKey = new (categoryId);

ItemResponse<Product> response = await container.ReadItemAsync<Product>("01AC0", partitionKey);
Product product = response.Resource;
string eTag = response.ETag;

product.price = 50d;

ItemRequestOptions options = new ItemRequestOptions { IfMatchEtag = eTag };
await container.UpsertItemAsync<Product>(product, partitionKey, requestOptions: options);
```

::: zone-end

::: zone pivot="python"

Here's a typical Python code example with a separate read and update operation.

```python
item_id = "01AC0"
partition_key = "9603ca6c-9e28-4a02-9194-51cdb7fea816"

# Read the item
item_response = container.read_item(item=item_id, partition_key=partition_key)
product = item_response

# Update the product price
product["price"] = 50.0

# Upsert the item back to the container
container.upsert_item(body=product)
```

Since read and write in this example are distinct operations, there's a latency between these operations. This latency is represented in this diagram as *n*.

![Diagram of the N latency between read and update.](../media/5-latency.png)

This latency can be as short as milliseconds or seconds in computer code but could still be catastrophic enough to lose potential updates. Some user-facing applications, where user input causes a longer latency between a read and update operation, can cause a longer *n* value and a higher potential for lost updates. This issue can be resolved by implementing **optimistic concurrency control**.

```python
item_response = container.read_item(item=item_id, partition_key=partition_key)
product = item_response
```

Each item has an **ETag** value. This value is updated when the item is updated. You can retrieve the ETag value of the item by observing the headers from the *read* operation.

There are two ways you can access the ETag value of the item. One way is to use the **get_response_headers** method. With this method, the ETag value is named **etag**.

```python
headers = item_response.get_response_headers()
etag = headers.get("etag")
```

Another way is to use the **get** method on the item response. With this method, the ETag value is named **_etag**.

```python
etag = item_response.get("_etag")
```

To prevent lost updates, you can use the **if-match** condition to see if the **ETag** still matches the current ETag header of the item server-side as part of your update request.

```python
headers = {"If-Match": etag}
container.upsert_item(body=product, headers=headers)
```

If the **ETag** value doesn't match the current ETag header of the item server-side, the operation fails, and you need to re-read the item to get the latest version of the item before trying to update it again. The failure code is **412 Precondition Failed**.

The updates to the Python code only required minor changes to implement optimistic concurrency control to ensure that your update operations didn't lose changes previously saved server-side by competing clients.

```python
item_id = "01AC0"
partition_key = "9603ca6c-9e28-4a02-9194-51cdb7fea816"

# Read the item
item_response = container.read_item(item=item_id, partition_key=partition_key)
product = item_response
etag = item_response.get("_etag")

# Update the product price
product["price"] = 50.0

# Use optimistic concurrency control
headers = {"If-Match": etag}
container.upsert_item(body=product, headers=headers)
```

::: zone-end

::: zone pivot="node"

Here's a typical JavaScript code example with a separate read and update operation.

```javascript
const categoryId = "9603ca6c-9e28-4a02-9194-51cdb7fea816";
const itemId = "01AC0";

// Read the item
const { resource: product } = await container.item(itemId, categoryId).read();

// Update the price
product.price = 50.0;

// Upsert the updated item
await container.items.upsert(product);
```

Since read and write in this example are distinct operations, there's a latency between these operations. This latency is represented in this diagram as *n*.

![Diagram of the N latency between read and update.](../media/5-latency.png)

This latency can be as short as milliseconds or seconds in computer code but could still be catastrophic enough to lose potential updates. Some user-facing applications, where user input causes a longer latency between a read and update operation, can cause a longer *n* value and a higher potential for lost updates. This issue can be resolved by implementing **optimistic concurrency control**.

Each item has an **ETag** value. This value is updated when the item is updated. You can retrieve the ETag value of the item by observing the response headers from the *read* operation.

```javascript
const { resource: product, headers } = await container.item(itemId, categoryId).read();
const eTag = headers.etag;
```

To prevent lost updates, you can use the **if-match** rule to see if the **ETag** still matches the current ETag header of the item server-side as part of your update request.

```javascript
// Update the product
product.price = 50.0;

// Use the if-match header for optimistic concurrency control
await container.items.upsert(product, {
  accessCondition: { type: "IfMatch", condition: eTag }
});
```

If the **ETag** value doesn't match the current ETag header of the item server-side, the operation fails, and you need to re-read the item to get the latest version of the item before trying to update it again. The failure code is **412 Precondition Failed**.

The updates to the JavaScript code only required minor changes to implement optimistic concurrency control to ensure that your update operations didn't lose changes previously saved server-side by competing clients.

```javascript
const categoryId = "9603ca6c-9e28-4a02-9194-51cdb7fea816";
const itemId = "01AC0";

// Read the item
const { resource: product, headers } = await container.item(itemId, categoryId).read();
const eTag = headers.etag;

// Update the product
product.price = 50.0;

// Use the if-match header for optimistic concurrency control
await container.items.upsert(product, {
  accessCondition: { type: "IfMatch", condition: eTag }
});
```

::: zone-end
