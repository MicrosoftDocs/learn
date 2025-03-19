We can also modify the properties of the **saddle** variable.

In this example, we change the price of the variable from the original **\$27.12** to **\$35.00**.

::: zone pivot="csharp"

```csharp
saddle.price = 35.00d;
```

To persist this change, we can invoke the asynchronous **ReplaceItemAsync<>** method passing in only the update item.

```csharp
await container.ReplaceItemAsync<Product>(saddle);
```

We can also continue to make new changes. In this example, we replace the array of tags with a new array of tags with more accurate descriptions of the saddle.

```csharp
saddle.tags = new string[] { "brown", "new", "crisp" };
```

Even though we updated the document already, we don't have to read a new item before updating the item again.

```csharp
await container.ReplaceItemAsync<Product>(saddle);
```

::: zone-end

::: zone pivot="python"

```python
saddle["price"] = 35.00
```

To persist this change, use the **replace_item** method, passing in the updated item.

```python
response = container.replace_item(item=saddle, body=saddle)
```

We can continue making updates to the item without needing to reread it. For instance, we can replace the tags array with a new array containing more accurate descriptions of the product.

```python
saddle["tags"] = ["brown", "new", "crisp"]
```

Even though we updated the document already, we don't have to read a new item before updating the item again.

```python
response = container.replace_item(item=saddle, body=saddle)
```

::: zone-end

::: zone pivot="node"

```javascript
saddle.price = 35.00;
```

To persist this change, use the **replace** method, passing in the updated item.

```javascript
await container.item(saddle.id, saddle.categoryId).replace(saddle);
```

We can continue making updates to the item without needing to reread it. For instance, we can replace the tags array with a new array containing more accurate descriptions of the product.

```javascript
item.tags = ["brown", "new", "crisp"];
```

Even though we updated the document already, we don't have to read a new item before updating the item again.

```javascript
await container.item(saddle.id, saddle.categoryId).replace(saddle);
```

::: zone-end

> [!NOTE]
> Cosmos DB supports **optimistic concurrency** to check if an item updated since the last read and return a conflict error if it has. Details on how to use this concurrency level are in the SDK documentation.
