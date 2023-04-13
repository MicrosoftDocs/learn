Let's start with a few definitions and a quick tour of the core features of Microsoft Purview. We won't list every possible feature of the service here, but we'll introduce you to the key features.

## What's Microsoft Purview?

Microsoft Purview is a unified data-governance service that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. You can easily create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. You can also empower data consumers to find valuable, trustworthy data.

The main elements are the Microsoft Purview Data Map, Purview Data Catalog, and Purview Data Estate Insights. Microsoft Purview Data Map powers the Purview Data Catalog and Purview Data Estate Insights as unified experiences within the Microsoft Purview governance portal.

:::image type="content" source="../media/data-map-sources.png" alt-text="Screenshot depicting the Data Map view in Microsoft Purview with data sources from Azure Data Lake Storage, Azure Files, Cosmos DB, Azure Blob storage, and Azure SQL Database on the map.":::

Data Estate Insights, one of the key pillars of Microsoft Purview, offers a bird's-eye view into your data catalog, covering these key facets:

* **Asset insights**: A report on the data estate and source-type distribution. You can view by source type, classification, and file size. View the insights as a graph or key performance indicators (KPI).
* **Scan insights**: This report provides information on the health of your scans (successes, failures, or canceled).
* **Glossary insights**: A status report on the glossary to help users understand the distribution of glossary terms by status, or to view how the terms are attached to assets.
* **Classification insights**: A report showing where classified data is located. It allows security administrators to understand the types of information found in their organization's data estate.
* **Sensitivity insights**: This report focuses on sensitivity labels that are found during scans. Security administrators can make use of this information to ensure security is appropriate for the data estate.
* **File extension insights**: Detailed reporting on file extensions or file types found during scans. You can use this to understand the number of files of each type that exist. It also indicates where these files are located and if they can be scanned for sensitive information.

:::image type="content" source="../media/insights.png" alt-text="Depiction of a computer monitor displaying the Purview Insights graphs and data.":::

## Microsoft Purview definition

Microsoft Purview is a data-governance solution. It helps customers gain deep knowledge of all their data while maintaining control over its use. With Microsoft Purview, organizations can discover and curate data. They gain insights into their data estate, and centrally govern access to data.

Microsoft Purview is designed to help enterprises get the most value from their existing information assets. It's a cloud-based service where you can register your various data sources with Microsoft Purview. Registering your data in Microsoft Purview helps you discover and understand data sources. Your data sources remain in place, but a copy of the metadata for the source is added to Microsoft Purview. The following image displays some of the data sources supported by Microsoft Purview:

:::image type="content" source="../media/register-sources.png" alt-text="Screenshot depicting the register sources dialog for Microsoft Purview Data Map. It displays some of the supported data sources such as Azure Blob Storage, Cosmos DB, Amazon S3, and Azure SQL Database, among others. The displayed list is also not comprehensive.":::
