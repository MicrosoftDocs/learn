The .NET SDK for Azure Cosmos DB SQL API ships with a change feed processor that simplifies the task of reading changes from the feed. The change feed processor also natively supports distributed scenarios where event processing responsibilities are shared across multiple consumer client applications in an efficient manner.

The change feed processor includes four core components:

| **Component** | **Description** |
| --- | --- |
| **Monitored container** | This container is monitored for any insert or update operations. These changes are then reflected in the feed. |
| **Lease container** | The lease container serves as a storage mechanism to manage state across multiple change feed consumers (clients). |
| **Host** | The host is a client application instance that listens for and reacts to changes from the change feed. |
| **Delegate** | The delegate is code within the client application that will implement business logic for each batch of changes. |

Prior to using the change feed processor, you should create a **lease** container that you will reference when configuring the processor.