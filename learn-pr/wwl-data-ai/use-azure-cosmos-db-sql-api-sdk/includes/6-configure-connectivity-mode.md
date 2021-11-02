The **CosmosClientOptions** class provides a range of options that you can configure for the client when it connects to an account. These options include, but are not limited to:

- The mode used to connect to the account
- Custom consistency level used specifically for the client instance
- The preferred account region\[s\]

## Overriding default client options

When connecting to an Azure Cosmos DB account using the **CosmosClient** class, there are a few assumptions that the client makes:

- That you will want to connect to the first writable (primary) region of your account
- That you will use the default consistency level for the account with your read requests
- That you will connect directly to data nodes for requests

> &#128221; There are other assumptions that are not listed here. These assumptions can also be configured with the **CosmosClient** class.

To configure the client, you will need to create an instance of the **CosmosClientOptions** class and pass in that instance as the last parameter to the **CosmosClient** constructor. Here are two examples using the constructors discussed earlier in this module.

You can either use the constructor that takes in an endpoint and key:

:::code language="csharp" source="../media/6-script.cs" range="26-28" highlight="3":::

Or, use the constructor that takes in a connection string:

:::code language="csharp" source="../media/6-script.cs" range="26-27,30" highlight="3":::

### Changing the connection mode

Within the **CosmosClientOptions** class, you can set the **ConnectionMode** property to one of two possible enumerable values:

| **Value** | **Description** |
| --- | --- |
| **Gateway** | All requests are routed through the Azure Cosmos DB gateway as a proxy |
| **Direct** | The gateway is only used in initialization and to and cache addresses for direct connectivity to data nodes |

The default setting is to use the **Direct** connection mode. This example configures the client to use the default settings.

:::code language="csharp" source="../media/6-script.cs" range="1-4" highlight="3":::

You can optionally configure the client to always use the gateway as a proxy for requests. This example configures the client to use the **Gateway** connection mode.

:::code language="csharp" source="../media/6-script.cs" range="6-9" highlight="3":::

### Changing the current consistency level

Every Azure Cosmos DB SQL API account has a default consistency level configured. Individual clients can configure a different consistency level for all read requests made with the client. This example illustrates a client configured to use **eventual** consistency.

:::code language="csharp" source="../media/6-script.cs" range="11-14" highlight="3":::

The **ConsistencyLevel** enumeration has multiple potential values including:

- Bounded Staleness
- ConsistentPrefix
- Eventual
- Session
- Strong

> &#128161; The **ConsistencyLevel** setting is only used to only *weaken* the consistency level for reads. It cannot be strengthened or applied to writes.

### Setting the preferred application region\[s\]

By default, the client will use the first writable region for requests. This is typically referred to as the primary region. You can use either the **CosmosClientOptions.ApplicationRegion** or **CosmosClientOptions.ApplicationPreferredRegions** to override this behavior.

The **ApplicationRegion** property sets the single preferred region that the client will connect to for operations. It the configured region is unavailable, the client will default to the fallback priority list set on the account to determine the next region to use. In this example, the preferred region is configured to **West US**.

:::code language="csharp" source="../media/6-script.cs" range="16-19" highlight="3":::

> &#128161; If your account is not configured for multi-region write, the client will always use the single writable region for write operations and this setting will only impact read operations.

If you would like to create a custom failover/priority list for the client to use for operations, you can use the **ApplicationPreferredRegions** property with a list of regions. This example uses a custom list configured to try **West US** first and then **East US**.

:::code language="csharp" source="../media/6-script.cs" range="21-24" highlight="3":::
