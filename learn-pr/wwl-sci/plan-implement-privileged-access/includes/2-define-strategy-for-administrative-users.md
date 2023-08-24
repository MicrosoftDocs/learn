## What is Privileged identity management (PIM)?

PIM is a service in Azure Active Directory (Azure AD), part of Entra, for managing access to privileged resources. PIM enables you to manage, control, and monitor access to important resources in your organization. Such resources include those in Azure AD, Azure, and other Microsoft Online Services, such as Microsoft 365 or Microsoft Intune.

## What does PIM do?

PIM provides time-based and approval-based role activation to access resources. This helps to mitigate the risks of excessive, unnecessary, or misused access permissions on resources that you care about. Key features of PIM include:

 -  Provide just-in-time privileged access to Azure AD and Azure resources
 -  Assign time-bound access to resources using start and end dates
 -  Require approval to activate privileged roles
 -  Enforce Azure AD Multi-Factor Authentication to activate any role
 -  Use justification to understand why users activate
 -  Get notifications when privileged roles are activated
 -  Conduct access reviews to ensure users still need roles
 -  Download audit history for internal or external audit

Before you deploy PIM in your organization, follow the instructions and understand the concepts in this section. This will help you create a plan tailored to your organization’s privileged identity requirements.

> [!NOTE]
> PIM requires a Premium P2 license.

## Identify your stakeholders

The following section helps you identify all the stakeholders who are involved in the project. You'll look at who needs to approve, review, or stay informed. It includes separate tables for deploying PIM for Azure AD roles and PIM for Azure roles. Add stakeholders to the following table as appropriate for your organization.

SO = Approval on this project

R = Review this project and provide input

I = Informed of this project

### Stakeholders: Privileged Identity Management for Azure AD roles

| **Name**                       | **Role**                                                                                                                                                                                                                         | **Action** |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| Name and email                 | **Identity architect or Azure Global Administrator** \- A representative from the identity management team in charge of defining how to align this change with the core identity management infrastructure in your organization. | SO/R/I     |
| Name and email                 | **Service owner or Line manager** \- A representative from the IT owners of a service or a group of services. They're key in making decisions and helping to roll out PIM for their team.                                        | SO/R/I     |
| Name and email                 | **Security owner** \- A representative from the security team who can approve that the plan meets the security requirements of your organization.                                                                                | SO/R       |
| Name and email                 | **IT support manager / Helpdesk** \- A representative from the IT support organization who can provide feedback on the supportability of this change from a helpdesk perspective.                                                | R/I        |
| Name and email for pilot users | **Privileged role users** \- The group of users for which privileged identity management is implemented. They'll need to know how to activate their roles once PIM is implemented.                                               | I          |

### Stakeholders: Privileged Identity Management for Azure roles

| **Name**                       | **Role**                                                                                                                                                                          | **Action** |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| Name and email                 | **Subscription/Resource owner** \- A representative from the IT owners of each subscription or resource that you want to deploy PIM for.                                          | SO/R/I     |
| Name and email                 | **Security owner** \- A representative from the security team that can approve that the plan meets the security requirements of your organization.                                | SO/R       |
| Name and email                 | **IT support manager / Helpdesk** \- A representative from the IT support organization who can provide feedback on the supportability of this change from a helpdesk perspective. | R/I        |
| Name and email for pilot users | **Azure role users** \- The group of users for which privileged identity management is implemented. They'll need to know how to activate their roles once PIM is implemented.     | I          |

## Start using Privileged Identity Management

As part of the planning process, prepare PIM by following our "Start using Privileged Identity Management" article. PIM gives you access to some features that are designed to help with your deployment.

If your goal is to deploy PIM for Azure resources, follow our "Discover Azure resources to manage in Privileged Identity Management" article. Only owners of subscriptions and management groups can bring these resources under management by PIM. After it's under management, the PIM functionality is available for owners at all levels, including management group, subscription, resource group, and resource. If you're a Global Administrator trying to deploy PIM for your Azure resources, you can elevate access to manage all Azure subscriptions to give yourself access to all Azure resources in the directory for discovery. However, we advise that you get approval from each of your subscription owners before managing their resources with PIM.

## Enforce principle of least privilege

It's important to make sure that you've enforced the principle of least privilege in your organization for both your Azure AD and your Azure roles.

