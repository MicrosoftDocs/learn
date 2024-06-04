A role assignment is the process of scoping a role definition to limit permissions for a requestor, such as a user, group, service principal, or managed identity.

### Things to know about role assignments

Review the following characteristics of role assignments:

- The purpose of a role assignment is to control access.

- The scope limits which permissions defined for a role are available for the assigned requestor.

- Access is revoked by removing a role assignment.

- A resource inherits role assignments from its parent resource.

- The effective permissions for a requestor are a combination of the permissions for the requestor's assigned roles, and the permissions for the roles assigned to the requested resources.

### Things to consider when assigning scope levels for roles

The following diagram shows an example of how scopes can be applied for a role to grant varying levels of access for different users. Think about how you can implement scopes for your roles to create meaningful assignments for your organization.

:::image type="content" source="../media/role-assignment-040eb1ab.png" alt-text="Diagram that shows how a role assignment is created for a service principal, role definition, and access scope level." border="false":::

This scenario has the following access management configuration:

- Three security principals are supported: user, group, service principal.

- Six built-in roles are implemented, and two custom roles are defined: _Reader Support Tickets_ and _Virtual Machine Operator_.

- The built-in _Contributor_ role has two sets of permissions: _Actions_ and _NotActions_.

- The _Contributor_ role is assigned at different scopes to the Marketing and Pharma-sales resource groups:

   - Marketing users are granted access to create or manage any Azure resource in the Pharma-sales resource group.

   - Marketing users aren't granted access to resources outside the Pharma-sales resource group.
