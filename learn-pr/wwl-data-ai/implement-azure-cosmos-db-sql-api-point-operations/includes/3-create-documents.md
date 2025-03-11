::: zone pivot="csharp"

To create a new item, we must first create a new variable in C# code of the **Product** type.

```csharp
Product saddle = new()
{
    id = "027D0B9A-F9D9-4C96-8213-C8546C4AAE71",
    categoryId = "26C74104-40BC-4541-8EF5-9892F7F03D72",
    name = "LL Road Seat/Saddle",
    price = 27.12d,
    tags = new string[] 
    {
        "brown",
        "weathered"
    }
};
```

Let's infer there's already a variable of type Microsoft.Azure.Cosmos.**Container** named **container**.

We can asynchronously invoke the **CreateItemAsync\<\>** method passing in the Product type and the new item variable into the constructor.

```csharp
await container.CreateItemAsync<Product>(saddle);
```

This invocation of the method creates the new item, but doesn't have any metadata about the result of the operation. Alternatively, you can store the result of the operation in a variable of type **ItemResponse\<\>**.

```csharp
ItemResponse<Product> response = await container.CreateItemAsync<Product>(saddle);

HttpStatusCode status = response.StatusCode;
double requestUnits = response.RequestCharge;

Product item = response.Resource;
```

If you're using a try-catch block, you can handle the **CosmosException** type, which includes a **StatusCode** property for HTTP status code values. There are a few common HTTP status codes that you should consider in your application code:

| Code | Title | Reason |
| :---: | :--- | :--- |
| 400 | Bad Request | Something was wrong with the item in the body of the request |
| 403 | Forbidden | Container was likely full |
| 409 | Conflict | Item in container likely already had a matching id |
| 413 | RequestEntityTooLarge | Item exceeds max entity size |
| 429 | TooManyRequests | Current request exceeds the maximum RU/s provisioned for the container |

In the following example, we handle a conflict scenario where the item already exists in the container and fall back to a general exception handling block for other scenarios:

```csharp
try
{
    await container.CreateItemAsync<Product>(saddle);
}
catch(CosmosException ex) when (ex.StatusCode == HttpStatusCode.Conflict)
{
    // Add logic to handle conflicting ids
}
catch(CosmosException ex) 
{
    // Add general exception handling logic
}
```

::: zone-end

::: zone pivot="python"

To create a new item in an Azure Cosmos DB container, you first need to create an instance of your item model. In Python, this process can be achieved by defining an instance of the **Product** class.

```python
saddle = Product(
        internal_id="2a7816bf-9a3c-4f33-b7d7-84efb3923538",
        name="Road Warrior Saddle",
        category_id="26C74104-40BC-4541-8EF5-9892F7F03D72",
        price=65.15,
        tags=["black", "cushioned", "leather"]
    ).to_dict()
```

Recall that the **Product** class has a `to_dict` method that converts the instance to a dictionary. This class also maps the `internal_id` property to the `id` property, which Azure Cosmos DB requires.

Let’s assume there’s already a variable of type `azure.cosmos.Container` named **container**.

You can use the **create_item** method to create a new item in the container.

```python
container.create_item(body=saddle)
```

This invocation of the method creates the new item, but it doesn't provide metadata about the result of the operation. Alternatively, you can capture the response of the operation in a variable. The `get_response_headers()` method retrieves metadata about the operation, such as the request charge and the ETag value of the created item, which allows for optimistic concurrency scenarios.

```python
response = container.create_item(body=saddle)
# Get response headers
headers = response.get_response_headers()

# Retrieve the created item
item = response

# Extract metadata from headers
request_charge = headers.get('x-ms-request-charge')
etag = headers.get('etag')

# Output the metadata
print(f"Request Charge: {request_charge}")
print(f"etag: {etag}")

print(f"Item created: {item}")
```

- `x-ms-request-charge`: The request units (RUs) consumed by the operation.
- `etag`: A unique value that represents the version of the item.

## Handling Exceptions

The Python SDK raises exceptions for various scenarios. You can handle these exceptions using a `try-except` block. The **CosmosHttpResponseError** exception includes useful information such as the HTTP status code. Some common HTTP status codes you might encounter include:

