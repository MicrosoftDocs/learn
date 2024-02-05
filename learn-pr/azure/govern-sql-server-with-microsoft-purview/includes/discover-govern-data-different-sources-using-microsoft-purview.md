You’ve been asked to evaluate the capabilities of Microsoft Purview to enable a unified data-governance service, including data stored on-premises and in multiple cloud-storage solutions.

So what is Microsoft Purview? Let's start by going through a few of the main applications of Microsoft Purview:

- The Microsoft Purview Governance Portal
- Data Map
- Data Catalog
- Data Estate Insights

## The Microsoft Purview Governance Portal

The Microsoft Purview Governance Portal is the web-based portal where you can access and manage your Microsoft Purview account. Launch Microsoft Purview Governance Portal from your Microsoft Purview account in the Azure portal, or directly using the [Microsoft Purview Governance Portal link](https://web.purview.azure.com).

:::image type="content" source="../media/2-azure-purview-studio.png" alt-text="Screenshot showing the Microsoft Purview Data Map pane that lists existing collections and sources." border="true" lightbox="../media/2-azure-purview-studio.png":::

The following are panes in Microsoft Purview Governance Portal:

- The **Data Catalog** pane is the dashboard you can use to search browse your catalog of data assets or manage your business glossary.

- The **Data map** pane provides options to register data sources, conduct metadata scans for your sources (this is how assets are registered in the catalog), and create collections and subcollections. You also can create custom classification rules to apply to your scans.

- The **Data insights** pane contains several reports that will help you understand the health of your Microsoft Purview instance, and your overall assets, scans, and classifications.

- The **Data policy** pane is used by the data owner to enable access to data at its source.

- The **Management** pane enables you to integrate a Microsoft Purview account with Key Vault to manage authentication secrets. You also can create Data Factory and Data share connections for more data lineage.

    >[!Note]
    >A *secret* is a type of credential that you can use to access information in a confidential system. Examples of secrets include usernames, passwords, or API keys.

## Data Map

Govern your distributed data sets stored in multicloud and on-premises environments by using Microsoft Purview Data Map. It enables you to capture metadata, intelligent insights, and the actual states of your enterprise data that’s stored in multicloud and on-premises environments.

First, you'll register a data source in the data map, then you'll run a scan on that source. The scan runs using capacity units (CU) that automatically scale to match the amount of data you need to scan and store. Scans will identify data assets in your data source, like files or folders, and store metadata information about those assets in the Microsoft Purview Data Catalog.

The metadata the data map discovers includes things like schema, data types, columns, and properties such as modified date/time.

### Use connectors to access data sources

Microsoft Purview natively supports a large number of source systems by offering connectors to many Microsoft data sources and non-Microsoft products such as SAP, Amazon RDS, and Teradata. You can host these sources in a multicloud environment or at your on-premises datacenter. The connectors are used to discover your data estate and to visualize data assets using Microsoft Purview Data Map.

### Manage discovered data by creating a collection

Manage discovered data assets in Microsoft Purview by creating a collection, which organizes assets and enables you to control access by granting users differing levels of permissions. You can also delegate ownership of data sources and assets by assigning roles to specific collections, which can contain subcollections. By default, subcollections inherit permissions from the parent collection.

:::image type="content" source="../media/2-data-map-collections.png" alt-text="Screenshot showing the Data map Collections pane." border="true" lightbox="../media/2-data-map-collections.png":::

Here are some of the available roles you can assign to users:

| Role assignment| Role permissions|
|------------------------|------------------------------------------------------------------------------------------------------------------------------|
| Collection admin| A collection admin can edit a collection and its details and add subcollections.|
| Data source admin| A data source admin can manage data sources and data scans.|
| Data curator| A data curator can perform Create, Read, Modify, and Delete actions on catalog data objects.|
| Data reader| A data reader can access—but not modify—catalog data objects.|
| Policy author| A policy author can use the policy management app to create and edit policy statements.|
| Workflow administrator | A workflow administrator can access the workflow authoring page and publish workflows on collections where they have access. |

## Data Catalog

Use Microsoft Purview Data Catalog to search and browse the data that Microsoft Purview discovered while scanning. For example, your CDO can use Data Catalog to find relevant data by searching with specific filters selected, such as glossary terms, classifications, and sensitivity labels.

:::image type="content" source="../media/2-data-catalog.png" alt-text="Screenshot showing the Data Catalog section in Microsoft Purview Governance Portal." border="true" lightbox="../media/2-data-catalog.png":::

Search the Microsoft Purview Data Catalog by using search queries that include keywords and operators such as **OR**, **AND**, and **NOT**.

Other Azure tools, like Azure Synapse Analytics workspace, can connect with Microsoft Purview so you can search the data catalog directly from those services too.

## Data Estate Insights

Use data insights to get valuable information about all your scanned data, including its classification and sensitivity label reports.

:::image type="content" source="../media/2-data-insights.png" alt-text="Screenshot that shows the Data insights pane." border="true" lightbox="../media/2-data-insights.png":::

:::image type="content" source="../media/2-scan-insights.png" alt-text="Screenshot of the Microsoft Purview Scan insights pane displaying statistics for successful, failed, and canceled scans." border="true" lightbox="../media/2-scan-insights.png":::

Some available data insights include:

- Asset insights. This report reveals a count of assets that have a specific classification. It also identifies the source type for information.

- Scan insights. This report provides the number of scans that run, that were successful, that failed, and that were canceled. Use this report as a starting point to troubleshoot failed scans.

- Glossary insights. This report summarizes a business vocabulary that represents an organization’s performance, culture, and operations, so that business users can understand the completeness of their glossary terms.

- Classification insights. An organization’s security administrators typically use this report to understand the types of information being used and scanned.

- Sensitivity Labeling insights. This report has details about the sensitivity labels found during a scan.