### Plan least privilege delegation

For Azure AD roles, it's common for organizations to assign the Global Administrator role to a number of administrators when most administrators only need one or two specific and less-powerful administrator roles. With a large number of Global Administrators or other high-privilege roles, it's hard to track your privileged role assignments closely enough.

Follow these steps to implement the principle of least privilege for your Azure AD roles.

1.  Understand the granularity of the roles by reading and understanding the available Azure AD administrator roles. You and your team should also reference administrator roles by identity task in Azure AD, which explains the least privileged role for specific tasks.
2.  List who has privileged roles in your organization. You can use the PIM Discovery and insights (preview) to reduce your exposure.
    
    :::image type="content" source="../media/new-preview-page-6eed0acb.png" alt-text="Screenshot of the Discovery and insights page to reduce exposure via privileged roles.":::
    
3.  For all Global Administrators in your organization, find out why they need the role. Then remove them from the Global Administrator role and assign built-in roles or custom roles with lower privilege inside Azure AD. FYI, Microsoft currently only has about 10 administrators with the Global Administrator role.
4.  For all other Azure AD roles, review the list of assignments, identify administrators who no longer need the role, and remove them from their assignments.

To automate the last two steps, you can use access reviews in PIM. Following the steps in "Start an access review for Azure AD roles in Privileged Identity Management," you can set up an access review for every Azure AD role that has one or more members.

:::image type="content" source="../media/create-access-review-e113cf95.jpg" alt-text="Screenshot of the Create an access review pane for Azure AD roles, within Privileged Identity Manager.":::


Set the reviewers to **Members (self)**. All users in the role will receive an email asking them to confirm that they need the access. Also, turn on **Require reason on approval** in the advanced settings so that users must state why they need the role. Based on this information, you can remove users from unnecessary roles or delegate them to more granular administrator roles.

Access reviews rely on emails to notify people to review their access to the roles. If you've privileged accounts that don’t have emails linked, be sure to populate the secondary email field on those accounts.

### Plan Azure resource role delegation

For Azure subscriptions and resources, you can set up a similar Access review process to review the roles in each subscription or resource. The goal of this process is to minimize Owner and User Access Administrator assignments attached to each subscription or resource and to remove unnecessary assignments. However, organizations often delegate such tasks to the owner of each subscription or resource because they have a better understanding of the specific roles (especially custom roles).

If you're in the Global Administrator role trying to deploy PIM for Azure roles in your organization, you can elevate access to manage all Azure subscriptions, to get access to each subscription. You can then find each subscription owner and work with them to remove unnecessary assignments and minimize owner role assignment.

Users with the Owner role for an Azure subscription can also use access reviews for Azure resources to audit and remove unnecessary role assignments similar to the process described earlier for Azure AD roles.

## Decide which role assignments should be protected by Privileged Identity Management

After cleaning up privileged role assignments in your organization, you'll need to decide which roles to protect with PIM.

If a role is protected by PIM, eligible users assigned to it must elevate to use the privileges granted by the role. The elevation process might also include obtaining approval, using Azure AD Multi-Factor Authentication, and providing the reason they're activating. PIM can also track elevations through notifications and the PIM and Azure AD audit event logs.

Choosing which roles to protect with PIM can be difficult and will be different for each organization. This section provides our best practices for Azure AD and Azure roles.

### Azure AD roles

It's important to prioritize protecting Azure AD roles that have the most permissions. Based on usage patterns among all PIM customers, the top 10 Azure AD roles managed by PIM are:

 -  Global Administrator
 -  Security Administrator
 -  User Administrator
 -  Exchange Administrator
 -  SharePoint Administrator
 -  Intune Administrator
 -  Security Reader
 -  Service Administrator
 -  Billing Administrator
 -  Skype for Business Administrator
    
    > [!TIP]
    > Microsoft recommends you manage all your Global Administrators and Security Administrators using PIM as a first step, because they are the users who can do the most harm when compromised.

It's important to consider the most sensitive data and permissions for your organization. As an example, some organizations may want to protect their Power BI Administrator role or their Teams Administrator role using PIM, since they can access data and change core workflows.

If there are any roles with guest users assigned, they're vulnerable to attack.

> [!TIP]
> Microsoft recommends that you manage all roles with guest users using PIM to reduce risk associated with compromised guest user accounts.

