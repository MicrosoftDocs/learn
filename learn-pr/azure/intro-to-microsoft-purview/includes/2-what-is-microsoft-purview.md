Let's start with a few definitions and a quick tour of the core features of Microsoft Purview.

## What's Microsoft Purview?

Microsoft Purview is a unified data-governance service that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. You can easily create a broad, up-to-date map of your data landscape with:

- Automated data discovery. 
- Sensitive data classification.
- End-to-end data lineage.

You can also empower data users to find valuable, trustworthy data.

Microsoft Purview is designed to help enterprises get the most value from their existing information assets. With this cloud-based service, you can register your data sources to help you discover and manage them. Your data sources remain in place, but a copy of the metadata for the source is added to Microsoft Purview.

You can register a wide range of sources in Azure and across your multicloud data estate in Microsoft Purview. These sources include Azure Data Lake Storage, AWS, Azure SQL Database on-premises and in the cloud, and many more.

Microsoft Purview has three main elements:

**Microsoft Purview Data Map**: The data map provides a structure for your data estate in Microsoft Purview, where you can map your existing data stores into groups and hierarchies. In the data map, you can grant users and teams access to these groups so that they have access to find relevant data stores. The data map can then scan your data stores and gather metadata such as schemas and data types. It can also identify sensitive data types so that you can keep track of them in your data estate.

:::image type="content" source="../media/data-map-sources.png" alt-text="Screenshot that shows the Data Map view with data sources from Azure Data Lake Storage, Azure Files, Azure Cosmos DB, Azure Blob Storage, and Azure SQL Database on the map.":::

**Microsoft Purview Data Catalog**: The data catalog allows your users to browse the metadata stored in the data map so that they can find reliable data and understand its context. For example, users can see where the data comes from and who are the experts they can contact about that data source. The data catalog also integrates with other Azure products, like the Azure Synapse Analytics workspace, so that users can search for the data they need from the applications they need it in.

**Microsoft Purview Data Estate Insights**: Insights offer a high-level view into your data catalog, covering these key facets:

* **Data stewardship**: A report on how curated your data assets are so that you can track your governance progress.
* **Catalog adoption**: A report on the number of active users in your data catalog, their top searches, and your most viewed assets.
* **Asset insights**: A report on the data estate and source-type distribution. You can view by source type, classification, and file size. View the insights as a graph or as key performance indicators.
* **Scan insights**: A report that provides information on the health of your scans (successes, failures, or canceled).
* **Glossary insights**: A status report on the glossary to help users understand the distribution of glossary terms by status, and view how the terms are attached to assets.
* **Classification insights**: A report that shows where classified data is located. It allows security administrators to understand the types of information found in their organization's data estate.
* **Sensitivity insights**: A report that focuses on sensitivity labels found during scans. Security administrators can make use of this information to ensure security is appropriate for the data estate.

:::image type="content" source="../media/insights.png" alt-text="Depiction of a computer monitor that shows Data Estate Insights graphs and data.":::