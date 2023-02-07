By default, Global administrators and Identity governance administrators
can create and manage all aspects of Azure AD entitlement management and
easily ensure that users or guests have the appropriate access. You can
ask the users themselves or a decision maker to participate in an access
review and re-certify (or attest) to users' access. However, the users
in these roles may not know all the situations where access packages are
required. The reviewers can give their input on each user's need for
continued access based on suggestions from Azure AD. When an access
review is finished, you can make changes and remove access from users
who no longer need it.

## Create and perform an access review for users

To perform an access review, you must be assigned one of the following roles:

-   Global administrator
-   User administrator
-   Identity Governance Administrator
-   Privileged Role Administrator (for reviews of role-assignable groups
    only)
-   (Preview) Microsoft 365 or Azure Active Directory Security Group owner of the group to
    be reviewed

If you have the required permissions, go to the [Identity Governance page](https://portal.azure.com/#blade/Microsoft_AAD_ERM/DashboardBlade/) to ensure that access reviews are ready for your organization.

You can have one or more users as reviewers in an access review.

Next, do the following:

1. Select a group in Azure AD that has one or more members. Or select an application connected to Azure AD that has one or more users assigned to it.

2. Decide whether to have each user review their own access or to have one or more users review everyone's access.

3. In one of the roles listed above, go to the [Identity Governance page](https://portal.azure.com/#blade/Microsoft_AAD_ERM/DashboardBlade/).

4. Create the access review. For more information, see [Create an access review of groups or
    applications](https://docs.microsoft.com/azure/active-directory/governance/create-access-review).

5. When the access review starts, ask the reviewers to give input. By default, they each receive an email from Azure AD with a link to the access panel, where they [review access to groups or applications](/azure/active-directory/governance/self-access-review).

6. If the reviewers haven't given input, you can ask Azure AD to send them a reminder. By default, Azure AD automatically sends a reminder halfway to the end date to all reviewers.

7. After the reviewers give input, stop the access review and apply the changes. For more information, see [Complete an access review of groups or applications](/azure/active-directory/governance/complete-access-review).

## Manage guest access with Azure AD access reviews

With Azure Active Directory (Azure AD), you can easily enable collaboration across organizational boundaries by using the [Azure AD B2B feature](/azure/active-directory/external-identities/what-is-b2b).

Guest users from other tenants can be [invited by administrators](/azure/active-directory/external-identities/add-users-administrator) or by [other users](/azure/active-directory/external-identities/what-is-b2b).

This capability also applies to social identities such as Microsoft accounts.

You can then decide whether to ask each guest to review their own access or to ask one or more users to review every guest's access.

### Create and perform an access review for guests

The same roles required to create an access review for users are also required to create an access review for guests. For more information, see [Create and perform an access review for users](/azure/active-directory/governance/manage-access-review#create-and-perform-an-access-review-for-users).

Azure AD enables several scenarios for reviewing guest users.

You can review either:
- A group in Azure AD that has one or more guests as members.
- An application connected to Azure AD that has one or more guest users assigned to it.

When reviewing guest user access to Microsoft 365 groups, you can either create a review for each group individually or turn on automatic, recurring access reviews of guest users across all Microsoft 365 groups.

Typically it's users within the respective departments, teams, or projects who know who they're collaborating with, using what resources, and for how long. Instead of granting unrestricted permissions to non-administrators, you can grant users the least permissions they need to do their job and avoid creating conflicting or inappropriate access rights.

There are a few main scenarios for delegating access governance from IT administrators to users who aren't administrators:

* Ask guests to review their own membership in a group - You can use access reviews to ensure that users who were invited and added to a group continue to need access. You can easily ask guests to review their own membership in that group.               |
* Ask a sponsor to review a guest's membership in a group - You can ask a sponsor, such as the owner of a group, to review a guest's need for continued membership in a group.
* Ask guests to review their own access to an application - You can use access reviews to ensure that users who were invited for a particular application continue to need access. You can easily ask the guests themselves to review their own need for access.
* Ask a sponsor to review a guest's access to an application - You can ask a sponsor, such as the owner of an application, to review the guest's need for continued access to the application.
* Ask guests to review their need for access, in general - In some organizations, guests might not be aware of their group memberships.

## Manage entitlement

With applications centrally authenticating and driven from Azure AD, you can now streamline your access request, approval, and re-certification process to make sure that the right people have the right access and
that you have a trail of why users in your organization have the access they have.

Follow these steps:

1. Use Entitlement Management to [create access packages](/azure/active-directory/governance/entitlement-management-access-package-create) that users can request as they join different teams/projects and that assign them access to the associated resources (such as applications, SharePoint sites, group memberships).

2. If deploying Entitlement Management isn't possible for your organization at this time, at least enable self-service paradigms in your organization by deploying [self-service group management](/azure/active-directory/users-groups-roles/groups-self-service-management) and [self-service application
access](https://docs.microsoft.com/azure/active-directory/manage-apps/manage-self-service-access).

### Additional information on entitlement

For more information on entitlement, see the following:

- [Entitlement management roles](/azure/active-directory/governance/entitlement-management-delegate#entitlement-management-roles)

- [Required roles to add resources to a catalog](/azure/active-directory/governance/entitlement-management-delegate#required-roles-to-add-resources-to-a-catalog)