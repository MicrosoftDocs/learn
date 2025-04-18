In Microsoft Entra ID, you can use role models to manage access at scale through identity governance.

 -  You can use access packages to represent organizational roles in your organization, such as "sales representative". An access package representing that organizational role would include all the access rights that a sales representative might typically need, across multiple resources.<br>
 -  Applications can define their own roles. For example, if you had a sales application, and that application included the app role "salesperson" in its manifest, you could then include that role from the app manifest in an access package. Applications can also use security groups in scenarios where a user could have multiple application-specific roles simultaneously.
 -  You can use roles for delegating administrative access. If you have a catalog for all the access packages needed by sales, you could assign someone to be responsible for that catalog, by assigning them a catalog-specific role.

This unit discusses how to use roles to manage aspects within Microsoft Entra entitlement management, for controlling access to the entitlement management resources.

By default, users in the Global Administrator role or the Identity Governance Administrator role can create and manage all aspects of entitlement management. However, the users in these roles may not know all the situations where access packages are required. Typically it's users within the respective departments, teams, or projects who know who they're collaborating with, using what resources, and for how long. Instead of granting unrestricted permissions to non-administrators, you can grant users the least permissions they need to do their job and avoid creating conflicting or inappropriate access rights.

## Delegate example

To understand how you might delegate access governance in entitlement management, it helps to consider an example. Suppose your organization has an IT administrator and managers in various departments such as Marketing, Finance, and Legal, who are responsible for their department's resources and business-critical content.

With entitlement management, you can delegate access governance to these non-administrators because they know which users need access, for how long, and to which resources. Delegating to non-administrators ensures the right people are managing access for their departments.

Here's one way that the IT administrator could delegate access governance to the marketing, finance, and legal departments:

The IT administrator creates a new Microsoft Entra security group and adds the department managers as members of the group. This group is then added to the catalog creators role. The department managers can now create catalogs for their departments, add resources that their departments need, and do further delegation within the catalog. They can't see each other's catalogs.

For example, the marketing manager creates a Marketing catalog, which is a container of resources. The marketing manager adds the resources that the marketing department owns to this catalog and can add other people from that department as catalog owners, which helps share the catalog management responsibilities. The marketing manager can further delegate the creation and management of access packages in the Marketing catalog to project managers in the Marketing department by assigning them to the access package manager role on a catalog. An access package manager can create and manage access packages, along with policies, requests, and assignments in that catalog. If the catalog allows it, the access package manager can configure policies to bring in users from connected organizations.

Entitlement management has the following roles, with permissions for administering entitlement management itself, that applies across all catalogs.

Entitlement management has the following roles that are defined for each particular catalog, for administering access packages and other configuration within a catalog. An administrator or a catalog owner can add users, groups of users, or service principals to these roles

Also, the chosen approver and a requestor of an access package have rights, although they're not roles

The following table lists the tasks that the entitlement management roles can do within entitlement management

| **Task**                                                                | **Admin** | **Catalog creator** | **Catalog owner** | **Access package manager** | **Access package assignment manager** |
| ----------------------------------------------------------------------- | --------- | ------------------- | ----------------- | -------------------------- | ------------------------------------- |
| Delegate to a catalog creator                                           | ✔️        |                     |                   |                            |                                       |
| Add a connected organization                                            | ✔️        |                     |                   |                            |                                       |
| Create a new catalog                                                    | ✔️        | ✔️                  |                   |                            |                                       |
| Add a resource to a catalog                                             | ✔️        |                     | ✔️                |                            |                                       |
| Add a catalog owner                                                     | ✔️        |                     | ✔️                |                            |                                       |
| Edit a catalog                                                          | ✔️        |                     | ✔️                |                            |                                       |
| Delete a catalog                                                        | ✔️        |                     | ✔️                |                            |                                       |
| Delegate to an access package manager                                   | ✔️        |                     | ✔️                |                            |                                       |
| Remove an access package manager                                        | ✔️        |                     | ✔️                |                            |                                       |
| Create a new access package in a catalog                                | ✔️        |                     | ✔️                | ✔️                         |                                       |
| Change resource roles in an access package                              | ✔️        |                     | ✔️                | ✔️                         |                                       |
| Create and edit policies, including policies for external collaboration | ✔️        |                     | ✔️                | ✔️                         |                                       |
| Directly assign a user to an access package                             | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| Directly remove a user from an access package                           | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| View who has an assignment to an access package                         | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| View an access package's requests                                       | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| View a request's delivery errors                                        | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| Reprocess a request                                                     | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| Cancel a pending request                                                | ✔️        |                     | ✔️                | ✔️                         | ✔️                                    |
| Hide an access package                                                  | ✔️        |                     | ✔️                | ✔️                         |                                       |
| Delete an access package                                                | ✔️        |                     | ✔️                | ✔️<br><br>                 |                                       |

## Required roles to add resources to a catalog

A Global administrator can add or remove any group (cloud-created security groups or cloud-created Microsoft 365 Groups), application, or SharePoint Online site in a catalog.

> [!NOTE]
> Users that have been assigned the User administrator role will no longer be able to create catalogs or manage access packages in a catalog they do not own. A User administrator who is a catalog owner can add or remove any group or application in the catalog they own, except for a group configured as assignable to a directory role. For more information on role-assignable groups, reference **Create a role-assignable group in Microsoft Entra ID**. If users in your organization have been assigned the User administrator role to configure catalogs, access packages, or policies in entitlement management, you should instead assign these users the **Identity Governance administrator** role.

