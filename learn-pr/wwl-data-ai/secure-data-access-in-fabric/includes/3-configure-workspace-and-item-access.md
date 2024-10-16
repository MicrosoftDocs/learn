
## Configure workspace roles and item permissions
Workspaces are environments where users can collaborate to create groups of items.  Items are the resources you can work with in Fabric such as lakehouses, warehouses and reports. Workspace roles are pre-configured sets of permissions that let you manage what users can do and access in a Fabric workspace.

Item permissions control access to individual Fabric items within a workspace. Item permissions let you either adjust the permissions set by a workspace role or give a user access to one or more items within a workspace without adding the user to a workspace role.

Let's consider some scenarios where you would need to configure data access using  workspace roles and item permissions.

## Understand workspace roles
Suppose you work at a health care company as the Fabric security admin. You need to set up access for a new data engineer. The data engineer needs the ability to:
- Create Fabric items in an existing workspace
- Read all data in an existing lakehouse that's in the same workspace where they can create Fabric items

Workspace roles control what users can do and access within a Fabric workspace. There are four workspace roles and they apply to *all items* within a workspace. Workspace roles can be assigned to individuals, security groups, Microsoft 365 groups, and distribution lists. Users can be assigned to the following roles:

- **Admin** - Can view, modify, share, and manage all content and data in the workspace, and manage permissions.
- **Member** - Can view, modify, and share all content and data in the workspace.
- **Contributor** - Can view and modify all content and data in the workspace.
- **Viewer** - Can view all content and data in the workspace, but can't modify it.

> [!Tip]
> For a full list of the permissions associated with workspace roles, see: [Roles in workspaces](../get-started/roles-workspaces.md)

To meet the access requirements for the new data engineer, you can assign them the workspace **Contributor**. This will give them access to modify content in the workspace, including creating Fabric items like lakehouses. The contributor role would also allow them to read data in the existing lakehouse.

### Assign workspace roles

Users can be added to workspace roles from the **Manage access** button from within a workspace.  

![Manage access](../media/manage-access.png)

Add a user by entering the user's name and selecting the workspace role to assign them in the **Add people** dialogue. 

![Add people](../media/add-people.png)

## Configure item permissions
Suppose that after a few months of having **Contributor** access on the workspace, the data engineer now only needs access to view a single lakehouse and read data in it. 

Item permissions control access to individual Fabric items within a workspace. They  give a user access to one or more items within a workspace without adding the user to a workspace role.

Since the engineer no longer needs to view all items in the workspace, the **Contributor** workspace role can be removed and item permissions on the lakehouse can be configured so the engineer will only be able to see the lakehouse metadata and data and nothing else in the workspace. This item access configuration helps you adhere to the principle of least privilege, where the engineer only has access to what's needed to perform their job duties.

Item permissions can be configured by selecting on the ellipse (...) next to a Fabric item in a workspace and then selecting **Manage permissions** and then adding the user. 

 ![Configure item permissions](../media/manage-item-permissions.png)

In the **Grant people access** window that appears after selecting **Manage permissions**, if you add the user and don't click any of the checkboxes under **Additional permissions**, the user will have read access to the lakehouse metadata and any reports associated with the lakehouse. The goal in this example was to grant the engineer the ability to read data and not just metadata, so **Read all SQL endpoint data** and **Read all Apache Spark** can be selected.

 ![Grant people lakehouse read all access](../media/grant-people-access-lakehouse.png)

As you can see from this example, there are nuances associated with granting access to Fabric items. To learn more about the differences in setting permissions for each Fabric item, see:

* [Semantic model](/power-bi/connect-data/service-datasets-permissions)

* [Warehouse](../data-warehouse/share-warehouse-manage-permissions.md)

* [Data Factory](../data-factory/data-factory-overview.md)

* [Lakehouse](../data-engineering/lakehouse-sharing.md)

* [Data science](../data-science/models-experiments-rbac.md)

* [Real-Time Intelligence](/azure/data-explorer/kusto/management/security-roles)