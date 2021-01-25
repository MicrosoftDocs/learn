Azure AD roles control permissions to manage Azure AD resources, such as allowing user accounts to be created, or billing information viewed.  Azure AD supports built-in and custom roles.

## Built-in roles

A few of the most common built-in roles include:

- *Global Administrator* - Users with this role have access to all administrative features in Azure Active Directory. The person who signs up for the Azure Active Directory tenant automatically becomes a Global Administrator.
- *User administrator* - Users with this role can create and manage all aspects of users and groups. Additionally, this role includes the ability to manage support tickets and monitor service health.
- *Billing administrator* – users with this role makes purchases, manages subscriptions, manages support tickets, and monitors service health.

There are many different built-in roles for different areas of responsibility.  All built-in roles are pre-configured bundles of permissions for designed for specific tasks.

## Custom roles (preview)

Although there are many built-in admin roles in Azure AD, custom roles give flexibility when granting access. This feature is currently in preview, with the first release including the ability to create a role to assign permissions for app registrations.

Granting permission using custom Azure AD roles is a two-step process that involves creating a custom role definition, which consists of a collection of permissions that you add from a preset list. These permissions are the same permissions used in the built-in roles.  Once you’ve created your role definition, you can assign it to a user by creating a role assignment. A role assignment grants the user the permissions in a role definition, at a specified scope. A custom role can be assigned at org-wide scope, meaning the role member has the role permissions over all resources in the organization. A custom role can also be assigned at an object scope. An example of an object scope would be a single application.

Unlike built-in roles, which are assigned at a tenant level and are pre-configured bundles of permissions for designed for specific tasks; custom roles can be assigned at the resource level (such as a single application) and allow permissions to be added to a custom role definition.

Custom roles require an Azure AD Premium P1 or P2 license.

## Azure AD role-based access control

Managing access using roles is known as role-based access control (RBAC). Azure AD built-in and custom roles are a form of RBAC in that Azure AD roles control access to Azure AD resources.

## Only grant the access users need

It's best practice, and more secure, to grant users the least privilege to get their work done. This means that if someone mostly manages users, you should assign the user administrator role, and not global administrator. This mitigates the risk of a user account being compromised, and a hacker locking you out of your account. By assigning least privileges, you limit the damage that could be done with a compromised account.