For a user who isn't a global administrator, to add groups, applications, or SharePoint Online sites to a catalog, that user must have *both* the ability to perform actions on that resource, and be a catalog owner role in entitlement management for the catalog. The most common way a user can have the ability to perform actions for a resource is by being in a Microsoft Entra directory role that allows them to administer the resource. Or for resources that have owners, the user can have the ability to perform actions by having been assigned as an owner of the resourceThe actions that entitlement management checks when a user adds a resource to a catalog are:

 -  To add a security group or Microsoft 365 group: the user must be permitted to perform the `microsoft.directory/groups/members/update` and `microsoft.directory/groups/owners/update` actions<br>
 -  To add an application: the user must be permitted to perform the `microsoft.directory/servicePrincipals/appRoleAssignedTo/update` action
 -  To add a SharePoint Online site: the user must be a SharePoint Administrator or be in a SharePoint Online site role allowing them to manage permissions in the site

The following table lists some of the role combinations that include the actions that allow users in those role combinations to add resources to a catalog. To remove resources from a catalog, you must also have a role or ownership with those same actions.

| **Microsoft Entra directory role** | **Entitlement management role** | **Can add security group** | **Can add Microsoft 365 Group** | **Can add app**   | **Can add SharePoint Online site** |
| ---------------------------------- | ------------------------------- | -------------------------- | ------------------------------- | ----------------- | ---------------------------------- |
| Global Administrator               | n/a                             | ✔️                         | ✔️                              | ✔️                | ✔️                                 |
| Identity Governance Administrator  | n/a                             |                            |                                 | ✔️                |                                    |
| Groups Administrator               | Catalog owner                   | ✔️                         | ✔️                              |                   |                                    |
| Intune Administrator               | Catalog owner                   | ✔️                         | ✔️                              |                   |                                    |
| Exchange Administrator             | Catalog owner                   |                            | ✔️                              |                   |                                    |
| SharePoint Administrator           | Catalog owner                   |                            | ✔️                              |                   | ✔️                                 |
| Application Administrator          | Catalog owner                   |                            |                                 | ✔️                |                                    |
| Cloud Application Administrator    | Catalog owner                   |                            |                                 | ✔️                |                                    |
| User                               | Catalog owner                   | Only if group owner        | Only if group owner             | Only if app owner |                                    |

## Delegated management of guest user lifecycle

Typically, a user in a role with Guest Inviter privileges can invite individual external users to an organization, and this setting can be changed using the external collaboration settings.

For managing external collaboration, where the individual external users for a collaboration project may not be known in advance, assigning users who are working with external organizations into entitlement management roles can allow them to configure catalogs, access packages and policies for their external collaboration. These configurations allow the external users they're collaborating with to request and be added to your organization's directory and access packages.

 -  To allow users in external directories from connected organizations to be able to request access packages in a catalog, the catalog setting of **Enabled for external users** needs to be set to **Yes**. Changing this setting can be done by an administrator or a catalog owner of the catalog.<br>
 -  The access package must also have a policy set for users not in your directory. This policy can be created by an administrator, catalog owner or access package manager of the catalog.
 -  An access package with that policy will allow users in scope to be able to request access, including users not already in your directory. If their request is approved, or doesn't require approval, then the user will be automatically added to your directory.
 -  If the policy setting was for **All users**, and the user wasn't part of an existing connected organization, then a new proposed connected organization is automatically created. You can view the list of connected organizations and remove organizations that are no longer needed.

You can also configure what happens when an external user brought in by entitlement management loses their last assignment to any access packages. You can block them from signing in to this directory, or have their guest account removed, in the settings to manage the lifecycle of external users.

## Restricting delegated administrators from configuring policies for users not in directory

You can prevent users who aren't in administrative roles from inviting individual guests, in the external collaboration settings, by changing the **Guest invite settings** setting to specific admin roles, and have **Enable guest self-service sign up** set to **No**.

To prevent delegated users from configuring entitlement management to let external users request for external collaboration, then be sure to communicate this constraint to all global administrators, identity governance administrators, catalog creators, and catalog owners, as they're able to change catalogs, so that they do not inadvertently permit new collaboration in new or updated catalogs. They should ensure that catalogs are set with **Enabled for external users** to **No**, and do not have any access packages with policies for allowing a user not in the directory to request.

You can view the list of catalogs currently enabled for external users in the Microsoft Entra admin center.

1.  Sign in to the **Microsoft Entra admin center** as at least an **Identity Governance Administrator**.<br>
2.  Browse to **Identity governance**, **Entitlement management**, **Catalogs**.<br>
3.  Change the filter setting for **Enabled for external users** to **Yes**.<br>
4.  If any of those catalogs have a non-zero number of access packages, those access packages may have a policy for users not in directory.<br>

## Manage role assignments to entitlement management roles programmatically

You can also view and update catalog creators and entitlement management catalog-specific role assignments using Microsoft Graph. A user in an appropriate role with an application that has the delegated `EntitlementManagement.ReadWrite.All` permission can call the Graph API to **list the role definitions** of entitlement management, and **list role assignments** to those role definitions.

For example, to view the entitlement management-specific roles that a particular user or group has been assigned, use the Graph query to list role assignments, and provide the user or group's ID as the value of the `principalId`query filter, as in

**HTTP**

```
   GET https://graph.microsoft.com/v1.0/roleManagement/entitlementManagement/roleAssignments?$filter=principalId eq '10850a21-5283-41a6-9df3-3d90051dd111'&$expand=roleDefinition&$select=id,appScopeId,roleDefinition">">

```

For a role that is specific to a catalog, the `appScopeId` in the response indicates the catalog in which the user is assigned a role. This response only retrieves explicit assignments of that principal to role in entitlement management, it doesn't return results for a user who has access rights via a directory role, or through membership in a group assigned to a role.
