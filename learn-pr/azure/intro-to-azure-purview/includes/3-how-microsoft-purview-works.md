Here is where we will take a look at how Microsoft Purview works, behind the scenes. You'll learn the core operational theory behind the functioning of Microsoft Purview for mapping and scanning your data sources. The key areas we will focus on include:

* Loading Data in the Data Map
* Browse and Search Information

## Loading data in the Data Map

The Purview Data Map is a unified map of your data assets and their relationships that enable more effective governance for your data estate. It is a knowledge graph that is the underpinning for the Purview Data Catalog and all the features that it has to offer. It is scalable and robust to meet your enterprise compliance requirements.

### Sourcing data
Sourcing your data starts with a process where you register data sources. Microsoft Purview supports an array of data sources that span on-premises, multi-cloud, and software-as-a-service (SaaS) options. You register the various data sources so Microsoft Purview is aware of them. The data remains in its location and is not migrated to any other platform.

Registering a data source is done from within the Azure portal. Once you have a Microsoft Purview service configured in Azure, you use the Microsoft Purview governance portal to register your data sources.

:::image type="content" source="../media/purview-studio.png" alt-text="Screenshot depicting the basic Microsoft Purview governance portal screen. We see the name of the Purview account along with options to select which include Knowledge center, Register sources, Browse assets, and Manage glossary.":::

Each type of data source you choose, will require specific information to complete the registration. For example, if your data sources reside in your Azure subscription, you will choose the necessary subscription and storage account name.  The following image is an example of choosing an Azure Blob Storage source.

:::image type="content" source="../media/register-sources-form.png" alt-text="Screenshot depicting the dialog to register an Azure Blob Storage source for Microsoft Purview. The dialog has entries for a name, Azure subscription name and storage account name, an endpoint, and a collection to add the source to.":::

Each data source will have specific requirements for authenticating and configuration, to permit scanning of the assets in that data source. If you have data stored in an Amazon S3 standard bucket, you will need to provide configuration for the connection. For this service, use Purview to provide a Microsoft account with secure access to AWS, where the Purview scanner will run. The Purview scanner uses this access to your Amazon S3 buckets to read your data, and then reports the scanning results, including only the metadata and classification, back to Azure. Use the Purview classification and labeling reports to analyze and review your data scan results.

> [!NOTE]
> Check the [Microsoft Purview connector for Amazon S3 documentation](/azure/purview/register-scan-amazon-s3) for region support related to AWS S3 sources.

In Microsoft Purview, there are a few options to use for authentication when the service needs to scan data sources. Some of these options are:

* Microsoft Purview Managed Identity
* Account Key (using Key Vault)
* SQL Authentication (using Key Vault)
* Service Principal (using Key Vault)

### Mapping data
A data map is the foundational platform for Microsoft Purview. Data Map = Data assets + Lineage + Classifications + Business Context. Customers create a knowledge graph of data coming in from a range of sources. Purview makes it easy to register, and automatically scan and classify data at scale. Within the data map, you can identify the type of data source along with other details around security, scanning, etc. The data map allows you to use collections as well.

Collections are a way of grouping data assets into logical collections (Categories), to simplify management and discovery of assets within the catalog.

Selecting the Map view displays the data sources in a graphical view, along with the collections you have created for them.

:::image type="content" source="../media/data-map-collections.png" alt-text="Screenshot depicting map view of the sources window in the Microsoft Purview governance portal. There are three collections listed, each with a single data source, and two other data sources that are not assigned to a collection.":::

### Scanning data
Once you have your data sources registered, you will need to run a scan to be able to access the metadata and browse the asset information. You configure scan rules for the data you want to scan. In a Microsoft Purview catalog, you can create scan rule sets to enable you to quickly scan data sources in your organization.

A scan rule set is a container for grouping a set of scan rules together so that you can easily associate them with a scan. A scan rule set lets you select file types for schema extraction and classification, and it also let’s you define new custom file types. For example, you might create a default scan rule set for each of your data source types, and then use these scan rule sets by default for all scans within your company. You might also want users with the right permissions to create other scan rule sets with different configurations based on business need.

