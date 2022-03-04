A role assignment is the process of scoping a role definition to a user, group, service principal, or managed identity. The purpose of the role assignment is to grant access. Access is revoked by removing a role assignment.

For example, in the diagram, the Marketing group has been assigned the Contributor role for the pharma-sales resource group. Users in the Marketing group can create or manage any Azure resource in the pharma-sales resource group. Marketing users don't have access to resources outside the pharma-sales resource group, unless they are part of another role assignment.

:::image type="content" source="../media/role-assignment-040eb1ab.png" alt-text="A service principle, role definition, and scope create a role assignment.":::


> [!NOTE]
> A resource inherits role assignments from its parent resource.
