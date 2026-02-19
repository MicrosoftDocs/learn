Azure Cosmos DB provides official SDKs for multiple programming languages that handle connection management, authentication, and request routing. AI applications interact with Cosmos DB through these SDKs to create, read, update, and delete items that store application data, user profiles, cached model outputs, and inference results. Understanding SDK patterns and best practices enables you to build efficient data access layers that minimize latency and optimize resource consumption.

## Connect using the SDK

The `CosmosClient` class serves as the entry point for all interactions with Azure Cosmos DB. The client manages connection pooling, request routing, and failover handling transparently. You provide the account endpoint and credentials when creating the client, and then use the client to access databases and containers.

Azure Cosmos DB offers SDKs for .NET, Python, JavaScript, Java, and Go. Each SDK follows similar patterns while providing language-idiomatic APIs. The Python SDK (`azure-cosmos`) integrates with the broader Azure SDK ecosystem, sharing authentication patterns with other Azure services. Regardless of which language you choose, the concepts remain consistent across SDKs.

Creating a client requires your account endpoint and authentication credentials. The endpoint follows the pattern `https://<account-name>.documents.azure.com:443/`. You can find this value in the Azure portal under your Cosmos DB account's overview page or keys section. The SDK uses this endpoint to route all requests to your specific account.

```python
from azure.cosmos import CosmosClient

# Code fragment - focus on client initialization
endpoint = "https://mycosmosaccount.documents.azure.com:443/"
key = "<your-account-key>"

client = CosmosClient(endpoint, credential=key)
```

## Choose an authentication method

Azure Cosmos DB supports two primary authentication approaches: account keys and Microsoft Entra ID (formerly Azure Active Directory). Your choice affects security posture, operational complexity, and compliance requirements. For production AI applications, Microsoft Entra ID authentication provides stronger security through identity-based access control.

Account keys are shared secrets that grant full access to all resources within an account. Cosmos DB provides both primary and secondary keys, allowing key rotation without downtime. While keys offer simplicity during development, they present security challenges in production: anyone with the key has complete access, and keys don't integrate with centralized identity management or conditional access policies.

Microsoft Entra ID authentication uses identity-based access control through role-based access control (RBAC). You assign roles to users, groups, service principals, or managed identities, granting specific permissions at the account, database, or container level. This approach integrates with Azure's security infrastructure, supporting features like conditional access, audit logging, and just-in-time access.

The `DefaultAzureCredential` class from the Azure Identity library simplifies Entra ID authentication by automatically selecting the appropriate credential based on the environment. During local development, it uses your Azure CLI login or Visual Studio credentials. In deployed environments, it uses managed identity. This single code path works across development and production without changes.

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

# Code fragment - focus on Entra ID authentication
endpoint = "https://mycosmosaccount.documents.azure.com:443/"
credential = DefaultAzureCredential()

client = CosmosClient(endpoint, credential=credential)
```

Before using Entra ID authentication, assign appropriate RBAC roles to your identity. The built-in roles include `Cosmos DB Built-in Data Reader` for read operations and `Cosmos DB Built-in Data Contributor` for read/write operations. You can assign roles using the Azure portal, Azure CLI, or infrastructure-as-code tools.

## Follow connection best practices

Reusing a single `CosmosClient` instance throughout your application lifecycle significantly improves performance and resource efficiency. The client maintains connection pools, caches routing information, and handles background operations like refreshing endpoints. Creating a new client for each request discards this cached state and adds latency for connection establishment.

For AI applications with high request volumes, connection reuse becomes critical. A recommendation engine processing thousands of requests per second benefits from the warmed connection pool of a singleton client. Conversely, creating clients per request adds connection overhead, increases latency variance, and might exhaust available connections.

In web frameworks, register the `CosmosClient` as a singleton or application-scoped service. In Python applications using frameworks like FastAPI or Flask, create the client during application startup and reuse it for all requests. Store references to frequently accessed database and container clients to avoid repeated lookups.

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

# Code fragment - focus on client reuse pattern
class CosmosService:
    def __init__(self, endpoint: str):
        credential = DefaultAzureCredential()
        self._client = CosmosClient(endpoint, credential=credential)
        self._database = self._client.get_database_client("aidata")
        self._products_container = self._database.get_container_client("products")

    @property
    def products(self):
        return self._products_container

# Create once at application startup
cosmos_service = CosmosService("https://myaccount.documents.azure.com:443/")
```