| Code | Title | Reason |
| :---: | :--- | :--- |
| 400 | Bad Request | Something was wrong with the item in the body of the request |
| 403 | Forbidden | Container was likely full |
| 409 | Conflict | Item in container likely already had a matching id |
| 413 | RequestEntityTooLarge | Item exceeds max entity size |
| 429 | TooManyRequests | Current request exceeds the maximum RU/s provisioned for the container |

Here’s an example of handling these exceptions:

```python
from azure.cosmos.exceptions import CosmosHttpResponseError

try:
    container.create_item(body=saddle)
except CosmosHttpResponseError as ex:
    if ex.status_code == 409:  # Conflict
        print("Conflict: Item with the same id already exists.")
    elif ex.status_code == 429:  # Too Many Requests
        print("Too many requests: Reduce request rate or increase RU/s provisioned.")
    elif ex.status_code == 400:  # Bad Request
        print("Bad request: Check the structure of the item being sent.")
    else:
        print(f"HTTP error occurred: Status code {ex.status_code}, message: {ex.message}")
except Exception as ex:
    print(f"An unexpected error occurred: {ex}")
```

::: zone-end

::: zone pivot="node"

To create a new item, you first need to define an object that represents your data.

## Define the Item

Define the item in JavaScript as an object with all the necessary properties. For example, here's how you can define a product item:

```javascript
const saddle = new Product(
    "027D0B9A-F9D9-4C96-8213-C8546C4AAE72", // internalId
    "LL Road Seat/Saddle", // name
    "26C74104-40BC-4541-8EF5-9892F7F03D72", // categoryId
    27.12, // price
    ["brown", "weathered"] // tags
);
```

This object has the following properties:

- `internalId`: A unique identifier for the item.
- `categoryId`: A property that matches the partition key path of the container.
- Other properties, such as `name`, `price`, and `tags`, that describe the item.

Recall that the **Product** class has a `toJSON()` method that converts the object to a JSON string. This class also maps the `internalId` property to the `id` property, which Azure Cosmos DB requires.

## Create the Item

Assume there's already a variable of type `Container` named **container**. You can use the **items.create** method to create the item.

```javascript
const { resource: item } = await container.items.create(saddle);
```

This method sends a request to create the item in the Azure Cosmos DB container.

## Retrieve Metadata

The response from the `items.create` method includes headers that provide useful metadata about the operation, such as the request charge and the ETag value, which allows for optimistic concurrency scenarios.

```javascript
const { resource: item, headers } = await container.items.create(saddle);

const requestCharge = headers["x-ms-request-charge"];
const etag = headers.etag;

console.log(`Request Charge: ${requestCharge}`);
console.log(`etag: ${etag}`);
console.log("Item created:", item);
```

- `x-ms-request-charge`: The request units (RUs) consumed by the operation.
- `etag`: A unique value that represents the version of the item.

## Handle Errors

When you're creating an item, errors might occur, such as conflicts or invalid requests. Use a `try-catch` block to handle these errors. Some common HTTP status codes you might encounter include:

| Code | Title | Reason |
| :---: | :--- | :--- |
| 400 | Bad Request | Something was wrong with the item in the body of the request |
| 403 | Forbidden | Container was likely full |
| 409 | Conflict | Item in container likely already had a matching id |
| 413 | RequestEntityTooLarge | Item exceeds max entity size |
| 429 | TooManyRequests | Current request exceeds the maximum RU/s provisioned for the container |

```javascript
try {
    const { resource: item, headers } = await container.items.create(saddle);
    console.log("Item created:", item);
} catch (error) {
    if (error.code === 409) {
        console.log(`Conflict: Item with the same id (${saddle.id}) already exists.`);
    } else if (error.code === 429) {
        console.log("Too many requests: Reduce request rate or increase RU/s provisioned.");
    } else if (error.code === 400) {
        console.log("Bad request: Check the structure of the item being sent.");
    } else {
        console.log(`An unexpected error occurred: ${error.message}`);
    }
}
```

::: zone-end

This implementation ensures that you can create items, retrieve metadata for diagnostics, and handle errors gracefully.
