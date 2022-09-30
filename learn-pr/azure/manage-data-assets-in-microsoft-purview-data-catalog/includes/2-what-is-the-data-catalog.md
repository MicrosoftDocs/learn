
The Microsoft Purview Data Catalog is one of two main applications that sits atop the Microsoft Purview Data Map.

Once data sources have been registered and scanned in the Microsoft Purview Data Map, metadata about the data sources and their assets are stored in the data map. Assets will be things like a file in Azure Blob Storage, or a table in a SQL server. Metadata that is gathered about these assets will be information like: asset type, classifications of data types in the asset, schema (column names, data types), lineage (where the data came from), and related assets.

Though metadata is stored in the data map, the Microsoft Purview Data Catalog that allows users to search and browse the information to find the data assets they're looking for. It also allows users to add more metadata to provide context for data in your business.

You can think of it this way:

The data map helps to **map** data sources to your organization and grant access to that information. The data map answers basic data estate questions like:

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

In this unit we'll, explore each of these aspects so you can use the data catalog to understand your data landscape and discover trustworthy data within your organization.

## Search and browse

Once your data sources have been scanned, the assets will be available to users who have permissions to find them. Your users will no longer need to track down individuals who own data sources or use team knowledge to keep track of valuable information.

Users can search all available assets through the Microsoft Purview Data Catalog using keywords like name, data type, classifications, and glossary terms. And during the search, it also provides more filters that may help users narrow down their search for relevant data. For example, if you're looking for sales receipts that you know are stored in a file format, you can narrow your search to only include file-based repositories like Azure Data Lake Storage Gen2.

While searching is great if you know what you're looking for, there are times when users don't know exactly what they need--then they can browse assets available to them either by collection, which will organize assets by their collections in Microsoft Purview and the data sources in those collections, or by source type, which allows you to browse data by specific courses, like a SQL Server and its databases.

As you're browsing, you can choose other parameters to apply, like classification (for example: EU Phone Number, Credit Card Number, Country/Region), a specific contact, content type, or related information.

Search and browse will only return results from collections that users have access to.

Remember, the Microsoft Purview Data Map, data sources are registered to collections, and when a scan is performed, data assets from those sources are added into the same collections. Users are assigned permissions in Microsoft Purview by collection, so users will be able to freely use Microsoft Purview Data Catalog's search and browse functions, while keeping data secure and allowing teams to manage their own information.

## Trustworthy data

The data catalog also allows you to mark and manage trustworthy data sets, so your users know which sources are up to date and ready for use. You can do this using a **certified** flag, that can be applied by data stewards in Microsoft Purview, and allows users to find quality data on their own without data stewards needing to field regular questions.

## Using the catalog across Azure

The Microsoft Purview Data Catalog also allows users to search for data where they need it. If you register your Microsoft Purview instance to an Azure Data Factory or an Azure Synapse Analytics workspace, your users can search the Microsoft Purview Data Catalog directly from those services to find the data they need.

In the next exercise, we'll show you how to search and browse through assets in your data catalog.
