Administrative units are Azure Active Directory (Azure AD) resources that can be containers for other Azure AD resources. An administrative unit can contain only users and groups.

Administrative units restrict permissions in a role to any portion of your organization that you define. You could, for example, use administrative units to delegate the Helpdesk Administrator role to regional support specialists, so they can manage users only in the region that they support. You can manage administrative units by using the Azure portal, PowerShell cmdlets and scripts, or Microsoft Graph.

### What is an administrative unit?

In Azure AD, using a single tenant if you assign a user any administrator role, they're now an admin over every user in the tenant. Always think about the security principle of least privilege, it's always the best way to grant administrative responsibilities. Administrative units are containers created to solve for this challenge in Azure AD. If you want a User Administrator to be able to manage only a specific set of users and group. Say to only manage users in the Research Department of a hospital. You could set up an administrative unit. Within that administrative unit you would add the users and groups for the research team, then you would add a specific user to the User Administrator role within the administrative unit, call them Admin-for-research. Admin-for-research would be able to manage the users in the administrative unit but not across the entire tenant, which helps to achieve the principle of least privilege.

### What admin roles are available for an administrative unit?

You can have users in the following roles to manage your administrative unit:

 -  Authentication administrator
 -  Groups administrator
 -  Helpdesk administrator
 -  License administrator
 -  Password administrator
 -  User administrator

> [!NOTE]
> If you are familiar with on-premises Active Directory, this capability was handled by setting up Organizational Units (OUs) in your directory and adding your users to the OU.

## Plan your administrative units

You can use administrative units to logically group Azure AD resources. An organization whose IT department is scattered globally might create administrative units that define relevant geographical boundaries. In another scenario, where a global organization has suborganizations that are semi-autonomous in their operations, administrative units could represent the suborganizations.

The criteria on which administrative units are created are guided by the unique requirements of an organization. Administrative units are a common way to define structure across Microsoft 365 services. We recommend that you prepare your administrative units with their use across Microsoft 365 services in mind. You can get maximum value out of administrative units when you can associate common resources across Microsoft 365 under an administrative unit.

You can expect the creation of administrative units in the organization to go through the following stages:

1.  **Initial adoption**: Your organization will start creating administrative units based on initial criteria, and the number of administrative units will increase as the criteria are refined.
2.  **Pruning**: After the criteria are defined, administrative units that are no longer required will be deleted.
3.  **Stabilization**: Your organizational structure is defined, and the number of administrative units isn't going to change significantly in the short term.

## Delegate administration in Azure Active Directory

With organizational growth comes complexity. One common response is to reduce some of the workload of access management with Azure Active Directory (AD) admin roles. You can assign the least possible privilege to users to access their apps and perform their tasks. Even if you don't assign the Global Administrator role to every application owner, you're placing application management responsibilities on the existing Global Administrators. There are many reasons for an organization move toward a more decentralized administration.

In Azure AD, you can delegate Application creation and management permissions in the following ways:

 -  Restricting who can create applications and manage the applications they create. By default in Azure AD, all users can register application registrations and manage all aspects of applications they create. You can restrict to only allow selected people that permission.
 -  Assigning one or more owners to an application. A simple way to grant someone the ability to manage all aspects of Azure AD configuration for a specific application.
 -  Assigning a built-in administrative role that grants access to manage configuration in Azure AD for all applications. The recommended way to grant IT experts access to manage broad application configuration permissions without granting access to manage other parts of Azure AD not related to application configuration.
 -  Create a custom role to define specific permissions. Then assign the role to a user to assign a limited-owner. Or you could assign at the directory scope - all applications - as a limited-administrator.

When granting access, use one of the above methods for two reasons. First, delegating the ability to perform administrative tasks reduces global administrator overhead. Second, using limited permissions improves your security posture and reduces the potential for unauthorized access.

## Plan for Delegation

It's work to develop a delegation model that fits your needs. Developing a delegation model is an iterative design process, and we suggest you follow these steps:

 -  Define the roles you need
 -  Delegate app administration
 -  Grant the ability to register applications
 -  Delegate app ownership
 -  Develop a security plan
 -  Establish emergency accounts
 -  Secure your administrator roles
 -  Make privileged elevation temporary

## Define roles

Determine the Active Directory tasks that are carried out by administrators and how they map to roles. Each task should be evaluated for frequency, importance, and difficulty. These criteria are vital aspects of task definition because they govern whether a permission should be delegated:

 -  Tasks that you do routinely, have limited risk, and are trivial to complete are excellent candidates for delegation.
 -  Tasks that you do rarely but have potential risk across the organization and require high skill levels should be considered carefully before delegating. Instead, you can temporarily elevate an account to the required role or reassign the task.

## Delegate app administration

The proliferation of apps within your organization can strain your delegation model. If it places the burden for application access management on the Global Administrator, it's likely that model increases its overhead as time goes on. If you have granted people the Global Administrator role for things like configuring enterprise applications, you can now offload them to the following less-privileged roles. Doing so helps to improve your security posture and reduces the potential for unfortunate mistakes. The most-privileged application administrator roles are:

 -  The **Application Administrator** role, which grants the ability to manage all applications in the directory, including registrations, single sign-on settings, user and group assignments and licensing, Application Proxy settings, and consent. It doesn't grant the ability to manage Conditional Access.
 -  The **Cloud Application Administrator** role, which grants all the abilities of the Application Administrator, except it doesn't grant access to Application Proxy settings (because it has no on-premises permission).

## Delegate app registration

By default, all users can create application registrations. To selectively grant the ability to create application registrations:

 -  Set **Users can register applications** to No in **User settings**
 -  Assign the user to the Application Developer role

To selectively grant the ability to consent to allow an application to access data:

 -  Set **Users can consent to applications accessing company data on their behalf** To No in **User settings** under Enterprise apps
 -  Assign the user to the Application Developer role

When an Application Developer creates a new application registration, they're automatically added as the first owner.

## Delegate app ownership

For even finer-grained app access delegation, you can assign ownership to individual enterprise applications. You improve existing support for assigning application registration owners. Ownership is assigned on a per-enterprise application basis in the Enterprise Applications screen. The benefit is owners can manage only the enterprise applications they own. For example, you can assign an owner for the Salesforce application, and that owner can manage access to and configuration for Salesforce, and no other applications. An enterprise application can have many owners, and a user can be the owner for many enterprise applications. There are two app owner roles:

 -  The **Enterprise Application Owner** role grants the ability to manage the ‘enterprise applications that the user owns, including single sign-on settings, user and group assignments, and adding more owners. It doesn't grant the ability to manage Application Proxy settings or Conditional Access.
 -  The **Application Registration Owner** role grants the ability to manage application registrations for app that the user owns, including the application manifest and adding other owners.

## Develop a security plan

Azure AD provides an extensive guide to planning and executing a security plan on your Azure AD admin roles, [Securing privileged access for hybrid and cloud deployments](/azure/active-directory/roles/security-planning).

## Establish emergency accounts

To maintain access to your identity management store when issue arises, prepare emergency access accounts according to [Create emergency-access administrative accounts](/azure/active-directory/roles/security-emergency-access).

## Secure your administrator roles

Attackers who get control of privileged accounts can do tremendous damage. Always protect these accounts first. Use the Security Defaults feature that is available to all Azure AD organizations. Security Defaults enforces multifactor authentication on privileged Azure AD accounts.
