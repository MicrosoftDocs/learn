
Data catalog - discover data.

The Microsoft Purview Data Catalog is one of two main pillars in Microsoft Purview that sits atop the Microsoft Purview Data Map. The data map scans resources, and houses metadata about the assets in those resources. The data catalog allows your users to browse those assets fo data they might need based on what kind of data it is, if it's sensitive, or even based on an aspect of your business. The data catalog helps to demistify your data estate so users can find the information they need, without sacrificing security, and while allowing you to curate your experience to match your business.

Once data sources have been registered and scanned in the Microsoft Purview Data Map, metadata about the in those data sources are stored in the datamap. Assets will be things like a file in Azure Blob Storage, or a table in a SQL server. Metadata that is gathered about these assets will be information like: asset type, classifications of data types in the asset, schema (column names, data types), lineage (where the data came from), and related assets. However, the Microsoft Purview Data Map also hosts added metadata. Information like: description, associated glossary terms, and contacts for that asset.

Though this metadata is stored in the data map, it is the Microsoft Purview Data Catalog that allows users to search and browse these assets to find information they may be looking for.

You can think of it this way: The data map helps to MAP data sources to your organization and grant access to that information. The data map answers questions like: where is my data stored? Who has access to it? The data catalog allows you to find specific pieces of data and answer questions like:

- what kind of data is this?
- What does that kind of data/attribute mean for my business?
- Where does it come from?
- Who can I contact if I have more questions?
- Where can I find a data set that has X, Y, and Z attributes?
- What is this data set about?
- Do we know where column X in table Y comes from?
- Can I trust this data?


There are three main attributes of the data catalog that contribute to each other:

- Search and browse data assets
- Manage and curate your data assets
- Build a business glossary

As we move through this unit, we'll explore each of these aspects so you can see how you can use the data catalog to understand your data landscape and discover trustworthy data within your organization.

## Search and browse

Once your data sources have been scanned, the assets will be available to users who have permissions to find them. You users will no longer need to track down individuals who own data sources, or use tribal knowledge to keep track of valuable information.

Users can search all available assets through the data catalog using keywords like name, data type, classifications, and glossary terms. And during the search, it also provides additional filters that may help users narrow down their search for relevant data. For example, if you're looking for sales receipts that you know are stored in a file format, you can narrow your search to only include file-based repositories like Azure Data Lake Storage Gen2.

While searching is great if you know what you're looking for, there are times when users don't know exactly what they're looking for-- then they can browse assets avilable to them either by collection, which will organize assets by their collections in Microsoft Purview and the data sources in those collections, or by source type, which allows you to browse data by specific courses, like a SQL Server and its databases.

As you're browsing, you can choose additional parameters to apply, like classification (for example: EU Phone Number, Credit Card Number, Country/Region), a specific contact, content type, or related information.
You can also choose to filter data using an AND or OR conditions.

## Asset properties

Once you have selected a data asset, you can determine if the asset is what you're looking for by browsing it's properties:

- Overview - An asset's basic details like description, classification, hierarchy, and glossary terms.
- Properties - The technical metadata and relationships discovered in the data source.
- Schema - The schema of the asset including column names, data types, column level classifications, terms, and descriptions are represented in the schema tab.
- Lineage - This tab contains lineage graph details for assets where it's available.
- Contacts - Every asset can have an assigned owner and expert that can be viewed and managed from the contacts tab.
- Related - This tab lets you navigate through the technical hierarchy of assets that are related to the current asset you're viewing.

Assets can also be certified by data stewards, which add a little flag to an asset to endorse that an asset is ready for use across your organization. This can help users identify quality, up-to-date information, without data stewards needing to field regular questions.

In the next excercise, we'll show you how to search and browse through assets in your data catalog.

<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: briefly summarize the key skill this unit will teach

    Heading: none

    Example: "Organizations often have multiple storage accounts to let them implement different sets of requirements."

    [Learning-unit introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=main#rule-use-the-standard-learning-unit-introduction-format)
-->
TODO: add your topic sentences(s)

<!-- 2. Scenario sub-task --------------------------------------------------------------------------------

    Goal: Describe the part of the scenario that will be solved by the content in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "In the shoe-company scenario, we will use a Twitter trigger to launch our app when tweets containing our product name are available."
-->
TODO: add your scenario sub-task

<!-- 3. Prose table-of-contents --------------------------------------------------------------------

    Goal: State concisely what's covered in this unit

    Heading: none, combine this with the topic sentence into a single paragraph

    Example: "Here, you will learn the policy factors that are controlled by a storage account so you can decide how many accounts you need."
-->
TODO: write your prose table-of-contents

<!-- 4. Visual element (highly recommended) ----------------------------------------------------------------

    Goal: Visual element, like an image, table, list, code sample, or blockquote. Ideally, you'll provide an image that illustrates the customer problem the unit will solve; it can use the scenario to do this or stay generic (i.e. not address the scenario).

    Heading: none
-->
TODO: add a visual element

<!-- 5. Chunked content-------------------------------------------------------------------------------------

    Goal: Provide all the information the learner needs to perform this sub-task.

    Structure: Break the content into 'chunks' where each chunk has three things:
        1. An H2 or H3 heading describing the goal of the chunk
        2. 1-3 paragraphs of text
        3. Visual like an image, table, list, code sample, or blockquote.

    [Learning-unit structural guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-structure-learning-content?branch=main)
-->

<!-- Pattern for simple chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list, code sample, blockquote)
Paragraph (optional)
Paragraph (optional)

<!-- Pattern for complex chunks (repeat as needed) -->
## H2 heading
Strong lead sentence; remainder of paragraph.
Visual (image, table, list)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)
### H3 heading
Strong lead sentence; remainder of paragraph.
Paragraph (optional)
Visual (image, table, list)
Paragraph (optional)

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->