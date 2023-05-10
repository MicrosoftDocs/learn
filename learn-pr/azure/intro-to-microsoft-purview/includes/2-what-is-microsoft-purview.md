Let's start with a few definitions and a quick tour of the core features of Microsoft Purview. We won't list every possible feature of the service here, but we'll introduce you to the key features.

## What's Microsoft Purview?

Microsoft Purview is a unified data-governance service that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. You can easily create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. You can also empower data consumers to find valuable, trustworthy data.

Microsoft Purview is designed to help enterprises get the most value from their existing information assets. It's a cloud-based service where you can register your data sources to help you discover and manage them. Your data sources remain in place, but a copy of the metadata for the source is added to Microsoft Purview. There are a wide range of sources in Azure and across your multicloud data estate that can be registered in Microsoft Purview including Azure Data Lake Store, AWS, SQL on premises and in the cloud, and many more.

The main elements are the Microsoft Purview Data Map, Purview Data Catalog, and Purview Data Estate Insights.

The **Microsoft Purview Data Map** provides a structure for your data estate in Microsoft Purview, where you can map your existing data stores into groups and hierarchies. In the data map you'll grant users and teams access to these groups so they have access to find relevant data stores. The data map can then scan your data stores and gather metadata, like schema and data types, and it can identify sensitive data types so you can keep track of them in your data estate.

:::image type="content" source="../media/data-map-sources.png" alt-text="Screenshot depicting the Data Map view in Microsoft Purview with data sources from Azure Data Lake Storage, Azure Files, Cosmos DB, Azure Blob storage, and Azure SQL Database on the map.":::

The **Microsoft Purview Data Catalog** allows your users to browse the metadata stored in the data map, so they can find reliable data and understand its context- like where it comes from, and who are the experts they can contact about that data source. The data catalog also integrates with other Azure products like the Azure Synapse Analytics Workspace so users can search for the data they need from the applications they need it in.

**Data Estate Insights** offers a bird's-eye view into your data catalog, covering these key facets:

* **Data stewardship**: A report on how curated your data assets are, so you can track your governance progress.
* **Catalog adoption**: A report on the number of active users in your data catalog, their top searches, and your most viewed assets.
* **Asset insights**: A report on the data estate and source-type distribution. You can view by source type, classification, and file size. View the insights as a graph or key performance indicators (KPI).
* **Scan insights**: This report provides information on the health of your scans (successes, failures, or canceled).
* **Glossary insights**: A status report on the glossary to help users understand the distribution of glossary terms by status, or to view how the terms are attached to assets.
* **Classification insights**: A report showing where classified data is located. It allows security administrators to understand the types of information found in their organization's data estate.
* **Sensitivity insights**: This report focuses on sensitivity labels that are found during scans. Security administrators can make use of this information to ensure security is appropriate for the data estate.

:::image type="content" source="../media/insights.png" alt-text="Depiction of a computer monitor displaying the Purview Insights graphs and data.":::

