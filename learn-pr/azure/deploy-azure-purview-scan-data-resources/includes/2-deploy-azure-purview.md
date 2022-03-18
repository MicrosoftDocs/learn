The first step in creating a holistic, up-to-date map of your data landscape, is to deploy an Azure Purview account. Here, we will discuss configuration settings, account concepts, and key considerations.

## Azure Purview account name
The name of the Azure Purview account. This name is used to programmatically access the Azure Purview account and cannot be changed. The Azure Purview account name must be:
* Globally unique
* Can contain only letters, numbers and hyphens
* The first and last characters must be a letter or number
* Spaces are not allowed

![Azure Purview account name](../media/03.01-purview-account-name.png)

## Managed resources
Azure Purview provisions a storage account and an Azure Event Hubs account as managed resources within the subscription that the Azure Purview account is provisioned in. This is required to support enhanced security features during scanning.
* The name of the managed resource group will be auto-generated but can be changed during the Azure Purview account creation process.
* The names of the storage account and Azure Event Hubs namespace will be auto-generated during account creation and cannot be changed.

![Azure Purview managed resources](../media/03.02-purview-managed-resources.png)

## Azure Purview Data Map
The Azure Purview Data Map is central to the Azure Purview service as it is responsible for storing and serving metadata, lineage, classifications, and other annotations associated with data assets. The size of the Data Map is measured in Capacity Units. There is no need to predetermine the number of Capacity Units required as Azure Purview will **auto-scale** up and down based on usage.

![Azure Purview data map](../media/03.04-purview-data-map.png)

## Capacity Units
All Azure Purview accounts come with one Capacity Unit by default, and elastically grow based on usage. The Data Map is **always on** while the Azure Purview account exists, in which case, there will always be a minimum of 1 Capacity Unit consumed. Each Capacity Unit:
* Can support up to **25 data map operations per second**.
* Includes storage of up to **10 GB** of metadata about data assets.

## Scanning
The compute required to facilitate the automated population of the Data Map is serverless (**pay as you go**) and based on the duration of scans or ingestion jobs. Duration of these jobs can vary based on the number of systems scanned, data assets contained in the scanned systems, number of classifications selected, the shape of the data and performance of the system scanned. Scanning is billed based on the number of vCore Hours.

## Network connectivity
You can connect to your Azure Purview account either publically, via public IP addresses or service endpoints, or privately, using a private endpoint. [Learn more about private endpoints for your Azure Purview account](https://docs.microsoft.com/en-us/azure/purview/catalog-private-link).

![Azure Purview networking](../media/03.03-purview-networking.png)