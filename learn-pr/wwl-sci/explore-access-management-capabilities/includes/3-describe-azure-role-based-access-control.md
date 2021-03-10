Azure AD roles control permissions to manage Azure AD resources. For example, allowing user accounts to be created, or billing information to be viewed.  Azure AD supports built-in and custom roles.

## Built-in roles

A few of the most common built-in roles are:

- *Global administrator*: users with this role have access to all administrative features in Azure Active Directory. The person who signs up for the Azure Active Directory tenant automatically becomes a global administrator.
- *User administrator*: users with this role can create and manage all aspects of users and groups. This role also includes the ability to manage support tickets and monitor service health.
- *Billing administrator*: users with this role make purchases, manage subscriptions and support tickets, and monitor service health.

There are many built-in roles for different areas of responsibility.  All built-in roles are preconfigured bundles of permissions designed for specific tasks.

## Custom roles (preview)

Although there are many built-in admin roles in Azure AD, custom roles give flexibility when granting access. This feature is currently in preview, with the first release including the ability to create a role to assign permissions for app registrations.

Granting permission using custom Azure AD roles is a two-step process that involves creating a custom role definition, consisting of a collection of permissions that you add from a preset list. These permissions are the same ones used in the built-in roles.  When you’ve created your role definition, you can assign it to a user by creating a role assignment. 

A role assignment grants the user the permissions in a role definition, at a specified scope. A custom role can be assigned at organization-wide scope, meaning the role member has the role permissions over all resources. A custom role can also be assigned at an object scope. An example of an object scope would be a single application.

Unlike built-in roles, which are assigned at a tenant level and are preconfigured bundles of permissions designed for specific tasks, custom roles can be assigned at the resource level (such as a single application) and allow permissions to be added to a custom role definition.

Custom roles require an Azure AD Premium P1 or P2 license.

## Azure AD role-based access control

Managing access using roles is known as role-based access control (RBAC). Azure AD built-in and custom roles are a form of RBAC in that Azure AD roles control access to Azure AD resources.

## Only grant the access users need

It's best practice, and more secure, to grant users the least privilege to get their work done. It means that if someone mostly manages users, you should assign the user administrator role, and not global administrator. This mitigates the risk of a user account being compromised, and a hacker locking you out of your account. By assigning least privileges, you limit the damage that could be done with a compromised account.
