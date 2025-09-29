# Explore data governance using Unity Catalog

In today's data-driven landscape, organizations face significant challenges in managing and governing their data assets across multiple platforms and environments. This unit explores how Unity Catalog provides a comprehensive solution to these governance challenges.

## Understand data governance

Data governance refers to the process of managing the availability, usability, integrity, and security of data. Data governance is needed to establish trustworthy data that is readily accessible to those who need it in accordance with internally defined policies or external regulatory requirements.

Data governance encompasses four fundamental areas:

### Data Access Control

Organizations need to control access to data and data artifacts such as files, tables, and machine learning models. Access permissions should be granted only to those who need them.

### Data Access Auditing

A data governance program requires knowledge of how data is being used. This includes understanding who is accessing the data, when access occurs, and how the data is being utilized. Unity Catalog captures user-level audit logs that record access to your data.

### Data Lineage

The journey your data takes from its origin as it moves through your pipelines is referred to as data lineage. Being able to trace this journey is beneficial in several ways:

- **Root cause analysis**: Being able to trace data flow makes it easier to identify the cause of data processing issues.  
- **Impact assessment**: Enables you to predict the impact of proposed upstream changes on your processing
- **Compliance support**: Helps compliance teams prove that data and reports come from trusted and verifiable sources
- **Enhanced understanding**: Fuels a better understanding of the data for data analysts, scientists, and engineers

### Data Discovery

A data governance program requires an inventory of data assets that can be easily searched.

## Navigate multi-platform governance

Organizations often use multiple data platforms, each implementing distinct security models:

- **Data lakes** use file and directory-level permissions where access is granted at the storage container level, making fine-grained row or column restrictions impossible without restructuring data layout
- **Data warehouses** provide table and column-level security with SQL-based permission models managed through database administration
- **Notebooks** use workspace-level Access Control Lists (ACLs) for individual notebook permissions
- **Dashboards** have their own permission systems that must be managed separately from underlying data permissions
- **Machine learning models** require specialized access control for model deployment and serving endpoints

This creates synchronization challenges where users might have dashboard access but lack permissions on underlying data, or notebook editing rights without data source access. These varied governance approaches make it difficult to manage permissions holistically or to conduct comprehensive audits.

## Unify data governance with Unity Catalog

Unity Catalog addresses these challenges by operating outside individual workspaces and spanning your Azure Databricks environment. It is a centralized data catalog within Azure Databricks that provides access control, auditing, lineage, and data discovery capabilities.

Unity Catalog allows you to define your data access rules once, where they can be applied across multiple Azure Databricks workspaces, programming languages, and use cases, governing all your data and AI assets in a consistent way through interfaces and APIs.

Regardless of where your data resides across your Azure Databricks deployment, Unity Catalog can manage it consistently through a centralized governance layer. There is no need to replicate or translate your security requirements across different systems. If rules change, those changes only need to be applied once. Unity Catalog also provides fine-grained auditing of all queries and automatically captures data lineage at the table and column level, regardless of the programming language your team works with.

### Unify existing catalogs

Unity Catalog is designed to be additive, meaning it works alongside the existing Hive metastore that comes with each Azure Databricks workspace. When you connect a workspace to Unity Catalog, you gain access to both governance systems simultaneously.

Your existing tables and views in the Hive metastore remain fully accessible, while Unity Catalog provides enhanced governance capabilities for new data objects. This dual access capability allows you to operate both systems in parallel, adopting Unity Catalog governance incrementally without disrupting existing workflows or requiring immediate metastore migration.

In the next unit, we'll explore the architectural components that make this unified governance possible, including the metastore structure and three-level namespace that forms the foundation of Unity Catalog's governance capabilities.
