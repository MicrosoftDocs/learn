Here, we'll discuss how you can decide if Microsoft Purview is the right choice for your data-governance and discovery needs. Here are the criteria that indicate whether Microsoft Purview will meet your requirements:

* Discovery
* Governance

## Decision criteria

Let's take a look at the listed criteria and see how Microsoft Purview can help address the needs in those specific areas.

### Discovery

Because there's no central location to register data sources, users might be unaware of a data source unless they come into contact with it as part of another process. The catalog makes data sources easily discoverable and understandable by the users who manage the data.

Unless users know the location of a data source, they can't connect to the data by using a client application. Data-consumption experiences require users to know the connection string or path.

The intended use of the data is hidden to users unless they know the location of a data source's documentation. Data sources and documentation might live in several places and be consumed through different kinds of experiences.

### Governance

As the data in your organization grows, the task of discovering, protecting, and governing that data becomes increasingly difficult. Data is stored in different locations, which may be required for compliance reasons. The data may contain sensitive information such as credit card numbers, social security numbers, or other personal information.

Compliance with company security policies, government regulations, and customer needs are critical considerations for data governance. Understanding which data sources contain sensitive information is key to knowing where protections are needed and how to guard against access to this sensitive data.

:::image type="content" source="../media/classifications.png" alt-text="Screenshot depicting a small snippet of the system-provided classifications for metadata. You can find this list in the Management pane of the Microsoft Purview governance portal. Some items displayed are the ABA Routing Number, Age of individual, and Argentina National Identity (DNI) Number.":::

## Apply the criteria

Let's take a look at how Microsoft Purview can address the criteria mentioned.

### Does Microsoft Purview help with data discovery?

Do you require a solution or centralized location to register data sources? For the most part, users might be unaware of a data source unless they come into contact with it as part of another process. Microsoft Purview can help to provide a solution.

Once you've registered data sources in the Microsoft Purview governance portal and displayed them in the data map, you can set up scanning of those data sources. The metadata returned helps catalog the data found in those sources, making it easier for users to discover what the data sources contain. The metadata is also indexed to make each data source easily discoverable via search and understandable to the users who discover it.

At the same time, users can contribute to the catalog by tagging, documenting, and annotating data sources that have already been registered. They can also register new data sources, which are then discovered, understood, and consumed by the community of catalog users.

:::image type="content" source="../media/list-view.png" alt-text="Screenshot of the Sources window in the Microsoft Purview governance portal. It depicts the List View option for a Blob Storage data source, showing columns for source name, source type, associated collection, source ID, any scans that are associated, and the date the source was registered.":::

### Does Microsoft Purview help with data governance?

Microsoft Purview can scan and automatically classify documentation files. Microsoft Purview classifies data by RegEx and Bloom Filter. Bloom Filter classifications include attributes for city, country/region, place, and person information. RegEx classifications cover a broad range of attributes that cover categories such as bank information (ABA routing numbers or country/region-specific banking account numbers), passport numbers, country/region-specific identification numbers, and so on. You can find the [full list of supported classifications](/azure/purview/supported-classifications) in the documentation for Microsoft Purview.

Microsoft Purview also uses predefined Data Plane roles to help control who has access to the information in Microsoft Purview. For access, users can only use the Microsoft Purview Account if they're placed in at least one of the supported roles (Data Reader, Data Curator, Data Source Administrator). When a Microsoft Purview Account is created, no one but the creator can access the account or use its APIs until they're put in one or more of the previously defined roles. The roles are:

* **Purview Data Reader Role**: Has access to the Microsoft Purview governance portal and can read all content in Microsoft Purview except for scan bindings.
* **Purview Data Curator Role**: Has access to the Microsoft Purview governance portal and can read all content in Microsoft Purview except for scan bindings. Can edit information about assets, can edit classification definitions and glossary terms, and can apply classifications and glossary terms to assets.
* **Purview Data Source Administrator Role**: Doesn't have access to the Microsoft Purview governance portal (the user needs to also be in the Data Reader or Data Curator roles). Can manage all aspects of scanning data into Microsoft Purview, but doesn't have read or write access to content in Microsoft Purview beyond those tasks related to scanning.

:::image type="content" source="../media/purview-data-roles.png" lightbox="../media/purview-data-roles-expanded.png" alt-text="Screenshot depicting the three Data Plane roles, which you can find in the Access control (IAM) pane for the Microsoft Purview account in the Azure portal. There are other roles displayed in the Roles tab, along with these three Data Plane roles.":::

The role assignment is managed via Azure's role-based access control (RBAC) capabilities.
