A domain name is a part of the identifier for many Azure Active Directory (Azure AD) resources: it's part of a user name or email address for a user, part of the address for a group, and is sometimes part of the app ID URI for an application. A resource in Azure AD can include a domain name that's owned by the organization that contains the resource. Only a Global Administrator can manage domains in Azure AD.

## Set the primary domain name for your Azure AD organization

When your organization is created, the initial domain name, such as ‘contoso.onmicrosoft.com,’ is also the primary domain name.

> [!IMPORTANT]
> The person who creates the tenant is automatically the Global administrator for that tenant. The Global administrator can add other administrators to the tenant.

The primary domain is the default domain name for a new user when you create a new user. Setting a primary domain name streamlines the process for an administrator to create new users in the portal. To change the primary domain name:

1.  Sign in to the [Azure portal](https://portal.azure.com/) with an account that's a Global Administrator for the organization.
2.  Select **Azure Active Directory**.
3.  Select **Custom domain names**.
    
    :::image type="content" source="../media/add-custom-domain-b91e0e89.png" alt-text="Screenshot of the Add custom user dialog box. Opening the user management page.":::
    
4.  Select the name of the domain that you want to be the primary domain.
5.  Select the **Make primary** command. Confirm your choice when prompted.
    
    :::image type="content" source="../media/make-primary-domain-0d2ab135.png" alt-text="Screenshot of the configure domain dialog. You can make a domain name the primary.":::
    

You can change the primary domain name for your organization to be any verified custom domain that isn't federated. Changing the primary domain for your organization won't change the user name for any existing users.

## Add custom domain names to your Azure AD organization

You can add up to 900 managed domain names. If you're configuring all your domains for federation with on-premises Active Directory, you can add up to 450 domain names in each organization.

## Add subdomains of a custom domain

If you want to add a subdomain name such as ‘europe.contoso.com’ to your organization, you should first add and verify the root domain, such as contoso.com. The subdomain is automatically verified by Azure AD. To see the verified subdomain you added, refresh the domain list in the browser.

If you've already added a contoso.com domain to one Azure AD organization, you can also verify the subdomain europe.contoso.com in a different Azure AD organization. When adding the subdomain, you're prompted to add a TXT record in the DNS hosting provider.

## What to do if you change the DNS registrar for your custom domain name

If you change the DNS registrars, there are no additional configuration tasks in Azure AD. You can continue using the domain name with Azure AD without interruption. If you use your custom domain name with Microsoft 365, Intune, or other services that rely on custom domain names in Azure AD, see the documentation for those services.

## Delete a custom domain name

You can delete a custom domain name from your Azure AD if your organization no longer uses that domain name, or if you need to use that domain name with another Azure AD.

To delete a custom domain name, you must first ensure that no resources in your organization rely on the domain name. You can't delete a domain name from your organization if:

 -  Any user has a user name, email address, or proxy address that includes the domain name.
 -  Any group has an email address or proxy address that includes the domain name.
 -  Any application in your Azure AD has an app ID URI that includes the domain name.

You must change or delete any such resource in your Azure AD organization before you can delete the custom domain name.

### ForceDelete option

**ForceDelete** can be used to remove a domain name in the Azure AD Admin Center or using Microsoft Graph API. These options use an asynchronous operation and update all references from the custom domain name like “user@contoso.com” to the initial default domain name such as “user@contoso.onmicrosoft.com.”

To call **ForceDelete** in the Azure portal, you must ensure that there are fewer than 1000 references to the domain name, and any references where Exchange is the provisioning service must be updated or removed in the Exchange Admin Center. Exchange Mail-Enabled Security Groups and distributed lists are included. Also, the **ForceDelete** operation won't succeed if either of the following is true:

 -  You purchased a domain via Microsoft 365 domain subscription services
 -  You're a partner administering on behalf of another customer organization

The following actions are performed as part of the **ForceDelete** operation:

 -  Renames the UPN, EmailAddress, and ProxyAddress of users with references to the custom domain name to the initial default domain name.
 -  Renames the EmailAddress of groups with references to the custom domain name to the initial default domain name.
 -  Renames the identifierUris of applications with references to the custom domain name to the initial default domain name.

An error is returned when:

 -  The number of objects to be renamed is greater than 1000
 -  One of the applications to be renamed is a multi-tenant app
