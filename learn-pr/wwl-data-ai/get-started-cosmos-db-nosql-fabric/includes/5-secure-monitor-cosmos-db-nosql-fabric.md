Fabric provides built-in security, access control, and monitoring for Cosmos DB NoSQL in Fabric. Workspace permissions determine database access, and options like network security and data encryption help protect information. Users can also track database operations and monitor usage through Fabric.

## Fabric authentication

*Microsoft Entra* is the primary authentication method for accessing Cosmos DB NoSQL in Fabric. Users sign in with their Microsoft Entra credentials, just as they do for other Fabric services. This approach provides a consistent and secure way to manage access across Fabric environments.

Fabric also supports other authentication methods for applications and services. With *managed identities*, applications can connect securely to Azure resources without handling credentials directly. *Service principals* allow automated tools and services to authenticate without user involvement.

By using these methods, you can secure access based on the needs of both users and applications.

## Cosmos DB integration with Fabric security

Cosmos DB NoSQL in Fabric applies the same access controls and network security settings used across Fabric workspaces.

User permissions are enforced automatically based on workspace access. When a user is removed from a workspace, they also lose access to the associated Cosmos DB database and its data.

If private access is configured, the database can only be accessed from the virtual network that has access to the workspace or tenant. This private access configuration ensures that data is only accessible to authorized users and applications within the specified network.

## Data security

Cosmos DB NoSQL in Fabric automatically encrypts data at rest. For extra control, you can choose to use Customer Managed Keys (CMK) to manage your own encryption keys.

Databases are also configured with zone-redundancy by default. This setup includes built-in high availability and disaster recovery (HADR), with data replicated across Fabric paired regions through OneLake.

## Backup and restore

Cosmos DB NoSQL in Fabric is backed up continuously. You can restore the database to a specific point in time, with backups retained for up to 30 days.

## Monitoring and metrics

The Cosmos DB NoSQL database experience in Fabric includes built-in metrics. Users can view operation counts by type, latency trends, and other integrated metrics directly in the database user experience (UX).

To track usage costs, the Capacity metrics app provides detailed insights into Cosmos DB consumption within Fabric.
