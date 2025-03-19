The Azure Cosmos DB SDK allows you to configure Time-to-Live (TTL) on individual items in a container. TTL ensures that items are automatically deleted after a specified duration. To implement time-to-live (TTL) on an individual item, you can use the same strategy as you use to update an item.

::: zone pivot="csharp"

First, let’s take a look at the **Product** class. We can define a new **TimeToLive** property that only sets the ttl property on the JSON if it’s not null. This technique is accomplished by configuring the JsonProperty header to ignore null values and configuring the member as a nullable int.

```csharp
[JsonProperty(PropertyName = "ttl", NullValueHandling = NullValueHandling.Ignore)]
public int? ttl { get; set; }
```

From there, you can update the **saddle** variable by setting the **TimeToLive** value to an integer to indicate how long, in seconds, you want the item to last before it automatically is purged beyond its last modified time.

```csharp
saddle.ttl = 1000;
```

Update the item using the **ReplaceItemAsync<>** method.

```csharp
await container.ReplaceItemAsync<Product>(saddle);
```

::: zone-end

::: zone pivot="python"

The Python SDK allows you to dynamically set a new property value on an item. To set the **TimeToLive** value on an item, assign an integer to indicate how long, in seconds, you want the item to last before it automatically is purged beyond its last modified time. You do this change by updating the item object with a new **ttl** property value.

```python
saddle["ttl"] = 1000
```

Update the item using the **replace_item** method.

```python
container.replace_item(item=saddle, body=saddle)
```

However, as you recall, we defined a **Product** class to represent our items. We can define a new **TimeToLive** property that only sets the ttl property on the JSON if it’s not null. This technique is accomplished by configuring the member as a nullable int.

```python
class Product:
    def __init__(
            self,
            internal_id: str,
            name: str,
            category_id: str,
            price: float,
            tags: list[str],
            ttl: int = None):
        self.internal_id = internal_id
        self.name = name
        self.category_id = category_id  # Partition key
        self.price = price
        self.tags = tags
        self.ttl = ttl # Time to live

    def to_dict(self):
        product_dict = {
            "id": self.internal_id,  # Map internal_id to id
            "name": self.name,
            "categoryId": self.category_id,
            "price": self.price,
            "tags": self.tags
        }
        if self.ttl is not None:
            product_dict["ttl"] = self.ttl
        return product_dict
```

To work with this class after adding the **ttl** property, we can instantiate a new **Product** object and set the property value.

```python
# Perform the point read
saddle = container.read_item(item=item_id, partition_key=partition_key_value)

# Convert the response to a Product object
product = Product(
    internal_id=saddle["id"],
    name=saddle["name"],
    category_id=saddle["categoryId"],
    price=saddle["price"],
    tags=saddle["tags"],
    # Add the TTL value here if it exists
    ttl=saddle.get("ttl")
)

# Set the TTL property (in seconds)
product.ttl = 1000

# Update the item in Cosmos DB
container.replace_item(item=item_id, body=product.to_dict())
```

We use the `to_dict()` method to convert the **Product** object back to a dictionary and update the item. As you may recall, we use this method instead of the `__dict__` attribute to ensure that the **internal_id** property is properly mapped to the **id** property on the JSON object.

> [!NOTE]
> The `get("ttl")` method is used to retrieve the value of the **ttl** property from the **saddle** object. If the property doesn't exist, the method returns `None`. This value is then passed to the **Product** object when instantiated.

::: zone-end

::: zone pivot="node"

The JavaScript SDK allows you to dynamically set a new property value on an item. To set the **TimeToLive** value on an item, assign an integer to indicate how long, in seconds, you want the item to last before it automatically is purged beyond its last modified time. You do this change by updating the item object with a new **ttl** property value.

```javascript
saddle.ttl = 1000;
```

Update the item using the **replace** method.

```javascript
await container.item(saddle.id, saddle.categoryId).replace(saddle);
```

However, as you recall, we defined a **Product** class to represent our items. We can define a new **TimeToLive** property that only sets the ttl property on the JSON if it’s not null. This technique is accomplished by configuring the member as a nullable int.

```javascript
class Product {
    constructor(internalId, name, categoryId, price, tags, ttl=null) {
        this.internalId = internalId;
        this.name = name;
        this.categoryId = categoryId; // Partition key
        this.price = price;
        this.tags = tags;
        this.ttl = ttl; // Optional time-to-live
    }

    toJSON() {
        const json = {
            id: this.internalId, // Map internalId to id
            name: this.name,
            categoryId: this.categoryId,
            price: this.price,
            tags: this.tags
        };
        if (this.ttl !== null) {
            json.ttl = this.ttl;
        }
        return json;
    }
}
```

To work with this class after adding the **ttl** property, we can instantiate a new **Product** object and set the property value.

```javascript
// Perform the point read
const { resource: saddle } = await container.item(itemId, partitionKeyValue).read();

const product = new Product(
    saddle.id,
    saddle.name,
    saddle.categoryId,
    saddle.price,
    saddle.tags,
    saddle.ttl // Include the TTL value if it exists
);

// Set the TTL property (in seconds)
product.ttl = 1500;

// Update the item in Cosmos DB
await container.item(product.internalId, product.categoryId).replace(product.toJSON());
```

We use the `toJSON()` method to convert the **Product** object back to a dictionary and update the item. As you may recall, we use this method instead relying on standard JSON serialization to ensure that the **internalId** property is properly mapped to the **id** property on the JSON object.

::: zone-end

> [!NOTE]
> Remember, this process doesn't work if the **DefaultTimeToLive** property isn't configured at the container level. Also, a `ttl` value of `-1` disables TTL for the item.
