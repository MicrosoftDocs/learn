Let's start with a few definitions and a quick tour of the core features of Azure Purview. We won't list every possible feature of the service here but we will introduce you to the key features.

## What is Azure Purview?
Azure Purview is a unified data governance service that helps you manage and govern your on-premises, multi-cloud, and software-as-a-service (SaaS) data. Easily create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. Empower data consumers to find valuable, trustworthy data.

The main elements are the Azure Purview Data Map, Purview Data Catalog, and Purview data insights. Azure Purview Data Map powers the Purview Data Catalog and Purview data insights as unified experiences within the Purview Studio.

:::image type="content" source="../media/data-map-sources.png" alt-text="Screenshot depicting the data map view in Azure Purview with data sources from Azure Data Lake Storage, Azure Files, CosmosDB, Azure Blob storage, and Azure SQL Database on the map.":::

## Azure Purview definition
Azure Purview is a data governance solution. It helps customers gain deep knowledge of all their data while maintaining control over its use. With Azure Purview, organizations discover and curate data. They gain insights into their data estate, and centrally govern access to data.

Azure Purview is designed to help enterprises get the most value from their existing information assets. It is a cloud-based service where you can register your various data sources with Azure Purview. Registering your data in Azure Purview helps in the discovery and understanding of data sources. Your data sources remain in place but a copy of the metadata for the source, is added to Azure Purview.

:::image type="content" source="../media/register-sources.png" alt-text="Screenshot depicting the register sources dialog for Azure Purview data map. It displays some of the supported data sources such as Azure Blob Storage, Cosmos DB, Amazon S3, and Azure SQL Database, among others. The displayed list is also not comprehensive.":::

## How to track you data sources
Tracking your data sources starts with registering the sources with Azure Purview. Once you have the data sources registered, Azure Purview can scan generate a map view in Azure Purview Studio.

:::image type="content" source="../media/register-sources-form.png" alt-text="Screenshot depicting the dialog to register an Azure Blob Storage source for Azure Purview. The dialog has entries for a name, Azure subscription name and storage account name, an endpoint, and a collection to add the source to.":::

Once you have your sources registered, you can view the map or a table view listing each registered data source. To better align your views with a grouping strategy, you can also create collections to contain related data sources.

:::image type="content" source="../media/collections.png" alt-text="Screenshot depicting a configured set of collections in a hierarchy with Fabrikam listed as the parent collection to Finance, and an Azure Blob storage data source in the Finance collection.":::
