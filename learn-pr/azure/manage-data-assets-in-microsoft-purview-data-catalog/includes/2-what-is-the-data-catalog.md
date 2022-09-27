
The Microsoft Purview Data Catalog is one of two main pillars in Microsoft Purview that sits atop the Microsoft Purview Data Map.

Once data sources have been registered and scanned in the Microsoft Purview Data Map, metadata about the data sources are stored in the data map. Assets will be things like a file in Azure Blob Storage, or a table in a SQL server. Metadata that is gathered about these assets will be information like: asset type, classifications of data types in the asset, schema (column names, data types), lineage (where the data came from), and related assets. However, the Microsoft Purview Data Map also hosts added metadata. Information like: description, associated glossary terms, and contacts for that asset.

Though this metadata is stored in the data map, it's the Microsoft Purview Data Catalog that allows users to search and browse these assets to find information they may be looking for.

You can think of it this way: The data map helps to **map** data sources to your organization and grant access to that information. The data map answers basic data estate questions like: 
- Where is my data stored?
- Who has access to it?

The data catalog creates an index for these sources (a **catalog** for your sources) that allows you to find specific pieces of data and answer more complex questions like:
- What kind of data is this?
- What does that kind of data/attribute mean for my business?
- Where does it come from?
- Who can I contact if I have more questions?
- Where can I find a data set that has X, Y, and Z attributes?
- What is this data set about?
- Do we know where column X in table Y comes from?
- Can I trust this data?

There are three main functions of the data catalog that contribute to each other:

- Search and browse data assets
- Manage and curate your data assets
- Build a business glossary

In this unit we'll explore each of these aspects so you can use the data catalog to understand your data landscape and discover trustworthy data within your organization.

## Search and browse

Once your data sources have been scanned, the assets will be available to users who have permissions to find them. Your users will no longer need to track down individuals who own data sources or use team knowledge to keep track of valuable information.

Users can search all available assets through the data catalog using keywords like name, data type, classifications, and glossary terms. And during the search, it also provides more filters that may help users narrow down their search for relevant data. For example, if you're looking for sales receipts that you know are stored in a file format, you can narrow your search to only include file-based repositories like Azure Data Lake Storage Gen2.

While searching is great if you know what you're looking for, there are times when users don't know exactly what they're looking for--then they can browse assets available to them either by collection, which will organize assets by their collections in Microsoft Purview and the data sources in those collections, or by source type, which allows you to browse data by specific courses, like a SQL Server and its databases.

As you're browsing, you can choose other parameters to apply, like classification (for example: EU Phone Number, Credit Card Number, Country/Region), a specific contact, content type, or related information.
You can also choose to filter data using an AND or OR conditions.

Search and browse will only return results from collections that users have access to.

Remember in the last lesson, data resources are added to collections and when a scan is performed those assets are added into those collections. Users are assigned permissions in Microsoft Purview by collection, so users will be able to freely use Microsoft Purview Data Catalog's search and browse functions, while keeping data secure and allowing teams to manage their own information.

Once you register your Microsoft Purview instance to an Azure Data Factory or an Azure Synapse Analytics workspace, you can search the Microsoft Purview Data Catalog directly from those services.

## Asset properties

Once you've selected a data asset, you can determine if the asset is what you're looking for by browsing its properties:

- Overview - An asset's basic details like description, classification, hierarchy, and glossary terms.
- Properties - The technical metadata and relationships discovered in the data source.
- Schema - The schema of the asset including column names, data types, column level classifications, terms, and descriptions are represented in the schema tab.
- Lineage - This tab contains lineage graph details for assets where it's available.
- Contacts - Every asset can have an assigned owner and expert that can be viewed and managed from the contacts tab.
- Related - This tab lets you navigate through the technical hierarchy of assets that are related to the current asset you're viewing.

Assets can also be certified by data stewards, which add a little flag to an asset to endorse that an asset is ready for use across your organization. This can help users identify quality, up-to-date information, without data stewards needing to field regular questions.

In the next exercise, we'll show you how to search and browse through assets in your data catalog.
