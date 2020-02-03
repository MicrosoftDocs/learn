You use Azure to add your organization's custom domain name and allow employees to create memorable user names.

In this unit, you'll see how to associate your custom domain to an existing Azure AD tenant, set it to be the primary domain, and then add users.

You won't be able to complete the steps in this unit unless you've purchased a domain name and registered it with a DNS provider. So the following steps walk through the process to add a custom domain name to Azure. If you do own a domain name that's not being  used, you can choose to follow along in your own Azure AD tenant. To create your own Azure AD tenant, see [Quickstart: Create a new tenant in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-access-create-new-tenant#create-a-new-tenant-for-your-organization).

## Add custom domain name to Azure AD

In our scenario, the organization has a Azure AD tenant that they can add the domain name to.

1. In Azure AD, under **Manage** select **Custom domain name**.

    ![Screenshot showing the Overview page, with Custom domain name highlighted](../media/3-overview-page.png)

1. Select **+ Add custom domain**
1. For **Custom domain name**, enter your domain name like proseware.com.
1. Select **Add domain**.
1. You then choose to verify that you own the domain by adding a TXT domain record, or an MX domain record. 
    ![Screenshot of the verification page for a custom domain name](../media/3-add-a-custom-domain-name.png)

1. After adding the records at your registrar, and allowing the DNS updates to propagate, select **Verify**.

    ![Screenshot of a domain registrar showing a TXT record for the custom domain](../media/3-dns-records.png)

1. If Azure verifies that the correct record exists, the domain name status will be updated to "verified".

    ![Screenshot of a verified domain](../media/3-verified-domain.png)


1. To add subdomains, repeat the above processes. You won't need to repeat the verification for the subdomain names – the second-level domain has already been verified.

    ![Screenshot showing a subdomain added and verified](../media/3-added-subdomain.png)

## Set the primary domain name

With your custom domain name and any subdomains added, the portal allows you to set one of these to be the primary domain name.

1. Select the domain name in the list you'd like to become the primary name.

    ![Screenshot showing the information for a domain](../media/3-make-primary.png)

1. On the domains detail page, select **Make primary**, then select **Yes**.
1. You'll be returned to the list and see the selected custom domain name with a check under **Primary**.

## Manage custom domain names by using Azure AD PowerShell

You might prefer to manage your domain names using PowerShell cmdlets.

- `New-AzureADDomain`: Creates a new domain. You specify if it should be the primary domain name in the parameters.
- `Confirm-AzureADDomain`: Allows you to try to validate the ownership of a domain.
- `Set-AzureADDomain`: Updates a domain name, and can be used to set the domain to the primary domain name.
- `Remove-AzureADDomain`: Deletes a domain from Azure AD.

## Add a user

With a custom domain name added, and set to the primary domain, you start to add users.

1. On the portal, go to the **Azure Active Directory**.
1. On the left, under **Manage**, select **Users**.
1. Select **+ New user**.

   ![Screenshot of adding a new user for a custom domain](../media/3-add-users.png)

1. Enter the **User name** and **Name** for your pilot user. Notice that the primary domain name is shown as part of the user name.
