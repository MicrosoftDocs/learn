The Unified Catalog brings together technical foundations, governance, and business context to make data discoverable, understandable, and trusted across the organization. To see how this works, it helps to look at its essential elements.

## Data assets: the foundation

The starting point for the Unified Catalog is the **Microsoft Purview Data Map**. The Data Map scans and inventories data sources across your estate, from on-premises systems to cloud services. Every file, table, or dataset captured in the Data Map becomes a **data asset** in the Unified Catalog.

This inventory layer is comprehensive. It represents the _entire_ data estate, not just curated or high-value items. For governance teams, it establishes visibility into what exists, where it lives, and how it flows. For business users, it provides the raw material that can later be organized into more meaningful forms.

## Data products: the curated marketplace

While the Data Map inventories everything, not all data is ready for broad consumption. That's where **data products** come in. A data product is a curated package of related assets designed to address a specific use case.

For instance, instead of a marketing analyst needing to search across multiple raw datasets, a data steward might create a _Customer Insights_ data product that combines customer records, transaction history, and loyalty data. This curated product gives analysts a governed, reliable package they can work with directly.

## Governance context

To make assets and data products meaningful to the business, the Unified Catalog adds layers of context:

- **[Glossary terms](/purview/unified-catalog-glossary-terms)**: Establish consistent business definitions so terms like _customer_ or _account_ are interpreted the same way across department.
- **[Governance domains](/purview/unified-catalog-governance-domains)**: Organize assets into business areas such as finance, human resources, or sales, making it easier for users to navigate by topic.
- **[Critical data elements (preview)](/purview/unified-catalog-critical-data-elements)**: Highlight high-value fields such as _customer ID_ or _account number_ that require stronger oversight and governance.

These layers of context reduce confusion, reinforce consistent usage, and help both governance teams and business users understand not just where data lives, but what it represents.

## Governance in action

Governance also depends on controls that ensure data is usable and trusted in practice. In the Unified Catalog, these controls include:

- **[Access policies](/purview/unified-catalog-data-product-access-policies)**: Control access to data products and business concepts such as domains, glossary terms, and critical data elements. They ensure that access is consistent and governed across the catalog.
- **[Objectives and key results (OKRs)](/purview/unified-catalog-okrs)**: Link governance activities to business outcomes, allowing teams to show measurable progress toward goals.
- **[Data quality health report](/purview/unified-catalog-reports-data-quality-health)**: Provide visibility into whether data meets standards for accuracy, completeness, and reliability.
- **[Data governance health report (preview)](/purview/unified-catalog-reports-data-governance)**: Show the overall state of governance across domains and point to areas that might need more attention.

## From foundation to value

The essential elements of the Unified Catalog work together to bridge the gap between raw data and business-ready insights. The **Data Map** inventories everything, while **data products** make curated data accessible to consumers. Governance elements such as glossary terms, domains, and policies add the consistency needed to turn data into a trusted organizational asset.
