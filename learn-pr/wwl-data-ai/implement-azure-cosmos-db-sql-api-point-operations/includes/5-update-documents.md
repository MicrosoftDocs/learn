We can also modify the properties of the **saddle** variable.

In this example, we change the price of the variable from the original **\$27.12** to **\$35.00**.

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

Even though we updated the document already, we don’t have to read a new item before updating the item again.

```csharp
await container.ReplaceItemAsync<Product>(saddle);
```

> [!NOTE]
> Cosmos DB supports **optimistic concurrency** to check if an item has been updated since the last read and return a conflict error if it has. Details on how to use this are within the SDK documentation.
