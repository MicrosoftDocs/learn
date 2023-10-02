In this unit, we discuss how you can decide whether Microsoft Purview is the right choice for your data governance and discovery needs. The criteria that indicate whether Microsoft Purview will meet your requirements are:

* Discovery
* Governance

Let's take a look at these criteria and see how Microsoft Purview can help address their needs.

## Discovery

Without a central location to register data sources, you might be unaware of a data source unless you come into contact with it as part of another process.

Unless you know the location of a data source, you can't connect to the data by using a client application. You're required to know the connection string or path.

The intended use of the data is hidden to you unless you know the location of a data source's documentation. Data sources and documentation might live in several places and be utilized through different kinds of experiences.

## Governance

As the data in your organization grows, the task of discovering, protecting, and governing that data becomes more difficult. Data is stored in different locations, which might be required for compliance reasons. The data might contain sensitive information such as credit card numbers, social security numbers, or other personal information.

Compliance with company security policies, government regulations, and customer needs are critical considerations for data governance. Understanding which data sources contain sensitive information is key to knowing where protections are needed and how to guard against access to this sensitive data.

:::image type="content" source="../media/classifications.png" alt-text="Screenshot that shows a small snippet of the system-provided classifications for metadata. You can find this list in the Management pane of the Microsoft Purview governance portal. Some items displayed are the ABA Routing Number, Age of individual, and Argentina National Identity (DNI) Number.":::

## Apply the criteria

Let's take a look at how Microsoft Purview can address the data discovery and governance criteria.

### Does Microsoft Purview help with data discovery?

Do you require a solution or centralized location to register data sources? Often, users might be unaware of a data source unless they come into contact with it as part of another process. Microsoft Purview can help provide a solution.

After you've registered data sources in the Microsoft Purview governance portal and displayed them in the data map, you can set up scanning of those data sources. The metadata that's returned catalogs the data in those sources. In this way, it's easier for users to discover what the data sources contain. The metadata is indexed to make each data source easy to discover via search. It's also more understandable to the users who discover it.

Users can contribute to the catalog by tagging, documenting, and annotating data sources that have already been registered. They can register new data sources so that other catalog users can discover, understand, and utilize them.

:::image type="content" source="../media/list-view.png" alt-text="Screenshot that shows the Sources window in the Microsoft Purview governance portal. It depicts the List view option for an Azure Blob Storage data source. This view shows columns for source name, source type, associated collection, source ID, any scans that are associated, and the date the source was registered.":::

### Does Microsoft Purview help with data governance?

Microsoft Purview can scan and automatically classify data in files and tables. Microsoft Purview classifies data by Bloom Filter and RegEx. Bloom Filter classifications include attributes for city, country/region, place, and person information. RegEx classifications cover attributes that include categories like bank information (ABA routing numbers or country/region-specific banking account numbers), passport numbers, and country/region-specific identification numbers. You can find the [full list of supported classifications](/azure/purview/supported-classifications) in the documentation for Microsoft Purview.

Microsoft Purview also uses predefined Data Plane roles to help control who has access to the information in Microsoft Purview. For access, users can use the Microsoft Purview governance portal only if they're placed in at least one of the three supported roles. When a Microsoft Purview account is created, no one but the creator can access the account or use its APIs. New users must be put in one or more of the following roles:

* **Purview Data Reader role**: Has access to the Microsoft Purview governance portal and can read all content in Microsoft Purview except for scan bindings.
* **Purview Data Curator role**: Has access to the Microsoft Purview governance portal and can read all content in Microsoft Purview except for scan bindings. Can edit information about assets, classification definitions, and glossary terms. Can also apply classifications and glossary terms to assets.
* **Purview Data Source Administrator role**: Doesn't have access to the Microsoft Purview governance portal because the user must also be in the Data Reader or Data Curator roles. Can manage all aspects of scanning data into Microsoft Purview. Doesn't have read or write access to content in Microsoft Purview beyond those tasks related to scanning.

These roles are assigned by using the collections where your data sources are registered. You can grant users access to the data they might need without granting them access to the entire data estate. By assigning roles, you can promote resource discoverability while still protecting sensitive information.
