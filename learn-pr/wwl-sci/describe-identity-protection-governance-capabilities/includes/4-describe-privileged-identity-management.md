
Privileged Identity Management (PIM) is a service of Microsoft Entra that enables you to manage, control, and monitor access to important resources in your organization. These include resources in Microsoft Entra, Azure, and other Microsoft online services such as Microsoft 365 or Microsoft Intune. PIM mitigates the risks of excessive, unnecessary, or misused access permissions. It requires justification to understand why users want permissions, and enforces multifactor authentication to activate any role.

PIM is:

- Just in time, providing privileged access only when needed, and not before.
- Time-bound, by assigning start and end dates that indicate when a user can access resources.
- Approval-based, requiring specific approval to activate privileges.
- Visible, sending notifications when privileged roles are activated.
- Auditable, allowing a full access history to be downloaded.

Privileged Identity Management is a feature of Microsoft Entra Premium licensing.

### Why use PIM?

PIM reduces the chance of a malicious actor getting access by minimizing the number of people who have access to secure information or resources. By time-limiting authorized users, it reduces the risk of an authorized user inadvertently affecting sensitive resources. PIM also provides oversight for what users are doing with their administrator privileges.

### What can you do with PIM?

Today, you can use PIM with:

- Microsoft Entra roles – Sometimes referred to as directory roles, Microsoft Entra roles include built-in and custom roles to manage Microsfot Entra and other Microsoft 365 online services.

- Azure roles – The role-based access control (RBAC) roles in Azure that grants access to management groups, subscriptions, resource groups, and resources.

- PIM for Groups – Provide just-in-time membership in the group and just-in-time ownership of the group. The Microsoft Entra Privileged Identity Management for Groups feature can be used to govern access to various scenarios that include Microsoft Entra roles, Azure roles, as well as Azure SQL, Azure Key Vault, Intune, other application roles, and third party applications.

### General workflow

There are a few steps that are generally part of a basic workflow when deploying PIM.  These steps are: assign, activate, approve/deny, and extend/renew.  

- **Assign** - The assignment process starts by assigning roles to members. To grant access to a resource, the administrator assigns roles to users, groups, service principals, or managed identities. The assignment includes the following data:
  - Members or owners - The members or owners to assign to the role.
  - Scope - The scope limits the assigned role to a particular set of resources.
  - Assignment type - There are two options. Eligible assignments require the member of the role to perform an action to use the role. Actions might include activation, or requesting approval from designated approvers.  Active assignments don't require the member to perform any action to use the role. Members assigned as active have the privileges assigned to the role.
  - Duration - The duration of the assignment is defined by start and end dates or is set to permanent.
  
  :::image type="content" source="../media/role-assignment-inline.png" alt-text="Screen capture showing the assignment step." lightbox="../media/role-assignment-expanded.png":::

- **Activate** - If users have been made eligible for a role, then they must activate the role assignment before using the role. To activate the role, users select specific activation duration within the maximum (configured by administrators), and the reason for the activation request.

  :::image type="content" source="../media/role-activation-inline.png" alt-text="Screen capture showing the activation step." lightbox="../media/role-assignment-expanded.png":::

- **Approve or deny** - Delegated approvers receive email notifications when a role request is pending their approval. Approvers can view, approve or deny these pending requests in PIM. After the request has been approved, the member can start using the role.

    :::image type="content" source="../media/resources-approve-pane-inline.png" alt-text="Screen capture showing the activation step." lightbox="../media/resources-approve-pane-expanded.png":::

- **Extend and renew** - When a role assignment nears expiration, the user can use PIM to request an extension for the role assignment. When a role assignment has already expired, the user can use Privileged Identity Management to request a renewal for the role assignment.

    :::image type="content" source="../media/pim-extend.png" alt-text="Screen capture showing the option to extend an assignment.":::

### Audit

You can use the Privileged Identity Management (PIM) audit history to see all role assignments and activations within the past 30 days for all privileged roles.

:::image type="content" source="../media/rbac-resource-audit-inline.png" alt-text="Screen capture showing the PIM audit history." lightbox="../media/rbac-resource-audit-extended.png":::
