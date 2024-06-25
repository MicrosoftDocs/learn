Privileged Identity Management (PIM) is a service in Microsoft Entra ID that enables you to manage, control, and monitor access to important resources in your organization. These resources include resources in Microsoft Entra ID, Azure, and other Microsoft Online Services such as Microsoft 365 or Microsoft Intune. The following video explains important PIM concepts and features.

## Reasons to use

Organizations want to minimize the number of people who have access to secure information or resources, because that reduces the chance of

 -  a malicious actor getting access
 -  an authorized user inadvertently impacting a sensitive resource

However, users still need to carry out privileged operations in Microsoft Entra ID, Azure, Microsoft 365, or SaaS apps. Organizations can give users just-in-time privileged access to Azure and Microsoft Entra resources and can oversee what those users are doing with their privileged access.

Privileged Identity Management (PIM) provides a time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions to important resources. These resources include resources in Microsoft Entra ID, Azure, and other Microsoft Online Services such as Microsoft 365 or Microsoft Intune.

PIM enables you to allow a specific set of actions at a particular scope. Key features include:

 -  Provide just-in-time privileged access to resources<br>
 -  Assign eligibility for membership or ownership of PIM for Groups<br>
 -  Assign time-bound access to resources using start and end dates<br>
 -  Require approval to activate privileged roles<br>
 -  Enforce Multifactor authentication to activate any role<br>
 -  Enforce Conditional Access policies to activate any role (Public preview)<br>
 -  Use justification to understand why users activate<br>
 -  Get notifications when privileged roles are activated<br>
 -  Conduct access reviews to ensure users still need roles<br>
 -  Download audit history for internal or external audit<br>

## Understand PIM<br>

The PIM concepts in this section will help you understand your organization’s privileged identity requirements.

Today, you can use PIM with:

 -  Microsoft Entra roles – Sometimes referred to as directory roles, Microsoft Entra roles include built-in and custom roles to manage Microsoft Entra ID and other Microsoft 365 online services.<br>
 -  Azure roles – The role-based access control (RBAC) roles in Azure that grants access to management groups, subscriptions, resource groups, and resources.<br>
 -  PIM for Groups – To set up just-in-time access to member and owner role of a Microsoft Entra security group. PIM for Groups not only gives you an alternative way to set up PIM for Microsoft Entra roles and Azure roles, but also allows you to set up PIM for other permissions across Microsoft online services like Intune, Azure Key Vaults, and Azure Information Protection. If the group is configured for app provisioning, activation of group membership triggers provisioning of group membership (and the user account, if it wasn’t provisioned) to the application using the System for Cross-Domain Identity Management (SCIM) protocol.<br>

You can assign the following to these roles or groups:

 -  Users- To get just-in-time access to Microsoft Entra roles, Azure roles, and PIM for Groups.<br>
 -  Groups- Anyone in a group to get just-in-time access to Microsoft Entra roles and Azure roles. For Microsoft Entra roles, the group must be a newly created cloud group that’s marked as assignable to a role while for Azure roles, the group can be any Microsoft Entra security group. We don't recommend assigning/nesting a group to a PIM for Groups.<br>

> [!NOTE]
> You cannot assign service principals as eligible to Microsoft Entra roles, Azure roles, and PIM for Groups but you can grant a time limited active assignment to all three.

## Principle of least privilege

You assign users the role with the [least privileges necessary to perform their tasks](/entra/identity/role-based-access-control/delegate-by-task). This practice minimizes the number of Global Administrators and instead uses specific administrator roles for certain scenarios.

