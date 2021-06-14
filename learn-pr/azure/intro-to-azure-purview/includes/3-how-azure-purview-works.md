Here is where we will take a look at how Azure Purview works, behind the scenes. You'll learn the core operational theory behind the functioning of Azure Purview for mapping and scanning your data sources. The key areas we will focus on include:

* Sourcing data
* Mapping data
* Scanning data
* Look at metadata

## Sourcing data
Sourcing your data starts with a process where you register data sources. Azure Purview supports an array of data sources that span on-premises, multi-cloud, and software-as-a-service (SaaS) options. You register the various data sources so Azure Purview is aware of them. The data remains in its location and is not migrated to any other platform.

Registering a data source is done from within the Azure portal. Once you have an Azure Purview service configured in Azure, you use Purview Studio to register your data sources.

:::image type="content" source="../media/purview-studio.png" alt-text="Screenshot depicting the basic Purview Studio screen. We see the name of the Purview account along with options to select which include Knowledge center, Register sources, Browse assets, and Manage glossary.":::

Each type of data source you choose, will require specific information to complete the registration. For example, if your data sources reside in your Azure subscription, you will choose the necessary subscription and storage account name.  The following image is an example of choosing an Azure Blob Storage source.

:::image type="content" source="../media/register-sources-form.png" alt-text="Screenshot depicting the dialog to register an Azure Blob Storage source for Azure Purview. The dialog has entries for a name, Azure subscription name and storage account name, an endpoint, and a collection to add the source to.":::

Each data source will have specific requirements for authenticating and configuration, to permit scanning of the assets in that data source. If you have data stored in an Amazon S3 standard bucket, you will need to provide configuration for the connection. For this service, use Purview to provide a Microsoft account with secure access to AWS, where the Purview scanner will run. The Purview scanner uses this access to your Amazon S3 buckets to read your data, and then reports the scanning results, including only the metadata and classification, back to Azure. Use the Purview classification and labeling reports to analyze and review your data scan results.

In Azure Purview, there are a few options to use for authentication when the service needs to scan data sources. Some of these options are:

* Azure Purview Managed Identity
* Account Key (using Key Vault)
* SQL Authentication (using Key Vault)
* Service Principal (using Key Vault)

## Mapping data
A data map is the foundational platform for Azure Purview. Data Map = Data assets + Lineage + Classifications + Business Context. Customers create a knowledge graph of data coming in from a range of sources. Purview makes it easy to register, and automatically scan and classify data at scale. Within the data map, you can identify the type of data source along with other details around security, scanning, etc. The data map allows you to use collections as well.

Collections are a way of grouping data assets into logical collections (Categories), to simplify management and discovery of assets within the catalog.

Selecting the Map view displays the data sources in a graphical view, along with the collections you have created for them.

:::image type="content" source="../media/data-map-collections.png" alt-text="Screenshot depicting map view of the sources window in Purview Studio. There are three collections listed, each with a single data source, and two other data sources that are not assigned to a collection.":::

## Scanning data
Once you have your data sources registered, you will need to run a scan to be able to access the metadata and browse the asset information. You configure scan rules for the data you want to scan. In an Azure Purview catalog, you can create scan rule sets to enable you to quickly scan data sources in your organization.

A scan rule set is a container for grouping a set of scan rules together so that you can easily associate them with a scan. For example, you might create a default scan rule set for each of your data source types, and then use these scan rule sets by default for all scans within your company. You might also want users with the right permissions to create other scan rule sets with different configurations based on business need.

Scanning the data sources will require the entry of credentials for these sources. You can store the credentials in an Azure Key Vault for security and ease of access by your scan rules. Purview Studio comes with existing system scan rule sets that you can select when creating a new scan rule, or you can specify a custom scan rule set.

:::image type="content" source="../media/scan-rule-sets.png" alt-text="Screenshot depicting the Management panel selected in Purview Studio and the Scan rule sets option also selected.  Displayed is a list of System provided scan rule sets that pre-configured for the various data sources such as Azure File Service, SQL Server, etc.":::

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

You can also configure custom file types by providing a file extension, a description for the file type, and specify if the contents are using custom delimiters or are of a system file type.

## Metadata
Metadata is used to help describe the data that is being scanned and made available in the catalog. During the configuration of a scan set, you can specify classification rules to apply during the scan that will also serve as metadata. The classification rules fall under five major categories:

* Government - covers attributes such as government identity cards, driver license numbers, passport numbers, etc.
* Financial - covers attributes such as bank account numbers or credit card numbers.
* Personal - personally identifiable information such as a person's age, date of birth, email address, phone number, etc.
* Security - attributes like passwords that may be stored.
* Miscellaneous - attributes not covered in the other categories.

:::image type="content" source="../media/classifications.png" alt-text="Screenshot depicting a small snippet of the System provided classifications for metadata. You would find this list in the Management pane of Purview Studio. Some items displayed are the ABA Routing Number, Age of individual, and Argentina National Identity (DNI) Number.":::

After you register a data source, you can then enrich its metadata. Either the user who registered the data source or another user in the enterprise adds the metadata. Any user can annotate a data source by providing descriptions, tags, or other metadata for requesting data source access. This descriptive metadata supplements the structural metadata, such as column names and data types, that's registered from the data source.

Discovering and understanding data sources and their use is the primary purpose of registering the sources. Enterprise users might need data for business intelligence, application development, data science, or any other task where the right data is required. They use the data catalog discovery experience to quickly find data that matches their needs, understand the data to evaluate its fitness for the purpose, and consume the data by opening the data source in their tool of choice.

At the same time, users can contribute to the catalog by tagging, documenting, and annotating data sources that have already been registered. They can also register new data sources, which are then discovered, understood, and consumed by the community of catalog users.
