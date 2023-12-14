Privileged Identity Management provides time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions on resources that you care about. Here are some of the key features of Privileged Identity Management:

 -  Provide just-in-time privileged access to Microsoft Entra ID and Azure resources
 -  Assign time-bound access to resources using start and end dates
 -  Require approval to activate privileged roles
 -  Enforce multi-factor authentication to activate any role
 -  Use justification to understand why users activate
 -  Get notifications when privileged roles are activated
 -  Conduct access reviews to ensure users still need roles
 -  Download audit history for internal or external audit
 -  Prevents removal of the last active Global Administrator and Privileged Role Administrator role assignments

Once you set up Privileged Identity Management, you'll see Tasks, Manage, and Activity options in the left navigation menu. As an administrator, you can choose between options such as managing Microsoft Entra roles, managing Azure resource roles, or PIM for Groups. When you choose what you want to manage, you see the appropriate set of options for that option.

:::image type="content" source="../media/manage-your-priviledged-access-page-960f586f.png" alt-text="Screenshot showing the Privileged Identity Management dashboard.":::


For Microsoft Entra roles in Privileged Identity Management, only a user who is in the Privileged Role Administrator or Global Administrator role can manage assignments for other administrators. Global Administrators, Security Administrators, Global Readers, and Security Readers can also view assignments to Microsoft Entra roles in Privileged Identity Management.<br>

For Azure resource roles in Privileged Identity Management, only a subscription administrator, a resource Owner, or a resource User Access administrator can manage assignments for other administrators. Users who are Privileged Role Administrators, Security Administrators, or Security Readers don't by default have access to view assignments to Azure resource roles in Privileged Identity Management.<br>

## Terminology<br>

To better understand Privileged Identity Management and its documentation, you should review the following terms.

## :::image type="content" source="../media/microsoft-entra-pim-terminology-table-ca06e6bf.png" alt-text="Table showing terminology or concepts definitions."::: Role assignment overview

The PIM role assignments give you a secure way to grant access to resources in your organization. This section describes the assignment process. It includes assign roles to members, activate assignments, approve or deny requests, extend and renew assignments.

PIM keeps you informed by sending you and other participants email notifications. These emails might also include links to relevant tasks, such activating, approve or deny a request.<br>

The following screenshot shows an email message sent by PIM. The email informs Patti that Alex updated a role assignment for Emily.<br>

:::image type="content" source="../media/storage-blob-data-reader-assignment-cd3fae23.png" alt-text="Screenshot showing a storage blob data reader assignment.":::


## Assign<br>

The assignment process starts by assigning roles to members. To grant access to a resource, the administrator assigns roles to users, groups, service principals, or managed identities. The assignment includes the following data:

 -  The members or owners to assign the role.<br>
 -  The scope of the assignment. The scope limits the assigned role to a particular set of resources.
 -  The type of the assignment
     -  Eligible assignments require the member of the role to perform an action to use the role. Actions might include activation, or requesting approval from designated approvers.
     -  Active assignments don't require the member to perform any action to use the role. Members assigned as active have the privileges assigned to the role.
 -  The duration of the assignment, using start and end dates or permanent. For eligible assignments, the members can activate or requesting approval during the start and end dates. For active assignments, the members can use the assign role during this period of time.

The following screenshot shows how administrator assigns a role to members.

:::image type="content" source="../media/pim-role-assignment-d689e10a.png" alt-text="Screenshot showing how to add assignment types for eligible and active Azure resources.":::


## Activate

If users have been made eligible for a role, then they must activate the role assignment before using the role. To activate the role, users select specific activation duration within the maximum (configured by administrators), and the reason for the activation request.

The following screenshot shows how members activate their role to a limited time.

:::image type="content" source="../media/pim-role-assignment-activation-page-3fb25d40.png" alt-text="Screenshot showing how to activate a storage blob data reader azure resource.":::
<br>

If the role requires approval to activate, a notification appears in the upper right corner of the user's browser informing them the request is pending approval. If an approval isn't required, the member can start using the role.

## Approve or deny

Delegated approvers receive email notifications when a role request is pending their approval. Approvers can view, approve or deny these pending requests in PIM. After the request has been approved, the member can start using the role. For example, if a user or a group was assigned with Contribution role to a resource group, they are able to manage that particular resource group.

## Extend and renew assignments

After administrators set up time-bound owner or member assignments, the first question you might ask is what happens if an assignment expires? In this new version, we provide two options for this scenario:

 -  **Extend** – When a role assignment nears expiration, the user can use Privileged Identity Management to request an extension for the role assignment<br>
 -  **Renew** – When a role assignment has already expired, the user can use Privileged Identity Management to request a renewal for the role assignment

Both user-initiated actions require an approval from a Global Administrator or Privileged Role Administrator. Admins don't need to be in the business of managing assignment expirations. You can just wait for the extension or renewal requests to arrive for simple approval or denial.