> [!NOTE]
> Microsoft has very few Global Administrators. Learn more at [how Microsoft uses Privileged Identity Management](https://www.microsoft.com/itshowcase/Article/Content/887/Using-Azure-AD-Privileged-Identity-Management-for-elevated-access).

## Type of assignments

There are two types of assignment – **eligible** and **active**. If a user has been made eligible for a role that means they can activate the role when they need to perform privileged tasks.

You can also set a start and end time for each type of assignment. This addition gives you four possible types of assignments:

 -  Permanent eligible<br>
 -  Permanent active<br>
 -  Time-bound eligible, with specified start and end dates for assignment<br>
 -  Time-bound active, with specified start and end dates for assignment<br>

In case the role expires, you can **extend** or **renew** these assignments.

**We recommend** you keep zero permanently active assignments for roles other than the recommended **two break-glass emergency access accounts**, which should have the permanent Global Administrator role.

## Plan the project

When technology projects fail, it’s typically because of mismatched expectations on impact, outcomes, and responsibilities. To avoid these pitfalls, [ensure that you’re engaging the right stakeholders](/entra/architecture/deployment-plans) and that stakeholder roles in the project are well understood.

### Plan a pilot

At each stage of your deployment ensure that you are evaluating that the results are as expected. See [best practices for a pilot](/entra/architecture/deployment-plans#best-practices-for-a-pilot).

 -  Start with a small set of users (pilot group) and verify that the PIM behaves as expected.<br>
 -  Verify whether all the configuration you set up for the roles or PIM for Groups are working correctly.<br>
 -  Roll it to production only after it’s thoroughly tested.<br>

### Plan communications<br>

Communication is critical to the success of any new service. Proactively communicate with your users how their experience changes, when it changes, and how to gain support if they experience issues.

Set up time with your internal IT support to walk them through the PIM workflow. Provide them with the appropriate documentations and your contact information.

## Plan testing and rollback

> [!NOTE]
> For Microsoft Entra roles, organizations often test and roll out Global Administrators first, while for Azure resources, they usually test PIM one Azure subscription at a time.

### Plan testing

Create test users to verify PIM settings work as expected before you impact real users and potentially disrupt their access to apps and resources. Build a test plan to have a comparison between the expected results and the actual results.

The following table shows an example test case:

| **Role**             | **Expected behavior during activation**                                                                                                                                    | **Actual results** |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| Global Administrator | Require MFA<br>Require approval<br>Require Conditional Access context (Public preview)<br>Approver receives notification and can approve<br>Role expires after preset time |                    |

For both Microsoft Entra ID and Azure resource role, make sure that you have users represented who will take those roles. In addition, consider the following roles when you test PIM in your staged environment:

| **Roles**                      | **Microsoft Entra roles** | **Azure Resource roles** | **PIM for Groups** |
| ------------------------------ | ------------------------- | ------------------------ | ------------------ |
| Member of a group              |                           |                          | x                  |
| Members of a role              | x                         | x                        |                    |
| IT service owner               | x                         |                          | x                  |
| Subscription or resource owner |                           | x                        | x                  |
| PIM for Groups owner           |                           |                          | x                  |

### Plan rollback

If PIM fails to work as desired in the production environment, you can change the role assignment from eligible to active once again. For each role that you’ve configured, select the ellipsis (**…**) for all users with assignment type as **eligible**. You can then select the **Make active** option to go back and make the role assignment **active**.

## Plan and implement PIM for Microsoft Entra roles

Follow these tasks to prepare PIM to manage Microsoft Entra roles.

### Discover and mitigate privileged roles<br>

List who has privileged roles in your organization. Review the users assigned, identify administrators who no longer need the role, and remove them from their assignments.

You can use [Microsoft Entra roles access reviews](/entra/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review) to automate the discovery, review, and approval or removal of assignments.

### Determine roles to be managed by PIM<br>

Prioritize protecting Microsoft Entra roles that have the most permissions. It’s also important to consider what data and permission are most sensitive for your organization.

First, ensure that all Global and Security admin roles are managed using PIM because they’re the users who can do the most harm when compromised. Then consider more roles that should be managed that could be vulnerable to attack.

You can use the Privileged label to identify roles with high privileges that you can manage with PIM. Privileged label is present on [Roles and Administrator](/entra/identity/role-based-access-control/privileged-roles-permissions?tabs=admin-center) in Microsoft Entra admin center. See the article, [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference) to learn more.

### Configure PIM settings for Microsoft Entra roles

[Draft and configure your PIM settings](/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings) for every privileged Microsoft Entra role that your organization uses.

The following table shows example settings:

| **Role**             | **Require MFA** | **Require Conditional Access** | **Notification** | **Incident ticket** | **Require approval** | **Approver**               | **Activation duration** | **Perm admin**            |
| -------------------- | --------------- | ------------------------------ | ---------------- | ------------------- | -------------------- | -------------------------- | ----------------------- | ------------------------- |
| Global Administrator | ✔️              | ✔️                             | ✔️               | ✔️                  | ✔️                   | Other Global Administrator | 1 Hour                  | Emergency access accounts |
| Exchange Admin       | ✔️              | ✔️                             | ✔️               | ❌                   | ❌                    | None                       | 2 Hour                  | None                      |
| Helpdesk Admin       | ❌               | ❌                              | ❌                | ✔️                  | ❌                    | None                       | 8 Hour                  | None                      |

### Assign and activate Microsoft Entra roles

For Microsoft Entra roles in PIM, only a user who is in the Privileged Role Administrator or Global Administrator role can manage assignments for other administrators. Global Administrators, Security Administrators, Global Readers, and Security Readers can also view assignments to Microsoft Entra roles in PIM.

Follow the instructions in the links below:

1.  [Give eligible assignments](/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user).
2.  [Allow eligible users to activate their Microsoft Entra role just-in-time](/entra/id-governance/privileged-identity-management/pim-how-to-activate-role)

When role nears its expiration, use [PIM to extend or renew the roles](/entra/id-governance/privileged-identity-management/pim-resource-roles-renew-extend). Both user-initiated actions require an approval from a Global administrator or Privileged role administrator.

When these important events occur in Microsoft Entra roles, PIM [sends email notifications and weekly digest emails](/entra/id-governance/privileged-identity-management/pim-email-notifications) to privilege administrators depending on the role, event, and notification settings. These emails might also include links to relevant tasks, such activating or renewing a role.

> [!NOTE]
> You can also perform these PIM tasks [using the Microsoft Graph APIs for Microsoft Entra roles](/entra/id-governance/privileged-identity-management/pim-apis).

### Approve or deny PIM activation requests

A delegated approver receives an email notification when a request is pending for approval. Follow these steps to [approve or deny requests to activate an Azure resource role](/entra/id-governance/privileged-identity-management/pim-resource-roles-approval-workflow).

### View audit history for Microsoft Entra roles

[View audit history for all role assignments and activations](/entra/id-governance/privileged-identity-management/pim-how-to-use-audit-log) within past 30 days for Microsoft Entra roles. You can access the audit logs if you are a Global Administrator or a privileged role administrator.

We recommend you have at least one administrator read through all audit events on a weekly basis and export your audit events on a monthly basis.

### Security alerts for Microsoft Entra roles<br>

[Configure security alerts for the Microsoft Entra roles](/entra/id-governance/privileged-identity-management/pim-how-to-configure-security-alerts) which triggers an alert in case of suspicious and unsafe activity.

## Plan and implement PIM for Azure Resource roles

Follow these tasks to prepare PIM to manage Azure resource roles.

### Discover and mitigate privileged roles<br>

Minimize Owner and User Access Administrator assignments attached to each subscription or resource and remove unnecessary assignments.

As a Global Administrator you can [elevate access to manage all Azure subscriptions](/azure/role-based-access-control/elevate-access-global-admin). You can then find each subscription owner and work with them to remove unnecessary assignments within their subscriptions.

Use [access reviews for Azure resources](/entra/id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review) to audit and remove unnecessary role assignments.

### Determine roles to be managed by PIM<br>

When deciding which role assignments should be managed using PIM for Azure resource, you must first identify the management groups, subscriptions, resource groups, and resources that are most vital for your organization. Consider using management groups to organize all their resources within their organization.

**We recommend** you manage all Subscription Owner and User Access Administrator roles using PIM.

Work with Subscription owners to document resources managed by each subscription and classify the risk level of each resource if compromised. Prioritize managing resources with PIM based on risk level. This also includes custom resources attached to the subscription.

We also recommend you work with Subscription or Resource owners of critical services to set up PIM workflow for all the roles inside sensitive subscriptions or resources.

For subscriptions or resources that aren’t as critical, you won’t need to set up PIM for all roles. However, you should still protect the Owner and User Access Administrator roles with PIM.

### Configure PIM settings for Azure Resource roles

[Draft and configure settings](/entra/id-governance/privileged-identity-management/pim-resource-roles-configure-role-settings) for the Azure Resource roles that you’ve planned to protect with PIM.

The following table shows example settings:

| **Role**                                                 | **Require MFA** | **Notification** | **Require Conditional Access** | **Require approval** | **Approver**                     | **Activation duration** | **Active admin** | **Active expiration** | **Eligible expiration** |
| -------------------------------------------------------- | --------------- | ---------------- | ------------------------------ | -------------------- | -------------------------------- | ----------------------- | ---------------- | --------------------- | ----------------------- |
| Owner of critical subscriptions                          | ✔️              | ✔️               | ✔️                             | ✔️                   | Other owners of the subscription | 1 Hour                  | None             | n/a                   | 3 months                |
| User Access Administrator of less critical subscriptions | ✔️              | ✔️               | ✔️                             | ❌                    | None                             | 1 Hour                  | None             | n/a                   | 3 months                |

### Assign eligibility for PIM for Groups

You can [assign eligibility to members or owners of the PIM for Groups.](/entra/id-governance/privileged-identity-management/groups-assign-member-owner) With just one activation, they will have access to all the linked resources.

> [!NOTE]
> You can assign the group to one or more Microsoft Entra ID and Azure resource roles in the same way as you assign roles to users. A **maximum of 500 role-assignable groups** can be created in a single Microsoft Entra organization (tenant).

:::image type="content" source="../media/privileged-identity-for-groups-800d8e90.png" alt-text="Diagram showing an example of privileged identity for groups.":::
 When group assignment nears its expiration, use \\\\\\\[PIM to extend or renew the group assignment\\\\\\\](/entra/id-governance/privileged-identity-management/groups-renew-extend). This operation requires group owner approval

### Approve or deny PIM activation request

Configure PIM for Groups members and owners to require approval for activation and choose users or groups from your Microsoft Entra organization as delegated approvers. We recommend selecting two or more approvers for each group to reduce workload for the privileged role administrator.

[Approve or deny role activation requests for PIM for Groups](/entra/id-governance/privileged-identity-management/groups-approval-workflow). As a delegated approver, you'll receive an email notification when a request is pending for your approval.

### View audit history for PIM for Groups

[View audit history for all assignments and activations](/entra/id-governance/privileged-identity-management/groups-audit) within past 30 days for PIM for Groups.
