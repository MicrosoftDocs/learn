
## Configure workspace roles and item permissions
Workspaces are environments where users can collaborate to create groups of items.  Items are the resources you can work with in Fabric such as lakehouses, warehouses and reports. Workspace roles are pre-configured sets of permissions that let you manage what users can do and access in a Fabric workspace.

Item permissions control access to individual Fabric items within a workspace.  Different Fabric items have different permissions. Item permissions let you either adjust the permissions set by a workspace role or give a user access to one or more items within a workspace without adding the user to a workspace role.

Let's consider a scenario where you would need to configure data access by applying workspace roles and item permissions.

Suppose you work at a health care company as the Fabric security admin on the IT team. You need to set up access for a new data engineer. The data engineer needs the ability to:
- Create Fabric items in an existing workspace to ingest data, store 
- Read all data in an existing lakehouse


## Configure workspace roles
Workspace roles control what users can do and access within a Fabric workspace.  

There are four workspace roles and they apply to all items within a workspace.  
Insert the picture


levels  https://learn.microsoft.com/en-us/fabric/security/permission-model#onelake-permissions-data-access-roles

show the diagram

## Configure item permissions

## Fabric security components

There are three primary access controls in Fabric that form the components of Fabric security. 

- Workspace roles
- Item permissions
- Compute permissions

OneLake
OneLake is a single, unified, logical data lake for the entire organization, and it's automatically provisioned for every Fabric tenant. It's built on Azure and it can store any type of file, structured or unstructured. Also, all Fabric items, like warehouses and lakehouses, automatically store their data in OneLake.

OneLake supports the same Azure Data Lake Storage Gen2 (ADLS Gen2) APIs and SDKs, therefore it's compatible with existing ADLS Gen2 applications, including Azure Databricks.

For more information, see Fabric and OneLake security.

Workspace security
Workspaces represent the primary security boundary for data stored in OneLake. Each workspace represents a single domain or project area where teams can collaborate on data. You manage security in the workspace by assigning users to workspace roles.

For more information, see Fabric and OneLake security (Workspace security).

Item security
Within a workspace, you can assign permissions directly to Fabric items, like warehouses and lakehouses. Item security provides the flexibility to grant access to an individual Fabric item without granting access to the entire workspace. Users can set up per item permissions either by sharing an item or by managing the permissions of an item.

-