## Navigate the resource hierarchy

After creating a `CosmosClient`, you access databases and containers through client objects. The `get_database_client()` and `get_container_client()` methods return lightweight client objects that reference specific resources. These methods don't make network calls or verify that resources exist—they create handles for performing operations.

Database and container clients provide methods for resource management and data operations. Database clients can create, list, and delete containers. Container clients support item operations like create, read, update, delete, and query. The separation of concerns allows you to structure your code around specific resources rather than passing around the root client.

```python
# Code fragment - focus on navigating resource hierarchy
database = client.get_database_client("productcatalog")
products = database.get_container_client("products")
users = database.get_container_client("users")

# These operations use the container clients
item = products.read_item(item="product-123", partition_key="electronics")
```

The container client doesn't validate that the container exists when you create it. If you attempt an operation on a nonexistent container, the SDK raises an exception. For applications that create resources dynamically, you can use methods that handle both creation and existing resource scenarios.

## Create databases and containers

Before storing items, you need databases and containers to organize your data. The SDK provides methods for creating these resources programmatically, which proves useful for application setup scripts, testing environments, and multitenant AI applications that provision resources dynamically. You can choose between methods that fail on existing resources or methods that handle both creation and lookup scenarios gracefully.

The `create_database()` method creates a new database in your Cosmos DB account. This method fails with an exception if a database with the same ID already exists. Use this method when you expect the database to be new and want to catch accidental duplicates during provisioning.

```python
from azure.cosmos import CosmosClient
from azure.identity import DefaultAzureCredential

# Code fragment - focus on database creation
endpoint = "https://mycosmosaccount.documents.azure.com:443/"
client = CosmosClient(endpoint, credential=DefaultAzureCredential())

# Create a new database
database = client.create_database(id="productcatalog")
```

The `create_database_if_not_exists()` method provides a safer approach for most scenarios. It creates the database if it doesn't exist and returns the existing database if it does. This idempotent behavior simplifies application startup code where you want to ensure resources exist without failing on subsequent runs.

```python
# Code fragment - focus on idempotent database creation
database = client.create_database_if_not_exists(id="productcatalog")
print(f"Database ready: {database.id}")
```

Creating containers requires specifying a partition key, which determines how data distributes across physical partitions. The partition key path references a JSON property that exists in your items. Choose a partition key that provides even data distribution and aligns with your query patterns. For AI applications storing user-specific data, user ID or tenant ID often serves as an effective partition key.

```python
from azure.cosmos import PartitionKey

# Code fragment - focus on container creation with partition key
container = database.create_container(
    id="products",
    partition_key=PartitionKey(path="/categoryId"),
    offer_throughput=400
)
```

The `offer_throughput` parameter sets dedicated throughput in Request Units per second (RU/s) for the container. You can omit this parameter if the database uses shared throughput across containers. For production AI workloads with variable demand, consider using autoscale throughput instead.

```python
# Code fragment - focus on autoscale throughput
from azure.cosmos import ThroughputProperties

container = database.create_container_if_not_exists(
    id="inferencecache",
    partition_key=PartitionKey(path="/modelId"),
    offer_throughput=ThroughputProperties(auto_scale_max_throughput=4000)  # Autoscale: 400-4000 RU/s
)
```

The `create_container_if_not_exists()` method combines creation and lookup, making it ideal for application initialization. This method returns the existing container if it already exists, allowing your startup code to run repeatedly without errors.

```python
# Code fragment - focus on idempotent container creation
products_container = database.create_container_if_not_exists(
    id="products",
    partition_key=PartitionKey(path="/categoryId")
)

users_container = database.create_container_if_not_exists(
    id="users",
    partition_key=PartitionKey(path="/userId")
)

print(f"Containers ready: {products_container.id}, {users_container.id}")
```

## Create and update items

The SDK provides several methods for writing items to containers. Understanding when to use each method helps you implement efficient data access patterns and handle edge cases like duplicate items or concurrent updates.

The `create_item()` method inserts a new item into the container. It fails with a conflict error (HTTP 409) if an item with the same `id` and partition key already exists. Use this method when you expect the item to be new and want to catch accidental duplicates.

```python
# Code fragment - focus on create operation
from azure.cosmos import exceptions

product = {
    "id": "product-12345",
    "categoryId": "electronics",
    "name": "Smart Speaker",
    "price": 99.99,
    "features": ["voice-control", "wifi", "bluetooth"]
}

try:
    response = container.create_item(body=product)
    print(f"Created item: {response['id']}")
except exceptions.CosmosResourceExistsError:
    print("Item already exists")
```

