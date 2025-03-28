Microsoft offers SDKs (Software Development Kits) for Azure Cosmos DB for NoSQL in various programming languages. In this module, we focus on the .NET SDK (C#), Python SDK, and JavaScript SDK (Node.js) for Azure Cosmos DB for NoSQL. Select the tab that corresponds to the SDK you want to explore.

::: zone pivot="csharp"

The **Microsoft.Azure.Cosmos** library is the latest version of the .NET SDK for Azure Cosmos DB for NoSQL.

The library is open-source and hosted online on GitHub at **azure/azure-cosmos-dotnet-v3**. The open-source project conforms to the Microsoft Open Source Code of Conduct and accepts contributions and suggestions from the community.

The Microsoft.Azure.Cosmos library includes a namespace of the same name with common classes that you explore later in this module including, but not limited to:

| **Class** | **Description** |
| --- | --- |
| Microsoft.Azure.Cosmos.**CosmosClient** | Client-side logical representation of an Azure Cosmos DB account and the primary class used for the SDK |
| Microsoft.Azure.Cosmos.**Database** | Logically represents a database client-side and includes common operations for database management |
| Microsoft.Azure.Cosmos.**Container** | Logically represents a container client-side and includes common operations for container management |

::: zone-end

::: zone pivot="python"

The **azure-cosmos** library is the latest version of the Python SDK for Azure Cosmos DB for NoSQL.

The library is open-source and hosted online on GitHub at **Azure/azure-sdk-for-python**. The open-source project conforms to the Microsoft Open Source Code of Conduct and accepts contributions and suggestions from the community.

The Azure-cosmos library includes a namespace of the same name with common classes that you explore later in this module including, but not limited to:

| **Class** | **Description** |
| --- | --- |
| azure.cosmos.**CosmosClient** | Client-side logical representation of an Azure Cosmos DB account and the primary class used for the SDK |
| azure.cosmos.**DatabaseProxy** | Interface that logically represents a database client-side and includes common operations for database management |
| azure.cosmos.**ContainerProxy** | Interface that logically represents a container client-side and includes common operations for container management |

> [!NOTE]
> You shouldn't directly instantiate the **DatabaseProxy** and **ContainerProxy** classes. Instead, you should use the **CosmosClient** class to interact with databases and containers.

::: zone-end

::: zone pivot="node"

The **@azure/cosmos** library is the latest version of the JavaScript SDK for Azure Cosmos DB for NoSQL.

The library is open-source and hosted online on GitHub at **Azure/azure-sdk-for-js**. The open-source project conforms to the Microsoft Open Source Code of Conduct and accepts contributions and suggestions from the community.

The @Azure/cosmos library includes a namespace of the same name with common classes that you explore later in this module including, but not limited to:

| **Class** | **Description** |
| --- | --- |
| @azure/cosmos.**CosmosClient** | Client-side logical representation of an Azure Cosmos DB account and the primary class used for the SDK |
| @azure/cosmos.**Database** | Logically represents a database client-side and includes common operations for database management |
| @azure/cosmos.**Container** | Logically represents a container client-side and includes common operations for container management |

::: zone-end
