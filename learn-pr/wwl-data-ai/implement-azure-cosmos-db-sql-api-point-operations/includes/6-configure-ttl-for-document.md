To implement time-to-live (TTL) on an individual item, you can use the same strategy as you use to upsert an item.

First, let’s take a look at the **Product** class. We can define a new **TimeToLive** property that will only set the ttl property on the JSON if it’s not null. This technique is accomplished by configuring the JsonProperty header to ignore null values and configuring the member as a nullable int.

```csharp
[JsonProperty(PropertyName = "ttl", NullValueHandling = NullValueHandling.Ignore)]
public int? ttl { get; set; }
```

From there, you can update the **saddle** variable by setting the **TimeToLive** value to an integer to indicate how long, in seconds, you want the item to last before it’s automatically purged beyond its last modified time.

```csharp
saddle.ttl = 1000;
```

Update the item using the **UpsertItemAsync<>** method.

```csharp
await container.UpsertItemAsync<Product>(saddle);
```

> [!NOTE]
> Remember, this will not work if the **DefaultTimeToLive** property is not configured at the container level.
