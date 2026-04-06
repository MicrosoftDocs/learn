
Microsoft Purview data governance involves two primary solutions: Data Map and Unified Catalog. In this unit, you learn about Data Map. The next unit covers Unified Catalog.

## What is Microsoft Purview Data Map?

Microsoft Purview Data Map provides the foundation for data discovery and data governance. It captures metadata about data present in analytics, software as a service (SaaS), and operational systems across hybrid, on-premises, and multicloud environments. Data Map keeps itself up to date through its built-in scanning and classification system.

Think of Data Map as an automated inventory of your organization's data. Just as a library catalog records every book and its location, Data Map records every data asset and its characteristics. The key difference is that Data Map does this automatically by scanning your connected data sources.

> [!NOTE]
> All data in Data Map is metadata—descriptive information about your data, not the underlying data itself. None of the permissions or roles in Data Map provide access to the actual data.

## How scanning and classification work

Data Map uses a built-in scanning process to automatically discover and catalog data across your connected sources. Here's how it works at a high level:

- **Scanning** connects to your data sources and discovers data assets such as databases, tables, files, and reports. As it scans, it captures metadata about each asset, including its structure, location, and relationships with other assets.
- **Classification** automatically identifies and labels sensitive information within your data assets. For example, it can detect columns that contain personal information, financial data, or other sensitive content. These classifications help your organization understand what types of data exist across the estate. Classification in Data Map uses built-in patterns and rules to recognize common sensitive data types, and it can also apply custom classifications that your organization defines.

This automated classification is especially valuable for organizations that use AI, because it helps identify which data assets contain sensitive information before that data is used to train or feed AI models.

Together, scanning and classification give your organization a comprehensive, up-to-date view of its data without requiring manual cataloging.

## Types of metadata

Data Map captures several types of metadata that, together, build a complete picture of your data estate:

- **Technical metadata** includes schema information, data types, and column names that the scanning process discovers automatically. This metadata describes the structure of your data.
- **Business metadata** includes descriptions, glossary terms, and other annotations that provide context about what the data means and how it should be used. Some business metadata is captured automatically—for example, descriptions promoted from Microsoft Power BI datasets or SQL tables—while other metadata is added manually by data stewards.
- **Semantic metadata** includes collection mappings and classifications that describe how data is organized and categorized. Collections group related data sources together, while classifications identify the nature of the data, such as whether it contains personal or financial information.
- **Operational metadata** includes information about data processing activities, such as run statuses and execution times. This metadata helps you understand how data flows through your systems and when it was last updated.

<!-- TODO: Consider adding a diagram here to illustrate the four types of metadata and how they relate to Data Map. -->

## Multicloud and hybrid support

Organizations today store data across many environments, including Azure, other cloud platforms like Amazon Web Services (AWS) and Google Cloud, and on-premises data centers. Data Map connects to data sources across all these environments, so you get a single, unified view of your metadata regardless of where the data resides.

This multicloud and hybrid support is especially important for organizations that have grown through acquisitions, operate in multiple regions, or use different platforms for different workloads. Without a unified metadata view, data governance efforts become fragmented and difficult to maintain.

## How Data Map and Unified Catalog work together

Data Map and Unified Catalog are the two primary components of Microsoft Purview data governance, and they work together in sequence:

1. **Data Map scans and captures metadata.** It connects to your data sources, discovers assets, and classifies sensitive information. The result is a comprehensive inventory of metadata that describes your entire data estate.
2. **Unified Catalog curates and governs.** It builds on the metadata that Data Map captures and provides tools for organizing data into governance domains, creating data products, defining glossary terms, managing data quality, and granting access to users.

In other words, Data Map provides the raw materials—the metadata—and Unified Catalog provides the tools to make that metadata meaningful, discoverable, and governed. Without Data Map scanning your sources, Unified Catalog wouldn't have the data inventory it needs to support governance activities.

This separation of concerns means that your technical teams can focus on connecting and scanning data sources in Data Map, while your business teams and data stewards focus on curating and governing data in Unified Catalog.
