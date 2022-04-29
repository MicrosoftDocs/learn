:::image type="content" source="../media/az500-privileged-identity-management-scope-741f45a3.png" alt-text="Screenshot of the PIM blade showing Azure AD roles and Resource roles.":::


 -  **Azure AD roles**. These roles are all in Azure Active Directory (such as Global Administrator, Exchange Administrator, and Security Administrator). You can read more about the roles and their functionality in Administrator role permissions in Azure Active Directory.
 -  **Azure resource roles**. These roles are linked to an Azure resource, resource group, subscription, or management group. Privileged Identity Management provides just-in-time access to both built-in roles like Owner, User Access Administrator, and Contributor, as well as custom roles.

## Azure AD roles

Users can be assigned to different administrative roles in Azure AD. These role assignments control which tasks, such as adding or removing users or changing service settings, the users are able to perform on Azure AD, Microsoft 365 and other Microsoft Online Services and connected applications.

A global administrator can update which users are **permanently** assigned to roles in Azure AD, using PowerShell cmdlets such as `Add-MsolRoleMember` and `Remove-MsolRoleMember`, or through the Azure portal.

Azure AD Privileged Identity Management (PIM) manages policies for privileged access for users in Azure AD. PIM assigns users to one or more roles in Azure AD, and you can assign someone to be permanently in the role, or eligible for the role. When a user is permanently assigned to a role, or activates an eligible role assignment, then they can manage Azure Active Directory, Microsoft 365, and other applications with the permissions assigned to their roles.

There's no difference in the access given to someone with a permanent versus an eligible role assignment. The only difference is that some people don't need that access all the time. They are made eligible for the role, and can turn it on and off whenever they need to.

### Roles managed in PIM

Privileged Identity Management lets you assign users to common administrator roles, including:

 -  **Global administrator** (also known as Company administrator) has access to all administrative features. You can have more than one global admin in your organization. The person who signs up to purchase Microsoft 365 automatically becomes a global admin.
 -  **Privileged role administrator** manages Azure AD PIM and updates role assignments for other users.
 -  **Billing administrator** makes purchases, manages subscriptions, manages support tickets, and monitors service health.
 -  **Password administrator** resets passwords, manages service requests, and monitors service health. Password admins are limited to resetting passwords for users.
 -  **Service administrator** manages service requests and monitors service health.
    
    > [!NOTE]
    > If you are using Microsoft 365, then before assigning the service admin role to a user, first assign the user administrative permissions to a service, such as Exchange Online.
 -  **User management administrator** resets passwords, monitors service health, and manages user accounts, user groups, and service requests. The user management admin can’t delete a global admin, create other admin roles, or reset passwords for billing, global, and service admins.
 -  **Exchange administrator** has administrative access to Exchange Online through the Exchange admin center (EAC), and can perform almost any task in Exchange Online.
 -  **SharePoint administrator** has administrative access to SharePoint Online through the SharePoint Online admin center, and can perform almost any task in SharePoint Online.
 -  **Skype for Business administrator** has administrative access to Skype for Business through the Skype for Business admin center, and can perform almost any task in Skype for Business Online.

### Roles not managed in PIM

Roles within Exchange Online or SharePoint Online, except for those mentioned above, are not represented in Azure AD and so are not visible in PIM. Azure subscriptions and resource groups are also not represented in Azure AD.

## Azure resources

When you first set up Privileged Identity Management for Azure resources, you need to discover and select the resources to protect with Privileged Identity Management. There's no limit to the number of resources that you can manage with Privileged Identity Management. However, we recommend starting with your most critical (production) resources.
