Microsoft Purview (formerly Azure Purview) is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS), and multi-cloud data. The Microsoft Purview Data Catalog is an application within Microsoft Purview that enables your users to quickly find relevant data using a search experience with filters based on lenses such as glossary terms, classifications, sensitivity labels and more.

:::image type="complex" source="../media/microsoft-purview.png" alt-text="Diagram showing the Microsoft Purview governance portal architecture.":::
   "In the Microsoft Purview governance portal architecture, on-premises, cloud, and S A A S data sources are flowing into the Data Map, which is at the bottom of the stack inside the Microsoft Purview governance portal. Data Catalog and Data Estate Insights sit on top of the data map, and on top of those are Data producers and consumers. Azure Synapse Analytics, SQL Server, Power BI, and Azure SQL are all shown extracting data from all levels of the Microsoft Purview governance portal stack."
:::image-end:::

The Microsoft Purview Data Catalog is one of two main pillars in Microsoft Purview that sits atop the Microsoft Purview Data Map. The data map scans resources, and houses metadata about the assets in those resources. The data catalog allows your users to browse those assets fo data they might need based on what kind of data it is, if it's sensitive, or even based on an aspect of your business. The data catalog helps to demistify your data estate so users can find the information they need, without sacrificing security, and while allowing you to curate your experience to match your business.

## Scenario

The Fabrikam Corp shoe company has expanded rapidly over the last year, going from a handful of employees and a single data lake, to a multi-regional business with data across several platforms. They've created a Microsoft Purivew proof of concept where they've scanned one of their data sources, and they need to know how to use the data catalog to see what kind of information Microsoft Purview has discovered and how they can customize and use this information.


## What will we be doing?

In this module we'll be exploring the Microsoft Purview Data Catalog and using it's main features:

- Search and browse data assets
- Manage data assets
- Create and curate a business glossary

By the end of this session, you'll be able to use the Microsoft Purview Data Catalog to discover and manage data assets across your data estate, all from within Microsoft Purview.