
An organization's data is constantly growing and users are storing and sharing data in new directions. For security and compliance administrators, the task of discovering, protecting, and governing sensitive data is one that never ends. The growth of data, also represents challenges for data consumers who might be unaware of a data source. For data producers, those who are responsible for producing and maintaining information assets, creating and maintaining documentation for data sources is complex and time-consuming. Restricting access to data sources and ensuring that data consumers know how to request access is an ongoing challenge.

Microsoft Purview is designed to address the challenges associated with the rapid growth of data and to help enterprises get the most value from their information assets.

The Microsoft Purview governance portal provides a unified data governance service that helps you manage your on-premises, multicloud, and software-as-a-service (SaaS) data. The Microsoft Purview governance portal allows you to:

- Create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage.
- Enable data curators to manage and secure your data estate.
- Empower data consumers to find valuable, trustworthy data.

:::image type="content" source="../media/purview-unified-governance-inline.png" lightbox="../media/purview-unified-governance-extended.png" alt-text="Screenshot of Microsoft Purview high level architecture.":::

### Data Map

Microsoft Purview Data Map provides the foundation for data discovery and data governance. By scanning registered data sources, Data Map is able to capture metadata about enterprise data, to identify and classify sensitive data. Microsoft Purview supports Azure data sources and various data source categories including databases, file storage, and applications and services from third parties.

### Data Catalog

With the Microsoft Purview Data Catalog, business and technical users can quickly and easily find relevant data using a search experience with filters based on various lenses like glossary terms, classifications, sensitivity labels and more. For subject matter experts, data stewards and officers, the Microsoft Purview Data Catalog provides data curation features such as business glossary management and the ability to automate tagging of data assets with glossary terms. Data consumers and producers can also visually trace the lineage of data assets: for example, starting from operational systems on-premises, through movement, transformation & enrichment with various data storage and processing systems in the cloud, to consumption in an analytics system like Power BI.

### Data Estate Insights

With the Microsoft Purview Data Estate Insights, data officers and security officers can get a bird’s eye view and at a glance understand what data is actively scanned, where sensitive data is, and how it moves. The application provides actionable insights into the organization’s data estate, catalog usage, adoption, and processes.

### Data Policy

Microsoft Purview Data Policy is a set of central, cloud-based experiences that help you manage access to data sources and datasets securely and at scale.

- Manage access to data sources from a single-pane of glass, cloud-based experience
- Enables at-scale access provisioning
Introduces a new data-plane permission model that is external to data sources
- It is seamlessly integrated with Microsoft Purview Data Map and Catalog
- Based on role definitions that are simple and abstracted (for example: Read, Modify)

Microsoft Purview data policies can be categorized as follows.
- **Data owner policies**. Access policies in Microsoft Purview enable you to manage access to different data systems across your entire data estate. For example, if a user needs read access to an Azure Storage account that has been registered in Microsoft Purview, you can grant this access directly in Microsoft Purview by creating a data access policy through the Policy management app in the Microsoft Purview governance portal.
- **DevOps policies**. DevOps policies are a special type of Microsoft Purview access policies. They grant access to database system metadata instead of user data. They simplify access provisioning for IT operations and security auditing personnel. DevOps policies only grant access. They don't deny access.
- **Self-service data access policies**. Microsoft Purview Self-service data access workflow allows data consumer to request access to data when browsing or searching for data. Once the data access request is approved, a policy gets auto-generated to grant access to the requestor provided the data source is enabled for Data Use Management. Currently, self-service data access policy is supported for storage accounts, containers, folders, and files.

### Data Sharing (preview)

Microsoft Purview Data Sharing enables organizations to securely share data both within your organization or cross organizations with business partners and customers. You can share or receive data with just a few clicks. Data providers can centrally manage and monitor data sharing relationships, and revoke sharing at any time. Data consumers can access received data with their own analytics tools and turn data into insights.
