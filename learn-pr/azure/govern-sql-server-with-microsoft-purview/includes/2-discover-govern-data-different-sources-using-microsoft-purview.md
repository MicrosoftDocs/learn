You’ve been asked to evaluate the capabilities of Microsoft Purview to enable a unified data-governance service, including data stored on-premises and in multiple cloud-storage solutions. Microsoft Purview enables your organization to have central locations for data, which provides better data discovery and comprehension. You can use Microsoft Purview to annotate data sources with descriptive metadata using tagging or classification.

## Data Map

Govern your distributed data sets stored in multicloud and on-premises environments by using Microsoft Purview Data Map. It enables you to capture metadata, intelligent insights, and the actual states of your enterprise data that’s stored in multicloud and on-premises environments.

To achieve data governance, Data Map uses operation throughput and storage components that are represented as a capacity unit (CU) and can scale based on usage.

Data Map uses operations such as Create, Read, Write, Update, and Delete on any metadata used to manage an asset. Use these operations to create assets, configure relationships using the metadata, and optimize search and similar activities that improve overall data lineage.

The storage component of Data Map includes items that Microsoft Purview discovers during its scanning process including schema, data types, columns, and properties such as modified date/time.

## Data Catalog

Use Microsoft Purview Data Catalog to search and browse the data that Microsoft Purview discovers while scanning. For example, your CDO can use Data Catalog to find relevant data by searching with specific filters selected, such as glossary terms, classifications, and sensitivity labels.

:::image type="content" source="../media/2-Data-Catalog.png" alt-text="The Data Catalog section in Microsoft Purview Studio." border="false":::

Search the Microsoft Purview Data Catalog by using search queries that include keywords and operators such as **OR**, **AND**, and **NOT**. You can also register an Azure Synapse Analytics workspace and conduct a search directly from that service.

## Data insights

Use data insights to get valuable information about scanned data, including its classification and sensitivity label reports.

:::image type="content" source="../media/2-data-insights.png" alt-text="Data insights page" border="false":::

:::image type="content" source="../media/2-Scan-insights.png" alt-text="The Microsoft Purview Scan insights pane displaying statistics for successful, failed, and cancelled scans." border="false":::

Available data insights include:

- Asset insights. This report reveals a count of assets that have a specific classification. It also identifies the source type for information.

- Scan insights. This report provides the number of scans that run, that were successful, that failed, and that were canceled. Use this report as a starting point to troubleshoot failed scans.

- Glossary insights. This report summarizes a business vocabulary that represents an organization’s performance, culture, and operations, so that business users can understand the completeness of their glossary terms.

- Classification insights. An organization’s security administrators typically use this report to understand the types of information being used and scanned.

- Sensitivity Labeling insights. This report has details about the sensitivity labels found during a scan.

## Use connectors to access data sources 

Microsoft Purview natively supports a large number of source systems by offering connectors to many Microsoft data sources and non-Microsoft products such as SAP, Amazon RDS, and Teradata. You can host these sources in a multicloud environment or at your on-premises datacenter. The connectors are used to discover your data estate and to visualize data assets using Microsoft Purview Data Map.

## Manage discovered data by creating a collection

Manage discovered data assets in Microsoft Purview by creating a collection, which organizes assets and enables you to control access by granting users differing levels of permissions. You can also delegate ownership of data sources and assets by assigning roles to specific collections, which can contain subcollections. By default, subcollections inherit permissions from the parent collection.

:::image type="content" source="../media/2-data-map-collections.png" alt-text="The Data map Collections pane" border="false":::

The following table lists the roles you can use to assign user permissions:

| Role assignment| Role Permissions|
|------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Collection admin| A collection admin can edit a collection and its details and add subcollections.|
| Data source admin| A data source admin can manage data sources and data scans.|
| Data curator| A data curator can perform Create, Read, Modify, and Delete actions on catalog data objects.|
| Data reader| A data reader can access—but not modify—catalog data objects.|
| Policy author| A policy author can use the policy management app to create and edit policy statements.|
| Workflow administrator | A workflow administrator can access the workflow authoring page and publish workflows on collections where they have access. |

## Prepare network and security for Microsoft Purview

Microsoft Purview is a managed service that provides public endpoints secured with Azure Active Directory logins and granular, role-based access control (RBAC).

The data sources integrated into Microsoft Purview can reside in an infrastructure as a service (IaaS), platform as a service (PaaS), or software as a service (SaaS) solution. To take advantage of this flexibility, you must prepare your network environment so the Microsoft Purview account can scan data sources from your network’s various locations. Prepare your environment by using one of the following approaches:

- Use Azure public endpoints. This is the default network infrastructure. The Microsoft Purview account uses public endpoints to connect over the internet and scan data sources.

- Use private endpoints. This solution is more secure and requires integration between your Microsoft Purview account and virtual network where the data source resides. You must deploy an Microsoft Purview account and Microsoft Purview portal private endpoint to scan data through private connectivity.

- Use private endpoints and allow public access on the same Microsoft Purview account. This architecture ensures that you can access a subset of your data sources that uses a private endpoint. At the same time, you can configure other sources with a service endpoint or a public endpoint that’s accessible through the internet.

## Navigate through the Microsoft Purview Studio

Microsoft Purview Studio is a web-based tool with which you can interact with Data Catalog, register data sources, run data insights, and enable data lineage. Launch Microsoft Purview Studio from your Microsoft Purview account or from [Microsoft Purview Studio](https://web.purview.azure.com).

:::image type="content" source="../media/2-Azure-Purview-Studio.png" alt-text="The Microsoft Purview Data map pane that lists existing collections and sources" border="false":::

The following are panes in Microsoft Purview Studio:

- The **Data Catalog** pane is the dashboard you can use to browse the catalog by collection or source type. On this pane, you can also manage existing term templates or create a new term.

- The **Data map** pane provides options to register data sources, conduct scans, and create collections and subcollections. On this pane, you can create scan rule sets that contain a group of scan rules and integration runtimes, which are used to run scans. You also can create classification rules to classify your digital assets.

- The **Data insights** pane contains several reports that will help you understand overall assets, scans, and classifications.

- The **Data policy** pane is used by the data owner to enable access to data at its source.

- The **Management** pane enables you to integrate an Microsoft Purview account with Key Vault to manage authentication secrets. You also can create Data Factory and Data share connections for additional data lineage.

    >[!Note]
    >A *secret* is a type of credential that you can use to access information in a confidential system. Examples of secrets include usernames, passwords, or API keys.