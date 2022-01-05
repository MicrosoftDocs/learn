We can also modify the properties of the **saddle** variable.

In this example, we change the price of the variable from the original **\$27.12** to **\$35.00**.

```csharp
saddle.price = 35.00d;
```

To persist this change, we can invoke the asynchronous **UpsertItemAsync<>** method passing in only the update item.

```csharp
await container.UpsertItemAsync<Product>(saddle);
```

We can also continue to make new changes. In this example, we replace the array of tags with a new array of tags with more accurate descriptions of the saddle.

```csharp
saddle.tags = new string[] { "brown", "new", "crisp" };
```

Even though we upserted the document already, we don’t have to read a new item before upserting the item again.

```csharp
await container.UpsertItemAsync<Product>(saddle);
```
