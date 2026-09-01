Your retail company now has a working Azure DocumentDB cluster. You created the cluster in the Azure portal, connected to it using MongoDB Shell, and ran your first queries against a sample product catalog.

You learned how to provision a cluster by configuring the compute tier, storage, location, and admin credentials. The connection string uses the `mongodb+srv` format with SCRAM-SHA-256 authentication, and standard MongoDB tools like `mongosh` connect without modification. You also learned how to right-size the cluster. You can choose between burstable and provisioned compute tiers, scale storage independently, and add physical shards for horizontal growth. You also learned how to secure the cluster. You can control network access with firewall rules or Azure Private Link. You can use Microsoft Entra ID for centralized authentication. Data at rest is encrypted using service-managed or customer-managed keys.

You can now create, connect to, and configure an Azure DocumentDB cluster that meets your workload and security requirements.

## Learn more

- [Quickstart: Create a cluster in the Azure portal](/azure/documentdb/quickstart-portal)
- [Connect using MongoDB Shell](/azure/documentdb/how-to-connect-mongo-shell)
- [Compute and storage configurations](/azure/documentdb/compute-storage)
- [Scale and configure a cluster](/azure/documentdb/how-to-scale-cluster)
- [Secure your Azure DocumentDB cluster](/azure/documentdb/security)
- [Enable private access with Azure Private Link](/azure/documentdb/how-to-private-link)
- [Connect using Microsoft Entra ID and role-based access control](/azure/documentdb/how-to-connect-role-based-access-control)
