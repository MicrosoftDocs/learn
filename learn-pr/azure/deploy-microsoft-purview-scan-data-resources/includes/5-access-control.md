# Access Control

As Fabrikam's usage of Microsoft Purview expands, it will become increasingly important that assets are logically grouped to aid data management and discovery, as well as ensuring user of the Microsoft Purview service have the right level of access to perform tasks such as curating and enriching the data catalog.

At the core of Microsoft Purview, the data map keeps an up-to-date map of your data assets (tables, files, ect...) and their metadata. To build this data map, you'll register and scan data sources into this map. In an organization there might be thousands of sources of data! To organize all this information, and build security boundaries for access and data discovery, Microsoft Purview uses collections.

## Collections

A collection enables Microsoft Purview to logically group assets, sources, and other artifacts into a customized hierarchy. When you first create your Microsoft Purview account, only the root collection is automatically created. This collection has the same name as your Microsoft Purview account and will always be the top-level collection.

All other collections will be created by you or your team, and should reflect your business landscape. These collections will be your map through your data estate in Microsoft Purview, and will be how you organize your data, users, and access control.

:::image type="content" source="../media/05.01-purview-collections.png" alt-text="Screenshot of a collection hierarchy, with the ACCOUNT-NAME root collection, and two subcollections beneath: Sales and Marketing":::

In the example above, we have the root collection (ACCOUNT-NAME), and two sub collections: Sales and Marketing. Users that need access only to Sales data should be granted permission only at the Sales collection level. The same for Marketing. If a user needs to be able to access all data, or maintain all collections within Microsoft Purview, they should be granted permission at the root collection, which will give them permission to the root collection and its subcollections.

When thinking about setting up collections, consider how your business is structured, your security requirements, and what kinds of data users might need. When thinking about permissions in Microsoft Purview, best practice would be:

- Users have the minimum amount of access they need to do their jobs.
- Users don't have access to sensitive data that they don't need.


## Roles

Microsoft Purview uses a set of predefined roles to control who can access what within the account. These roles are currently:

* **Collection admin**: Collection admins can edit the collection, its details, and add subcollections. They can also add data curators, data readers, and other Microsoft Purview roles to a collection scope. Collection admins that are automatically inherited from a parent collection can't be removed.
* **Data source admin**: Data source admins can manage data sources and data scans.
* **Data curator**: Data curators can perform create, read, modify, and delete actions on catalog data objects and establish relationships between objects.
* **Data reader**: Data readers have access to read catalog data objects.
* **Policy author**: Policy authors can create, view, update and delete policies through the Policy management app.
* **Workflow admin**: Workflow admins can perform create, read, modify, and delete action on workflow definitions and the associated workflow runs. Workflow admins can also bind workflow definition with supported business objects.

:::image type="content" source="../media/05.02-purview-roles.png" alt-text="Microsoft Purview Roles":::
