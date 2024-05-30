Choose deploying a vCore-based Azure Cosmos DB for MongoDB cluster for advanced MongoDB applications needing high scalability, complex query processing, and high availability. It's ideal for both migrating existing MongoDB workloads and initiating new projects, with the flexibility to support both traditional and AI-enhanced applications.

## Key advantages

- **Migrations and new projects**: Lift & shift existing MongoDB workloads easily or start fresh.
- **Complex workloads**: Ideal for long queries, complex pipelines, and transactions.
- **Scalability**: Uses vCore tiers like M30, M40, M50 for robust scaling.
- **High availability**: Supports applications requiring 99.995% uptime.
- **Vector search**: Includes native support for vector embeddings.

## MongoDB compatibility

A vCore-based Azure Cosmos DB for MongoDB ensures seamless integration using the MongoDB wire protocol, allowing the use of familiar tools and SDK. The cluster also supports most MongoDB commands and query language constructs. To learn more MongoDB compatibility info, visit the [MongoDB compatibility and feature support with vCore-based Azure Cosmos DB for MongoDB](/azure/cosmos-db/mongodb/vcore/compatibility) documentation.

## Creating your cluster

To create a vCore-based Azure Cosmos DB for MongoDB cluster, you can use the Azure portal or Azure CLI commands.

**Requirements**:

- An Azure account with an active subscription.

**Methods**:

- **Azure portal**: As with most Azure resources, you can use the Azure portal's straightforward prompts to create your cluster. In the module's interactive exercise, you use the Azure portal to create a sample cluster.

- **CLI deployment**: Use `az deployment group create` with a Bicep, Azure Resource Manager JSON, or Terraform template. This method is used in later modules to deploy resources programmatically.

### Example CLI command

Next, is an example of deploying a vCore-based Azure Cosmos DB for MongoDB cluster using the Azure CLI:

```azurecli
az deployment group create --resource-group 'yourResourceGroupName' --template-file 'create-mongodb-vcore-cluster.bicep'
```

Bicep file ***create-mongodb-vcore-cluster.bicep*** (*make sure you use a strong admin password and replace the blank placeholder value with your own*):

```bicep
resource cluster 'Microsoft.DocumentDB/mongoClusters@2023-03-01-preview' = {
  name: 'MLearSampleCluster123456'
  location: 'eastus'
  properties: {
    administratorLogin: 'clusterAdmin'
    administratorLoginPassword: ' '
    nodeGroupSpecs: [
        {
            kind: 'Shard'
            nodeCount: 1
            sku: 'M40'
            diskSizeGB: 128
            enableHa: false
        }
    ]
  }
}
```

Creating a vCore-based Azure Cosmos DB for MongoDB cluster simplifies migrating existing projects and starting new ones, positioning your work for scalable growth and AI or traditional application development with Azure.
