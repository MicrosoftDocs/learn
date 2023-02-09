
An organization's data is constantly growing and users are storing and sharing data in new directions. For security and compliance administrators, the task of discovering, protecting, and governing sensitive data is one that never ends. The growth of data, also represents challenges for data consumers who might be unaware of a data source. For data producers, those who are responsible for producing and maintaining information assets, creating and maintaining documentation for data sources is complex and time-consuming. Restricting access to data sources and ensuring that data consumers know how to request access is an ongoing challenge.

Microsoft Purview is designed to address the challenges associated with the rapid growth of data and to help enterprises get the most value from their information assets.

The Microsoft Purview governance portal provides a unified data governance service that helps you manage your on-premises, multi-cloud, and software-as-a-service (SaaS) data. The Microsoft Purview governance portal allows you to:

- Create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage.
- Enable data curators to manage and secure your data estate.
- Empower data consumers to find valuable, trustworthy data.

:::image type="content" source="../media/microsoft-purview-v2-inline.png" lightbox="../media/microsoft-purview-v2-expanded.png" alt-text="Screenshot of Microsoft Purview high level architecture.":::

### Data Map
Microsoft Purview Data Map provides the foundation for data discovery and data governance. By scanning registered data sources, Azure Purview Data Map is able to capture metadata about enterprise data, to identify and classify sensitive data. Microsoft Purview supports Azure data sources and various data source categories including databases, file storage, and applications and services from third parties.

### Data Catalog
With the Microsoft Purview Data Catalog, business and technical users can quickly and easily find relevant data using a search experience with filters based on various lenses like glossary terms, classifications, sensitivity labels and more.

### Data Estate Insights
With the Microsoft Purview Data Estate Insights, data officers and security officers can get a bird’s eye view and at a glance understand what data is actively scanned, where sensitive data is, and how it moves.

### Data Sharing and Data Policy (preview)
Microsoft Purview Data Sharing enables organizations to securely share data both within your organization or cross organizations with business partners and customers.

Access policies in Microsoft Purview enable you to manage access to different data systems across your entire data estate. For example, if a user needs read access to an Azure Storage account that has been registered in Microsoft Purview, you can grant this access directly in Microsoft Purview by creating a data access policy through the Policy management app in the Microsoft Purview governance portal.
