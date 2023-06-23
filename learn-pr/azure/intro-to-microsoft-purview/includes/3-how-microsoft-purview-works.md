Here's where we take a look at how Microsoft Purview works. In this unit, you learn the core operational theory behind the functioning of Microsoft Purview for mapping and scanning your data sources. The key areas we focus on include how to:

* Load data in the data map.
* Browse and search information in the data catalog.

## Load data in the data map

The Microsoft Purview Data Map is a unified map of your data assets and their relationships. As one cohesive map, it's easier for you and your users to visualize and govern. It also houses the metadata that underpins the Microsoft Purview Data Catalog and Data Estate Insights. It scales up and down to meet your enterprise compliance requirements. You can use it to govern your data estate in a way that makes the most sense for your business.

### Source data

Sourcing your data starts with a process where you register data sources. Microsoft Purview supports an array of data sources that span on-premises, multicloud, and software-as-a-service (SaaS) options. You register the various data sources so that Microsoft Purview is aware of them. The data remains in its location and isn't migrated to any other platform.

After you have a Microsoft Purview service configured in Azure, you use the Microsoft Purview governance portal to register your data sources.

:::image type="content" source="../media/purview-studio.png" alt-text="Screenshot that shows the Microsoft Purview governance portal. The portal includes the name of the Microsoft Purview account along with options to select, including Knowledge center, Register sources, Browse assets, and Manage glossary.":::

Each type of data source you choose requires specific information to complete the registration. For example, if your data sources reside in your Azure subscription, you choose the necessary subscription and storage account name. The following image is an example of choosing an Azure Blob Storage source.

:::image type="content" source="../media/register-sources-form.png" alt-text="Screenshot that shows the dialog to register an Azure Blob Storage source for Microsoft Purview. The dialog has entries for a name, Azure subscription name and storage account name, an endpoint, and a collection to which to add the source.":::

After registration, you scan the data source. Scanning ingests metadata about your data source into the Microsoft Purview Data Map. Each data source has specific requirements for authenticating and configuration to permit scanning of the assets in that data source.

For example, if you have data stored in an Amazon S3 standard bucket, you need to provide a configuration for the connection. For this service, you use Microsoft Purview to provide a Microsoft account with secure access to AWS, where the Microsoft Purview scanner will run. The Microsoft Purview scanner uses this access to your Amazon S3 buckets to read your data. The scanner then reports the results (including only the metadata and classification) back to Azure. You can use the Microsoft Purview classification and labeling reports to analyze and review your data scan results.

> [!NOTE]
> Check the [Microsoft Purview connector for Amazon S3 documentation](/azure/purview/register-scan-amazon-s3) for region support related to AWS S3 sources.

In Microsoft Purview, there are a few options to use for authentication when the service needs to scan data sources. Some of these options are:

* Microsoft Purview managed identity
* Account key (using Azure Key Vault)
* SQL authentication (using Key Vault)
* Service principal (using Key Vault)

### Map data

The data map is the foundational platform for Microsoft Purview. The data map consists of:

- Data assets.
- Data lineage.
- Data classifications.
- Business context.

Customers create a knowledge graph of data that comes in from a range of sources. Microsoft Purview makes it easy to register and automatically scan and classify data at scale. Within the data map, you can identify the type of data source, along with other details around security and scanning.

The data map uses collections to organize these details. Collections are a way of grouping data assets into logical categories to simplify management and discovery of assets within the catalog. You also use collections to manage access to the metadata that's available in the data map.

Select **Map view** in the Microsoft Purview governance portal to display the data sources in a graphical view, along with the collections you created for them.

:::image type="content" source="../media/data-map-collections.png" alt-text="Screenshot that shows the Map view of the sources window in the Microsoft Purview governance portal. Three collections are listed, each with a single data source, and two other data sources that aren't assigned to a collection.":::

### Scan data

After you register your data sources, you need to run a scan to access the metadata and browse the asset information. Before you can scan the data sources, you're required to enter the credentials for these sources. You can use Azure Key Vault to store the credentials for security and ease of access by your scan rules. The Microsoft Purview governance portal comes with existing system scan rule sets that you can select when you create a new scan rule. You can also specify a custom scan rule set.

