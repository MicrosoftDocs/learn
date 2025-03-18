::: zone pivot="csharp"

The **CosmosClientOptions** class provides a range of options that you can configure for the client when it connects to an account. These options include, but aren't limited to:

- The mode used to connect to the account
- Custom consistency level used specifically for the client instance
- The preferred account region\[s\]

## Overriding default client options

When you connect to an Azure Cosmos DB account using the **CosmosClient** class, there are a few assumptions that the client makes:

- That you want to connect to the first writable (primary) region of your account
- That you use the default consistency level for the account with your read requests
- That you connect directly to data nodes for requests

> [!NOTE]
> There are other assumptions that aren't listed here. These assumptions can also be configured with the **CosmosClient** class.

To configure the client, you need to create an instance of the CosmosClientOptions class and pass it as the last parameter to the CosmosClient constructor. Using Microsoft Entra ID Managed Identity for authentication ensures secure access to Azure Cosmos DB without exposing secrets like connection strings or keys.

Here’s an example using Microsoft Entra Managed Identity:

```csharp
using Azure.Identity;
using Microsoft.Azure.Cosmos;

// Configure the account endpoint
string accountEndpoint = "https://<youraccountname>.documents.azure.com:443/";

// Use DefaultAzureCredential for Azure Entra Managed Identity authentication
DefaultAzureCredential credential = new DefaultAzureCredential();

// Initialize CosmosClient with endpoint and credential
CosmosClient client = new (accountEndpoint, credential);
```

### Changing the connection mode

Within the **CosmosClientOptions** class, you can set the **ConnectionMode** property to one of two possible enumerable values:

| **Value** | **Description** |
| --- | --- |
| **Gateway** | All requests are routed through the Azure Cosmos DB gateway as a proxy |
| **Direct** | The gateway is only used in initialization and to cache addresses for direct connectivity to data nodes |

The default setting is to use the **Direct** connection mode. This example configures the client to use the default settings.

```csharp
CosmosClientOptions options = new ()
{
    ConnectionMode = ConnectionMode.Direct
};
```

You can optionally configure the client to always use the gateway as a proxy for requests. This example configures the client to use the **Gateway** connection mode.

```csharp
CosmosClientOptions options = new ()
{
    ConnectionMode = ConnectionMode.Gateway
};
```

### Changing the current consistency level

Every Azure Cosmos DB for NoSQL account has a default consistency level configured. Individual clients can configure a different consistency level for all read requests made with the client. This example illustrates a client configured to use **eventual** consistency.

```csharp
CosmosClientOptions options = new ()
{
    ConsistencyLevel = ConsistencyLevel.Eventual
};
```

The **ConsistencyLevel** enumeration has multiple potential values including:

- Bounded Staleness
- ConsistentPrefix
- Eventual
- Session
- Strong

> [!TIP]
> The **ConsistencyLevel** setting is only used to only *weaken* the consistency level for reads. It can't be strengthened or applied to writes.

### Setting the preferred application region\[s\]

By default, the client uses the first writable region for requests. This region is typically referred to as the primary region. You can use either the **CosmosClientOptions.ApplicationRegion** or **CosmosClientOptions.ApplicationPreferredRegions** to override this behavior.

The **ApplicationRegion** property sets the single preferred region that the client connects to for operations. If the configured region is unavailable, the client defaults to the fallback priority list set on the account to determine the next region to use. In this example, the preferred region is configured to **West US**.

```csharp
CosmosClientOptions options = new ()
{
    ApplicationRegion = "westus"
};
```

> [!TIP]
> If your account isn't configured for multi-region write, the client always uses the single writable region for write operations and this setting only impacts read operations.

If you would like to create a custom failover/priority list for the client to use for operations, you can use the **ApplicationPreferredRegions** property with a list of regions. This example uses a custom list configured to try **West US** first and then **East US**.

```csharp
CosmosClientOptions options = new CosmosClientOptions()
{
    ApplicationPreferredRegions = new List<string> { "westus", "eastus" }
};
```

::: zone-end

::: zone pivot="python"

The **CosmosClient** class in the Python SDK provides several options that can be configured to customize the behavior of the client when connecting to an account. These options include, but aren't limited to:

- Custom consistency level used specifically for the client instance
- The preferred account region

## Overriding default client options

When a client connects to an Azure Cosmos DB account using the **CosmosClient** class, the following default assumptions are made:

