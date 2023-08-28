## Role assignment overview

The Privileged Identity Management (PIM) role assignments give you a secure way to grant access to resources in your organization. This section describes the assignment process. It includes assigning roles to members, activating assignments, approving or denying requests, extend and renewing assignments.

PIM keeps you informed by sending you and other participants email notifications. These emails might also include links to relevant tasks, such as activating, approving, or denying a request.

The following Privileged Identity Management. The email below informs Patti that Alex updated a role assignment for Emily.

## :::image type="content" source="../media/pim-email-3e57c23c.png" alt-text="Screenshot showing email with updated a role assignment."::: 

## Assign

The assignment process starts by assigning roles to members. To grant access to a resource, the administrator assigns roles to users, groups, service principals, or managed identities. The assignment includes the following data:

 -  The members or owners to assign the role.
 -  The scope of the assignment. The scope limits the assigned role to a particular set of resources.
 -  The type of the assignment
     -  Eligible assignments require the member of the role to perform an action to use the role. Actions might include activation or requesting approval from designated approvers.
     -  Active assignments don't require the member to perform any action to use the role. Members assigned as active have the privileges assigned to the role.
 -  The duration of the assignment, using start and end dates or permanent. For eligible assignments, the members can activate or request approval during the start and end dates. For active assignments, the members can use the assigned role during this period of time.

The following screenshot shows how the administrator assigns a role to members.

:::image type="content" source="../media/role-assignment-04b22c03.png" alt-text="Screenshot showing how an administrator assigns a role to members.":::


## Activate

If users have been made eligible for a role, then they must activate the role assignment before using the role. To activate the role, users select a specific activation duration within the maximum (configured by administrators) and the reason for the activation request.

The following screenshot shows how members activate their roles for a limited time.

## :::image type="content" source="../media/role-activation-913cac21.png" alt-text="Screenshot showing how members activate their role to a limited time."::: 

If the role requires approval to activate, a notification will appear in the upper right corner of the user's browser, informing them the request is pending approval. If approval isn't required, the member can start using the role.

## Approve or deny<br>

Delegated approvers receive email notifications when a role request is pending their approval. Approvers can view, approve or deny these pending requests in PIM. After the request has been approved, the member can start using the role. For example, if a user or a group was assigned with Contribution role to a resource group, they'll be able to manage that particular resource group.

## Extend and renew assignments<br>

After administrators set up the time-bound owner or member assignments, the first question you might ask is, what happens if an assignment expires? In this new version, we provide two options for this scenario:

 -  **Extend** – When a role assignment nears expiration, the user can use Privileged Identity Management to request an extension for the role assignment
 -  **Renew** – When a role assignment has already expired, the user can use Privileged Identity Management to request a renewal for the role assignment

Both user-initiated actions require approval from a Global Administrator or Privileged Role Administrator. Admins don't need to be in the business of managing assignment expirations. You can wait for the extension or renewal requests to arrive for simple approval or denial.

## Scenarios

Privileged Identity Management supports the following scenarios:

### Privileged Role Administrator permissions

 -  Enable approval for specific roles
 -  Specify approver users or groups to approve requests
 -  View request and approval history for all privileged roles

### Approver permissions

 -  View pending approvals (requests)
 -  Approve or reject requests for role elevation (single and bulk)
 -  Provide justification for my approval or rejection

### Eligible role user permissions

 -  Request activation of a role that requires approval
 -  View the status of your request to activate
 -  Complete your task in Azure AD if activation was approved
