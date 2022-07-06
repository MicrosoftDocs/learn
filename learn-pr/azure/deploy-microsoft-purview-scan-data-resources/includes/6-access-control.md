Now that you've created your Microsoft Purview account, we'll need to add other users and start organizing your data map.

As we discussed in the last section, the Microsoft Purview Data Map is the core of your account. It keeps an up-to-date map of your data assets (tables, files, etc.) and their metadata.

:::image type="complex" source="../media/purview-data-map.png" alt-text="Diagram showing the Microsoft Purview Data Map.":::
   "The Data Map is at the top of the diagram, with on-premises, cloud, S A A S applications, and Power BI data flowing into the map. The data map information flows into collections. Collections are split into two parts: registered sources that contain assets (tables, files, etc.), and access control that contains users and groups assigned to roles."
:::image-end:::

To build this data map, you'll register and scan your data sources into Microsoft Purview. The data map will store the metadata for these sources and create a navigable table that you can browse through.

In a single corporation there might be thousands of sources of data! To organize all this information and build security boundaries for access and data discovery, Microsoft Purview uses collections.

## Collections

A collection is a grouping of data sources and assets that are defined by your organization. Collections allow you to structure your data assets in a customized hierarchy that reflects your organization. Let's look at what that means.

:::image type="content" source="../media/example-collections.png" alt-text="Screenshot of collections in Microsoft Purview, with the root collection called Fabrikam Purview, and subcollections, Development, Finance, Marketing, Outreach, and Sales. Finance also has subcollections:":::

When you first create your Microsoft Purview account, only the root collection is automatically created. In the example above, the root collection is called FabrikamPurview.

This collection has the same name as your Microsoft Purview account and will always be the top-level collection, but works like any other collection. You can add permissions for users, register sources, or create subcollections.

All other collections will be created by you or your team, and should reflect your business landscape. In the example above, the collections are groups within the Fabrikam organization. When you set up collections in your account, you want to think about how your organization is structured, or how data is currently accessed and managed. These collections will be how you navigate through your data estate in Microsoft Purview, and will also be how you manage access control in your data map.

Let's look at a smaller example:

:::image type="content" source="../media/purview-collections.png" alt-text="Screenshot of a collection hierarchy, with the ACCOUNT-NAME root collection, and two subcollections beneath: Sales and Marketing":::

In the image above, we have the root collection (ACCOUNT-NAME), and two sub collections: Sales and Marketing. 

For our Fabrikam proof of concept, we may create a structure like this if Fabrikam has organized teams with specialized functions, and specialized data they need to manage and discover. All data sources associated with Sales could be registered to the Sales collection, and all data sources associated with Marketing would be registered with the Marketing collection. 

Users on the Sales team could be granted permission to the Sales collection, and would only be able to see information on data sources that were registered to the Sales collection. The same for Marketing. 

If a user needed to be able to access all data, or maintain all collections within the Microsoft Purview account, they should be granted permission at the root collection, which will give them permission to the root collection (ACCOUNT-NAME) and its subcollections (Sales and Marketing).

When thinking about setting up collections, consider how your business is structured, your security requirements, and what kinds of data users might need. For the small proof of concept, we're only going to register a single storage account, but for an expanded proof of concept, or when deploying Microsoft Purview across an entire data estate (that is, registering all or most of your data sources to the data map), it's important that your sources are logically grouped. 

Sources that are well organized to reflect your business structure improve data management, discovery, and right use of data. When thinking about permissions in Microsoft Purview, best practice would be:

- Users have the minimum amount of access they need to do their jobs.
- Users don't have access to sensitive data that they don't need.

## Roles

To manage access control in collections, Microsoft Purview uses a set of predefined roles to control who can access what within the account. Access is applied at the level of the collection it's assigned and inherited downwards.

In our above example, permissions applied at the root collection (ACCOUNT-NAME) will also be applied to its subcollections, Sales and Marketing. But permissions on Sales and Marketing won't apply to any sources registered on the root collection, and they won't apply laterally to each other. They would only be applied to any subcollections that may be added later.

:::image type="content" source="../media/purview-collections.png" alt-text="A repeated screenshot of a collection hierarchy, with the ACCOUNT-NAME root collection, and two subcollections beneath: Sales and Marketing":::

We won't need all the roles available for our proof of concept, but some of Microsoft Purview's roles currently are:

* **Collection admin**: Collection admins can edit the collection they're assigned to and add subcollections. They can also add data curators, data readers, and other Microsoft Purview roles to a collection. Collection admins that are automatically inherited from a parent collection can't be removed from the subcollection.
* **Data source admin**: Data source admins can manage data sources and data scans on the collection they're assigned to, and any subcollections.
* **Data curator**: Data curators can perform create, read, modify, and delete actions on catalog data objects and establish relationships between objects.
* **Data reader**: Data readers have access to read catalog data objects.

:::image type="content" source="../media/purview-roles.png" alt-text="Microsoft Purview Roles":::

> [!TIP]
> The Microsoft Purview Data Catalog is a companion to the Data Map. It's a searchable inventory of assets and their metadata that allows users to find and curate data across their data estate. The Data Catalog also includes a business glossary where subject matter experts can provide terms and definitions to add a business context to an asset.
>
> Essentially it's a tool that allows you to find, personalize, organize the information that the Data Map is holding.

## Inherited access

The permissions of a parent collection are automatically inherited by its subcollections. This allows you to assign some groups or users broad access across the organization, so users can discover and manage data across an entire section, without having to assign individual permissions to every single subcollection.

However, you may have groups within your organization that have sensitive data that should restrict inheritance so only that group can discover and manage the information within.

There's an option within every subcollection that is **Restrict permission inheritance** that stops this automatic process of inheritance. If you enable this option, its subcollections will no longer inherit permissions from the parent and will need to be added directly. However, collection admins that are automatically inherited from a parent collection can't be removed, so select your collection administrators carefully!

