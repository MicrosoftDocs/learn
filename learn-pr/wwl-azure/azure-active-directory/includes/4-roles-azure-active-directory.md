Using Azure Active Directory (Azure AD), you can designate limited administrators to manage identity tasks in less-privileged roles. Administrators can be assigned for such purposes as adding or changing users, assigning administrative roles, resetting user passwords, managing user licenses, and managing domain names. **The default user permissions can be changed only in user settings in Azure AD**.

## Limit the use of Global administrators

Users who are assigned to the Global administrator role can read and modify every administrative setting in your Azure AD organization. By default, the person who signs up for an Azure subscription is assigned the Global administrator role for the Azure AD organization. Only Global administrators and Privileged Role administrators can delegate administrator roles. To reduce the risk to your business, we recommend that you assign this role to the fewest possible people in your organization.

**As a best practice, we recommend that you assign this role to fewer than five people in your organization**. If you have more than five admins assigned to the Global Administrator role in your organization, here are some ways to reduce its use.

## Available roles

 -  **Application Administrator** \- Users in this role can create and manage all aspects of enterprise applications, application registrations, and application proxy settings.
 -  **Application Developer** \- Can create application registrations independent of the 'Users can register applications' setting.
 -  **Authentication Administrator** \- Users with this role can set or reset any authentication method (including passwords) for non-administrators and some roles. Authentication Administrators can require users who are non-administrators or assigned to some roles to re-register against existing non-password credentials (for example, multi-factor authentication or Fast Identity Online), and can also revoke remember multi-factor authentication on the device, which prompts for multi-factor authentication on the next sign-in.
 -  **Azure DevOps Administrator** \- Users with this role can manage the Azure DevOps policy to restrict new Azure DevOps organization creation to a set of configurable users or groups.
 -  **Azure Information Protection Administrator** \- Users with this role have all permissions in the Azure Information Protection service.
 -  **B2C User Flow Administrator** \- Users with this role can create and manage B2C User Flows (also called "built-in" policies) in the Azure portal.
 -  **B2C User Flow Attribute Administrator** \- Users with this role add or delete custom attributes available to all user flows in the tenant.
 -  **B2C IEF Keyset Administrator** \- User can create and manage policy keys and secrets for token encryption, token signatures, and claim encryption/decryption.
 -  **B2C IEF Policy Administrator** \- Users in this role can create, read, update, and delete all custom policies in Azure AD B2C and therefore have full control over the Identity Experience Framework in the relevant Azure AD B2C tenant.
 -  **Billing Administrator** \- Makes purchases, manages subscriptions, manages support tickets, and monitors service health.
 -  **Cloud Application Administrator** \- Users in this role have the same permissions as the Application Administrator role, excluding the ability to manage application proxy.
 -  **Cloud Device Administrator** \- Users in this role can enable, disable, and delete devices in Azure AD and read Windows 10 BitLocker keys (if present) in the Azure portal.
 -  **Compliance Administrator** \- Users with this role have permissions to manage compliance-related features in the Microsoft 365 compliance center, Microsoft 365 admin center, Azure, and Microsoft 365 Security &amp; Compliance Center.
 -  **Compliance Data Administrator** \- Users with this role have permissions to track data in the Microsoft 365 compliance center, Microsoft 365 admin center, and Azure. Users can also track compliance data within the Exchange admin center,
 -  **Conditional Access Administrator** \- Users with this role have the ability to manage Azure Active Directory Conditional Access settings
 -  **Exchange Administrator** \- Users with this role have global permissions within Microsoft Exchange Online when the service is present.
 -  **Directory Readers** \- Users in this role can read basic directory information.
 -  **Global Administrator / Company Administrator** \- Users with this role have access to all administrative features in Azure Active Directory, as well as services that use Azure Active Directory identities like Microsoft 365 security center, Microsoft 365 compliance center, Exchange Online, SharePoint Online, and Skype for Business Online.
 -  **Groups Administrator** \- Users in this role can create/manage groups and its settings like naming and expiration policies.
 -  **Security Administrator** \- Users with this role have permissions to manage security-related features in the Microsoft 365 security center, Azure Active Directory Identity Protection, Azure Information Protection, and Microsoft 365 Security &amp; Compliance Center.

For most organizations, the security of business assets depends on the integrity of the privileged accounts that administer and manage IT systems. Cyber-attackers focus on privileged access to infrastructure systems (such as Active Directory and Azure Active Directory) to gain access to an organization’s sensitive data.

Traditional approaches that focus on securing the entrance and exit points of a network as the primary security perimeter are less effective due to the rise in the use of SaaS apps and personal devices on the Internet. The natural replacement for the network security perimeter in a complex modern enterprise is the authentication and authorization controls in an organization's identity layer.

Privileged administrative accounts are effectively in control of this new **security perimeter**. It's critical to protect privileged access, regardless of whether the environment is on-premises, cloud, or hybrid on-premises and cloud-hosted services. Protecting administrative access against determined adversaries requires you to take a complete and thoughtful approach to isolating your organization’s systems from risks.
