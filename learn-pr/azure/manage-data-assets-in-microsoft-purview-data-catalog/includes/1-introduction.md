Microsoft Purview (formerly Azure Purview) is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS), and multicloud data. The Microsoft Purview Data Catalog is an application within the service that helps users find useful data in your organization using a search experience based on their permissions.

:::image type="complex" source="../media/microsoft-purview.png" alt-text="Diagram showing the Microsoft Purview governance portal architecture." border="false":::
   "In the Microsoft Purview governance portal architecture, on-premises, cloud, and SAAS data sources are flowing into the Data Map, which is at the bottom of the stack inside the Microsoft Purview governance portal. Data Catalog and Data Estate Insights sit on top of the data map, and on top of those applications are data producers and consumers. Azure Synapse Analytics, SQL Server, Power BI, and Azure SQL are shown extracting data from all levels of the Microsoft Purview governance portal stack."
:::image-end:::

The Microsoft Purview Data Catalog is one of two main pillars in Microsoft Purview that sits atop the Microsoft Purview Data Map. The data map scans resources and houses metadata about the assets in those resources. The data catalog makes this metadata accessible to your users without sacrificing security, and allows you to curate your experience to match your data. Users can search and browse data assets to find relevant information based on the kind of data it is or even its context in your business.

## Scenario

The Fabrikam Corp shoe company has expanded rapidly over the last year, going from a handful of employees and a single data lake, to a multi-regional business with data across several platforms. [In the module before this one, they've created a Microsoft Purview proof of concept](/learn/modules/deploy-microsoft-purview-scan-data-resources/) where they've scanned one of their data sources and now they need to know how to use the data catalog to see what kind of information Microsoft Purview has discovered. They also need to start their data governance lifecycle by curating and managing these data assets to give their users more context.

## What will we be doing?

In this module we'll be exploring the Microsoft Purview Data Catalog and using its main features:

- Search and browse data assets
- Manage data assets
- Create and curate a business glossary

By the end of this session, you'll be able to use the Microsoft Purview Data Catalog to discover and manage data assets across your data estate, all from within Microsoft Purview.