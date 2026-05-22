Data access in organizations is often restricted by users' responsibilities and roles, and by the organization's deployment patterns and data architecture. Fabric has a multi-layer security model that lets you control permissions at different layers, so you can follow the principle of least privilege — restricting each user's access to only what they need.

## Three levels of access evaluation

Fabric evaluates access sequentially across three levels:

1. **Microsoft Entra ID authentication** — checks whether the user can authenticate to Microsoft Entra ID.
2. **Fabric access** — checks whether the user can access Fabric.
3. **Data security** — checks whether the user can perform the requested action on a table or file.

The third level, data security, has four primary access controls that can be configured individually or together:

- Workspace roles
- Item permissions
- Compute or granular permissions
- OneLake security

Each layer provides increasingly specific control — from broad workspace-level access down to individual tables and folders within a data item.

## How the layers work together

**Workspace roles** apply to all items in a workspace. When you assign someone a workspace role, they can access every item in that workspace at the level the role allows. Use workspace roles when a user needs broad access to collaborate across multiple items.

**Item permissions** apply to a single item, like a specific lakehouse or warehouse. Instead of giving workspace-wide access, you share an individual item and choose what the recipient can do with it. Use item permissions when a user only needs access to one or two items — not the whole workspace.

**Compute permissions** apply within a specific engine, like the SQL analytics endpoint or semantic model. They include permissions such as Read, ReadAll, or Write. Use compute permissions to control what a user can do through a particular query engine.

Across all three layers, when you grant someone access to an item, they can see *all* the data in it.

**OneLake security** adds control *within* an item. Instead of giving access to all data, you create security roles that grant access to specific tables or folders. These restrictions apply consistently across all compute engines — Spark, SQL, and OneLake APIs. Use OneLake security when a user needs access to a Fabric item but should only see specific data within it.