A scan rule set is a container for grouping scan rules together to use the same rules repeatedly. A scan rule set lets you select file types for schema extraction and classification. It also lets you define new custom file types. You might create a default scan rule set for each of your data source types. Then you can use these scan rule sets by default for all scans within your company.

For example, you might want to scan only the .csv files in an Azure Data Lake Storage account. Or you might want to check your data only for credit card numbers rather than all the possible classifications. You might also want users with the right permissions to create other scan rule sets with different configurations based on business need.

:::image type="content" source="../media/scan-rule-sets.png" lightbox="../media/scan-rule-sets-expanded.png" alt-text="Screenshot that shows the Management panel selected in the Microsoft Purview governance portal. The Scan rule sets option is also selected. A list of System-provided scan rule sets are preconfigured for data sources such as Azure File Service and SQL Server.":::

### Classification

Metadata is used to help describe the data that's being scanned and made available in the catalog. During the configuration of a scan set, you can specify classification rules to apply during the scan that also serve as metadata. The classification rules fall under five major categories:

* **Government**: Attributes such as government identity cards, driver license numbers, and passport numbers.
* **Financial**: Attributes such as bank account numbers or credit card numbers.
* **Personal**: Personal information such as a person's age, date of birth, email address, and phone number.
* **Security**: Attributes like passwords that can be stored.
* **Miscellaneous**: Attributes not included in the other categories.

You can use several system classifications to classify your data. These classifications align with the sensitive information types in the Microsoft Purview compliance portal. You can also create custom classifications to identify other important or sensitive information types in your data estate.

:::image type="content" source="../media/classifications.png" alt-text="Screenshot that shows a small snippet of the system-provided classifications for metadata. You can find this list in the Management pane of the Microsoft Purview governance portal. Some items displayed are the ABA Routing Number, Age of individual, and Argentina National Identity (DNI) Number.":::

After you register a data source, you can enrich its metadata. With proper access, you can annotate a data source by providing descriptions, ratings, tags, glossary terms, identifying experts, or other metadata for requesting data-source access. This descriptive metadata supplements the structural metadata, such as column names and data types, that's registered from the data source.

Discovering and understanding data sources and their use is the primary purpose of registering the sources. If you're an enterprise user, you might need data for business intelligence, application development, data science, or any other task where the right data is required. You can use the data catalog discovery experience to quickly find data that matches your needs. You can evaluate the data for its fitness for the purpose and then open the data source in your tool of choice.

At the same time, you can contribute to the catalog by tagging, documenting, and annotating data sources that have already been registered. You can also register new data sources, which are then discovered, evaluated, and used by the community of catalog users.

## Browse and search

Microsoft Purview allows you to search information from the data map by using the Microsoft Purview Data Catalog. You can perform text-based search and browse through results by using filters like data source type, tags, ratings, or collection.

You can use business context to search information from the Microsoft Purview catalog. You can define business glossaries and bulk import existing ones, too. You can also apply business context onto assets in the data map. By using a metamodel, you can define business processes in your environment and associate your data sources with those processes. Users can then apply these business contexts to browse and search for information in the data catalog.

Discovery enables you to use:

* Semantic search and browse.
* Business glossary and workflows.
* Data lineage with sources, owners, transformations, and lifecycle​.

:::image type="content" source="../media/search.png" alt-text="Screenshot that shows the fictional company Adatum Corporation by using the search function of Microsoft Purview.":::

## Data lineage

The concept of data lineage focuses on the lifecycle of data. The lifecycle concerns itself with the various stages data might go through. Data is sourced, moved, and stored throughout its lifecycle. Data might also undergo transformations in the extract, load, and transform/extract, transform, and load (ELT/ETL) operations.

Data lineage can offer insights into the data lifecycle by looking at the data pipeline. You can use the lineage to identify the root cause of data issues, perform data quality analysis, and verify compliance.

Microsoft Purview represents this data lineage in a visual form by showing data movement from source to destination.

:::image type="content" source="../media/lineage-end-end.png" lightbox="../media/lineage-end-end-expanded.png" alt-text="Screenshot that shows a sample data lineage graph in Microsoft Purview.":::