Reader roles like the Directory Reader, Message Center Reader, and Security Reader are sometimes regarded as less important than other roles, because they don’t have write permission. However, we have some customers who also protect those roles because attackers with access to those accounts might be able to read sensitive data, including personal data. Take this risk into consideration when deciding whether you want reader roles in your organization to be managed using PIM.

### Azure roles

When deciding which role assignments should be managed using PIM for Azure resources, you must first identify the subscriptions/resources that are most vital for your organization. Examples of such subscriptions/resources are:

 -  Resources that host the most sensitive data.
 -  Resources that core customer-facing applications depend on.

If you're a Global Administrator having trouble deciding which subscriptions and resources are most important, you should contact subscription owners in your organization to gather a list of resources managed by each subscription. Then, work with the subscription owners to group the resources based on severity level in the case they're compromised (low, medium, high). Prioritize managing resources with PIM based on this severity level.

> [!TIP]
> Microsoft recommends you work with subscription/resource owners of critical services to set up PIM workflow for all roles inside sensitive subscriptions/resources.

PIM for Azure resources supports time-bound service accounts. You should treat service accounts exactly the same as you would treat a regular user account.

For subscriptions/resources that aren't as critical, you won’t need to set up PIM for all roles. However, you should still protect the Owner and User Access Administrator roles with PIM.

> [!TIP]
> Microsoft recommends that you manage Owner roles and User Access Administrator roles of all subscriptions/resources using PIM.

## Decide whether to use a group to assign roles

Whether to assign a role to a group instead of to individual users is a strategic decision. When planning, consider assigning a role to a group to manage role assignments when:

 -  Many users are assigned to a role.
 -  You want to delegate assigning the role.

### Many users are assigned to a role

Manually keeping track of who is assigned to a role and managing their assignments based on when they need it can take time. To assign a group to a role, first create a role-assignable group and then assign the group as eligible for a role. This action subjects everyone in the group to the same activation process as individual users who are eligible to elevate into the role. Group members activate their assignments to the group individually using the PIM activation request and approval process. The group isn't activated—just the user's group membership.

### You want to delegate assigning the role

A group owner can manage membership for a group. For Azure AD role-assignable groups, only the Privileged Role Administrator, the Global Administrator, and the group owners can manage group membership. When an admin adds new members to the group, the member gets access to the roles to which the group is assigned whether the assignment is eligible or active. Use group owners to delegate the management of group membership for an assigned role to reduce the breadth of privilege required.

> [!TIP]
> Microsoft recommends that you bring Azure AD role-assignable groups under management by PIM. After a role-assignable group is brought under management by PIM, it's called a privileged access group. Use PIM to require group owners to activate their Owner role assignment before they can manage group membership.

## Decide which role assignments should be permanent or eligible

Once you've decided the list of roles to be managed by PIM, you must decide which users should get the eligible role versus the permanently active role. **Permanently active roles are the normal roles assigned through Azure AD and Azure resources, while eligible roles can only be assigned in PIM.**

Microsoft recommends you've zero permanently active assignments for both Azure AD roles and Azure roles other than the recommended two break-glass emergency access accounts, which should have the permanent Global Administrator role.

Even though we recommend zero standing-administrators, it's sometimes difficult for organizations to achieve this right away. Things to consider when making this decision include:

 -  Frequency of elevation – If the user only needs the privileged assignment once, they shouldn’t have the permanent assignment. On the other hand, if the user needs the role for their day-to-day job and using PIM would greatly reduce their productivity, they can be considered for the permanent role.
 -  Cases specific to your organization – If the person being given the eligible role is from a distant team or a high-ranking executive to the point that communicating and enforcing the elevation process is difficult, they can be considered for the permanent role.
    
    > [!TIP]
    > Microsoft recommends you to set up recurring access reviews for users with permanent role assignments.

## Draft your Privileged Identity Management settings

Before you implement your PIM solution, it's good practice to draft your PIM settings for every privileged role your organization uses. This section has some examples of PIM settings for particular roles; they are for reference only and might be different for your organization. Each of these settings is explained in detail with Microsoft’s recommendations after the tables.

### Privileged Identity Management settings for Azure AD roles

