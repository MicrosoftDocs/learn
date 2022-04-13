Azure Purview uses Collections to organize and manage access to sources, assets, and other artifacts. This unit describes collections and access management in your Azure Purview account.

## Collections
A collection enables Azure Purview to logically group assets, sources, and other artifacts into a hierarchy for discoverability and to manage access control. All accesses to Azure Purview's resources are managed from collections in the Azure Purview account.

![Azure Purview Collections](../media/05.01-purview-collections.png)

## Roles
Azure Purview uses a set of predefined roles to control who can access what within the account. THese roles are currently:

* **Collection admin**: Collection admins can edit the collection, its details, and add subcollections. They can also add data curators, data readers, and other Azure Purview roles to a collection scope. Collection admins that are automatically inherited from a parent collection can't be removed.
* **Data source admin**: Data source admins can manage data sources and data scans.
* **Data curator**: Data curators can perform create, read, modify, and delete actions on catalog data objects and establish relationships between objects.
* **Data reader**: Data readers have access to read catalog data objects.
* **Policy author**: Policy authors can create, view, update and delete policies through the Policy management app.
* **Workflow admin**: Workflow admins can perform create, read, modify, and delete action on workflow definitions and the associated workflow runs. Workflow admins can also bind workflow definition with supported business objects.

![Azure Purview Roles](../media/05.02-purview-roles.png)