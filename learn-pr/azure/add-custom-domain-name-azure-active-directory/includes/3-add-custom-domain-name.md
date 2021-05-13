You use Azure to add your organization's custom domain name and allow employees to create memorable usernames.

In this unit, you'll see how to:

- Associate your custom domain with an existing Azure Active Directory (Azure AD) organization.
- Set the custom domain to be the primary domain.
- Add users.

You can't complete this unit unless you've purchased a domain name and registered it with a Domain Name System (DNS) provider.

The following steps walk through the process to add a custom domain name to Azure. If you own an unused domain name, you can follow along in your own Azure AD organization.

## Add a custom domain name to Azure AD

In our scenario, your company has an Azure AD organization where you can add the domain name.

1. In Azure AD, under **Manage** select **Custom domain name**.

    ![Screenshot of the Overview page with Custom domain name highlighted.](../media/3-overview-page.png)

1. Select **+ Add custom domain**.

1. For **Custom domain name**, enter the domain name **proseware.com**.

1. Select **Add domain**.

1. On the **proseware.com** page, copy the DNS information.

    ![Screenshot of the verification page for a custom domain name.](../media/3-add-a-custom-domain-name.png)

## Add your DNS information to the domain registrar

1. Go to your domain registrar.

1. Create records for your domain based on the DNS information you copied from Azure. The following screenshot shows a text record added to Azure DNS. Azure DNS is acting as the domain registrar.

    ![Screenshot of a domain registrar that shows a TXT record for the custom domain.](../media/3-dns-records.png)

1. Wait at least an hour for the DNS updates to propagate.

## Verify your custom domain in Azure

1. In Azure AD, under **Manage** select **Custom domain name**.

1. Select your custom domain name.

1. Select **Verify**.

    ![Screenshot of the Verify button on the custom domain's DNS information page](../media/3-verify-domain.png)

1. If Azure verifies that the correct record exists, the domain name status changes to "Verified."

    ![Screenshot of a list of custom domains with the domain proseware.com listed as verified.](../media/3-verified-domain.png)

1. To add a subdomain, select **+ Add domain name** and enter a subdomain name like **marketing.proseware.com**. You don't need to repeat the verification steps.

    ![Screenshot of a list of custom domains with a callout highlighting the subdomain marketing.proseware.com with the status set to verified.](../media/3-added-subdomain.png)

## Set the primary domain name

After you add the custom domain name and any subdomains, set one of the domain names as the primary.

1. Select **proseware.com** from the list of custom domain names.

1. Select **Make primary**.

    ![Screenshot of the information about the proseware.com domain with a checkmark next to Mark primary option.](../media/3-make-primary.png)

1. Select **Yes**.

1. In the list of custom domain names, the **Primary** column is now checked for **proseware.com**.

## Manage custom domain names by using Azure PowerShell

You might prefer to manage your domain names by using Azure PowerShell.

- `New-AzureADDomain`: Creates a new domain. Use the parameter `-IsDefault` to set the domain name as the primary domain name.
- `Confirm-AzureADDomain`: Lets you try to validate the ownership of a domain.
- `Set-AzureADDomain`: Updates a domain name and can set the domain to the primary domain name.
- `Remove-AzureADDomain`: Deletes a domain from Azure AD.

## Add a user

After you add a custom domain name and set it to be the primary domain, add users.

1. In the Azure portal, go to **Azure Active Directory**.

1. On the left side of the pane, under **Manage** select **Users**.

1. Select **+ New user**.

   ![Screenshot of adding a new user for a custom domain.](../media/3-add-users.png)

1. For **User name** and **Name**, enter values for your pilot user. The primary domain name appears as part of the username.