| **Setting**                        | **Global Administrator**    | **Exchange Administrator** | **Helpdesk Administrator** |
| ---------------------------------- | --------------------------- | -------------------------- | -------------------------- |
| Require MFA; two-step verification | Yes                         | Yes                        | No                         |
| Notification                       | Yes                         | Yes                        | No                         |
| Incident ticket                    | Yes                         | No                         | Yes                        |
| Require approval                   | Yes                         | No                         | No                         |
| Approver                           | Other Global Administrators | None                       | None                       |
| Activation Duration                | 1 hour                      | 2 hour                     | 8 hour                     |
| Permanent admin                    | Emergency access accounts   | None                       | None                       |

### Privileged Identity Management settings for Azure roles

| **Setting**                        | **Owner of critical subscriptions** | **User Access Administrator of less critical subscriptions** | **Virtual Machine Contributor** |
| ---------------------------------- | ----------------------------------- | ------------------------------------------------------------ | ------------------------------- |
| Require MFA; two-step verification | Yes                                 | Yes                                                          | No                              |
| Notification                       | Yes                                 | Yes                                                          | Yes                             |
| Require approval                   | Yes                                 | No                                                           | No                              |
| Approver                           | Other owners of the subscription    | None                                                         | None                            |
| Activation Duration                | 1 hour                              | 1 hour                                                       | 3 hour                          |
| Active admin                       | None                                | None                                                         | None                            |
| Active expiration                  | n/a                                 | n/a                                                          | n/a                             |

The following table describes each of the settings.

| **Setting**                        | **Description**                                                                                                                                                                                                                                                                                            |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Role                               | Name of the role you're defining the settings for.                                                                                                                                                                                                                                                         |
| Require MFA; two-step verification | Whether the eligible user needs to perform MFA; two-step verification before activating the role.                                                                                                                                                                                                          |
|                                    | **Microsoft recommends** you enforce MFA; two-step verification for all administrator roles, especially if the roles have guest users.                                                                                                                                                                     |
| Notification                       | If set to true, Global Administrator, Privileged Role Administrator, and Security Administrator in the organization will receive an email notification when an eligible user activates the role.                                                                                                           |
|                                    | Some organizations don’t have an email address tied to their administrator accounts. To get these email notifications, set an alternative email address so administrators will receive these emails.                                                                                                       |
| Incident ticket                    | Whether the eligible user needs to record an incident ticket number when activating their role. This setting helps an organization identify each activation with an internal incident number to mitigate unwanted activations.                                                                             |
|                                    | **Microsoft recommends** taking advantage of incident ticket numbers to tie PIM into your internal system. This method can be useful for approvers who need context for the activation.                                                                                                                    |
| Require approval                   | Whether the eligible user needs to get approval to activate the role.                                                                                                                                                                                                                                      |
|                                    | **Microsoft recommends** that you set up approval for roles with the most permission. Based on usage patterns of all PIM customers, Global Administrator, User Administrator, Exchange Administrator, Security Administrator, and Password Administrator are the most common roles with approval required. |
| Approver                           | If approval is required to activate the eligible role, list the people who should approve the request. By default, PIM sets the approver to be all users who are privileged role administrators whether they are permanent or eligible.                                                                    |
|                                    | If a user is both eligible for an Azure AD role and an approver of the role, they will not be able to approve themselves.                                                                                                                                                                                  |
|                                    | **Microsoft recommends** that you choose approvers to be users who are most knowledgeable about the role and its frequent users rather than a Global Administrator.                                                                                                                                        |
| Activation duration                | The length of time a user will be activated in the role before it will expire.                                                                                                                                                                                                                             |
| Permanent admin                    | List of users who will be a permanent administrator for the role (never have to activate).                                                                                                                                                                                                                 |
|                                    | **Microsoft recommends** you have zero standing administrator for all roles except for Global Administrators.                                                                                                                                                                                              |
| Active admin                       | For Azure resources, active administrator is the list of users who will never have to activate to use the role. This list is not referred to as permanent administrator like in Azure AD roles because you can set an expiration time for when the user will lose this role.                               |
| Active expiration                  | Active role assignments for Azure roles expire after the configured duration. You can choose from 15 days, 1 month, 3 months, 6 months, 1 year or permanently active.                                                                                                                                      |
| Eligible expiration                | Eligible role assignments for Azure roles expire after this duration. You can choose from 15 days, 1 month, 3 months, 6 months, 1 year or permanently eligible.                                                                                                                                            |
