
## Purview discovery and classification features

Microsoft Purview's solutions in the governance portal provide a unified data governance service that helps you manage your on-premises, multicloud, and software-as-a-service (SaaS) data. The Microsoft Purview governance portal allows you to:

-   Create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage.
-   Enable data curators and security administrators to manage and keep your data estate secure.
-   Empower data consumers to find valuable, trustworthy data.

[![Diagram that shows Microsoft Purview's high-level architecture.](../media/high-level-overview-large.png)](../media/high-level-overview-large.png#lightbox)

### Data Map

Microsoft Purview automates data discovery by providing data scanning and classification for assets across your data estate. Metadata and descriptions of discovered data assets are integrated into a holistic map of your data estate. Microsoft Purview Data Map provides the foundation for data discovery and data governance. Microsoft Purview Data Map is a cloud native PaaS service that captures metadata about enterprise data present in analytics and operation systems on-premises and cloud. Microsoft Purview Data Map is automatically kept up to date with built-in automated scanning and classification system. Business users can configure and use the data map through an intuitive UI and developers can programmatically interact with the Data Map using open-source Apache Atlas 2.2 APIs. Microsoft Purview Data Map powers the Microsoft Purview Data Catalog, the Microsoft Purview Data Estate Insights and the Microsoft Purview Data Policy as unified experiences within the [Microsoft Purview governance portal](https://web.purview.azure.com/resource/).

For more information, see our [introduction to Data Map](/azure/purview/concept-elastic-data-map).

Atop the Data Map, there are purpose-built apps that create environments for data discovery, access management, and insights about your data landscape.

|App  |Description  |
|----------|-----------|
|Data Catalog  | Finds trusted data sources by browsing and searching your data assets. The data catalog aligns your assets with friendly business terms and data classification to identify data sources.      |
|Data Estate Insights | Gives you an overview of your data estate to help you discover what kinds of data you have and where it is. |
|Data Sharing | Allows you to securely share data internally or cross organizations with business partners and customers. |
|Data Policy | A set of central, cloud-based experiences that help you provision access to data securely and at scale. |
|||

### Data Catalog app

With the Microsoft Purview Data Catalog, business and technical users can quickly and easily find relevant data using a search experience with filters based on lenses such as glossary terms, classifications, sensitivity labels and more. For subject matter experts, data stewards and officers, the Microsoft Purview Data Catalog provides data curation features such as business glossary management and the ability to automate tagging of data assets with glossary terms. Data consumers and producers can also visually trace the lineage of data assets: for example, starting from operational systems on-premises, through movement, transformation & enrichment with various data storage and processing systems in the cloud, to consumption in an analytics system like Power BI. For more information, see our [introduction to search using Data Catalog](/azure/purview/how-to-search-catalog).

### Data Estate Insights app

With the Microsoft Purview Data Estate Insights, the chief data officers and other governance stakeholders can get a bird’s eye view of their data estate and can gain actionable insights into the governance gaps that can be resolved from the experience itself.

For more information, see our [introduction to Data Estate Insights](/azure/purview/concept-insights).

### Data Sharing app

Microsoft Purview Data Sharing enables organizations to securely share data both within your organization or cross organizations with business partners and customers. You can share or receive data with just a few clicks. Data providers can centrally manage and monitor data sharing relationships, and revoke sharing at any time. Data consumers can access received data with their own analytics tools and turn data into insights.

For more information, see our [introduction to Data Sharing](/azure/purview/concept-data-share).

### Data Policy app

Microsoft Purview Data Policy is a set of central, cloud-based experiences that help you manage access to data sources and datasets securely and at scale.

-   Manage access to data sources from a single-pane of glass, cloud-based experience
-   Enables at-scale access provisioning
-   Introduces a new data-plane permission model that is external to data sources
-   It is seamlessly integrated with Microsoft Purview Data Map and Catalog:
    -   Search for data assets and grant access only to what is required via fine-grained policies.
    -   Path to support SaaS, on-premises, and multicloud data sources.
    -   Path to create policies that leverage any metadata associated to the data objects.
-   Based on role definitions that are simple and abstracted (for example: Read, Modify)

## Defense in depth in Microsoft Purview

![Screenshot that shows defense in depth in Microsoft Purview.](../media/security-defense-in-depth.png)

Before applying these recommendations to your environment, you should consult your security team as some may not be applicable to your security requirements.

### Network security

Microsoft Purview is a Platform as a Service (PaaS) solution in Azure. You can enable the following network security capabilities for your Microsoft Purview accounts:

-   Enable [end-to-end network isolation](/azure/purview/catalog-private-link-end-to-end) using Private Link Service.
-   Use [Microsoft Purview Firewall](/azure/purview/catalog-private-link-end-to-end#firewalls-to-restrict-public-access) to disable Public access.
-   Deploy [Network Security Group (NSG) rules](/azure/purview/concept-best-practices-security#use-network-security-groups) for subnets where Azure data sources private endpoints, Microsoft Purview private endpoints and self-hosted runtime VMs are deployed.
-   Implement Microsoft Purview with private endpoints managed by a Network Virtual Appliance, such as [Azure Firewall](/azure/firewall/overview) for network inspection and network filtering.

### Access management

Identity and Access Management provides the basis of a large percentage of security assurance. It enables access based on identity authentication and authorization controls in cloud services. These controls protect data and resources and decide which requests should be permitted.

Related to roles and access management in Microsoft Purview, you can apply the following security best practices:

-   Define roles and responsibilities to manage Microsoft Purview in control plane and data plane:
    -   Define roles and tasks required to deploy and manage Microsoft Purview inside an Azure subscription.
    -   Define roles and task needed to perform data management and governance using Microsoft Purview.
-   Assign roles to Microsoft Entra groups instead of assigning roles to individual users.
-   Use Azure [Active Directory Entitlement Management](/azure/active-directory/governance/entitlement-management-overview) to map user access to Microsoft Entra groups using Access Packages.
-   Enforce multi-factor authentication for Microsoft Purview users, especially, for users with privileged roles such as collection admins, data source admins or data curators.

### Threat protection and preventing data exfiltration

Microsoft Purview provides rich insights into the sensitivity of your data, which makes it valuable to security teams using Microsoft Defender for Cloud to manage the organization's security posture and protect against threats to their workloads. Data resources remain a popular target for malicious actors, making it crucial for security teams to identify, prioritize, and secure sensitive data resources across their cloud environments. To address this challenge, we're announcing the integration between Microsoft Defender for Cloud and Microsoft Purview in public preview.

### Information protection

#### Secure metadata extraction and storage

Microsoft Purview is a data governance solution in cloud. You can register and scan different data sources from various data systems from your on-premises, Azure, or multicloud environments into Microsoft Purview. While data source is registered and scanned in Microsoft Purview, the actual data and data sources stay in their original locations, only metadata is extracted from data sources and stored in Microsoft Purview Data Map, which means you don't need to move data out of the region or their original location to extract the metadata into Microsoft Purview.

When a Microsoft Purview account is deployed, in addition, a managed resource group is also deployed in your Azure subscription. A managed Azure Storage Account is deployed inside this resource group. The managed storage account is used to ingest metadata from data sources during the scan. Since these resources are consumed by the Microsoft Purview they can't be accessed by any other users or principals, except the Microsoft Purview account. This is because an Azure role-based access control (RBAC) deny assignment is added automatically for all principals to this resource group at the time of Microsoft Purview account deployment, preventing any CRUD operations on these resources if they aren't initiated from Microsoft Purview.

#### Information protection and encryption

Azure offers many mechanisms for keeping data private in rest and as it moves from one location to another. For Microsoft Purview, data is encrypted at rest using Microsoft-managed keys and when data is in transit, using Transport Layer Security (TLS) v1.2 or greater.
