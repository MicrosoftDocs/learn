## What is Microsoft Purview?

Microsoft Purview (formerly Azure Purview) is a unified data governance service that helps you manage and govern your on-premises, software-as-a-service (SaaS), and multicloud data. You can use the Microsoft Purview Data Map to create a comprehensive, up-to-date map of your data landscape that will tell you what kind of data you've stored, and where. You can then use the Microsoft Purview governance portal to govern this data with automated data discovery, sensitive data classification, end-to-end data lineage, insights reports, and a business glossary. Empower data consumers, data officers, data stewards, experts, and analytics admins to find valuable, trustworthy data and where it's located.

:::image type="complex" source="../media/microsoft-purview.png" alt-text="Diagram showing the Microsoft Purview governance portal architecture.":::
   "In the Microsoft Purview governance portal architecture, on-premises, cloud, and S A A S data sources are flowing into the Data Map, which is at the bottom of the stack inside the Microsoft Purview governance portal. Data Catalog and Data Estate Insights sit on top of the data map, and on top of those are Data producers and consumers. Azure Synapse Analytics, SQL Server, Power BI, and Azure SQL are all shown extracting data from all levels of the Microsoft Purview governance portal stack."
:::image-end:::

### How does Microsoft Purview benefit an organization?

Microsoft Purview helps chief data officers, data analysts, BI engineers, data stewards, governance experts and admins to answer these kinds of questions:

- What data does my org have?
- Where did this data come from?
- Where is data stored?
- What’s my exposure to risk?
- What is the data being used for?
- Is my data usage compliant?
- How do I control access & use?
- For what business purpose?
- Where is the sensitive data?

## Scenario

The Fabrikam Corp shoe company has expanded rapidly over the last year, going from a handful of employees and a single data lake, to a multi-regional business with data across several platforms. In the expansion, keeping track of what data Fabrikam stores and where has mostly fallen to department heads. Data officers often have to repeat security procedures as new data repositories surface, data experts and officers are flooded with requests for data access and questions about their data. Before the company can go international, Fabrikam needs a solution to help them understand and take command of their full data estate.

Microsoft Purview will allow Fabrikam to register all their data sources, manage access and data discovery by department, and even understand where data comes from and what kind of data it is.

You've been requested to create a small Microsoft Purview proof of concept for Fabrikam, to understand how to deploy Microsoft Purview in their environment and onboard resources.

## What is the main goal?

By the end of this session, you'll have deployed a Microsoft Purview account in your Azure environment, registered an Azure Data Lake Gen 2 Storage Account, and scanned the storage account so Microsoft Purview can classify the data and add the metadata to its data map.