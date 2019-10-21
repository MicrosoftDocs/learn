
You want to give the developers within your organization the same access. You also want to manage who is part of the developers' group and who isn't.

Azure Active Directory (Azure AD) helps you to manage your cloud-based apps, on-premises apps, and resources using your organization's groups. Your resources can be part of the directory, like permissions to manage objects through roles. Or your resources can be external to the directory, like software as a service (SaaS) apps, Azure services, SharePoint sites, and on-premises resources.

## Access management in Azure AD

With role-based access control (RBAC), you can manage how Azure resources are accessed. For example, you could use RBAC to allow a group of users to view virtual machines in a resource group. You could allow only a single user to access, manage, and delete SQL databases in a specific resource group or subscription.

While Azure RBAC roles are used to manage access to Azure resources, Azure AD administrator roles let you manage Azure AD-related resources like users, groups, billing, licensing, application registration, and more.

## Access rights through single user or group assignment

Azure AD helps you provide access rights to a single user or to an entire group of users. You can assign a set of access permissions to all the members of the group. Access permissions range from full access, to create or remove resources.

There are different ways you can assign access rights:

- **Direct assignment**: Assign a user the required access rights by directly assigning a role that has those access rights.

- **Group assignment**: Assign a group the required access rights, and members of the group will inherit those rights.

- **Rule-based assignment**: Use rules to determine a group membership based on user or device properties. For a user account or device's group membership to be valid, the user or device must meet the rules. If the rules aren't met, the user account or device's group membership is no longer valid.  The rules can be simple. You can select pre-written rules or write your own advanced rules.

In the next unit, we assign users to an Azure AD group and use rule-based assignment to automatically manage their group membership.
