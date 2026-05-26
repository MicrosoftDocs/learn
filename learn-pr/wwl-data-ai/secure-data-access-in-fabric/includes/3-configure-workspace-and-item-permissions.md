Suppose you're the Fabric security admin at a healthcare company. A new data engineer has joined the team and needs to:

- Create Fabric items in an existing workspace
- Read all data in an existing lakehouse in that workspace

Your first tool is **workspace roles**.

## Grant workspace access with roles

Workspace roles apply to *all items* in a workspace. When someone needs broad access to collaborate in a workspace, assigning a workspace role is the right starting point. Workspace roles can be assigned to individuals, security groups, Microsoft 365 groups, and distribution lists.

There are four workspace roles:

- **Admin** — Can create, view, modify, share, and manage all content and data in the workspace, and manage permissions.
- **Member** — Can create, view, modify, and share all content and data in the workspace.
- **Contributor** — Can create, view, and modify all content and data in the workspace.
- **Viewer** — Can view all content in the workspace, but can't modify it.

> [!NOTE]
> Viewers can see Fabric items listed in the workspace, but have no access to the underlying data stored in OneLake by default. Use OneLake security roles to grant Viewers access to specific tables or folders.

Returning to the scenario: the new data engineer who joined your team needs to create Fabric items and read all data in the existing lakehouse. The **Contributor** role is the right fit — it grants those capabilities without giving them share or permission management capabilities. For the full list of permissions associated with each role, see [Roles in workspaces](/fabric/get-started/roles-workspaces?azure-portal=true).

### Assign a workspace role

To add a user to a workspace role:

1. In the workspace, select **Manage access**.
2. Enter the user's name or email address.
3. Select the workspace role to assign and select **Add**.

:::image type="content" source="../media/manage-access.png" alt-text="Screenshot of the Manage access panel in a Fabric workspace." lightbox="../media/manage-access.png":::

## Refine access with item permissions

Back to the data engineer: a few months later, their needs have changed. They no longer need to create Fabric items — they only need to read data from a single lakehouse. Keeping the Contributor role gives them more access than they need — it applies to every item in the workspace, not just the lakehouse.

**Item permissions** solve this. Different Fabric items have different permissions that can be granted when you share them. Instead of workspace membership, you share a specific item directly with a user and choose exactly what they can access. Because the data engineer needs access to a lakehouse, the rest of this section uses the lakehouse as an example — for other item types, see [Item permissions](/fabric/security/permission-model#item-permissions?azure-portal=true) in the Fabric permission model.

Remove the engineer from the Contributor role and share the lakehouse with item permissions. The engineer can then view and query that lakehouse — and nothing else in the workspace. This follows the principle of least privilege.

To share an item and configure its permissions, select the ellipsis (**...**) next to the item in the workspace and select **Manage permissions**.

:::image type="content" source="../media/manage-item-permissions.png" alt-text="Screenshot of the context menu for a lakehouse in a Fabric workspace, with Manage permissions highlighted." lightbox="../media/manage-item-permissions.png":::

### Lakehouse sharing permissions

When you share a lakehouse, **Read** permission is always granted — it lets the recipient see the item's metadata and view any associated reports, but doesn't grant access to any underlying data in SQL or OneLake. You can also grant additional permissions:

| Additional permission | What it allows |
|---|---|
| **Read all SQL endpoint data** | Read data from the SQL analytics endpoint using T-SQL |
| **Read all Apache Spark and subscribe to events** | Read lakehouse data through Apache Spark and OneLake APIs |
| **Build reports on the default semantic model** | Create Power BI reports on the default semantic model |

Both additional data access permissions grant access to all data in the lakehouse by default. Granting **Read all Apache Spark and subscribe to events** also adds the recipient to the lakehouse's **DefaultReader** OneLake security role. In the next unit, you'll learn how to restrict that access further. Use T-SQL permissions to restrict SQL endpoint access, and OneLake security roles to restrict Spark and OneLake API access.