The `upsert_item()` method inserts a new item or replaces an existing item with the same `id` and partition key. This method simplifies update logic when you don't care whether the item existed previously. AI applications commonly use upsert when caching model outputs or synchronizing data from external sources.

```python
# Code fragment - focus on upsert operation
product = {
    "id": "product-12345",
    "categoryId": "electronics",
    "name": "Smart Speaker Pro",
    "price": 129.99,
    "features": ["voice-control", "wifi", "bluetooth", "smart-home-hub"]
}

container.upsert_item(body=product)
print(f"Request charge: {container.client_connection.last_response_headers['x-ms-request-charge']} RUs")
```

The `replace_item()` method updates an existing item. Unlike upsert, replace requires the item to exist and fails if it doesn't. Replace also supports optimistic concurrency through the `etag` parameter. When you provide an etag, the operation succeeds only if the item's current etag matches, preventing lost updates from concurrent modifications.

```python
# Code fragment - focus on optimistic concurrency
from azure.cosmos import exceptions

item = container.read_item(item="product-12345", partition_key="electronics")

# Modify the item
item["price"] = 149.99

# Replace with etag check
try:
    container.replace_item(
        item=item["id"],
        body=item,
        if_match=item["_etag"]  # Optimistic concurrency
    )
except exceptions.CosmosAccessConditionFailedError:
    print("Item was modified by another process")
```

## Read items efficiently

Reading items from Azure Cosmos DB involves choosing between point reads and queries. Point reads retrieve a single item by its `id` and partition key with the lowest possible latency and RU cost. Queries retrieve multiple items based on filter criteria and offer flexibility at the cost of higher resource consumption.

Point reads using `read_item()` provide the most efficient way to retrieve a specific document. The operation routes directly to the correct partition and returns the item without query parsing or execution. For a 1-KB item, a point read typically costs approximately 1 RU—the minimum cost for any operation.

```python
# Code fragment - focus on point read efficiency
item = container.read_item(
    item="product-12345",
    partition_key="electronics"
)
print(f"Product name: {item['name']}")
```

Use point reads whenever you know the item's `id` and partition key. Common scenarios include fetching user profiles by user ID, retrieving cached inference results by request ID, or loading configuration documents by known identifiers. Design your data model to enable point reads for your most frequent access patterns.

If a point read fails because the item doesn't exist, the SDK raises `CosmosResourceNotFoundError`. Handle this exception to implement fallback logic, such as computing a value that wasn't cached or returning a default response.

## Delete items

The `delete_item()` method removes an item from the container. Like point reads, deletes require both the item `id` and partition key to route the operation correctly. Deleted items don't consume storage, but the delete operation itself consumes RUs.

```python
# Code fragment - focus on delete operation
from azure.cosmos import exceptions

try:
    container.delete_item(
        item="product-12345",
        partition_key="electronics"
    )
    print("Item deleted successfully")
except exceptions.CosmosResourceNotFoundError:
    print("Item not found")
```

## Handle response metadata

Every SDK operation returns metadata alongside the operation result. This metadata includes the RU charge, request latency, and system properties like etags. Monitoring these values helps you understand your application's resource consumption and identify optimization opportunities.

Access response headers by examining the response headers from the last SDK operation. The `x-ms-request-charge` header contains the RU cost for the operation. Track this value across operations to understand which patterns consume the most resources.

```python
# Code fragment - focus on response metadata
container.upsert_item(body=product)

# Access response headers
headers = container.client_connection.last_response_headers
request_charge = headers['x-ms-request-charge']
activity_id = headers['x-ms-activity-id']

print(f"RU charge: {request_charge}")
print(f"Activity ID: {activity_id}")  # Useful for support requests
```

The activity ID uniquely identifies each request and proves invaluable when working with Azure support to diagnose issues. Log activity IDs alongside errors or unusually high RU charges to enable troubleshooting.

## Additional resources

- [Azure Cosmos DB SDK for Python](/python/api/overview/azure/cosmos-readme)
- [Best practices for Azure Cosmos DB Python SDK](/azure/cosmos-db/nosql/best-practice-python)
- [Use Azure AD for authentication with Azure Cosmos DB](/azure/cosmos-db/how-to-setup-rbac)
