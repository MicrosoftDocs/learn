TODO

## Connect to data services from a pipeline

Often need to seed databases, apply schemas, or upload blobs

### Azure Storage

- Can create and configure blob containers in Bicep
- Data plane operations like uploading files require additional tooling
- Can use Azure CLI, Azure PowerShell, or AzCopy

### Azure SQL Database

- Deploy DACPACs that deploy a schema
- Insert data
- Issue SQL commands

:::image type="content" source="../media/6-dacpac-pipeline-artifact.png" alt-text="Diagram showing a pipeline publishing and then referring to an artifact named 'database'." border="false":::

### Azure Cosmos DB

- Can create and configure containers in Bicep
- Inserting documents might require custom code, or using a third-party task

## Idempotence

Ideally deployment pipelines should be able to be run repeatedly
If you roll back, you might also need to revert a change by re-running an older version of a deployment pipeline
It's important to consider these factors when working with data services in a deployment pipeline
For example, when writing a blob or inserting test data, ensure you won't create duplicates

## Network security

Sometimes you configure your resources to only be accessible from specific IP addresses, or from specific virtual networks
This often happens with databases, because it might seem like there's no need for anything on the internet to connect
For example, SQL DB with private endpoint, or storage account with IP address-based firewall
But this can make it hard for your deployment pipelines to connect to the resources when you use Microsoft-hosted agents
Even though they run in Azure, you can't get the IP address range for Microsoft-hosted agents, and you can't join them to VNets
When you have special network requirements like this, you need to consider using self-hosted agents
Then you can configure them however you want, and ensure they use a known IP address or VNet
We don't discuss self-hosted agents in this module, but we provide links to more information in the summary