- The client connects to the first writable (primary) region of your account.
- The client uses the default consistency level for read requests.
- The client uses the **Gateway** connection mode (Direct mode isn't available in the Python SDK).

> [!NOTE]
> Other assumptions exist and can be configured as needed. This section covers the most common configurations.

To customize these options, pass a configuration dictionary or keyword arguments to the **CosmosClient** constructor. The following examples show how to configure the client with different options.

### Changing the current consistency level

Every Azure Cosmos DB for NoSQL account has a default consistency level configured. The Python SDK allows you to configure a different consistency level for all read requests made with the client. This example configures a client to use **eventual** consistency.

```python
from azure.cosmos import CosmosClient, ConsistencyLevel

client = CosmosClient(
    url="https://dp420.documents.azure.com:443/",
    credential="fDR2ci9QgkdkvERTQ==",
    consistency_level=ConsistencyLevel.Eventual
)
```

The `ConsistencyLevel` class includes several options, such as:

- Bounded Staleness
- Consistent Prefix
- Eventual
- Session
- Strong

> [!TIP]
> The **consistency_level** setting can only be used to *weaken* the consistency level for reads. It can't be strengthened or applied to writes.

### Setting the preferred application region

By default, the client connects to the first writable region for operations. You can specify a preferred region by using the **preferred_locations** parameter. This example sets the preferred region to **West US**.

```python
client = CosmosClient(
    url="https://dp420.documents.azure.com:443/",
    credential="fDR2ci9QgkdkvERTQ==",
    preferred_locations=["West US"]
)
```

> [!TIP]
> If your account isn't configured for multi-region writes, the client always uses the single writable region for write operations, and this setting only impacts read operations.

You can also set multiple preferred regions for a custom failover/priority list. This example configures the client to try **West US** first and then **East US**.

```python
client = CosmosClient(
    url="https://dp420.documents.azure.com:443/",
    credential="fDR2ci9QgkdkvERTQ==",
    preferred_locations=["West US", "East US"]
)
```

## Other configuration options

While the Python SDK doesn't support setting the connection mode to **Direct**, it includes other configurable options for **CosmosClient**:

- **Retry policies**: Configure retry policies to handle transient failures.
- **Timeouts**: Set custom time-outs for client operations.
- **User agent**: Customize the user agent string for telemetry and tracking.

Example showing custom time out configuration:

```python
client = CosmosClient(
    url="https://dp420.documents.azure.com:443/",
    credential="fDR2ci9QgkdkvERTQ==",
    connection_timeout=10  # Sets a custom connection timeout of 10 seconds
)
```

::: zone-end

::: zone pivot="node"

The **CosmosClient** class in the JavaScript SDK provides several options that can be configured to customize the behavior of the client when connecting to an account. These options include, but aren't limited to:

- Custom consistency level used specifically for the client instance
- The preferred account region

## Overriding default client options

When a client connects to an Azure Cosmos DB account using the **CosmosClient** class, the following default assumptions are made:

- The client connects to the first writable (primary) region of your account.
- The client uses the default consistency level for read requests.
- The client uses the **Gateway** connection mode (Direct mode isn't available in the JavaScript SDK).

> [!NOTE]
> Other assumptions exist and can be configured as needed. This section covers the most common configurations.

To customize these options, pass a configuration object to the **CosmosClient** constructor. The following examples show how to configure the client with different options.

### Changing the current consistency level

Every Azure Cosmos DB for NoSQL account has a default consistency level configured. The JavaScript SDK allows you to configure a different consistency level for all read requests made with the client. This example configures a client to use **eventual** consistency.

```javascript
const { CosmosClient, ConsistencyLevel } = require("@azure/cosmos");

const client = new CosmosClient({
  endpoint: "https://dp420.documents.azure.com:443/",
  key: "fDR2ci9QgkdkvERTQ==",
  consistencyLevel: ConsistencyLevel.Eventual
});
```

The **CosmosClient** class contains an optional constructor that accepts both a connection string and a configuration object. To set the ``consistencyLevel`` property, you can use the following syntax:

```javascript
const { CosmosClient, ConsistencyLevel } = require("@azure/cosmos");

const client = new CosmosClient(
  "AccountEndpoint=https://dp420.documents.azure.com:443/;AccountKey=fDR2ci9QgkdkvERTQ==",
  {
    consistencyLevel: ConsistencyLevel.Eventual,
  }
);
```

The `consistencyLevel` property can be set to one of the following values:

- **Strong**
- **BoundedStaleness**
- **Session**
- **Eventual**
- **ConsistentPrefix**

> [!TIP]
> The **consistencyLevel** setting can only be used to *weaken* the consistency level for reads. It can't be strengthened or applied to writes.

### Setting the preferred application region

By default, the client connects to the first writable region for operations. You can specify a preferred region by using the **preferredLocations** property within the **connectionPolicy** property. This example sets the preferred region to **West US**.

```javascript
const client = new CosmosClient({
  endpoint: "https://dp420.documents.azure.com:443/",
  key: "fDR2ci9QgkdkvERTQ==",
  connectionPolicy: {
    preferredLocations: ["West US"]
  }
});
```

> [!TIP]
> If your account isn't configured for multi-region writes, the client always uses the single writable region for write operations, and this setting only impacts read operations.

You can also set multiple preferred regions for a custom failover/priority list. This example configures the client to try **West US** first and then **East US**.

```javascript
const client = new CosmosClient({
  endpoint: "https://dp420.documents.azure.com:443/",
  key: "fDR2ci9QgkdkvERTQ==",
  connectionPolicy: {
    preferredLocations: ["West US", "East US"]
  }
});
```

## Other configuration options

The JavaScript SDK includes other configurable options for **CosmosClient**:

- **Retry policies**: Configure retry policies to handle transient failures.
- **Timeouts**: Set custom time-outs for client operations.
- **User agent suffix**: Customize the user agent string for telemetry and tracking.

Example showing custom time out configuration on the request:

```javascript
const client = new CosmosClient({
  endpoint: "https://dp420.documents.azure.com:443/",
  key: "fDR2ci9QgkdkvERTQ==",
  connectionPolicy: {
    requestTimeout: 10000 // Sets a custom request timeout of 10 seconds (in milliseconds)
  }
});
```

::: zone-end