Scanning the data sources will require the entry of credentials for these sources. You can store the credentials in an Azure Key Vault for security and ease of access by your scan rules. The Microsoft Purview governance portal comes with existing system scan rule sets that you can select when creating a new scan rule, or you can specify a custom scan rule set.

:::image type="content" source="../media/scan-rule-sets.png" lightbox="../media/scan-rule-sets-expanded.png" alt-text="Screenshot depicting the Management panel selected in the Microsoft Purview governance portal and the Scan rule sets option also selected.  Displayed is a list of System provided scan rule sets that pre-configured for the various data sources such as Azure File Service, SQL Server, etc.":::

You can also select the file types to include in the scan. The file types will be used in the schema extraction and classification of the data. Built-in file type support includes the following types:

* CSV
* JSON
* PSV
* SSV
* TSV
* TXT
* XML
* PARQUET
* AVRO
* ORC
* Document file types (.doc, pdf, xls, etc.)

You can select which system and custom classification rules you want to run. The system classification rules are the same as the sensitive information types in Microsoft 365, which will let you extend your sensitivity labeling policies in the Microsoft 365 Compliance Center to Microsoft Purview supported stores.

### Classification
Metadata is used to help describe the data that is being scanned and made available in the catalog. During the configuration of a scan set, you can specify classification rules to apply during the scan that will also serve as metadata. The classification rules fall under five major categories:

* Government - covers attributes such as government identity cards, driver license numbers, passport numbers, etc.
* Financial - covers attributes such as bank account numbers or credit card numbers.
* Personal - personally identifiable information such as a person's age, date of birth, email address, phone number, etc.
* Security - attributes like passwords that may be stored.
* Miscellaneous - attributes not covered in the other categories.

:::image type="content" source="../media/classifications.png" alt-text="Screenshot depicting a small snippet of the System provided classifications for metadata. You would find this list in the Management pane of the Microsoft Purview governance portal. Some items displayed are the ABA Routing Number, Age of individual, and Argentina National Identity (DNI) Number.":::

After you register a data source, you can then enrich its metadata. Either the user who registered the data source or another user in the enterprise adds the metadata. Any user can annotate a data source by providing descriptions, tags, or other metadata for requesting data source access. This descriptive metadata supplements the structural metadata, such as column names and data types, that's registered from the data source.

Discovering and understanding data sources and their use is the primary purpose of registering the sources. Enterprise users might need data for business intelligence, application development, data science, or any other task where the right data is required. They use the data catalog discovery experience to quickly find data that matches their needs, understand the data to evaluate its fitness for the purpose, and consume the data by opening the data source in their tool of choice.

At the same time, users can contribute to the catalog by tagging, documenting, and annotating data sources that have already been registered. They can also register new data sources, which are then discovered, understood, and consumed by the community of catalog users.

## Browse and search

Microsoft Purview allows you to search information from Data Map using Purview Catalog. You can perform text-based search and incorporate business context into the search as well.

Use business context to search information from the Purview catalog. You can define business glossaries (bulk import existing ones too) and apply business context onto assets in the Data Map. They can then use this business context to browse and search information from the Data Map.

Enable effortless discovery with:

* Semantic search and browse
* Business glossary and workflows
* Data lineage with sources, owners, transformations, and lifecycle​


:::image type="content" source="../media/search.png" alt-text="Screenshot depicting fictional company Adatum Corporation using the search functional of Microsoft Purview.":::

## Data lineage

The concept of data lineage focuses on the lifecycle of data. The lifecycle concerns itself with the various stages data may go through. Data is sourced, moved, and stored throughout the lifecycle. Data may also undergo transformations in the extract load transform / extract transform load (ELT/ETL) operations.

Data lineage can offer insights into the data lifecycle by looking at the data pipeline. You can use the lineage to identify the root cause of issues, perform data quality analysis, and verify compliance.

Microsoft Purview represents this data lineage in a visual form, showing data movement from source to destination.

:::image type="content" source="../media/lineage-end-end.png" lightbox="../media/lineage-end-end-expanded.png" alt-text="Screen shot depicting a sample data lineage graph in Microsoft Purview":::
